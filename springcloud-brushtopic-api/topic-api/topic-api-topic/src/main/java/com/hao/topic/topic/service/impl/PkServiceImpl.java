package com.hao.topic.topic.service.impl;

import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hao.topic.common.constant.RedisConstant;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.model.entity.topic.PkRecord;
import com.hao.topic.model.entity.topic.PkUserLevel;
import com.hao.topic.model.entity.topic.Topic;
import com.hao.topic.model.entity.topic.TopicRecord;
import com.hao.topic.model.vo.topic.PkRankVo;
import com.hao.topic.topic.mapper.PkRecordMapper;
import com.hao.topic.topic.mapper.PkUserLevelMapper;
import com.hao.topic.topic.mapper.PkWordItemMapper;
import com.hao.topic.topic.mapper.TopicMapper;
import com.hao.topic.topic.mapper.TopicRecordMapper;
import com.hao.topic.topic.service.PkService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class PkServiceImpl implements PkService {

    private final StringRedisTemplate stringRedisTemplate;
    private final PkRecordMapper pkRecordMapper;
    private final PkUserLevelMapper pkUserLevelMapper;
    private final TopicMapper topicMapper;
    private final TopicRecordMapper topicRecordMapper;
    private final PkWordItemMapper pkWordItemMapper;

    private static final org.springframework.data.redis.core.script.DefaultRedisScript<Long> SECKILL_SCRIPT;

    static {
        SECKILL_SCRIPT = new org.springframework.data.redis.core.script.DefaultRedisScript<>();
        SECKILL_SCRIPT.setScriptText(
            "local userId = ARGV[1]\n" +
            "local userKey = KEYS[2]\n" +
            "if redis.call('SISMEMBER', userKey, userId) == 1 then\n" +
            "    return -1\n" +
            "end\n" +
            "local lockKey = KEYS[3] .. userId .. ':matching'\n" +
            "if redis.call('GET', lockKey) == '1' then\n" +
            "    return -1\n" +
            "end\n" +
            "redis.call('LPUSH', KEYS[1], userId)\n" +
            "redis.call('SET', lockKey, '1', 'EX', 10)\n" +
            "return 1"
        );
        SECKILL_SCRIPT.setResultType(Long.class);
    }

    private static final int WARMUP_COUNT = 15;
    private static final int WARMUP_TIME_LIMIT = 15;
    private static final int WARMUP_ROUNDS = 3;

    private static final int LEVEL_1_THRESHOLD = 0;

    @Override
    public void startMatch(Long userId) {
        String queueKey = RedisConstant.PK_QUEUE;
        String userSetKey = "pk:matching:users";
        String lockPrefix = RedisConstant.PK_USER_MATCHING_PREFIX;

        Long result = stringRedisTemplate.execute(
                SECKILL_SCRIPT,
                List.of(queueKey, userSetKey, lockPrefix),
                userId.toString()
        );

        if (result == null || result == -1L) {
            throw new TopicException("您已在匹配中，请勿重复操作");
        }

        tryMatch();
    }

    @Override
    public void cancelMatch(Long userId) {
        String lockKey = RedisConstant.PK_USER_MATCHING_PREFIX + userId + RedisConstant.PK_USER_MATCHING_SUFFIX;
        stringRedisTemplate.delete(lockKey);
        stringRedisTemplate.opsForList().remove(RedisConstant.PK_QUEUE, 1, userId.toString());
    }

    @Override
    @Transactional
    public Map<String, Object> submitAnswer(Long userId, String roomId, int questionIndex, String answer) {
        String roomKey = RedisConstant.PK_ROOM_PREFIX + roomId;
        Map<Object, Object> room = stringRedisTemplate.opsForHash().entries(roomKey);

        if (room.isEmpty() || !"1".equals(room.get("status").toString())) {
            throw new TopicException("PK 已结束或房间不存在");
        }

        String userA = room.get("userA").toString();
        String scoreField = userId.toString().equals(userA) ? "scoreA" : "scoreB";

        int currentRound = Integer.parseInt(room.get("currentRound").toString());
        String roundQuestionsKey = roomKey + ":round:" + currentRound;
        String questionId = stringRedisTemplate.opsForList().index(roundQuestionsKey, questionIndex);
        if (questionId == null) {
            throw new TopicException("题目不存在");
        }

        Topic topic = topicMapper.selectById(Long.valueOf(questionId));
        boolean correct = topic != null && answer.equalsIgnoreCase(topic.getCorrectOption());

        if (correct) {
            stringRedisTemplate.opsForHash().increment(roomKey, scoreField, 1);
        }

        Long totalAnswers = stringRedisTemplate.opsForHash().increment(roomKey, "answerCount", 1);

        Map<String, Object> scoreUpdate = new HashMap<>();
        scoreUpdate.put("type", "SCORE_UPDATE");
        scoreUpdate.put("scoreA", room.get("scoreA"));
        scoreUpdate.put("scoreB", room.get("scoreB"));
        scoreUpdate.put("currentQuestion", totalAnswers);
        scoreUpdate.put("totalCount", RedisConstant.PK_QUESTIONS_PER_USER);
        scoreUpdate.put("correct", correct);
        PkWebSocketHandler.sendToRoom(roomId, scoreUpdate);

        Map<String, Object> result = new HashMap<>();
        result.put("correct", correct);
        result.put("correctOption", topic != null ? topic.getCorrectOption() : "");
        result.put("scoreA", stringRedisTemplate.opsForHash().get(roomKey, "scoreA"));
        result.put("scoreB", stringRedisTemplate.opsForHash().get(roomKey, "scoreB"));

        if (totalAnswers >= RedisConstant.PK_QUESTIONS_PER_USER) {
            endRound(roomId, currentRound);
        }

        return result;
    }

    @Transactional
    public void endRound(String roomId, int round) {
        String roomKey = RedisConstant.PK_ROOM_PREFIX + roomId;
        Map<Object, Object> room = stringRedisTemplate.opsForHash().entries(roomKey);

        if (room.isEmpty()) {
            return;
        }

        Long userA = Long.valueOf(room.get("userA").toString());
        Long userB = Long.valueOf(room.get("userB").toString());
        int scoreA = Integer.parseInt(room.get("scoreA").toString());
        int scoreB = Integer.parseInt(room.get("scoreB").toString());

        Long winnerId = null;
        if (scoreA > scoreB) {
            winnerId = userA;
        } else if (scoreB > scoreA) {
            winnerId = userB;
        }

        String winsAKey = "roundWinsA";
        String winsBKey = "roundWinsB";
        if (winnerId != null && winnerId.equals(userA)) {
            stringRedisTemplate.opsForHash().increment(roomKey, winsAKey, 1);
        } else if (winnerId != null && winnerId.equals(userB)) {
            stringRedisTemplate.opsForHash().increment(roomKey, winsBKey, 1);
        }

        Map<String, Object> roundEnd = new HashMap<>();
        roundEnd.put("type", "ROUND_END");
        roundEnd.put("round", round);
        roundEnd.put("scoreA", scoreA);
        roundEnd.put("scoreB", scoreB);
        roundEnd.put("winner", winnerId == null ? "DRAW" : (winnerId.equals(userA) ? "A" : "B"));
        PkWebSocketHandler.sendToRoom(roomId, roundEnd);

        int totalRounds = Integer.parseInt(room.get("totalRounds").toString());
        if (round >= totalRounds) {
            determineLevel(roomId);
        }
    }

    @Transactional
    public void startNextRound(String roomId, int round, Long userId) {
        String roomKey = RedisConstant.PK_ROOM_PREFIX + roomId;
        Map<Object, Object> room = stringRedisTemplate.opsForHash().entries(roomKey);

        if (room.isEmpty()) {
            return;
        }

        Long userA = Long.valueOf(room.get("userA").toString());
        Long userB = Long.valueOf(room.get("userB").toString());

        String allQuestionsKey = roomKey + RedisConstant.PK_ROOM_QUESTIONS_SUFFIX;
        List<String> allQuestionIds = stringRedisTemplate.opsForList().range(allQuestionsKey, 0, -1);

        if (allQuestionIds == null || allQuestionIds.isEmpty()) {
            log.error("题目列表为空，roomId={}", roomId);
            return;
        }

        List<Long> allTopicIds = allQuestionIds.stream()
                .map(Long::valueOf)
                .collect(Collectors.toList());

        sendRoundQuestions(roomId, userA, userB, round, allTopicIds);
    }

    @Transactional
    public void determineLevel(String roomId) {
        String roomKey = RedisConstant.PK_ROOM_PREFIX + roomId;
        Map<Object, Object> room = stringRedisTemplate.opsForHash().entries(roomKey);

        if (room.isEmpty()) {
            return;
        }

        Long userA = Long.valueOf(room.get("userA").toString());
        Long userB = Long.valueOf(room.get("userB").toString());

        int winsA = Integer.parseInt(room.getOrDefault("roundWinsA", "0").toString());
        int winsB = Integer.parseInt(room.getOrDefault("roundWinsB", "0").toString());

        int totalRounds = Integer.parseInt(room.get("totalRounds").toString());

        PkUserLevel levelA = getUserLevelEntity(userA);
        PkUserLevel levelB = getUserLevelEntity(userB);

        if (levelA == null) {
            levelA = new PkUserLevel();
            levelA.setUserId(userA);
            levelA.setLevel(1);
            levelA.setScore(0);
            levelA.setTotalGames(0);
            levelA.setWins(0);
            levelA.setWinStreak(0);
            levelA.setMaxWinStreak(0);
            pkUserLevelMapper.insert(levelA);
        }

        if (levelB == null) {
            levelB = new PkUserLevel();
            levelB.setUserId(userB);
            levelB.setLevel(1);
            levelB.setScore(0);
            levelB.setTotalGames(0);
            levelB.setWins(0);
            levelB.setWinStreak(0);
            levelB.setMaxWinStreak(0);
            pkUserLevelMapper.insert(levelB);
        }

        updateLevelFromPreMatch(levelA, winsA, totalRounds);
        updateLevelFromPreMatch(levelB, winsB, totalRounds);

        pkUserLevelMapper.updateById(levelA);
        pkUserLevelMapper.updateById(levelB);

        stringRedisTemplate.opsForValue().set("pk:level:" + userA, String.valueOf(levelA.getLevel()), 2, TimeUnit.HOURS);
        stringRedisTemplate.opsForValue().set("pk:level:" + userB, String.valueOf(levelB.getLevel()), 2, TimeUnit.HOURS);

        Map<String, Object> levelMsgA = new HashMap<>();
        levelMsgA.put("type", "LEVEL_DETERMINED");
        levelMsgA.put("level", levelA.getLevel());
        levelMsgA.put("levelName", getLevelName(levelA.getLevel()));
        levelMsgA.put("wins", winsA);
        levelMsgA.put("totalRounds", totalRounds);
        PkWebSocketHandler.sendToUser(userA, levelMsgA);

        Map<String, Object> levelMsgB = new HashMap<>();
        levelMsgB.put("type", "LEVEL_DETERMINED");
        levelMsgB.put("level", levelB.getLevel());
        levelMsgB.put("levelName", getLevelName(levelB.getLevel()));
        levelMsgB.put("wins", winsB);
        levelMsgB.put("totalRounds", totalRounds);
        PkWebSocketHandler.sendToUser(userB, levelMsgB);

        String today = LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE);
        String dailyRankKey = RedisConstant.PK_RANK_DAILY_PREFIX + today;

        Long winnerId = null;
        int scoreA = Integer.parseInt(room.get("scoreA").toString());
        int scoreB = Integer.parseInt(room.get("scoreB").toString());
        if (scoreA > scoreB) {
            winnerId = userA;
        } else if (scoreB > scoreA) {
            winnerId = userB;
        }

        if (winnerId != null) {
            Long loserId = winnerId.equals(userA) ? userB : userA;
            stringRedisTemplate.opsForZSet().incrementScore(dailyRankKey, winnerId.toString(), totalRounds);
            stringRedisTemplate.opsForZSet().incrementScore(RedisConstant.PK_RANK_ALL, winnerId.toString(), 10 * totalRounds);
            stringRedisTemplate.opsForZSet().incrementScore(RedisConstant.PK_RANK_ALL, loserId.toString(), 3 * totalRounds);
        } else {
            stringRedisTemplate.opsForZSet().incrementScore(dailyRankKey, userA.toString(), totalRounds);
            stringRedisTemplate.opsForZSet().incrementScore(dailyRankKey, userB.toString(), totalRounds);
            stringRedisTemplate.opsForZSet().incrementScore(RedisConstant.PK_RANK_ALL, userA.toString(), 5 * totalRounds);
            stringRedisTemplate.opsForZSet().incrementScore(RedisConstant.PK_RANK_ALL, userB.toString(), 5 * totalRounds);
        }

        stringRedisTemplate.expire(dailyRankKey, Duration.ofDays(2));

        PkRecord record = new PkRecord();
        record.setRoomId(roomId);
        record.setUserAId(userA);
        record.setUserBId(userB);
        record.setUserAScore(scoreA);
        record.setUserBScore(scoreB);
        record.setWinnerId(winnerId);
        record.setTotalQuestions(RedisConstant.PK_QUESTIONS_PER_USER * totalRounds);
        record.setEndTime(LocalDateTime.now());
        pkRecordMapper.insert(record);

        stringRedisTemplate.delete(roomKey);
        stringRedisTemplate.delete(roomKey + RedisConstant.PK_ROOM_QUESTIONS_SUFFIX);
        for (int i = 1; i <= totalRounds; i++) {
            stringRedisTemplate.delete(roomKey + ":round:" + i);
        }
    }

    private void updateLevelFromPreMatch(PkUserLevel userLevel, int wins, int totalRounds) {
        userLevel.setTotalGames(userLevel.getTotalGames() + totalRounds);
        userLevel.setWins(userLevel.getWins() + wins);

        int winRate = totalRounds > 0 ? (wins * 100 / totalRounds) : 0;

        if (winRate >= 80 && userLevel.getLevel() < 4) {
            userLevel.setLevel(userLevel.getLevel() + 1);
        } else if (winRate >= 60) {
        } else if (winRate <= 30 && userLevel.getLevel() > 1) {
            userLevel.setLevel(userLevel.getLevel() - 1);
        }

        userLevel.setScore(userLevel.getScore() + wins * 10);
    }

    @Override
    @Transactional
    public void endRoom(String roomId) {
        String roomKey = RedisConstant.PK_ROOM_PREFIX + roomId;
        Map<Object, Object> room = stringRedisTemplate.opsForHash().entries(roomKey);

        if (room.isEmpty()) {
            return;
        }

        Long userA = Long.valueOf(room.get("userA").toString());
        Long userB = Long.valueOf(room.get("userB").toString());
        int scoreA = Integer.parseInt(room.get("scoreA").toString());
        int scoreB = Integer.parseInt(room.get("scoreB").toString());

        Long winnerId = null;
        if (scoreA > scoreB) {
            winnerId = userA;
        } else if (scoreB > scoreA) {
            winnerId = userB;
        }

        String today = LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE);
        String dailyRankKey = RedisConstant.PK_RANK_DAILY_PREFIX + today;

        if (winnerId != null) {
            Long loserId = winnerId.equals(userA) ? userB : userA;
            stringRedisTemplate.opsForZSet().incrementScore(dailyRankKey, winnerId.toString(), 1);
            stringRedisTemplate.opsForZSet().incrementScore(RedisConstant.PK_RANK_ALL, winnerId.toString(), 10);
            stringRedisTemplate.opsForZSet().incrementScore(RedisConstant.PK_RANK_ALL, loserId.toString(), 3);
        } else {
            stringRedisTemplate.opsForZSet().incrementScore(dailyRankKey, userA.toString(), 1);
            stringRedisTemplate.opsForZSet().incrementScore(dailyRankKey, userB.toString(), 1);
            stringRedisTemplate.opsForZSet().incrementScore(RedisConstant.PK_RANK_ALL, userA.toString(), 5);
            stringRedisTemplate.opsForZSet().incrementScore(RedisConstant.PK_RANK_ALL, userB.toString(), 5);
        }

        stringRedisTemplate.expire(dailyRankKey, Duration.ofDays(2));

        PkRecord record = new PkRecord();
        record.setRoomId(roomId);
        record.setUserAId(userA);
        record.setUserBId(userB);
        record.setUserAScore(scoreA);
        record.setUserBScore(scoreB);
        record.setWinnerId(winnerId);
        record.setTotalQuestions(RedisConstant.PK_QUESTIONS_PER_USER);
        record.setEndTime(LocalDateTime.now());
        pkRecordMapper.insert(record);

        updateUserLevel(userA, winnerId != null && winnerId.equals(userA));
        updateUserLevel(userB, winnerId != null && winnerId.equals(userB));

        stringRedisTemplate.delete(roomKey);
        stringRedisTemplate.delete(roomKey + RedisConstant.PK_ROOM_QUESTIONS_SUFFIX);

        Map<String, Object> endMsg = new HashMap<>();
        endMsg.put("type", "PK_END");
        endMsg.put("winner", winnerId == null ? "DRAW" : (winnerId.equals(userA) ? "A" : "B"));
        endMsg.put("scoreA", scoreA);
        endMsg.put("scoreB", scoreB);
        endMsg.put("roomId", roomId);
        PkWebSocketHandler.sendToRoom(roomId, endMsg);
    }

    @Override
    public List<PkRankVo> getRank(String type, int page, int size) {
        String key;
        if ("daily".equals(type)) {
            String today = LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE);
            key = RedisConstant.PK_RANK_DAILY_PREFIX + today;
        } else {
            key = RedisConstant.PK_RANK_ALL;
        }

        long start = (long) (page - 1) * size;
        long end = start + size - 1;

        Set<ZSetOperations.TypedTuple<String>> tuples =
                stringRedisTemplate.opsForZSet().reverseRangeWithScores(key, start, end);

        if (tuples == null || tuples.isEmpty()) {
            return Collections.emptyList();
        }

        List<PkRankVo> result = new ArrayList<>();
        long rank = start + 1;
        for (ZSetOperations.TypedTuple<String> tuple : tuples) {
            PkRankVo vo = new PkRankVo();
            vo.setUserId(Long.valueOf(Objects.requireNonNull(tuple.getValue())));
            vo.setScore(tuple.getScore() != null ? tuple.getScore().intValue() : 0);
            vo.setRank(rank++);
            result.add(vo);
        }
        return result;
    }

    @Override
    public Map<String, Object> getMyPkStats(Long userId) {
        String today = LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE);
        String dailyKey = RedisConstant.PK_RANK_DAILY_PREFIX + today;

        Double dailyScore = stringRedisTemplate.opsForZSet().score(dailyKey, userId.toString());
        Long dailyRank = stringRedisTemplate.opsForZSet().reverseRank(dailyKey, userId.toString());

        Double totalScore = stringRedisTemplate.opsForZSet().score(RedisConstant.PK_RANK_ALL, userId.toString());
        Long totalRank = stringRedisTemplate.opsForZSet().reverseRank(RedisConstant.PK_RANK_ALL, userId.toString());

        LambdaQueryWrapper<PkRecord> wrapper = new LambdaQueryWrapper<>();
        wrapper.and(w -> w.eq(PkRecord::getUserAId, userId).or().eq(PkRecord::getUserBId, userId));
        Long totalGames = pkRecordMapper.selectCount(wrapper);

        LambdaQueryWrapper<PkRecord> winWrapper = new LambdaQueryWrapper<>();
        winWrapper.eq(PkRecord::getWinnerId, userId);
        Long wins = pkRecordMapper.selectCount(winWrapper);

        PkUserLevel userLevel = getUserLevelEntity(userId);

        Map<String, Object> stats = new HashMap<>();
        stats.put("dailyScore", dailyScore != null ? dailyScore.intValue() : 0);
        stats.put("dailyRank", dailyRank != null ? dailyRank + 1 : 0);
        stats.put("totalScore", totalScore != null ? totalScore.intValue() : 0);
        stats.put("totalRank", totalRank != null ? totalRank + 1 : 0);
        stats.put("totalGames", totalGames);
        stats.put("wins", wins);
        stats.put("winRate", totalGames > 0 ? Math.round(wins * 100.0 / totalGames) : 0);
        stats.put("level", userLevel != null ? userLevel.getLevel() : 1);
        stats.put("score", userLevel != null ? userLevel.getScore() : 0);
        stats.put("levelName", getLevelName(userLevel != null ? userLevel.getLevel() : 1));
        return stats;
    }

    @Override
    public Map<String, Object> submitWarmUp(Long userId, String roomId, int questionIndex, String answer) {
        return new HashMap<>();
    }

    @Override
    public int getUserLevel(Long userId) {
        String cached = stringRedisTemplate.opsForValue().get("pk:level:" + userId);
        if (cached != null) {
            return Integer.parseInt(cached);
        }

        PkUserLevel userLevel = getUserLevelEntity(userId);
        int level = userLevel != null ? userLevel.getLevel() : 1;
        stringRedisTemplate.opsForValue().set("pk:level:" + userId, String.valueOf(level), 2, TimeUnit.HOURS);
        return level;
    }

    public void startBattle(String roomId, Long userIdA, Long userIdB) {
        String roomKey = RedisConstant.PK_ROOM_PREFIX + roomId;
        Map<Object, Object> room = stringRedisTemplate.opsForHash().entries(roomKey);

        if (room.isEmpty()) {
            return;
        }

        int levelA = getUserLevel(userIdA);
        int levelB = getUserLevel(userIdB);
        int avgLevel = (levelA + levelB) / 2;

        List<Long> allTopicIds = getTopicsByLevel(avgLevel);
        if (allTopicIds.size() < RedisConstant.PK_TOTAL_QUESTIONS) {
            log.warn("题库题目不足，当前{}道，需要{}道", allTopicIds.size(), RedisConstant.PK_TOTAL_QUESTIONS);
            throw new TopicException("题库题目不足，暂无法PK");
        }

        Collections.shuffle(allTopicIds);
        List<Long> selectedIds = allTopicIds.subList(0, RedisConstant.PK_TOTAL_QUESTIONS);

        stringRedisTemplate.opsForHash().put(roomKey, "status", "1");

        String questionsKey = roomKey + RedisConstant.PK_ROOM_QUESTIONS_SUFFIX;
        stringRedisTemplate.opsForList().rightPushAll(questionsKey,
                selectedIds.stream().map(String::valueOf).toList());
        stringRedisTemplate.expire(questionsKey, Duration.ofMinutes(RedisConstant.PK_ROOM_TTL));

        Map<String, Object> battleStart = new HashMap<>();
        battleStart.put("type", "BATTLE_START");
        battleStart.put("roomId", roomId);
        battleStart.put("totalCount", RedisConstant.PK_QUESTIONS_PER_USER);
        battleStart.put("levelA", levelA);
        battleStart.put("levelB", levelB);

        List<Map<String, Object>> questionList = new ArrayList<>();
        for (int i = 0; i < selectedIds.size(); i++) {
            Topic topic = topicMapper.selectById(selectedIds.get(i));
            if (topic != null) {
                Map<String, Object> q = new HashMap<>();
                q.put("index", i);
                q.put("word", topic.getTopicName());
                q.put("options", topic.getOptions());
                questionList.add(q);
            }
        }
        battleStart.put("questions", questionList);

        PkWebSocketHandler.sendToUser(userIdA, battleStart);
        PkWebSocketHandler.sendToUser(userIdB, battleStart);
    }

    private void tryMatch() {
        String userA = stringRedisTemplate.opsForList().rightPop(RedisConstant.PK_QUEUE);
        if (userA == null) {
            return;
        }

        String userB = stringRedisTemplate.opsForList().rightPop(RedisConstant.PK_QUEUE);
        if (userB == null) {
            stringRedisTemplate.opsForList().leftPush(RedisConstant.PK_QUEUE, userA);
            return;
        }

        if (userA.equals(userB)) {
            stringRedisTemplate.opsForList().leftPush(RedisConstant.PK_QUEUE, userA);
            stringRedisTemplate.opsForList().leftPush(RedisConstant.PK_QUEUE, userB);
            return;
        }

        createRoom(Long.valueOf(userA), Long.valueOf(userB));
    }

    private void createRoom(Long userIdA, Long userIdB) {
        String roomId = UUID.randomUUID().toString().replace("-", "").substring(0, 16);
        String roomKey = RedisConstant.PK_ROOM_PREFIX + roomId;

        int levelA = getUserLevel(userIdA);
        int levelB = getUserLevel(userIdB);
        int avgLevel = (levelA + levelB) / 2;

        List<Long> allTopicIds = getTopicsByLevel(avgLevel);
        if (allTopicIds.size() < RedisConstant.PK_TOTAL_QUESTIONS * WARMUP_ROUNDS) {
            log.warn("题库题目不足，当前{}道，需要{}道", allTopicIds.size(), RedisConstant.PK_TOTAL_QUESTIONS * WARMUP_ROUNDS);
            throw new TopicException("题库题目不足，暂无法PK");
        }

        Collections.shuffle(allTopicIds);
        List<Long> selectedIds = allTopicIds.subList(0, RedisConstant.PK_TOTAL_QUESTIONS * WARMUP_ROUNDS);

        Map<String, String> roomData = new HashMap<>();
        roomData.put("userA", userIdA.toString());
        roomData.put("userB", userIdB.toString());
        roomData.put("scoreA", "0");
        roomData.put("scoreB", "0");
        roomData.put("answerCount", "0");
        roomData.put("status", "1");
        roomData.put("levelA", String.valueOf(levelA));
        roomData.put("levelB", String.valueOf(levelB));
        roomData.put("currentRound", "1");
        roomData.put("totalRounds", String.valueOf(WARMUP_ROUNDS));
        roomData.put("roundWinsA", "0");
        roomData.put("roundWinsB", "0");
        stringRedisTemplate.opsForHash().putAll(roomKey, roomData);
        stringRedisTemplate.expire(roomKey, Duration.ofMinutes(RedisConstant.PK_ROOM_TTL + 10));

        String questionsKey = roomKey + RedisConstant.PK_ROOM_QUESTIONS_SUFFIX;
        stringRedisTemplate.opsForList().rightPushAll(questionsKey,
                selectedIds.stream().map(String::valueOf).toList());
        stringRedisTemplate.expire(questionsKey, Duration.ofMinutes(RedisConstant.PK_ROOM_TTL + 10));

        sendRoundQuestions(roomId, userIdA, userIdB, 1, selectedIds);

        Map<String, Object> matchSuccess = new HashMap<>();
        matchSuccess.put("type", "MATCH_SUCCESS");
        matchSuccess.put("roomId", roomId);
        matchSuccess.put("userA", userIdA);
        matchSuccess.put("userB", userIdB);
        matchSuccess.put("totalCount", RedisConstant.PK_QUESTIONS_PER_USER);
        matchSuccess.put("levelA", levelA);
        matchSuccess.put("levelB", levelB);
        matchSuccess.put("warmupCount", WARMUP_ROUNDS);

        PkWebSocketHandler.sendToUser(userIdA, matchSuccess);
        PkWebSocketHandler.sendToUser(userIdB, matchSuccess);
    }

    private void sendRoundQuestions(String roomId, Long userIdA, Long userIdB, int round, List<Long> allTopicIds) {
        int startIndex = (round - 1) * RedisConstant.PK_QUESTIONS_PER_USER;
        int endIndex = startIndex + RedisConstant.PK_QUESTIONS_PER_USER;

        if (endIndex > allTopicIds.size()) {
            log.warn("题目不足，round={}, startIndex={}, size={}", round, startIndex, allTopicIds.size());
            return;
        }

        List<Long> roundTopicIds = allTopicIds.subList(startIndex, endIndex);

        String roomKey = RedisConstant.PK_ROOM_PREFIX + roomId;
        stringRedisTemplate.opsForHash().put(roomKey, "currentRound", String.valueOf(round));
        stringRedisTemplate.opsForHash().put(roomKey, "answerCount", "0");
        stringRedisTemplate.opsForHash().put(roomKey, "scoreA", "0");
        stringRedisTemplate.opsForHash().put(roomKey, "scoreB", "0");

        String roundQuestionsKey = roomKey + ":round:" + round;
        stringRedisTemplate.opsForList().rightPushAll(roundQuestionsKey,
                roundTopicIds.stream().map(String::valueOf).toList());
        stringRedisTemplate.expire(roundQuestionsKey, Duration.ofMinutes(RedisConstant.PK_ROOM_TTL + 10));

        Map<String, Object> battleStart = new HashMap<>();
        battleStart.put("type", "BATTLE_QUESTIONS");
        battleStart.put("roomId", roomId);
        battleStart.put("round", round);
        battleStart.put("totalCount", RedisConstant.PK_QUESTIONS_PER_USER);

        List<Map<String, Object>> questionList = new ArrayList<>();
        for (int i = 0; i < roundTopicIds.size(); i++) {
            Topic topic = topicMapper.selectById(roundTopicIds.get(i));
            if (topic != null) {
                Map<String, Object> q = new HashMap<>();
                q.put("index", i);
                q.put("word", topic.getTopicName());
                q.put("options", topic.getOptions());
                questionList.add(q);
            }
        }
        battleStart.put("questions", questionList);

        PkWebSocketHandler.sendToUser(userIdA, battleStart);
        PkWebSocketHandler.sendToUser(userIdB, battleStart);
    }

    private List<Long> getAllTopicIds() {
        LambdaQueryWrapper<Topic> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Topic::getStatus, 0);
        wrapper.select(Topic::getId);
        return topicMapper.selectList(wrapper).stream()
                .map(Topic::getId)
                .collect(Collectors.toList());
    }

    private List<Long> getTopicsByLevel(int level) {
        LambdaQueryWrapper<Topic> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Topic::getStatus, 0);
        wrapper.select(Topic::getId);

        if (level <= 1) {
            wrapper.last("ORDER BY RAND() LIMIT 200");
        } else if (level <= 2) {
            wrapper.last("ORDER BY RAND() LIMIT 300");
        } else if (level <= 3) {
            wrapper.last("ORDER BY RAND() LIMIT 400");
        } else {
            wrapper.select(Topic::getId);
        }

        return topicMapper.selectList(wrapper).stream()
                .map(Topic::getId)
                .collect(Collectors.toList());
    }

    private PkUserLevel getUserLevelEntity(Long userId) {
        LambdaQueryWrapper<PkUserLevel> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PkUserLevel::getUserId, userId);
        return pkUserLevelMapper.selectOne(wrapper);
    }

    private void updateUserLevel(Long userId, boolean isWin) {
        PkUserLevel userLevel = getUserLevelEntity(userId);
        if (userLevel == null) {
            userLevel = new PkUserLevel();
            userLevel.setUserId(userId);
            userLevel.setLevel(1);
            userLevel.setScore(0);
            userLevel.setTotalGames(0);
            userLevel.setWins(0);
            userLevel.setWinStreak(0);
            userLevel.setMaxWinStreak(0);
            pkUserLevelMapper.insert(userLevel);
        }

        userLevel.setTotalGames(userLevel.getTotalGames() + 1);

        if (isWin) {
            userLevel.setWins(userLevel.getWins() + 1);
            userLevel.setWinStreak(userLevel.getWinStreak() + 1);
            userLevel.setScore(userLevel.getScore() + 10);

            if (userLevel.getWinStreak() > userLevel.getMaxWinStreak()) {
                userLevel.setMaxWinStreak(userLevel.getWinStreak());
            }

            if (userLevel.getWinStreak() >= 3 && userLevel.getLevel() < 4) {
                userLevel.setLevel(userLevel.getLevel() + 1);
                userLevel.setWinStreak(0);
            }
        } else {
            userLevel.setWinStreak(0);
            userLevel.setScore(Math.max(0, userLevel.getScore() - 5));

            if (userLevel.getScore() < getLevelThreshold(userLevel.getLevel()) && userLevel.getLevel() > 1) {
                userLevel.setLevel(userLevel.getLevel() - 1);
            }
        }

        pkUserLevelMapper.updateById(userLevel);
        stringRedisTemplate.opsForValue().set("pk:level:" + userId, String.valueOf(userLevel.getLevel()), 2, TimeUnit.HOURS);
    }

    private int getLevelThreshold(int level) {
        return switch (level) {
            case 2 -> 100;
            case 3 -> 300;
            case 4 -> 600;
            default -> 0;
        };
    }

    private String getLevelName(int level) {
        return switch (level) {
            case 1 -> "Lv1 初学者";
            case 2 -> "Lv2 进阶者";
            case 3 -> "Lv3 挑战者";
            case 4 -> "Lv4 大师";
            default -> "Lv1 初学者";
        };
    }
}
