package com.hao.topic.topic.task;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hao.topic.api.utils.enums.StatusEnums;
import com.hao.topic.client.security.SecurityFeignClient;
import com.hao.topic.model.entity.system.SysUser;
import com.hao.topic.model.entity.topic.*;
import com.hao.topic.model.vo.topic.TopicUserRankVo;
import com.hao.topic.topic.mapper.*;
import com.hao.topic.topic.service.impl.TopicDataServiceImpl;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@EnableScheduling
@Component
@Slf4j
@AllArgsConstructor
public class TopicTask {
    private final TopicRecordMapper topicRecordMapper;
    private final TopicDataServiceImpl topicDataService;
    private final TopicMapper topicMapper;
    private final TopicDailyStagingMapper topicDailyStagingMapper;
    private final TopicSubjectTopicMapper topicSubjectTopicMapper;
    private final SecurityFeignClient securityFeignClient;
    private final TopicSubjectMapper topicSubjectMapper;
    private final TopicDailyBrushMapper topicDailyBrushMapper;

    

    @Scheduled(cron = "0 0 0 * * ?")
    
    public void refreshRankingToRedis() {
        log.info("refreshRankingToRedis===========>我执行了");
        
        List<TopicUserRankVo> countRank = topicDataService.rank();
        if (CollectionUtils.isNotEmpty(countRank)) {
            log.info("refreshRankingToRedis===========>排行数据已刷新，共{}条", countRank.size());
        }
    }

    

    @Scheduled(cron = "0 0 0 * * ?")
    
    public void refreshUserTopicToRedis() {
        
        int delete1 = topicDailyBrushMapper.delete(null);
        int delete = topicDailyStagingMapper.delete(null);

        
        LambdaQueryWrapper<Topic> topicLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicLambdaQueryWrapper.eq(Topic::getIsEveryday, 1);
        topicLambdaQueryWrapper.eq(Topic::getIsMember, 0);
        topicLambdaQueryWrapper.eq(Topic::getStatus, StatusEnums.NORMAL.getCode());
        List<Topic> topicList = topicMapper.selectList(topicLambdaQueryWrapper);
        
        LambdaQueryWrapper<Topic> topicLambdaQueryWrapper1 = new LambdaQueryWrapper<>();
        topicLambdaQueryWrapper1.eq(Topic::getStatus, StatusEnums.NORMAL.getCode());
        topicLambdaQueryWrapper1.eq(Topic::getIsDeleted,0);
        List<Topic> topics = topicMapper.selectList(topicLambdaQueryWrapper1);
        if (CollectionUtils.isNotEmpty(topicList)) {
            
            int size = topicList.size();
            
            if (size == 9) {
                
                for (Topic topic : topicList) {
                    
                    LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                    topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getTopicId, topic.getId());
                    TopicSubjectTopic topicSubjectTopicDb = topicSubjectTopicMapper.selectOne(topicSubjectTopicLambdaQueryWrapper);
                    TopicDailyStaging topicDailyStaging = new TopicDailyStaging();
                    topicDailyStaging.setTopicId(topic.getId());
                    topicDailyStaging.setSubjectId(topicSubjectTopicDb.getSubjectId());
                    topicDailyStaging.setIsPublic(1);
                    
                    topicDailyStagingMapper.insert(topicDailyStaging);
                }
                return;
            }
            
            int randomTopicSize = 9 - size;
            
            List<SysUser> allUser = securityFeignClient.getAllUser();
            if (CollectionUtils.isNotEmpty(allUser)) {
                for (SysUser sysUser : allUser) {
                    
                    LambdaQueryWrapper<TopicRecord> topicRecordLambdaQueryWrapper = new LambdaQueryWrapper<>();
                    topicRecordLambdaQueryWrapper.eq(TopicRecord::getUserId, sysUser.getId());
                    List<TopicRecord> topicRecords = topicRecordMapper.selectList(topicRecordLambdaQueryWrapper);
                    if (CollectionUtils.isEmpty(topicRecords)) {
                        
                        for (int i = 0; i < randomTopicSize; i++) {
                            int randomIndex = new Random().nextInt(topics.size());
                            Topic selectedTopic = topics.get(randomIndex);
                            
                            LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                            topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getTopicId, selectedTopic.getId());
                            TopicSubjectTopic topicSubjectTopicDb = topicSubjectTopicMapper.selectOne(topicSubjectTopicLambdaQueryWrapper);
                            TopicDailyStaging topicDailyStaging = new TopicDailyStaging();
                            topicDailyStaging.setTopicId(selectedTopic.getId());
                            topicDailyStaging.setSubjectId(topicSubjectTopicDb.getSubjectId());
                            topicDailyStaging.setIsPublic(1);
                            topicDailyStagingMapper.insert(topicDailyStaging);
                        }
                    } else {
                        
                        
                        Long subjectId = topicRecordMapper.selectMaxSubject(sysUser.getId());
                        
                        LambdaQueryWrapper<TopicSubject> topicSubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
                        topicSubjectLambdaQueryWrapper.eq(TopicSubject::getId, subjectId);
                        TopicSubject topicSubject = topicSubjectMapper.selectOne(topicSubjectLambdaQueryWrapper);
                        if (topicSubject != null) {
                            
                            
                            LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                            topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getSubjectId, topicSubject.getId());
                            List<TopicSubjectTopic> topicSubjectTopics = topicSubjectTopicMapper.selectList(topicSubjectTopicLambdaQueryWrapper);
                            
                            if (CollectionUtils.isEmpty(topicSubjectTopics)) {
                                continue;
                            }
                            
                            List<Topic> topicListAll = new ArrayList<>();
                            
                            topicSubjectTopics.forEach(item -> {
                                Long topicId = item.getTopicId();
                                Topic topic = topicMapper.selectById(topicId);
                                if (topic.getStatus() == 0 && topic.getIsMember() == 0 && topic.getIsEveryday() == 0) {
                                    topicListAll.add(topic);
                                }
                            });
                            
                            for (int i = 0; i < randomTopicSize; i++) {
                                
                                int randomIndex = new Random().nextInt(topicListAll.size());
                                Topic selectedTopic = topicListAll.get(randomIndex);
                                TopicDailyStaging topicDailyStaging = new TopicDailyStaging();
                                topicDailyStaging.setTopicId(selectedTopic.getId());
                                topicDailyStaging.setSubjectId(subjectId);
                                topicDailyStaging.setIsPublic(2);
                                topicDailyStaging.setUserId(sysUser.getId());
                                topicDailyStagingMapper.insert(topicDailyStaging);
                            }
                        }
                    }
                }
                return;
            }
        }
        
        
        if (CollectionUtils.isNotEmpty(topics)) {
            for (int i = 0; i < 5; ) {
                int randomIndex = new Random().nextInt(topics.size());
                Topic selectedTopic = topics.get(randomIndex);
                
                LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getTopicId, selectedTopic.getId());
                TopicSubjectTopic topicSubjectTopicDb = topicSubjectTopicMapper.selectOne(topicSubjectTopicLambdaQueryWrapper);
                
                
                LambdaQueryWrapper<TopicDailyStaging> topicDailyStagingLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicDailyStagingLambdaQueryWrapper.eq(TopicDailyStaging::getTopicId, selectedTopic.getId())
                        .eq(TopicDailyStaging::getIsPublic, 1);
                if (topicDailyStagingMapper.selectOne(topicDailyStagingLambdaQueryWrapper) == null) {
                    
                    TopicDailyStaging topicDailyStaging = new TopicDailyStaging();
                    topicDailyStaging.setTopicId(selectedTopic.getId());
                    topicDailyStaging.setSubjectId(topicSubjectTopicDb.getSubjectId());
                    topicDailyStaging.setIsPublic(1);
                    topicDailyStagingMapper.insert(topicDailyStaging);

                    
                    i++;
                }
            }
        }
        
        
        List<SysUser> allUser = securityFeignClient.getAllUser();
        if (CollectionUtils.isNotEmpty(allUser)) {
            for (SysUser sysUser : allUser) {
                
                LambdaQueryWrapper<TopicRecord> topicRecordLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicRecordLambdaQueryWrapper.eq(TopicRecord::getUserId, sysUser.getId());
                List<TopicRecord> topicRecords = topicRecordMapper.selectList(topicRecordLambdaQueryWrapper);
                if (CollectionUtils.isEmpty(topicRecords)) {
                    
                    for (int i = 0; i < 4; ) {
                        int randomIndex = new Random().nextInt(topics.size());
                        Topic selectedTopic = topics.get(randomIndex);
                        
                        LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                        topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getTopicId, selectedTopic.getId());
                        TopicSubjectTopic topicSubjectTopicDb = topicSubjectTopicMapper.selectOne(topicSubjectTopicLambdaQueryWrapper);
                        
                        LambdaQueryWrapper<TopicDailyStaging> topicDailyStagingLambdaQueryWrapper = new LambdaQueryWrapper<>();
                        topicDailyStagingLambdaQueryWrapper.eq(TopicDailyStaging::getTopicId, selectedTopic.getId())
                                .eq(TopicDailyStaging::getIsPublic, 2)
                                .eq(TopicDailyStaging::getUserId, sysUser.getId());
                        if (topicDailyStagingMapper.selectOne(topicDailyStagingLambdaQueryWrapper) == null) {
                            
                            LambdaQueryWrapper<TopicDailyStaging> topicDailyStagingLambdaQueryWrapper1 = new LambdaQueryWrapper<>();
                            topicDailyStagingLambdaQueryWrapper1.eq(TopicDailyStaging::getIsPublic, 1);
                            topicDailyStagingLambdaQueryWrapper1.eq(TopicDailyStaging::getTopicId, selectedTopic.getId());
                            if (topicDailyStagingMapper.selectOne(topicDailyStagingLambdaQueryWrapper1) == null) {
                                
                                TopicDailyStaging topicDailyStaging = new TopicDailyStaging();
                                topicDailyStaging.setTopicId(selectedTopic.getId());
                                topicDailyStaging.setSubjectId(topicSubjectTopicDb.getSubjectId());
                                topicDailyStaging.setIsPublic(2);
                                topicDailyStaging.setUserId(sysUser.getId());
                                topicDailyStagingMapper.insert(topicDailyStaging);

                                
                                i++;
                            }

                        }
                    }
                } else {
                    
                    
                    Long subjectId = topicRecordMapper.selectMaxSubject(sysUser.getId());
                    
                    LambdaQueryWrapper<TopicSubject> topicSubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
                    topicSubjectLambdaQueryWrapper.eq(TopicSubject::getId, subjectId);
                    TopicSubject topicSubject = topicSubjectMapper.selectOne(topicSubjectLambdaQueryWrapper);
                    if (topicSubject != null) {
                        
                        
                        LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                        topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getSubjectId, topicSubject.getId());
                        List<TopicSubjectTopic> topicSubjectTopics = topicSubjectTopicMapper.selectList(topicSubjectTopicLambdaQueryWrapper);
                        
                        if (CollectionUtils.isEmpty(topicSubjectTopics)) {
                            continue;
                        }
                        
                        List<Topic> topicListAll = new ArrayList<>();
                        
                        topicSubjectTopics.forEach(item -> {
                            Long topicId = item.getTopicId();
                            Topic topic = topicMapper.selectById(topicId);
                            if (topic.getStatus() == 0 && topic.getIsMember() == 0 && topic.getIsEveryday() == 0) {
                                topicListAll.add(topic);
                            }
                        });
                        
                        for (int i = 0; i < 4; ) {
                            
                            int randomIndex = new Random().nextInt(topicListAll.size());
                            Topic selectedTopic = topicListAll.get(randomIndex);
                            
                            LambdaQueryWrapper<TopicDailyStaging> eq = new LambdaQueryWrapper<TopicDailyStaging>()
                                    .eq(TopicDailyStaging::getTopicId, selectedTopic.getId())
                                    .eq(TopicDailyStaging::getUserId, sysUser.getId())
                                    .eq(TopicDailyStaging::getIsPublic, 2);
                            if (topicDailyStagingMapper.selectOne(eq) == null) {
                                
                                LambdaQueryWrapper<TopicDailyStaging> topicDailyStagingLambdaQueryWrapper = new LambdaQueryWrapper<>();
                                topicDailyStagingLambdaQueryWrapper.eq(TopicDailyStaging::getIsPublic, 1);
                                topicDailyStagingLambdaQueryWrapper.eq(TopicDailyStaging::getTopicId, selectedTopic.getId());
                                if (topicDailyStagingMapper.selectOne(topicDailyStagingLambdaQueryWrapper) == null) {
                                    TopicDailyStaging topicDailyStaging = new TopicDailyStaging();
                                    topicDailyStaging.setTopicId(selectedTopic.getId());
                                    topicDailyStaging.setSubjectId(subjectId);
                                    topicDailyStaging.setIsPublic(2);
                                    topicDailyStaging.setUserId(sysUser.getId());
                                    topicDailyStagingMapper.insert(topicDailyStaging);
                                    i++;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
