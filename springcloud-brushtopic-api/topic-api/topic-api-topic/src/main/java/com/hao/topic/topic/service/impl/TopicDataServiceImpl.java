package com.hao.topic.topic.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hao.ai.client.ai.AiFeignClient;
import com.hao.topic.api.utils.enums.StatusEnums;
import com.hao.topic.client.security.SecurityFeignClient;
import com.hao.topic.common.constant.RedisConstant;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.entity.topic.*;
import com.hao.topic.model.vo.ai.AiTrendVo;
import com.hao.topic.model.vo.system.SysUserTrentVo;
import com.hao.topic.model.vo.topic.*;
import com.hao.topic.topic.mapper.*;
import com.hao.topic.topic.service.TopicDataService;
import com.hao.topic.topic.service.TopicSubjectService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
@Slf4j
public class TopicDataServiceImpl implements TopicDataService {
    private final SecurityFeignClient securityFeignClient;
    private final TopicRecordMapper topicRecordMapper;
    private final TopicMapper topicMapper;
    private final StringRedisTemplate stringRedisTemplate;
    private final TopicSubjectMapper subjectMapper;
    private final TopicLabelMapper topicLabelMapper;
    private final AiFeignClient aiFeignClient;
    private final TopicCategoryMapper topicCategoryMapper;
    private final TopicCategorySubjectMapper topicCategorySubjectMapper;
    private final TopicSubjectMapper topicSubjectMapper;
    private final TopicSubjectService topicSubjectService;
    private final TopicDailyStagingMapper topicDailyStagingMapper;
    private final TopicLabelTopicMapper topicLabelTopicMapper;
    private final TopicDailyBrushMapper topicDailyBrushMapper;

    

    public Map<String, Object> webHomeCount() {
        
        Long userId = SecurityUtils.getCurrentId();
        
        String role = SecurityUtils.getCurrentRole();
        
        String username = SecurityUtils.getCurrentName();
        
        Long count = securityFeignClient.count();
        
        Long rank = topicRecordMapper.getRank(userId);
        
        Long todayCount = null;
        LambdaQueryWrapper<TopicRecord> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(TopicRecord::getUserId, userId);
        wrapper.eq(TopicRecord::getTopicTime, LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        List<TopicRecord> topicRecords = topicRecordMapper.selectList(wrapper);
        if (!CollectionUtils.isEmpty(topicRecords)) {
            todayCount = topicRecords.stream().mapToLong(TopicRecord::getCount).sum();
        } else {
            todayCount = 0L;
        }
        
        LambdaQueryWrapper<TopicRecord> topicRecordLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicRecordLambdaQueryWrapper.eq(TopicRecord::getUserId, userId);
        topicRecordLambdaQueryWrapper.eq(TopicRecord::getTopicTime, LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
        Long todayTopicCount = topicRecordMapper.selectCount(topicRecordLambdaQueryWrapper);
        
        Long totalTopicCount = null;
        if (role.equals("user")) {
            
            LambdaQueryWrapper<Topic> topicLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicLambdaQueryWrapper.eq(Topic::getCreateBy, "admin");
            topicLambdaQueryWrapper.eq(Topic::getStatus, StatusEnums.NORMAL.getCode());
            totalTopicCount = topicMapper.selectCount(topicLambdaQueryWrapper);
        } else {
            
            LambdaQueryWrapper<Topic> topicLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicLambdaQueryWrapper.eq(Topic::getStatus, StatusEnums.NORMAL.getCode());
            topicLambdaQueryWrapper.in(Topic::getCreateBy, "admin", username);
            totalTopicCount = topicMapper.selectCount(topicLambdaQueryWrapper);
        }
        
        Long totalTopicRecordCountSize = null;
        LambdaQueryWrapper<TopicRecord> topicRecordLambdaQueryWrapper1 = new LambdaQueryWrapper<>();
        topicRecordLambdaQueryWrapper1.eq(TopicRecord::getUserId, userId);
        topicRecordLambdaQueryWrapper1.groupBy(TopicRecord::getTopicId);
        List<TopicRecord> totalTopicRecordCount = topicRecordMapper.selectList(topicRecordLambdaQueryWrapper1);
        if (CollectionUtils.isEmpty(totalTopicRecordCount)) {
            totalTopicRecordCountSize = 0L;
        } else {
            totalTopicRecordCountSize = (long) totalTopicRecordCount.size();
        }
        Map<String, Object> map = new HashMap<>();
        map.put("userCount", count);
        map.put("rank", rank);
        map.put("todayTopicCount", todayTopicCount);
        map.put("totalTopicCount", totalTopicCount);
        map.put("totalTopicRecordCount", totalTopicRecordCountSize);
        map.put("todayCount", todayCount);

        return map;
    }

    

    public List<TopicUserRankVo> rank(Integer type) {
        if (type == null) {
            return null;
        }
        
        List<TopicUserRankVo> rankList = new ArrayList<>();
        if (type == 1) {
            
            String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            String todayKey = RedisConstant.TOPIC_RANK_TODAY_PREFIX + date;
            
            Set<ZSetOperations.TypedTuple<String>> tuples = stringRedisTemplate.opsForZSet()
                    .reverseRangeWithScores(todayKey, 0, 99);
            if (CollectionUtils.isEmpty(tuples)) {
                
                List<TopicUserRankVo> countRank = topicRecordMapper.getCountRank(date);
                if (CollectionUtils.isNotEmpty(countRank)) {
                    readRankTodayCache(countRank);
                }
                return countRank;
            }
            getRankVo(rankList, tuples);
        } else {
            
            
            Set<ZSetOperations.TypedTuple<String>> tuples = stringRedisTemplate.opsForZSet()
                    .reverseRangeWithScores(RedisConstant.TOPIC_RANK_PREFIX, 0, 99);
            if (CollectionUtils.isEmpty(tuples)) {
                
                List<TopicUserRankVo> countRank = topicRecordMapper.getCountRank(null);
                if (CollectionUtils.isNotEmpty(countRank)) {
                    readRankTodayCache(countRank);
                    readRankCache(countRank);
                }
                return countRank;
            }
            getRankVo(rankList, tuples);
        }
        return rankList;
    }

    

    private void getRankVo(List<TopicUserRankVo> rankList, Set<ZSetOperations.TypedTuple<String>> tuples) {
        if (tuples != null) {
            
            for (ZSetOperations.TypedTuple<String> tuple : tuples) {
                
                String userId = tuple.getValue();
                Double score = tuple.getScore();
                log.info("用户ID:{},分数:{}", userId, score);
                
                Map<Object, Object> userInfo = stringRedisTemplate.opsForHash()
                        .entries(RedisConstant.USER_RANK_PREFIX + userId);

                
                TopicUserRankVo topicUserRankVo = new TopicUserRankVo();
                if (score != null) {
                    topicUserRankVo.setScope(score.longValue());
                }
                if (userInfo.get("avatar") == null) {
                    topicUserRankVo.setAvatar(null);
                } else {
                    topicUserRankVo.setAvatar((String) userInfo.get("avatar"));
                }
                topicUserRankVo.setNickname((String) userInfo.get("nickname"));
                if (userId != null) {
                    topicUserRankVo.setUserId(Long.valueOf(userId));
                }
                topicUserRankVo.setRole((String) userInfo.get("role"));

                rankList.add(topicUserRankVo);
            }
        }
    }

    

    public TopicUserRankVo userRank(Integer type) {
        
        Long userId = SecurityUtils.getCurrentId();
        if (userId == null) {
            return null;
        }
        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        String key;
        if (type == 1) {
            
            key = RedisConstant.TOPIC_RANK_TODAY_PREFIX + date;
        } else {
            
            key = RedisConstant.TOPIC_RANK_PREFIX;
        }

        
        Long rank = stringRedisTemplate.opsForZSet().reverseRank(key, userId.toString());
        if (type == 1) {
            
            if (rank == null) {
                
                return topicRecordMapper.getUserCountRank(date, userId);
            }
        } else {
            
            if (rank == null) {
                
                return topicRecordMapper.getUserCountRank(null, userId);
            }
        }

        
        Double score = stringRedisTemplate.opsForZSet().score(key, userId.toString());

        
        if (score == null) {
            return null;
        }

        
        Map<Object, Object> userInfo = stringRedisTemplate.opsForHash()
                .entries(RedisConstant.USER_RANK_PREFIX + userId);

        
        TopicUserRankVo topicUserRankVo = new TopicUserRankVo();
        topicUserRankVo.setUserId(userId);
        topicUserRankVo.setNickname((String) userInfo.get("nickname"));
        topicUserRankVo.setAvatar((String) userInfo.get("avatar"));
        topicUserRankVo.setScope(score.longValue());
        topicUserRankVo.setRank(rank + 1);
        topicUserRankVo.setRole((String) userInfo.get("role"));

        return topicUserRankVo;
    }

    

    public void readRankTodayCache(List<TopicUserRankVo> countRank) {
        
        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        
        for (TopicUserRankVo topicUserRankVo : countRank) {
            
            Map<String, String> userInfo = new HashMap<>();
            userInfo.put("nickname", topicUserRankVo.getNickname());
            userInfo.put("avatar", topicUserRankVo.getAvatar());
            userInfo.put("role", topicUserRankVo.getRole());
            stringRedisTemplate.opsForHash().putAll(RedisConstant.USER_RANK_PREFIX + topicUserRankVo.getUserId(), userInfo);
            
            if (date.equals(topicUserRankVo.getTopicTime())) {
                stringRedisTemplate.opsForZSet().add(RedisConstant.TOPIC_RANK_TODAY_PREFIX + date, String.valueOf(topicUserRankVo.getUserId()), topicUserRankVo.getScope());
            }
        }
    }

    

    public void readRankCache(List<TopicUserRankVo> countRank) {
        for (TopicUserRankVo topicUserRankVo : countRank) {
            
            stringRedisTemplate.opsForZSet().add(RedisConstant.TOPIC_RANK_PREFIX, String.valueOf(topicUserRankVo.getUserId()), topicUserRankVo.getScope());
        }
    }

    

    public Map<String, Object> adminHomeCount() {
        
        Map<String, Object> map = new HashMap<>();
        
        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        
        String yesterday = LocalDate.now().minusDays(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        
        
        Long count = topicRecordMapper.countTopicFrequency(null);
        
        Long countTodayTopicFrequency = topicRecordMapper.countTopicFrequency(date);
        countTodayTopicFrequency = countTodayTopicFrequency == null ? 0L : countTodayTopicFrequency;
        
        Long countYesterdayTopicFrequency = topicRecordMapper.countTopicFrequency(yesterday);
        countYesterdayTopicFrequency = countYesterdayTopicFrequency == null ? 0L : countYesterdayTopicFrequency;
        
        long topicGrowthRate = countTodayTopicFrequency - countYesterdayTopicFrequency;

        
        Long aiCount = aiFeignClient.count();
        
        Long aLong1 = aiFeignClient.countDate(date);
        
        Long aLong = aiFeignClient.countDate(yesterday);
        
        long aiGrowthRate = aLong1 - aLong;

        
        
        Long userCount = securityFeignClient.count();
        
        Long tCount = securityFeignClient.countDate(date);
        
        Long yCount = securityFeignClient.countDate(yesterday);
        
        long userGrowthRate = tCount - yCount;

        
        
        LambdaQueryWrapper<Topic> topicLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicLambdaQueryWrapper.eq(Topic::getCreateBy, "admin");
        topicLambdaQueryWrapper.eq(Topic::getStatus, StatusEnums.NORMAL.getCode());
        Long totalTopicCount = topicMapper.selectCount(topicLambdaQueryWrapper);

        
        LambdaQueryWrapper<TopicSubject> topicSubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicSubjectLambdaQueryWrapper.eq(TopicSubject::getStatus, StatusEnums.NORMAL.getCode());
        topicLambdaQueryWrapper.eq(Topic::getCreateBy, "admin");
        Long totalSubjectCount = subjectMapper.selectCount(topicSubjectLambdaQueryWrapper);

        
        LambdaQueryWrapper<TopicLabel> topicTagLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicTagLambdaQueryWrapper.eq(TopicLabel::getStatus, StatusEnums.NORMAL.getCode());
        topicLambdaQueryWrapper.eq(Topic::getCreateBy, "admin");
        Long topicLabelCount = topicLabelMapper.selectCount(topicTagLambdaQueryWrapper);

        map.put("countTodayFrequency", count);
        map.put("topicGrowthRate", topicGrowthRate);
        map.put("userCount", userCount);
        map.put("userGrowthRate", userGrowthRate);
        map.put("totalTopicCount", totalTopicCount);
        map.put("totalSubjectCount", totalSubjectCount);
        map.put("topicLabelCount", topicLabelCount);
        map.put("aiCount", aiCount);
        map.put("aiGrowthRate", aiGrowthRate);

        return map;
    }

    

    public List<TopicCategoryDataVo> adminHomeCategory() {
        
        LambdaQueryWrapper<TopicCategory> topicCategoryLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicCategoryLambdaQueryWrapper.eq(TopicCategory::getStatus, StatusEnums.NORMAL.getCode());
        topicCategoryLambdaQueryWrapper.eq(TopicCategory::getCreateBy, "admin");
        List<TopicCategory> topicCategoryList = topicCategoryMapper.selectList(topicCategoryLambdaQueryWrapper);
        if (CollectionUtils.isEmpty(topicCategoryList)) {
            return null;
        }
        
        return topicCategoryList.stream().map(topicCategory -> {
            TopicCategoryDataVo topicCategoryDataVo = new TopicCategoryDataVo();
            topicCategoryDataVo.setCategoryName(topicCategory.getCategoryName());
            LambdaQueryWrapper<TopicCategorySubject> topicCategorySubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicCategorySubjectLambdaQueryWrapper.eq(TopicCategorySubject::getCategoryId, topicCategory.getId());
            List<TopicCategorySubject> topicCategorySubjects = topicCategorySubjectMapper.selectList(topicCategorySubjectLambdaQueryWrapper);
            if (CollectionUtils.isEmpty(topicCategorySubjects)) {
                topicCategoryDataVo.setCount(0L);
                return topicCategoryDataVo;
            }
            long count = 0L;
            
            for (TopicCategorySubject topicCategorySubject : topicCategorySubjects) {
                LambdaQueryWrapper<TopicSubject> topicSubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicSubjectLambdaQueryWrapper.eq(TopicSubject::getId, topicCategorySubject.getSubjectId());
                topicSubjectLambdaQueryWrapper.eq(TopicSubject::getStatus, StatusEnums.NORMAL.getCode());
                topicSubjectLambdaQueryWrapper.eq(TopicSubject::getCreateBy, "admin");
                TopicSubject topicSubject = topicSubjectMapper.selectOne(topicSubjectLambdaQueryWrapper);
                if (topicSubject != null) {
                    
                    TopicSubjectDetailAndTopicVo topicSubjectDetailAndTopicVo = topicSubjectService.subjectDetail(topicSubject.getId());
                    if (topicSubjectDetailAndTopicVo != null) {
                        if (CollectionUtils.isNotEmpty(topicSubjectDetailAndTopicVo.getTopicNameVos())) {
                            count += topicSubjectDetailAndTopicVo.getTopicNameVos().size();
                        }
                    }

                }
            }

            topicCategoryDataVo.setCount(count);
            return topicCategoryDataVo;
        }).toList();
    }

    

    public TopicTrendVo topicTrend() {
        Map<String, Object> map = new HashMap<>();
        
        List<TopicDataVo> topicDataTopicList = topicRecordMapper.countTopicDay15();
        
        List<TopicDataVo> topicDataVoUserList = topicRecordMapper.countUserDay15();
        
        List<String> dateList = topicDataTopicList.stream().map(TopicDataVo::getDate).toList();
        
        List<Integer> countTopicList = topicDataTopicList.stream().map(TopicDataVo::getCount).toList();
        
        List<Integer> countUserList = topicDataVoUserList.stream().map(TopicDataVo::getCount).toList();
        TopicTrendVo topicTrendVo = new TopicTrendVo();
        topicTrendVo.setDateList(dateList);
        topicTrendVo.setCountTopicList(countTopicList);
        topicTrendVo.setCountUserList(countUserList);

        return topicTrendVo;
    }

    

    public SysUserTrentVo userTrend() {
        
        List<TopicDataVo> topicDataVoList = securityFeignClient.countUserDay7();
        
        List<String> dateList = topicDataVoList.stream().map(TopicDataVo::getDate).toList();
        List<Integer> countList = topicDataVoList.stream().map(TopicDataVo::getCount).toList();
        SysUserTrentVo sysUserTrentVo = new SysUserTrentVo();
        sysUserTrentVo.setDateList(dateList);
        sysUserTrentVo.setCountList(countList);
        return sysUserTrentVo;
    }

    

    public AiTrendVo aiTrend() {
        List<TopicDataVo> topicDataVoList = aiFeignClient.countAiDay7();
        List<String> dateList = topicDataVoList.stream().map(TopicDataVo::getDate).toList();
        List<Integer> countList = topicDataVoList.stream().map(TopicDataVo::getCount).toList();
        AiTrendVo aiTrendVo = new AiTrendVo();
        aiTrendVo.setDateList(dateList);
        aiTrendVo.setCountList(countList);
        return aiTrendVo;
    }

    

    public Map<String, Object> userHomeData() {
        
        Map<String, Object> map = new HashMap<>();
        Long currentId = SecurityUtils.getCurrentId();
        String role = SecurityUtils.getCurrentRole();
        String currentName = SecurityUtils.getCurrentName();

        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        String yesterday = LocalDate.now().minusDays(1).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        
        Long topicFrequencyCount = topicRecordMapper.countTopicUserRecord(currentId);

        
        Long aLong = topicRecordMapper.countTopicFrequency(today);
        Long aLong1 = topicRecordMapper.countTopicFrequency(yesterday);
        if (aLong == null) {
            aLong = 0L;
        }
        if (aLong1 == null) {
            aLong1 = 0L;
        }
        
        long topicFrequencyGrowthRate = aLong - aLong1;

        
        
        Long rank = topicRecordMapper.getRank(currentId);

        
        long todayRank = topicRecordMapper.getDateRank(currentId, today) == null ? 0L : topicRecordMapper.getDateRank(currentId, today);
        long yesterdayRank = topicRecordMapper.getDateRank(currentId, yesterday) == null ? 0L : topicRecordMapper.getDateRank(currentId, yesterday);

        
        long rankGrowthRate = todayRank - yesterdayRank;

        
        
        Long totalTopicRecordCountSize = null;
        LambdaQueryWrapper<TopicRecord> topicRecordLambdaQueryWrapper1 = new LambdaQueryWrapper<>();
        topicRecordLambdaQueryWrapper1.eq(TopicRecord::getUserId, currentId);
        topicRecordLambdaQueryWrapper1.groupBy(TopicRecord::getTopicId);
        List<TopicRecord> totalTopicRecordCount = topicRecordMapper.selectList(topicRecordLambdaQueryWrapper1);
        if (CollectionUtils.isEmpty(totalTopicRecordCount)) {
            totalTopicRecordCountSize = 0L;
        } else {
            totalTopicRecordCountSize = (long) totalTopicRecordCount.size();
        }

        
        
        Long totalTopicCount = null;
        if (role.equals("user")) {
            
            LambdaQueryWrapper<Topic> topicLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicLambdaQueryWrapper.eq(Topic::getCreateBy, "admin");
            topicLambdaQueryWrapper.eq(Topic::getStatus, StatusEnums.NORMAL.getCode());
            totalTopicCount = topicMapper.selectCount(topicLambdaQueryWrapper);
        } else {
            
            LambdaQueryWrapper<Topic> topicLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicLambdaQueryWrapper.eq(Topic::getStatus, StatusEnums.NORMAL.getCode());
            topicLambdaQueryWrapper.in(Topic::getCreateBy, "admin", currentName);
            totalTopicCount = topicMapper.selectCount(topicLambdaQueryWrapper);
        }

        
        Long aiCount = aiFeignClient.countAi(currentId);

        
        Long maxConsecutiveCount = topicRecordMapper.selectMaximumCount(currentId);

        
        Long recentConsecutiveCount = topicRecordMapper.selectRecentConsecutiveCount(currentId);

        map.put("topicFrequencyCount", topicFrequencyCount);
        map.put("topicFrequencyGrowthRate", topicFrequencyGrowthRate);
        map.put("rank", rank);
        map.put("rankGrowthRate", rankGrowthRate);
        map.put("totalTopicRecordCountSize", totalTopicRecordCountSize);
        map.put("totalTopicCount", totalTopicCount);
        map.put("aiCount", aiCount == null ? 0L : aiCount);
        map.put("maxConsecutiveCount", maxConsecutiveCount == null ? 0L : maxConsecutiveCount);
        map.put("recentConsecutiveCount", recentConsecutiveCount == null ? 0L : recentConsecutiveCount);

        return map;
    }

    

    public List<TopicCategoryUserDataVo> userHomeCategory() {
        
        List<TopicCategoryUserDataVo> topicCategoryUserDataVos = new ArrayList<>();
        Long currentId = SecurityUtils.getCurrentId();
        String role = SecurityUtils.getCurrentRole();
        String currentName = SecurityUtils.getCurrentName();
        
        LambdaQueryWrapper<TopicCategory> topicCategoryLambdaQueryWrapper = new LambdaQueryWrapper<>();
        if (role.equals("user")) {
            
            topicCategoryLambdaQueryWrapper.eq(TopicCategory::getCreateBy, "admin");
            topicCategoryLambdaQueryWrapper.eq(TopicCategory::getStatus, StatusEnums.NORMAL.getCode());
        } else {
            
            topicCategoryLambdaQueryWrapper.eq(TopicCategory::getStatus, StatusEnums.NORMAL.getCode());
            topicCategoryLambdaQueryWrapper.in(TopicCategory::getCreateBy, "admin", currentName);
        }
        
        List<TopicCategory> topicCategories = topicCategoryMapper.selectList(topicCategoryLambdaQueryWrapper);
        
        if (CollectionUtils.isEmpty(topicCategories)) {
            return null;
        }
        
        for (TopicCategory topicCategory : topicCategories) {
            
            
            TopicCategoryUserDataVo topicCategoryUserDataVo = new TopicCategoryUserDataVo();
            
            LambdaQueryWrapper<TopicCategorySubject> topicCategorySubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicCategorySubjectLambdaQueryWrapper.eq(TopicCategorySubject::getCategoryId, topicCategory.getId());
            List<TopicCategorySubject> topicCategorySubjects = topicCategorySubjectMapper.selectList(topicCategorySubjectLambdaQueryWrapper);
            
            topicCategoryUserDataVo.setCategoryName(topicCategory.getCategoryName());
            if (CollectionUtils.isEmpty(topicCategorySubjects)) {
                continue;
            }
            long totalCount = 0L;
            long count = 0L;
            
            for (TopicCategorySubject topicCategorySubject : topicCategorySubjects) {
                
                LambdaQueryWrapper<TopicSubject> topicSubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicSubjectLambdaQueryWrapper.eq(TopicSubject::getId, topicCategorySubject.getSubjectId());
                topicSubjectLambdaQueryWrapper.eq(TopicSubject::getStatus, StatusEnums.NORMAL.getCode());
                TopicSubject topicSubject = topicSubjectMapper.selectOne(topicSubjectLambdaQueryWrapper);
                if (StringUtils.isNull(topicSubject)) {
                    continue;
                }
                
                TopicSubjectDetailAndTopicVo topicSubjectDetailAndTopicVo = topicSubjectService.subjectDetail(topicSubject.getId());
                if (topicSubjectDetailAndTopicVo != null) {
                    if (CollectionUtils.isNotEmpty(topicSubjectDetailAndTopicVo.getTopicNameVos())) {
                        totalCount += topicSubjectDetailAndTopicVo.getTopicNameVos().size();
                        
                        List<Long> topicSubjectIds = topicSubjectDetailAndTopicVo.getTopicNameVos().stream().map(TopicNameVo::getId).toList();
                        
                        
                        LambdaQueryWrapper<TopicRecord> topicRecordLambdaQueryWrapper = new LambdaQueryWrapper<>();
                        topicRecordLambdaQueryWrapper.eq(TopicRecord::getUserId, currentId);
                        topicRecordLambdaQueryWrapper.eq(TopicRecord::getSubjectId, topicCategorySubject.getSubjectId());
                        topicRecordLambdaQueryWrapper.groupBy(TopicRecord::getTopicId);
                        List<TopicRecord> topicRecords = topicRecordMapper.selectList(topicRecordLambdaQueryWrapper);
                        if (CollectionUtils.isNotEmpty(topicRecords)) {
                            
                            List<Long> topicIds = topicRecords.stream().map(TopicRecord::getTopicId).toList();
                            if (CollectionUtils.isNotEmpty(topicIds)) {
                                
                                
                                Set<Long> topicSubjectIdSet = new HashSet<>(topicSubjectIds);
                                
                                long matchingCount = topicIds.stream()
                                        .filter(topicSubjectIdSet::contains)
                                        .count();
                                if (matchingCount != 0) {
                                    count += matchingCount;
                                }
                            }
                        }
                    }
                }
            }
            topicCategoryUserDataVo.setTotalCount(totalCount);
            topicCategoryUserDataVo.setCount(count);
            topicCategoryUserDataVos.add(topicCategoryUserDataVo);
        }
        return topicCategoryUserDataVos;
    }

    

    public List<TopicDataVo> userTopicDateCount(String date) {
        
        Long currentId = SecurityUtils.getCurrentId();
        
        return topicRecordMapper.userTopicDateCount(date, currentId);
    }

    

    public List<TopicTodayVo> topicTodayVo() {
        
        LambdaQueryWrapper<TopicDailyStaging> topicDailyStagingLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicDailyStagingLambdaQueryWrapper.eq(TopicDailyStaging::getIsPublic, 1);
        List<TopicDailyStaging> topicDailyStagings = topicDailyStagingMapper.selectList(topicDailyStagingLambdaQueryWrapper);
        
        
        Long currentId = SecurityUtils.getCurrentId();
        
        LambdaQueryWrapper<TopicDailyStaging> topicDailyStagingLambdaQueryWrapper1 = new LambdaQueryWrapper<>();
        topicDailyStagingLambdaQueryWrapper1.eq(TopicDailyStaging::getUserId, currentId);
        topicDailyStagingLambdaQueryWrapper1.eq(TopicDailyStaging::getIsPublic, 2);
        List<TopicDailyStaging> topicDailyStagings1 = topicDailyStagingMapper.selectList(topicDailyStagingLambdaQueryWrapper1);
        
        topicDailyStagings.addAll(topicDailyStagings1);
        
        return topicDailyStagings.stream().map(topicDailyStaging -> {
            
            TopicTodayVo topicTodayVo = new TopicTodayVo();
            
            Topic topic = topicMapper.selectById(topicDailyStaging.getTopicId());
            
            LambdaQueryWrapper<TopicLabelTopic> topicLabelTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicLabelTopicLambdaQueryWrapper.eq(TopicLabelTopic::getTopicId, topicDailyStaging.getTopicId());
            List<TopicLabelTopic> topicLabelTopics = topicLabelTopicMapper.selectList(topicLabelTopicLambdaQueryWrapper);
            if (CollectionUtils.isEmpty(topicLabelTopics)) {
                return null;
            }
            
            
            List<Long> labelIds = topicLabelTopics.stream().map(TopicLabelTopic::getLabelId).toList();
            
            List<String> labelNames = new ArrayList<>();
            
            for (Long labelId : labelIds) {
                LambdaQueryWrapper<TopicLabel> topicLabelLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicLabelLambdaQueryWrapper.eq(TopicLabel::getId, labelId);
                topicLabelLambdaQueryWrapper.eq(TopicLabel::getStatus, StatusEnums.NORMAL.getCode());
                topicLabelLambdaQueryWrapper.orderByDesc(TopicLabel::getCreateTime);
                TopicLabel topicLabel = topicLabelMapper.selectOne(topicLabelLambdaQueryWrapper);
                if (topicLabel != null) {
                    labelNames.add(topicLabel.getLabelName());
                }
            }
            
            LambdaQueryWrapper<TopicDailyBrush> topicDailyBrushLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicDailyBrushLambdaQueryWrapper.eq(TopicDailyBrush::getUserId, currentId);
            topicDailyBrushLambdaQueryWrapper.eq(TopicDailyBrush::getDailyId, topicDailyStaging.getId());
            if (topicDailyBrushMapper.selectOne(topicDailyBrushLambdaQueryWrapper) != null) {
                topicTodayVo.setStatus(1);
            } else {
                topicTodayVo.setStatus(0);
            }
            topicTodayVo.setTopicName(topic.getTopicName());
            topicTodayVo.setLabelNames(labelNames);
            topicTodayVo.setId(topicDailyStaging.getId());
            topicTodayVo.setSubjectId(topicDailyStaging.getSubjectId());
            topicTodayVo.setTopicId(topicDailyStaging.getTopicId());
            return topicTodayVo;
        }).toList();
    }

    

    public void flushTopic(Long id) {
        
        LambdaQueryWrapper<TopicDailyBrush> topicDailyBrushLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicDailyBrushLambdaQueryWrapper.eq(TopicDailyBrush::getDailyId, id);
        topicDailyBrushLambdaQueryWrapper.eq(TopicDailyBrush::getUserId, SecurityUtils.getCurrentId());
        TopicDailyBrush topicDailyBrush = topicDailyBrushMapper.selectOne(topicDailyBrushLambdaQueryWrapper);
        if (topicDailyBrush == null) {
            topicDailyBrush = new TopicDailyBrush();
            topicDailyBrush.setDailyId(id);
            topicDailyBrush.setUserId(SecurityUtils.getCurrentId());
            topicDailyBrushMapper.insert(topicDailyBrush);
        }
    }
}
