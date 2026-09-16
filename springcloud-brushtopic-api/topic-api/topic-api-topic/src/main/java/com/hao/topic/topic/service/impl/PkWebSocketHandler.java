package com.hao.topic.topic.service.impl;

import com.alibaba.fastjson2.JSON;
import com.hao.topic.common.constant.RedisConstant;
import com.hao.topic.common.security.utils.SecurityUtils;
import jakarta.websocket.*;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
@Slf4j
@ServerEndpoint("/ws/pk/{token}")
public class PkWebSocketHandler {

    private static StringRedisTemplate stringRedisTemplate;
    private static PkWebSocketHandler instance;
    private static com.hao.topic.topic.service.PkService pkServiceInstance;

    private Session session;
    private Long userId;
    private String roomId;

    private static final ConcurrentHashMap<Long, PkWebSocketHandler> USER_SESSIONS = new ConcurrentHashMap<>();
    private static final ConcurrentHashMap<String, ConcurrentHashMap<Long, PkWebSocketHandler>> ROOM_SESSIONS = new ConcurrentHashMap<>();

    @Autowired
    public void setStringRedisTemplate(StringRedisTemplate template) {
        stringRedisTemplate = template;
    }

    @Autowired
    public void setPkService(com.hao.topic.topic.service.PkService pkService) {
        pkServiceInstance = pkService;
    }

    @OnOpen
    public void onOpen(Session session, @PathParam("token") String token) {
        try {
            this.session = session;
            this.userId = parseUserId(token);

            if (userId == null) {
                session.close(new CloseReason(CloseReason.CloseCodes.VIOLATED_POLICY, "无效的token"));
                return;
            }

            USER_SESSIONS.put(userId, this);
            log.info("PK WebSocket 连接成功: userId={}", userId);
        } catch (Exception e) {
            log.error("PK WebSocket 连接失败", e);
        }
    }

    @OnMessage
    public void onMessage(String message) {
        try {
            Map<String, Object> msg = JSON.parseObject(message, Map.class);
            String type = (String) msg.get("type");

            if ("JOIN_ROOM".equals(type)) {
                joinRoom((String) msg.get("roomId"));
            } else if ("SUBMIT_ANSWER".equals(type)) {
                handleAnswer(msg);
            } else if ("SUBMIT_WARMUP".equals(type)) {
                handleWarmUpAnswer(msg);
            } else if ("START_ROUND".equals(type)) {
                handleStartRound(msg);
            }
        } catch (Exception e) {
            log.error("处理PK消息失败", e);
        }
    }

    @OnClose
    public void onClose() {
        if (userId != null) {
            USER_SESSIONS.remove(userId);
            if (roomId != null) {
                ConcurrentHashMap<Long, PkWebSocketHandler> room = ROOM_SESSIONS.get(roomId);
                if (room != null) {
                    room.remove(userId);
                    if (room.isEmpty()) {
                        ROOM_SESSIONS.remove(roomId);
                    }
                }
            }
            log.info("PK WebSocket 断开: userId={}", userId);
        }
    }

    @OnError
    public void onError(Session session, Throwable error) {
        log.error("PK WebSocket 错误: userId={}", userId, error);
    }

    private void joinRoom(String roomId) {
        this.roomId = roomId;
        ROOM_SESSIONS.computeIfAbsent(roomId, k -> new ConcurrentHashMap<>()).put(userId, this);
        log.info("用户 {} 加入PK房间 {}", userId, roomId);
    }

    private void handleAnswer(Map<String, Object> msg) {
        if (roomId == null) {
            return;
        }
        String answer = (String) msg.get("answer");
        int questionIndex = (int) msg.get("questionIndex");

        log.info("用户 {} 在房间 {} 提交答案: Q{}={}", userId, roomId, questionIndex, answer);
    }

    private void handleStartRound(Map<String, Object> msg) {
        String roundRoomId = (String) msg.get("roomId");
        int round = (int) msg.get("round");

        log.info("用户 {} 请求开始第 {} 轮", userId, round);

        if (pkServiceInstance == null) {
            log.error("PkService 实例未注入");
            return;
        }

        pkServiceInstance.startNextRound(roundRoomId, round, userId);
    }

    private void handleWarmUpAnswer(Map<String, Object> msg) {
        String warmupRoomId = (String) msg.get("roomId");
        int questionIndex = (int) msg.get("questionIndex");
        String answer = (String) msg.get("answer");

        log.info("用户 {} 提交热身答案: Q{}={}", userId, questionIndex, answer);

        if (pkServiceInstance == null) {
            log.error("PkService 实例未注入");
            return;
        }

        Map<String, Object> result = pkServiceInstance.submitWarmUp(userId, warmupRoomId, questionIndex, answer);
        sendToUser(userId, result);

        if (result.containsKey("type") && "WARMUP_COMPLETE".equals(result.get("type"))) {
            String roomKey = RedisConstant.PK_ROOM_PREFIX + warmupRoomId;
            Map<Object, Object> room = stringRedisTemplate.opsForHash().entries(roomKey);

            if (!room.isEmpty()) {
                Long userA = Long.valueOf(room.get("userA").toString());
                Long userB = Long.valueOf(room.get("userB").toString());

                stringRedisTemplate.opsForHash().put(roomKey, "warmupComplete:" + userId, "1");

                String completeA = (String) stringRedisTemplate.opsForHash().get(roomKey, "warmupComplete:" + userA);
                String completeB = (String) stringRedisTemplate.opsForHash().get(roomKey, "warmupComplete:" + userB);

                if ("1".equals(completeA) && "1".equals(completeB)) {
                    pkServiceInstance.startBattle(warmupRoomId, userA, userB);
                }
            }
        }
    }

    public static void sendToUser(Long userId, Object message) {
        PkWebSocketHandler handler = USER_SESSIONS.get(userId);
        if (handler != null && handler.session.isOpen()) {
            try {
                handler.session.getBasicRemote().sendText(JSON.toJSONString(message));
            } catch (IOException e) {
                log.error("发送消息失败: userId={}", userId, e);
            }
        }
    }

    public static void sendToRoom(String roomId, Object message) {
        ConcurrentHashMap<Long, PkWebSocketHandler> room = ROOM_SESSIONS.get(roomId);
        if (room != null) {
            String json = JSON.toJSONString(message);
            room.values().forEach(handler -> {
                if (handler.session.isOpen()) {
                    try {
                        handler.session.getBasicRemote().sendText(json);
                    } catch (IOException e) {
                        log.error("发送房间消息失败: roomId={}", roomId, e);
                    }
                }
            });
        }
    }

    private Long parseUserId(String token) {
        try {
            if (stringRedisTemplate == null) {
                return null;
            }
            Map<String, Object> tokenInfo = com.hao.topic.common.utils.JWTUtils.getTokenInfo(token);
            String username = (String) tokenInfo.get("username");
            String userIdStr = (String) tokenInfo.get("id");

            if (username == null || userIdStr == null) {
                return null;
            }

            String cachedToken = stringRedisTemplate.opsForValue().get(username);
            if (cachedToken == null || !cachedToken.equals(token)) {
                log.warn("WebSocket Token验证失败: {}", username);
                return null;
            }

            return Long.valueOf(userIdStr);
        } catch (Exception e) {
            log.error("解析token失败", e);
        }
        return null;
    }
}
