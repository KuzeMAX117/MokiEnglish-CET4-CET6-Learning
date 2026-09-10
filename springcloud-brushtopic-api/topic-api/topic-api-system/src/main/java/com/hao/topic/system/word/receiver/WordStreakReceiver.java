package com.hao.topic.system.word.receiver;

import com.alibaba.fastjson2.JSON;
import com.hao.topic.api.utils.constant.RabbitConstant;
import com.hao.topic.common.constant.RedisConstant;
import com.hao.topic.model.dto.word.WordStudyMessage;
import com.rabbitmq.client.Channel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.Exchange;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.QueueBinding;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Component
@Slf4j
public class WordStreakReceiver {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @RabbitListener(
            bindings = @QueueBinding(
                    value = @Queue(value = RabbitConstant.WORD_STUDY_QUEUE_NAME),
                    exchange = @Exchange(value = RabbitConstant.WORD_STUDY_EXCHANGE),
                    key = {RabbitConstant.WORD_STUDY_ROUTING_KEY_NAME}))
    public void handleWordStudy(String messageJson, Message message, Channel channel) {
        log.info("接收到打卡学习消息: {}", messageJson);

        WordStudyMessage msg = JSON.parseObject(messageJson, WordStudyMessage.class);
        String userId = String.valueOf(msg.getUserId());
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        String lockKey = RedisConstant.STREAK_LOCK_KEY_PREFIX + userId;
        try {
            Boolean acquiredLock = stringRedisTemplate.opsForValue()
                    .setIfAbsent(lockKey, "1", RedisConstant.STREAK_LOCK_EXPIRE_TIME, TimeUnit.MINUTES);
            if (acquiredLock == null || !acquiredLock) {
                log.info("打卡处理中，忽略重复消息: {}", userId);
                channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
                return;
            }

            String lastStudyDate = stringRedisTemplate.opsForValue()
                    .get(RedisConstant.USER_LAST_STUDY_KEY_PREFIX + userId);

            if (today.equals(lastStudyDate)) {
                log.info("今日已打卡，跳过: {}", userId);
                channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
                return;
            }

            long streak = 1;
            if (lastStudyDate != null && isYesterday(lastStudyDate)) {
                String currentStreak = stringRedisTemplate.opsForValue()
                        .get(RedisConstant.USER_STREAK_KEY_PREFIX + userId);
                streak = (currentStreak != null ? Long.parseLong(currentStreak) : 0) + 1;
            }

            stringRedisTemplate.opsForValue().set(
                    RedisConstant.USER_STREAK_KEY_PREFIX + userId, String.valueOf(streak));
            stringRedisTemplate.opsForValue().set(
                    RedisConstant.USER_LAST_STUDY_KEY_PREFIX + userId, today);

            // 更新总榜（累计连续天数）
            stringRedisTemplate.opsForZSet().add(
                    RedisConstant.WORD_STREAK_RANK, userId, streak);

            // 更新日榜（今日打卡的人，score=1表示今日已打卡）
            String todayKey = RedisConstant.WORD_STREAK_TODAY_RANK + today;
            stringRedisTemplate.opsForZSet().add(todayKey, userId, 1);
            // 日榜过期时间2天
            stringRedisTemplate.expire(todayKey, 2, TimeUnit.DAYS);

            Map<String, String> userInfo = new HashMap<>();
            userInfo.put("nickname", msg.getNickname());
            userInfo.put("avatar", msg.getAvatar());
            userInfo.put("role", msg.getRole());
            stringRedisTemplate.opsForHash().putAll(
                    RedisConstant.USER_RANK_PREFIX + userId, userInfo);

            log.info("打卡成功，用户: {}, 连续天数: {}", userId, streak);

            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
        } catch (Exception e) {
            log.error("打卡处理异常", e);
        } finally {
            stringRedisTemplate.delete(lockKey);
        }
    }

    private boolean isYesterday(String dateStr) {
        LocalDate date = LocalDate.parse(dateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        return ChronoUnit.DAYS.between(date, LocalDate.now()) == 1;
    }
}
