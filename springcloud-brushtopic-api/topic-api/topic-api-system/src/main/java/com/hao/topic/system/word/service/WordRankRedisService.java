package com.hao.topic.system.word.service;

import com.hao.topic.system.word.mapper.UserWordRecordMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class WordRankRedisService {

    private final StringRedisTemplate stringRedisTemplate;
    private final UserWordRecordMapper userWordRecordMapper;

    /** Redis ZSET key: 打卡连续天数排行榜 */
    private static final String RANK_KEY = "word:rank:streak";

    /**
     * 从MySQL同步所有用户打卡数据到Redis ZSET
     */
    public void syncFromMySQL() {
        log.info("开始同步打卡数据到Redis...");
        List<Map<String, Object>> rankData = userWordRecordMapper.getWordCountRank();
        if (rankData == null || rankData.isEmpty()) {
            log.info("MySQL中无打卡数据，跳过同步");
            return;
        }

        stringRedisTemplate.delete(RANK_KEY);

        Map<String, Double> scoreMap = new HashMap<>();
        for (Map<String, Object> row : rankData) {
            Object userIdObj = row.get("userId");
            Object scopeObj = row.get("scope");
            if (userIdObj != null && scopeObj != null) {
                String userId = String.valueOf(userIdObj);
                double score = ((Number) scopeObj).doubleValue();
                scoreMap.put(userId, score);
            }
        }

        if (!scoreMap.isEmpty()) {
            Set<Map.Entry<String, Double>> entries = scoreMap.entrySet();
            for (Map.Entry<String, Double> entry : entries) {
                stringRedisTemplate.opsForZSet().add(RANK_KEY, entry.getKey(), entry.getValue());
            }
        }

        log.info("同步完成，共 {} 个用户", scoreMap.size());
    }

    /**
     * 更新单个用户的打卡天数到Redis
     */
    public void updateStreak(Long userId) {
        Long streak = userWordRecordMapper.countStreakDays(userId);
        if (streak != null && streak > 0) {
            stringRedisTemplate.opsForZSet().add(RANK_KEY, String.valueOf(userId), streak.doubleValue());
            log.debug("更新用户{}打卡天数到Redis: {}", userId, streak);
        }
    }

    /**
     * 从Redis获取排行榜Top N（含用户信息）
     */
    public List<Map<String, Object>> getRankFromRedis(int limit) {
        Set<org.springframework.data.redis.core.ZSetOperations.TypedTuple<String>> tuples =
                stringRedisTemplate.opsForZSet().reverseRangeWithScores(RANK_KEY, 0, limit - 1);

        if (tuples == null || tuples.isEmpty()) {
            return new ArrayList<>();
        }

        List<Map<String, Object>> result = new ArrayList<>();
        long rank = 1;
        for (org.springframework.data.redis.core.ZSetOperations.TypedTuple<String> tuple : tuples) {
            String userId = tuple.getValue();
            Double score = tuple.getScore();
            if (userId == null) continue;

            Map<String, Object> row = new HashMap<>();
            row.put("userId", Long.valueOf(userId));
            row.put("scope", score != null ? score.longValue() : 0);
            row.put("rank", rank++);

            // 补充用户信息
            Map<String, Object> userInfo = userWordRecordMapper.getUserInfo(Long.valueOf(userId));
            if (userInfo != null) {
                row.put("nickname", userInfo.get("nickname"));
                row.put("avatar", userInfo.get("avatar"));
                row.put("role", userInfo.get("role"));
            }
            result.add(row);
        }
        return result;
    }

    /**
     * 从Redis获取当前用户排名
     */
    public Map<String, Object> getUserRankFromRedis(Long userId) {
        Long rank = stringRedisTemplate.opsForZSet().reverseRank(RANK_KEY, String.valueOf(userId));
        Double score = stringRedisTemplate.opsForZSet().score(RANK_KEY, String.valueOf(userId));

        if (rank == null) {
            return null;
        }

        Map<String, Object> row = new HashMap<>();
        row.put("userId", userId);
        row.put("scope", score != null ? score.longValue() : 0);
        row.put("rank", rank + 1);

        // 补充用户信息
        Map<String, Object> userInfo = userWordRecordMapper.getUserInfo(userId);
        if (userInfo != null) {
            row.put("nickname", userInfo.get("nickname"));
            row.put("avatar", userInfo.get("avatar"));
            row.put("role", userInfo.get("role"));
        }
        return row;
    }
}
