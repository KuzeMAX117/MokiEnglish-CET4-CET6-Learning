package com.hao.topic.topic.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hao.topic.api.utils.enums.StatusEnums;
import com.hao.topic.model.entity.topic.Topic;
import com.hao.topic.model.entity.topic.TopicSubject;
import com.hao.topic.model.entity.topic.TopicSubjectTopic;
import com.hao.topic.model.vo.topic.TopicSubjectVo;
import com.hao.topic.topic.mapper.TopicMapper;
import com.hao.topic.topic.mapper.TopicSubjectMapper;
import com.hao.topic.topic.mapper.TopicSubjectTopicMapper;
import com.hao.topic.topic.service.TopicAiService;
import lombok.AllArgsConstructor;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class TopicAiServiceImpl implements TopicAiService {
    private final TopicMapper topicMapper;
    private final TopicSubjectTopicMapper topicSubjectTopicMapper;
    private final TopicSubjectMapper topicSubjectMapper;

    

    public List<Topic> getSubjectIdByTopicList(Long subjectId) {
        
        LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getSubjectId, subjectId);
        List<TopicSubjectTopic> topicSubjectTopics = topicSubjectTopicMapper.selectList(topicSubjectTopicLambdaQueryWrapper);
        if (topicSubjectTopics.size() == 0) {
            return null;
        }
        
        List<Long> topicIds = topicSubjectTopics.stream()
                .map(TopicSubjectTopic::getTopicId).toList();
        
        return topicMapper.selectBatchIds(topicIds);
    }

    

    public List<TopicSubjectVo> getSubject(String role, String createBy) {

        
        List<TopicSubject> topicSubjectList = null;
        
        List<TopicSubject> topicSubjects = null;
        
        LambdaQueryWrapper<TopicSubject> subjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
        subjectLambdaQueryWrapper.eq(TopicSubject::getStatus, StatusEnums.NORMAL.getCode())
                .eq(TopicSubject::getCreateBy, "admin")
                .orderByDesc(TopicSubject::getCreateTime);
        topicSubjectList = topicSubjectMapper.selectList(subjectLambdaQueryWrapper);
        if (role.equals("member")) {
            
            
            LambdaQueryWrapper<TopicSubject> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(TopicSubject::getStatus, StatusEnums.NORMAL.getCode());
            lambdaQueryWrapper.orderByDesc(TopicSubject::getCreateTime);
            lambdaQueryWrapper.eq(TopicSubject::getCreateBy, createBy);
            topicSubjects = topicSubjectMapper.selectList(lambdaQueryWrapper);
        }
        
        if (!CollectionUtils.isEmpty(topicSubjects)) {
            
            topicSubjectList.addAll(0, topicSubjects);
        }
        return topicSubjectList.stream().map(topicSubject -> {
            TopicSubjectVo topicSubjectVo = new TopicSubjectVo();
            BeanUtils.copyProperties(topicSubject, topicSubjectVo);
            return topicSubjectVo;
        }).toList();
    }
}
