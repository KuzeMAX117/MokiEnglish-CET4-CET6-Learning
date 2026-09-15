package com.hao.topic.topic.service.impl;

import com.alibaba.excel.EasyExcel;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hao.topic.api.utils.constant.RabbitConstant;
import com.hao.topic.api.utils.enums.StatusEnums;
import com.hao.topic.api.utils.mq.RabbitService;
import com.hao.topic.common.constant.RedisConstant;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.audit.TopicAudit;
import com.hao.topic.model.dto.topic.TopicDto;
import com.hao.topic.model.dto.topic.TopicListDto;
import com.hao.topic.model.dto.topic.TopicRecordCountDto;
import com.hao.topic.model.entity.topic.*;
import com.hao.topic.model.entity.topic.Topic;
import com.hao.topic.model.excel.topic.*;
import com.hao.topic.model.vo.topic.TopicAnswerVo;
import com.hao.topic.model.vo.topic.TopicCollectionVo;
import com.hao.topic.model.vo.topic.TopicDetailVo;
import com.hao.topic.model.vo.topic.TopicVo;
import com.hao.topic.topic.mapper.*;
import com.hao.topic.topic.service.TopicService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
@Slf4j
@AllArgsConstructor
public class TopicServiceImpl implements TopicService {
    private final TopicMapper topicMapper;
    private final TopicSubjectTopicMapper topicSubjectTopicMapper;
    private final TopicSubjectMapper topicSubjectMapper;
    private final TopicLabelMapper topicLabelMapper;
    private final TopicLabelTopicMapper topicLabelTopicMapper;
    private final RabbitService rabbitService;
    private final StringRedisTemplate stringRedisTemplate;
    private final TopicCollectionMapper topicCollectionMapper;
    private final TopicRecordMapper topicRecordMapper;

    

    public Map<String, Object> topicList(TopicListDto topicListDto) {
        
        String username = SecurityUtils.getCurrentName();
        
        Long currentId = SecurityUtils.getCurrentId();
        log.info("当前用户登录名称和id：{},{}", username, currentId);
        
        LambdaQueryWrapper<Topic> topicLambdaQueryWrapper = new LambdaQueryWrapper<>();
        
        if (currentId != 1L) {
            
            topicLambdaQueryWrapper.like(Topic::getCreateBy, username);
        } else {
            
            
            if (!StringUtils.isEmpty(topicListDto.getCreateBy())) {
                topicLambdaQueryWrapper.like(Topic::getCreateBy, topicListDto.getCreateBy());
            }
        }
        
        if (!StringUtils.isEmpty(topicListDto.getTopicName())) {
            topicLambdaQueryWrapper.like(Topic::getTopicName, topicListDto.getTopicName());
        }
        
        if (!StringUtils.isEmpty(topicListDto.getBeginCreateTime()) && !StringUtils.isEmpty(topicListDto.getEndCreateTime())) {
            topicLambdaQueryWrapper.between(Topic::getCreateTime, topicListDto.getBeginCreateTime(), topicListDto.getEndCreateTime());
        }
        topicLambdaQueryWrapper.orderByDesc(Topic::getCreateTime);
        if (topicListDto.getPageNum() == null || topicListDto.getPageSize() == null) {
            List<Topic> topics = topicMapper.selectList(topicLambdaQueryWrapper);
            List<TopicVo> list = topics.stream().map(topic -> {
                TopicVo topicVo = new TopicVo();
                BeanUtils.copyProperties(topic, topicVo);
                
                LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getTopicId, topic.getId());
                TopicSubjectTopic topicSubjectTopic = topicSubjectTopicMapper.selectOne(topicSubjectTopicLambdaQueryWrapper);
                if (topicSubjectTopic != null) {
                    TopicSubject topicSubject = topicSubjectMapper.selectById(topicSubjectTopic.getSubjectId());
                    if (topicSubject != null) {
                        topicVo.setSubject(topicSubject.getSubjectName());
                    }
                }
                List<String> stringList = new ArrayList<>();
                
                LambdaQueryWrapper<TopicLabelTopic> topicLabelTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicLabelTopicLambdaQueryWrapper.eq(TopicLabelTopic::getTopicId, topic.getId());
                List<TopicLabelTopic> topicLabelTopics = topicLabelTopicMapper.selectList(topicLabelTopicLambdaQueryWrapper);
                if (CollectionUtils.isNotEmpty(topicLabelTopics)) {
                    topicLabelTopics.forEach(topicLabelTopic -> {
                        TopicLabel topicLabel = topicLabelMapper.selectById(topicLabelTopic.getLabelId());
                        if (topicLabel != null) {
                            stringList.add(topicLabel.getLabelName());
                        }
                    });
                }
                topicVo.setLabels(stringList);
                return topicVo;
            }).toList();
            
            return Map.of("total", list.size(), "rows", list);
        } else {
            
            Page<Topic> topicPage = new Page<>(topicListDto.getPageNum(), topicListDto.getPageSize());
            
            Page<Topic> topicListPage = topicMapper.selectPage(topicPage, topicLambdaQueryWrapper);
            List<TopicVo> list = topicListPage.getRecords().stream().map(topic -> {
                TopicVo topicVo = new TopicVo();
                BeanUtils.copyProperties(topic, topicVo);
                
                LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getTopicId, topic.getId());
                TopicSubjectTopic topicSubjectTopic = topicSubjectTopicMapper.selectOne(topicSubjectTopicLambdaQueryWrapper);
                if (topicSubjectTopic != null) {
                    TopicSubject topicSubject = topicSubjectMapper.selectById(topicSubjectTopic.getSubjectId());
                    if (topicSubject != null) {
                        topicVo.setSubject(topicSubject.getSubjectName());
                    }
                }
                List<String> stringList = new ArrayList<>();
                
                LambdaQueryWrapper<TopicLabelTopic> topicLabelTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicLabelTopicLambdaQueryWrapper.eq(TopicLabelTopic::getTopicId, topic.getId());
                List<TopicLabelTopic> topicLabelTopics = topicLabelTopicMapper.selectList(topicLabelTopicLambdaQueryWrapper);
                if (CollectionUtils.isNotEmpty(topicLabelTopics)) {
                    topicLabelTopics.forEach(topicLabelTopic -> {
                        TopicLabel topicLabel = topicLabelMapper.selectById(topicLabelTopic.getLabelId());
                        if (topicLabel != null) {
                            stringList.add(topicLabel.getLabelName());
                        }
                    });
                }
                topicVo.setLabels(stringList);
                return topicVo;
            }).toList();
            return Map.of("total", topicListPage.getTotal(), "rows", list);
        }
    }

    

    @Transactional
    public void add(TopicDto topicDto) {
        LambdaQueryWrapper<Topic> topicLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicLambdaQueryWrapper.eq(Topic::getTopicName, topicDto.getTopicName());
        
        Topic topicDb = topicMapper.selectOne(topicLambdaQueryWrapper);
        if (topicDb != null) {
            throw new TopicException(ResultCodeEnum.TOPIC_NAME_EXIST);
        }

        
        TopicSubject topicSubject = topicSubjectMapper.selectById(topicDto.getSubjectId());
        
        if (topicSubject == null) {
            throw new TopicException(ResultCodeEnum.SUBJECT_NOT_EXIST);
        }
        StringBuilder labelNames = new StringBuilder();
        
        List<TopicLabel> topicLabels = topicLabelMapper.selectBatchIds(topicDto.getLabelIds());
        if (CollectionUtils.isEmpty(topicLabels)) {
            throw new TopicException(ResultCodeEnum.LABEL_NOT_EXIST);
        }
        for (TopicLabel topicLabel : topicLabels) {
            labelNames.append(topicLabel.getLabelName());
            
            if (topicLabels.size() != topicLabels.indexOf(topicLabel) + 1) {
                labelNames.append(":");
            }
        }
        log.info("标签名称：{}", labelNames);

        
        String username = SecurityUtils.getCurrentName();
        
        Topic topic = new Topic();
        BeanUtils.copyProperties(topicDto, topic);
        
        topic.setCreateBy(username);
        
        if (topic.getIsEveryday() == 1) {
            LambdaQueryWrapper<Topic> topicLambdaQueryWrapper1 = new LambdaQueryWrapper<>();
            topicLambdaQueryWrapper1.eq(Topic::getIsEveryday, 1);
            List<Topic> topics = topicMapper.selectList(topicLambdaQueryWrapper1);
            if (CollectionUtils.isNotEmpty(topics) && topics.size() >= 9) {
                throw new TopicException(ResultCodeEnum.TOPIC_EVERYDAY_ERROR);
            }
        }

        
        Long currentId = SecurityUtils.getCurrentId();
        if (currentId == 1L) {
            
            topic.setStatus(StatusEnums.NORMAL.getCode());

            
            topicMapper.insert(topic);
        } else {
            topicMapper.insert(topic);
            
            topic.setStatus(StatusEnums.AUDITING.getCode());
            
            TopicAudit topicAudit = new TopicAudit();
            topicAudit.setId(topic.getId());
            topicAudit.setTopicName(topic.getTopicName());
            topicAudit.setAccount(username);
            topicAudit.setAnswer(topic.getAnswer());
            topicAudit.setUserId(currentId);
            topicAudit.setTopicSubjectName(topicSubject.getSubjectName());
            topicAudit.setTopicLabelName(labelNames.toString());
            String topicAuditJson = JSON.toJSONString(topicAudit);
            log.info("发送消息{}", topicAuditJson);
            rabbitService.sendMessage(RabbitConstant.TOPIC_AUDIT_EXCHANGE, RabbitConstant.TOPIC_AUDIT_ROUTING_KEY_NAME, topicAuditJson);
        }

        
        TopicSubjectTopic topicSubjectTopic = new TopicSubjectTopic();
        topicSubjectTopic.setTopicId(topic.getId());
        topicSubjectTopic.setSubjectId(topicDto.getSubjectId());
        topicSubjectTopicMapper.insert(topicSubjectTopic);

        
        topicSubject.setTopicCount(topicSubject.getTopicCount() + 1);
        topicSubjectMapper.updateById(topicSubject);
        for (TopicLabel topicLabel : topicLabels) {
            
            TopicLabelTopic topicLabelTopic = new TopicLabelTopic();
            topicLabelTopic.setTopicId(topic.getId());
            topicLabelTopic.setLabelId(topicLabel.getId());
            topicLabelTopicMapper.insert(topicLabelTopic);

            
            topicLabel.setUseCount(topicLabel.getUseCount() + 1);
            topicLabelMapper.updateById(topicLabel);
        }
    }

    

    @Transactional
    public void update(TopicDto topicDto) {
        
        Topic oldTopic = topicMapper.selectById(topicDto.getId());
        if (oldTopic == null) {
            throw new TopicException(ResultCodeEnum.TOPIC_UPDATE_IS_NULL);
        }
        
        TopicSubject topicSubject = topicSubjectMapper.selectById(topicDto.getSubjectId());
        
        if (topicSubject == null) {
            throw new TopicException(ResultCodeEnum.SUBJECT_NOT_EXIST);
        }
        
        List<TopicLabel> topicLabels = topicLabelMapper.selectBatchIds(topicDto.getLabelIds());
        if (CollectionUtils.isEmpty(topicLabels)) {
            throw new TopicException(ResultCodeEnum.LABEL_NOT_EXIST);
        }
        StringBuilder labelNames = new StringBuilder();
        for (TopicLabel topicLabel : topicLabels) {
            labelNames.append(topicLabel.getLabelName());
            
            if (topicLabels.size() != topicLabels.indexOf(topicLabel) + 1) {
                labelNames.append(":");
            }
        }
        
        Topic topic = new Topic();
        BeanUtils.copyProperties(topicDto, topic);
        
        String username = SecurityUtils.getCurrentName();
        
        if (topic.getIsEveryday() == 1) {
            LambdaQueryWrapper<Topic> topicLambdaQueryWrapper1 = new LambdaQueryWrapper<>();
            topicLambdaQueryWrapper1.eq(Topic::getIsEveryday, 1);
            List<Topic> topics = topicMapper.selectList(topicLambdaQueryWrapper1);
            if (CollectionUtils.isNotEmpty(topics) && topics.size() >= 9) {
                throw new TopicException(ResultCodeEnum.TOPIC_EVERYDAY_ERROR);
            }
        }

        
        Long currentId = SecurityUtils.getCurrentId();
        if (currentId == 1L) {
            
            topic.setStatus(StatusEnums.NORMAL.getCode());
        } else {
            
            topic.setStatus(StatusEnums.AUDITING.getCode());
            
            TopicAudit topicAudit = new TopicAudit();
            topicAudit.setId(topicDto.getId());
            topicAudit.setTopicName(topicDto.getTopicName());
            topicAudit.setAccount(username);
            topicAudit.setAnswer(topicDto.getAnswer());
            topicAudit.setUserId(currentId);
            topicAudit.setTopicSubjectName(topicSubject.getSubjectName());
            topicAudit.setTopicLabelName(labelNames.toString());
            String topicAuditJson = JSON.toJSONString(topicAudit);
            log.info("发送消息{}", topicAuditJson);
            rabbitService.sendMessage(RabbitConstant.TOPIC_AUDIT_EXCHANGE, RabbitConstant.TOPIC_AUDIT_ROUTING_KEY_NAME, topicAuditJson);
        }
        topic.setFailMsg("");
        
        topicMapper.updateById(topic);

        
        LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getTopicId, oldTopic.getId());
        TopicSubjectTopic topicSubjectTopicDb = topicSubjectTopicMapper.selectOne(topicSubjectTopicLambdaQueryWrapper);
        if (topicSubjectTopicDb != null) {
            
            TopicSubject topicSubjectDb = topicSubjectMapper.selectById(topicSubjectTopicDb.getSubjectId());
            if (topicSubjectDb != null) {
                
                topicSubjectDb.setTopicCount(topicSubjectDb.getTopicCount() - 1);
                topicSubjectMapper.updateById(topicSubjectDb);
            }
            
            topicSubjectTopicMapper.deleteById(topicSubjectTopicDb);
        }

        
        TopicSubjectTopic topicSubjectTopic = new TopicSubjectTopic();
        topicSubjectTopic.setTopicId(topic.getId());
        topicSubjectTopic.setSubjectId(topicDto.getSubjectId());
        topicSubjectTopicMapper.insert(topicSubjectTopic);
        
        topicSubject.setTopicCount(topicSubject.getTopicCount() + 1);
        topicSubjectMapper.updateById(topicSubject);

        
        LambdaQueryWrapper<TopicLabelTopic> topicLabelTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicLabelTopicLambdaQueryWrapper.eq(TopicLabelTopic::getTopicId, oldTopic.getId());
        List<TopicLabelTopic> topicLabelTopics = topicLabelTopicMapper.selectList(topicLabelTopicLambdaQueryWrapper);
        if (!CollectionUtils.isEmpty(topicLabelTopics)) {
            for (TopicLabelTopic topicLabelTopic : topicLabelTopics) {
                
                TopicLabel topicLabelDb = topicLabelMapper.selectById(topicLabelTopic.getLabelId());
                if (topicLabelDb != null) {
                    
                    topicLabelDb.setUseCount(topicLabelDb.getUseCount() - 1);
                    topicLabelMapper.updateById(topicLabelDb);
                }
                
                topicLabelTopicMapper.deleteById(topicLabelTopic);
            }
        }

        for (TopicLabel topicLabel : topicLabels) {
            
            TopicLabelTopic topicLabelTopic = new TopicLabelTopic();
            topicLabelTopic.setTopicId(topic.getId());
            topicLabelTopic.setLabelId(topicLabel.getId());
            topicLabelTopicMapper.insert(topicLabelTopic);

            
            topicLabel.setUseCount(topicLabel.getUseCount() + 1);
            topicLabelMapper.updateById(topicLabel);
        }
    }

    

    @Transactional
    public void delete(Long[] ids) {
        
        if (ids == null) {
            throw new TopicException(ResultCodeEnum.TOPIC_DELETE_IS_NULL);
        }
        
        for (Long id : ids) {
            Topic topic = topicMapper.selectById(id);
            if (topic == null) {
                throw new TopicException(ResultCodeEnum.TOPIC_DELETE_IS_NULL);
            }
            
            topicMapper.deleteById(id);
            
            LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getTopicId, id);
            TopicSubjectTopic topicSubjectTopic = topicSubjectTopicMapper.selectOne(topicSubjectTopicLambdaQueryWrapper);
            if (topicSubjectTopic != null) {
                
                TopicSubject topicSubjectDb = topicSubjectMapper.selectById(topicSubjectTopic.getSubjectId());
                if (topicSubjectDb != null) {
                    
                    topicSubjectDb.setTopicCount(topicSubjectDb.getTopicCount() - 1);
                    topicSubjectMapper.updateById(topicSubjectDb);
                }
            }
            
            topicSubjectTopicMapper.deleteById(topicSubjectTopic);

            
            LambdaQueryWrapper<TopicLabelTopic> topicLabelTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicLabelTopicLambdaQueryWrapper.eq(TopicLabelTopic::getTopicId, id);
            List<TopicLabelTopic> topicLabelTopics = topicLabelTopicMapper.selectList(topicLabelTopicLambdaQueryWrapper);
            if (!CollectionUtils.isEmpty(topicLabelTopics)) {
                for (TopicLabelTopic topicLabelTopic : topicLabelTopics) {
                    
                    TopicLabel topicLabelDb = topicLabelMapper.selectById(topicLabelTopic.getLabelId());
                    if (topicLabelDb != null) {
                        
                        topicLabelDb.setUseCount(topicLabelDb.getUseCount() - 1);
                        topicLabelMapper.updateById(topicLabelDb);
                    }
                }
            }
            
            topicLabelTopicMapper.delete(topicLabelTopicLambdaQueryWrapper);
        }
    }

    

    public List<TopicExcelExport> getExcelVo(TopicListDto topicListDto, Long[] ids) {
        
        if (ids[0] != 0) {
            
            List<Topic> topics = topicMapper.selectBatchIds(Arrays.asList(ids));
            if (CollectionUtils.isEmpty(topics)) {
                throw new TopicException(ResultCodeEnum.EXPORT_ERROR);
            }
            return topics.stream().map(topic -> {
                TopicExcelExport topicExcelExport = new TopicExcelExport();
                BeanUtils.copyProperties(topic, topicExcelExport);
                
                topicExcelExport.setStatus(StatusEnums.getMessageByCode(topic.getStatus()));
                
                
                LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getTopicId, topic.getId());
                TopicSubjectTopic topicSubjectTopic = topicSubjectTopicMapper.selectOne(topicSubjectTopicLambdaQueryWrapper);
                if (topicSubjectTopic != null) {
                    
                    TopicSubject topicSubjectDb = topicSubjectMapper.selectById(topicSubjectTopic.getSubjectId());
                    if (topicSubjectDb != null) {
                        topicExcelExport.setSubjectName(topicSubjectDb.getSubjectName());
                    }
                }
                
                
                LambdaQueryWrapper<TopicLabelTopic> topicLabelTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicLabelTopicLambdaQueryWrapper.eq(TopicLabelTopic::getTopicId, topic.getId());
                List<TopicLabelTopic> topicLabelTopics = topicLabelTopicMapper.selectList(topicLabelTopicLambdaQueryWrapper);
                StringBuilder labelNames = new StringBuilder();
                if (!CollectionUtils.isEmpty(topicLabelTopics)) {
                    for (TopicLabelTopic topicLabelTopic : topicLabelTopics) {
                        
                        TopicLabel topicLabelDb = topicLabelMapper.selectById(topicLabelTopic.getLabelId());
                        if (topicLabelDb != null) {
                            labelNames.append(topicLabelDb.getLabelName());
                            
                            if (topicLabelTopics.size() != topicLabelTopics.indexOf(topicLabelTopic) + 1) {
                                labelNames.append(":");
                            }
                        }
                    }
                }
                topicExcelExport.setLabelName(labelNames.toString());
                return topicExcelExport;
            }).collect(Collectors.toList());
        } else {
            Map<String, Object> map = topicList(topicListDto);
            if (map.get("rows") == null) {
                throw new TopicException(ResultCodeEnum.EXPORT_ERROR);
            }
            List<Topic> topics = (List<Topic>) map.get("rows");
            
            return topics.stream().map(topic -> {
                TopicExcelExport topicExcelExport = new TopicExcelExport();
                BeanUtils.copyProperties(topic, topicExcelExport);
                
                topicExcelExport.setStatus(StatusEnums.getMessageByCode(topic.getStatus()));
                return topicExcelExport;
            }).collect(Collectors.toList());
        }
    }

    

    public String memberImport(MultipartFile multipartFile, Boolean updateSupport) throws IOException {
        
        String username = SecurityUtils.getCurrentName();
        
        List<TopicMemberExcel> excelVoList = EasyExcel.read(multipartFile.getInputStream())
                
                .head(TopicMemberExcel.class)
                
                .sheet()
                
                .doReadSync();
        
        if (CollectionUtils.isEmpty(excelVoList)) {
            throw new TopicException(ResultCodeEnum.IMPORT_ERROR);
        }
        
        int successNum = 0;
        
        int failureNum = 0;
        
        StringBuilder successMsg = new StringBuilder();
        
        StringBuilder failureMsg = new StringBuilder();
        Long currentId = SecurityUtils.getCurrentId();

        
        for (TopicMemberExcel topicExcel : excelVoList) {
            try {
                
                LambdaQueryWrapper<Topic> topicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicLambdaQueryWrapper.eq(Topic::getTopicName, topicExcel.getTopicName());
                Topic topic = topicMapper.selectOne(topicLambdaQueryWrapper);
                if (StringUtils.isNull(topic)) {
                    
                    Topic topicDb = new Topic();
                    BeanUtils.copyProperties(topicExcel, topicDb);
                    topicDb.setCreateBy(username);
                    if (topicExcel.getSubjectName() == null) {
                        throw new TopicException(ResultCodeEnum.TOPIC_SUBJECT_IS_NULL);
                    }
                    if (topicExcel.getLabelName() == null) {
                        throw new TopicException(ResultCodeEnum.TOPIC_LABEL_IS_NULL);
                    }
                    
                    LambdaQueryWrapper<TopicSubject> topicSubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
                    topicSubjectLambdaQueryWrapper.eq(TopicSubject::getSubjectName, topicExcel.getSubjectName());
                    TopicSubject topicSubjectDb = null;
                    if (topicSubjectMapper != null) {
                        topicSubjectDb = topicSubjectMapper.selectOne(topicSubjectLambdaQueryWrapper);
                    }
                    if (StringUtils.isNull(topicSubjectDb)) {
                        throw new TopicException(ResultCodeEnum.TOPIC_SUBJECT_IS_NULL);
                    }
                    
                    if (currentId == 1L) {
                        
                        topicDb.setStatus(StatusEnums.NORMAL.getCode());
                        topicMapper.insert(topicDb);
                    } else {
                        
                        topicDb.setStatus(StatusEnums.AUDITING.getCode());
                        topicMapper.insert(topicDb);
                    }

                    topicSubjectDb.setTopicCount(topicSubjectDb.getTopicCount() + 1);
                    topicSubjectMapper.updateById(topicSubjectDb);
                    
                    TopicSubjectTopic topicSubject = new TopicSubjectTopic();
                    topicSubject.setTopicId(topicDb.getId());
                    topicSubject.setSubjectId(topicSubjectDb.getId());
                    topicSubjectTopicMapper.insert(topicSubject);

                    
                    String[] labelNames = topicExcel.getLabelName().split(":");
                    
                    for (int i = 0; i < labelNames.length; i++) {
                        for (int j = i + 1; j < labelNames.length; j++) {
                            if (labelNames[i].equals(labelNames[j])) {
                                throw new TopicException(ResultCodeEnum.TOPIC_LABEL_IS_NULL);
                            }
                        }
                    }
                    for (String labelName : labelNames) {
                        if (StringUtils.isNull(labelName)) {
                            throw new TopicException(ResultCodeEnum.TOPIC_LABEL_IS_NULL);
                        }
                        
                        LambdaQueryWrapper<TopicLabel> topicLabelLambdaQueryWrapper = new LambdaQueryWrapper<>();
                        topicLabelLambdaQueryWrapper.eq(TopicLabel::getLabelName, labelName);
                        TopicLabel topicLabelDb = topicLabelMapper.selectOne(topicLabelLambdaQueryWrapper);
                        if (topicLabelDb == null) {
                            throw new TopicException(ResultCodeEnum.TOPIC_LABEL_IS_NULL);
                        }
                        
                        topicLabelDb.setUseCount(topicLabelDb.getUseCount() + 1);
                        topicLabelMapper.updateById(topicLabelDb);

                        
                        TopicLabelTopic topicLabelTopic = new TopicLabelTopic();
                        topicLabelTopic.setTopicId(topicDb.getId());
                        topicLabelTopic.setLabelId(topicLabelDb.getId());
                        topicLabelTopicMapper.insert(topicLabelTopic);
                    }
                    
                    if (currentId == 1L) {
                    } else {
                        
                        TopicAudit topicAudit = new TopicAudit();
                        topicAudit.setTopicName(topicExcel.getTopicName());
                        topicAudit.setAnswer(topicExcel.getAnswer());
                        topicAudit.setAccount(username);
                        topicAudit.setUserId(currentId);
                        topicAudit.setTopicSubjectName(topicExcel.getSubjectName());
                        topicAudit.setTopicLabelName(topicExcel.getLabelName());
                        topicAudit.setId(topicDb.getId());
                        
                        String topicAuditJson = JSON.toJSONString(topicAudit);
                        rabbitService.sendMessage(RabbitConstant.TOPIC_AUDIT_EXCHANGE, RabbitConstant.TOPIC_AUDIT_ROUTING_KEY_NAME, topicAuditJson);
                    }
                    successNum++;
                    successMsg.append("<br/>").append(successNum).append("-题目：").append(topicDb.getTopicName()).append("-导入成功");
                } else if (updateSupport) {
                    if (topicExcel.getSubjectName() == null) {
                        throw new TopicException(ResultCodeEnum.TOPIC_SUBJECT_IS_NULL);
                    }
                    if (topicExcel.getLabelName() == null) {
                        throw new TopicException(ResultCodeEnum.TOPIC_LABEL_IS_NULL);
                    }
                    
                    String[] labelNames = topicExcel.getLabelName().split(":");
                    
                    for (int i = 0; i < labelNames.length; i++) {
                        for (int j = i + 1; j < labelNames.length; j++) {
                            if (labelNames[i].equals(labelNames[j])) {
                                throw new TopicException(ResultCodeEnum.TOPIC_LABEL_IS_NULL);
                            }
                        }
                    }
                    
                    LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                    topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getTopicId, topic.getId());
                    TopicSubjectTopic topicSubjectTopic = topicSubjectTopicMapper.selectOne(topicSubjectTopicLambdaQueryWrapper);
                    if (topicSubjectTopic != null) {
                        
                        TopicSubject topicSubject = topicSubjectMapper.selectById(topicSubjectTopic.getSubjectId());
                        if (topicSubject != null) {
                            
                            if (!topicSubject.getSubjectName().equals(topicExcel.getSubjectName())) {
                                
                                topicSubject.setTopicCount(topicSubject.getTopicCount() - 1);
                                topicSubjectMapper.updateById(topicSubject);
                                
                                LambdaQueryWrapper<TopicSubject> topicSubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
                                topicSubjectLambdaQueryWrapper.eq(TopicSubject::getSubjectName, topicExcel.getSubjectName());
                                TopicSubject topicSubjectDb = topicSubjectMapper.selectOne(topicSubjectLambdaQueryWrapper);
                                if (topicSubjectDb != null) {
                                    topicSubjectDb.setTopicCount(topicSubjectDb.getTopicCount() + 1);
                                    topicSubjectMapper.updateById(topicSubjectDb);
                                    
                                    TopicSubjectTopic topicSubjectTopicDb = new TopicSubjectTopic();
                                    topicSubjectTopicDb.setSubjectId(topicSubjectDb.getId());
                                    topicSubjectTopicDb.setTopicId(topic.getId());
                                    topicSubjectTopicMapper.insert(topicSubjectTopicDb);
                                }
                                
                                topicSubjectTopicMapper.deleteById(topicSubjectTopic);
                            }
                        }
                    }

                    
                    LambdaQueryWrapper<TopicLabelTopic> topicLabelTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                    topicLabelTopicLambdaQueryWrapper.eq(TopicLabelTopic::getTopicId, topic.getId());
                    List<TopicLabelTopic> topicLabelTopics = topicLabelTopicMapper.selectList(topicLabelTopicLambdaQueryWrapper);
                    
                    if (CollectionUtils.isNotEmpty(topicLabelTopics)) {
                        
                        List<Long> labelIds = topicLabelTopics.stream()
                                .map(TopicLabelTopic::getLabelId)
                                .toList();
                        
                        List<TopicLabel> topicLabels = topicLabelMapper.selectBatchIds(labelIds);
                        
                        topicLabels.forEach(topicLabel -> {
                            topicLabel.setUseCount(topicLabel.getUseCount() - 1);
                            topicLabelMapper.updateById(topicLabel);
                        });
                        
                        topicLabelTopicMapper.delete(topicLabelTopicLambdaQueryWrapper);

                        
                        for (String labelName : labelNames) {
                            
                            LambdaQueryWrapper<TopicLabel> topicLabelLambdaQueryWrapper = new LambdaQueryWrapper<>();
                            topicLabelLambdaQueryWrapper.eq(TopicLabel::getLabelName, labelName);
                            TopicLabel topicLabelDb = topicLabelMapper.selectOne(topicLabelLambdaQueryWrapper);
                            if (topicLabelDb != null) {
                                topicLabelDb.setUseCount(topicLabelDb.getUseCount() + 1);
                                topicLabelMapper.updateById(topicLabelDb);
                                
                                TopicLabelTopic topicLabelTopicDb = new TopicLabelTopic();
                                topicLabelTopicDb.setLabelId(topicLabelDb.getId());
                                topicLabelTopicDb.setTopicId(topic.getId());
                                topicLabelTopicMapper.insert(topicLabelTopicDb);
                            }
                        }
                    }

                    
                    if (currentId == 1L) {
                        
                        topic.setStatus(StatusEnums.NORMAL.getCode());
                    } else {
                        
                        topic.setStatus(StatusEnums.AUDITING.getCode());
                        
                        TopicAudit topicAudit = new TopicAudit();
                        topicAudit.setTopicName(topicExcel.getTopicName());
                        topicAudit.setAnswer(topicExcel.getAnswer());
                        topicAudit.setAccount(username);
                        topicAudit.setUserId(currentId);
                        topicAudit.setTopicSubjectName(topicExcel.getSubjectName());
                        topicAudit.setTopicLabelName(topicExcel.getLabelName());
                        topicAudit.setId(topic.getId());
                        
                        String topicAuditJson = JSON.toJSONString(topicAudit);
                        rabbitService.sendMessage(RabbitConstant.TOPIC_AUDIT_EXCHANGE, RabbitConstant.TOPIC_AUDIT_ROUTING_KEY_NAME, topicAuditJson);
                    }
                    topic.setFailMsg("");
                    
                    BeanUtils.copyProperties(topicExcel, topic);
                    topicMapper.updateById(topic);

                    successNum++;
                    successMsg.append("<br/>").append(successNum).append("-题目：").append(topic.getTopicName()).append("-更新成功");

                } else {
                    
                    failureNum++;
                    failureMsg.append("<br/>").append(failureNum).append("-题目：").append(topic.getTopicName()).append("-已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "-题目： " + topicExcel.getTopicName() + " 导入失败：";
                failureMsg.append(msg).append(e.getMessage());
                log.error(msg, e);
            }
        }
        if (failureNum > 0) {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
            throw new TopicException(failureMsg.toString());
        } else {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
        }
        return successMsg.toString();
    }

    

    public String adminImport(MultipartFile multipartFile, Boolean updateSupport) throws IOException {
        
        String username = SecurityUtils.getCurrentName();
        
        List<TopicExcel> excelVoList = EasyExcel.read(multipartFile.getInputStream())
                
                .head(TopicExcel.class)
                
                .sheet()
                
                .doReadSync();
        
        if (CollectionUtils.isEmpty(excelVoList)) {
            throw new TopicException(ResultCodeEnum.IMPORT_ERROR);
        }
        
        int successNum = 0;
        
        int failureNum = 0;
        
        StringBuilder successMsg = new StringBuilder();
        
        StringBuilder failureMsg = new StringBuilder();
        Long currentId = SecurityUtils.getCurrentId();
        
        for (TopicExcel topicExcel : excelVoList) {
            try {

                
                LambdaQueryWrapper<Topic> topicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicLambdaQueryWrapper.eq(Topic::getTopicName, topicExcel.getTopicName());
                Topic topic = topicMapper.selectOne(topicLambdaQueryWrapper);
                if (StringUtils.isNull(topic)) {
                    
                    Topic topicDb = new Topic();
                    BeanUtils.copyProperties(topicExcel, topicDb);
                    topicDb.setCreateBy(username);
                    if (topicExcel.getSubjectName() == null) {
                        throw new TopicException(ResultCodeEnum.TOPIC_SUBJECT_IS_NULL);
                    }
                    if (topicExcel.getLabelName() == null) {
                        throw new TopicException(ResultCodeEnum.TOPIC_LABEL_IS_NULL);
                    }
                    
                    LambdaQueryWrapper<TopicSubject> topicSubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
                    topicSubjectLambdaQueryWrapper.eq(TopicSubject::getSubjectName, topicExcel.getSubjectName());
                    TopicSubject topicSubjectDb = topicSubjectMapper.selectOne(topicSubjectLambdaQueryWrapper);
                    if (StringUtils.isNull(topicSubjectDb)) {
                        throw new TopicException(ResultCodeEnum.TOPIC_SUBJECT_IS_NULL);
                    }
                    topicSubjectDb.setTopicCount(topicSubjectDb.getTopicCount() + 1);
                    topicSubjectMapper.updateById(topicSubjectDb);
                    
                    TopicSubjectTopic topicSubject = new TopicSubjectTopic();
                    topicSubject.setTopicId(topicDb.getId());
                    topicSubject.setSubjectId(topicSubjectDb.getId());
                    topicSubjectTopicMapper.insert(topicSubject);

                    
                    String[] labelNames = topicExcel.getLabelName().split(":");
                    
                    for (int i = 0; i < labelNames.length; i++) {
                        for (int j = i + 1; j < labelNames.length; j++) {
                            if (labelNames[i].equals(labelNames[j])) {
                                throw new TopicException(ResultCodeEnum.TOPIC_LABEL_IS_NULL);
                            }
                        }
                    }
                    for (String labelName : labelNames) {
                        if (StringUtils.isNull(labelName)) {
                            throw new TopicException(ResultCodeEnum.TOPIC_LABEL_IS_NULL);
                        }
                        
                        LambdaQueryWrapper<TopicLabel> topicLabelLambdaQueryWrapper = new LambdaQueryWrapper<>();
                        topicLabelLambdaQueryWrapper.eq(TopicLabel::getLabelName, labelName);
                        TopicLabel topicLabelDb = topicLabelMapper.selectOne(topicLabelLambdaQueryWrapper);
                        if (topicLabelDb == null) {
                            throw new TopicException(ResultCodeEnum.TOPIC_LABEL_IS_NULL);
                        }
                        
                        topicLabelDb.setUseCount(topicLabelDb.getUseCount() + 1);
                        topicLabelMapper.updateById(topicLabelDb);

                        
                        TopicLabelTopic topicLabelTopic = new TopicLabelTopic();
                        topicLabelTopic.setTopicId(topicDb.getId());
                        topicLabelTopic.setLabelId(topicLabelDb.getId());
                        topicLabelTopicMapper.insert(topicLabelTopic);
                    }
                    
                    if (currentId == 1L) {
                        
                        topicDb.setStatus(StatusEnums.NORMAL.getCode());
                        topicMapper.insert(topicDb);
                    } else {
                        
                        topicDb.setStatus(StatusEnums.AUDITING.getCode());
                        topicMapper.insert(topicDb);
                        
                        TopicAudit topicAudit = new TopicAudit();
                        topicAudit.setTopicName(topicExcel.getTopicName());
                        topicAudit.setAnswer(topicExcel.getAnswer());
                        topicAudit.setAccount(username);
                        topicAudit.setUserId(currentId);
                        topicAudit.setTopicSubjectName(topicExcel.getSubjectName());
                        topicAudit.setTopicLabelName(topicExcel.getLabelName());
                        topicAudit.setId(topicDb.getId());
                        
                        String topicAuditJson = JSON.toJSONString(topicAudit);
                        rabbitService.sendMessage(RabbitConstant.TOPIC_AUDIT_EXCHANGE, RabbitConstant.TOPIC_AUDIT_ROUTING_KEY_NAME, topicAuditJson);
                    }
                    successNum++;
                    successMsg.append("<br/>").append(successNum).append("-题目：").append(topicDb.getTopicName()).append("-导入成功");

                } else if (updateSupport) {
                    if (topicExcel.getSubjectName() == null) {
                        throw new TopicException(ResultCodeEnum.TOPIC_SUBJECT_IS_NULL);
                    }
                    if (topicExcel.getLabelName() == null) {
                        throw new TopicException(ResultCodeEnum.TOPIC_LABEL_IS_NULL);
                    }
                    
                    String[] labelNames = topicExcel.getLabelName().split(":");
                    
                    for (int i = 0; i < labelNames.length; i++) {
                        for (int j = i + 1; j < labelNames.length; j++) {
                            if (labelNames[i].equals(labelNames[j])) {
                                throw new TopicException(ResultCodeEnum.TOPIC_LABEL_IS_NULL);
                            }
                        }
                    }
                    
                    LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                    topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getTopicId, topic.getId());
                    TopicSubjectTopic topicSubjectTopic = topicSubjectTopicMapper.selectOne(topicSubjectTopicLambdaQueryWrapper);
                    if (topicSubjectTopic != null) {
                        
                        TopicSubject topicSubject = topicSubjectMapper.selectById(topicSubjectTopic.getSubjectId());
                        if (topicSubject != null) {
                            
                            if (!topicSubject.getSubjectName().equals(topicExcel.getSubjectName())) {
                                
                                topicSubject.setTopicCount(topicSubject.getTopicCount() - 1);
                                topicSubjectMapper.updateById(topicSubject);
                                
                                LambdaQueryWrapper<TopicSubject> topicSubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
                                topicSubjectLambdaQueryWrapper.eq(TopicSubject::getSubjectName, topicExcel.getSubjectName());
                                TopicSubject topicSubjectDb = topicSubjectMapper.selectOne(topicSubjectLambdaQueryWrapper);
                                if (topicSubjectDb != null) {
                                    topicSubjectDb.setTopicCount(topicSubjectDb.getTopicCount() + 1);
                                    topicSubjectMapper.updateById(topicSubjectDb);
                                    
                                    TopicSubjectTopic topicSubjectTopicDb = new TopicSubjectTopic();
                                    topicSubjectTopicDb.setSubjectId(topicSubjectDb.getId());
                                    topicSubjectTopicDb.setTopicId(topic.getId());
                                    topicSubjectTopicMapper.insert(topicSubjectTopicDb);
                                }
                                
                                topicSubjectTopicMapper.deleteById(topicSubjectTopic);
                            }
                        }
                    }

                    
                    LambdaQueryWrapper<TopicLabelTopic> topicLabelTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                    topicLabelTopicLambdaQueryWrapper.eq(TopicLabelTopic::getTopicId, topic.getId());
                    List<TopicLabelTopic> topicLabelTopics = topicLabelTopicMapper.selectList(topicLabelTopicLambdaQueryWrapper);
                    
                    if (CollectionUtils.isNotEmpty(topicLabelTopics)) {
                        
                        List<Long> labelIds = topicLabelTopics.stream()
                                .map(TopicLabelTopic::getLabelId)
                                .toList();
                        
                        List<TopicLabel> topicLabels = topicLabelMapper.selectBatchIds(labelIds);
                        
                        topicLabels.forEach(topicLabel -> {
                            topicLabel.setUseCount(topicLabel.getUseCount() - 1);
                            topicLabelMapper.updateById(topicLabel);
                        });
                        
                        topicLabelTopicMapper.delete(topicLabelTopicLambdaQueryWrapper);

                        
                        for (String labelName : labelNames) {
                            
                            LambdaQueryWrapper<TopicLabel> topicLabelLambdaQueryWrapper = new LambdaQueryWrapper<>();
                            topicLabelLambdaQueryWrapper.eq(TopicLabel::getLabelName, labelName);
                            TopicLabel topicLabelDb = topicLabelMapper.selectOne(topicLabelLambdaQueryWrapper);
                            if (topicLabelDb != null) {
                                topicLabelDb.setUseCount(topicLabelDb.getUseCount() + 1);
                                topicLabelMapper.updateById(topicLabelDb);
                                
                                TopicLabelTopic topicLabelTopicDb = new TopicLabelTopic();
                                topicLabelTopicDb.setLabelId(topicLabelDb.getId());
                                topicLabelTopicDb.setTopicId(topic.getId());
                                topicLabelTopicMapper.insert(topicLabelTopicDb);
                            }
                        }
                    }

                    
                    if (currentId == 1L) {
                        
                        topic.setStatus(StatusEnums.NORMAL.getCode());
                    } else {
                        
                        topic.setStatus(StatusEnums.AUDITING.getCode());
                        
                        TopicAudit topicAudit = new TopicAudit();
                        topicAudit.setTopicName(topicExcel.getTopicName());
                        topicAudit.setAnswer(topicExcel.getAnswer());
                        topicAudit.setAccount(username);
                        topicAudit.setUserId(currentId);
                        topicAudit.setTopicSubjectName(topicExcel.getSubjectName());
                        topicAudit.setTopicLabelName(topicExcel.getLabelName());
                        topicAudit.setId(topic.getId());
                        
                        String topicAuditJson = JSON.toJSONString(topicAudit);
                        rabbitService.sendMessage(RabbitConstant.TOPIC_AUDIT_EXCHANGE, RabbitConstant.TOPIC_AUDIT_ROUTING_KEY_NAME, topicAuditJson);
                    }
                    topic.setFailMsg("");
                    
                    BeanUtils.copyProperties(topicExcel, topic);
                    topicMapper.updateById(topic);
                    successNum++;
                    successMsg.append("<br/>").append(successNum).append("-题目：").append(topic.getTopicName()).append("-更新成功");
                } else {
                    
                    failureNum++;
                    failureMsg.append("<br/>").append(failureNum).append("-题目：").append(topic.getTopicName()).append("-已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "-题目： " + topicExcel.getTopicName() + " 导入失败：";
                failureMsg.append(msg).append(e.getMessage());
                log.error(msg, e);
            }
        }
        if (failureNum > 0) {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
            throw new TopicException(failureMsg.toString());
        } else {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
        }
        return successMsg.toString();
    }

    

    public void auditTopic(Topic topic) {
        
        Topic topicDb = topicMapper.selectById(topic.getId());
        if (topicDb == null) {
            throw new TopicException(ResultCodeEnum.TOPIC_UPDATE_IS_NULL);
        }
        
        BeanUtils.copyProperties(topic, topicDb);
        
        if (Objects.equals(topic.getStatus(), StatusEnums.NORMAL.getCode())) {
            topic.setFailMsg("");
        }
        topic.setAiAnswer("");
        
        stringRedisTemplate.delete(RedisConstant.GENERATE_ANSWER_KEY_PREFIX + topic.getId());
        topicMapper.updateById(topic);
    }

    

    public void generateAnswer(Long id) {
        
        String s = stringRedisTemplate.opsForValue().get(RedisConstant.GENERATE_ANSWER_KEY_PREFIX + id);
        
        if (s == null || s.equals("")) {
            
            stringRedisTemplate.opsForValue().set(RedisConstant.GENERATE_ANSWER_KEY_PREFIX + id, String.valueOf(id), 1, TimeUnit.DAYS);
        } else {
            throw new TopicException(ResultCodeEnum.TOPIC_GENERATE_ANSWER_PROCESSING);
        }
        
        Topic topicDb = topicMapper.selectById(id);
        if (topicDb == null) {
            throw new TopicException(ResultCodeEnum.TOPIC_GENERATE_ANSWER_ERROR);
        }
        
        TopicAudit topicAudit = new TopicAudit();
        topicAudit.setTopicName(topicDb.getTopicName());
        topicAudit.setId(topicDb.getId());
        topicAudit.setUserId(SecurityUtils.getCurrentId());
        topicAudit.setAccount(SecurityUtils.getCurrentName());
        rabbitService.sendMessage(RabbitConstant.AI_ANSWER_EXCHANGE, RabbitConstant.AI_ANSWER_ROUTING_KEY_NAME, JSON.toJSONString(topicAudit));
    }

    

    public void updateAiAnswer(Topic topic) {
        
        Topic topicDb = topicMapper.selectById(topic.getId());
        if (topicDb == null) {
            throw new TopicException(ResultCodeEnum.TOPIC_GENERATE_ANSWER_ERROR);
        }
        
        topicDb.setAiAnswer(topic.getAiAnswer());
        topicMapper.updateById(topicDb);
    }

    

    public TopicDetailVo detail(Long id) {
        if (id == null) {
            return null;
        }
        Topic topic = topicMapper.selectById(id);
        if (topic == null) {
            return null;
        }
        
        LambdaQueryWrapper<TopicLabelTopic> topicLabelTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicLabelTopicLambdaQueryWrapper.eq(TopicLabelTopic::getTopicId, id);
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
        TopicDetailVo topicDetailVo = new TopicDetailVo();
        BeanUtils.copyProperties(topic, topicDetailVo);
        topicDetailVo.setLabelNames(labelNames);
        
        boolean topicCollected = isTopicCollected(topic.getId());
        topicDetailVo.setIsCollected(topicCollected);
        return topicDetailVo;
    }

    public boolean isTopicCollected(Long topicId) {
        
        Long userId = SecurityUtils.getCurrentId();
        
        String key = RedisConstant.USER_COLLECTIONS_PREFIX + userId;
        
        String value = String.valueOf(topicId);

        
        Double score = stringRedisTemplate.opsForZSet().score(key, value);

        return score != null;
    }

    

    public TopicAnswerVo getAnswer(Long id) {
        if (id == null) {
            throw new TopicException(ResultCodeEnum.TOPIC_ANSWER_NOT_EXIST);
        }
        
        String role = SecurityUtils.getCurrentRole();
        
        Topic topic = topicMapper.selectById(id);
        if (topic == null) {
            throw new TopicException(ResultCodeEnum.TOPIC_ANSWER_NOT_EXIST);
        }
        if (topic.getIsMember() == 1) {
            if (role.equals("member") || role.equals("admin")) {
                TopicAnswerVo topicAnswerVo = new TopicAnswerVo();
                BeanUtils.copyProperties(topic, topicAnswerVo);
                return topicAnswerVo;
            } else {
                throw new TopicException(ResultCodeEnum.TOPIC_MEMBER_ERROR);
            }
        } else {
            TopicAnswerVo topicAnswerVo = new TopicAnswerVo();
            BeanUtils.copyProperties(topic, topicAnswerVo);
            return topicAnswerVo;
        }
    }

    

    public void collection(Long id) {
        if (id == null) {
            throw new TopicException(ResultCodeEnum.TOPIC_COLLECTION_ERROR);
        }
        Long userId = SecurityUtils.getCurrentId(); 

        
        LambdaQueryWrapper<TopicCollection> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(TopicCollection::getTopicId, id)
                .eq(TopicCollection::getUserId, userId);

        
        Long count = topicCollectionMapper.selectCount(wrapper);

        if (count > 0) {
            
            int delete = topicCollectionMapper.delete(wrapper);
            if (delete <= 0) {
                throw new TopicException(ResultCodeEnum.TOPIC_COLLECTION_ERROR);
            }
            try {
                
                stringRedisTemplate.opsForZSet().remove(RedisConstant.USER_COLLECTIONS_PREFIX + userId, String.valueOf(id));
            } catch (Exception e) {
                throw new TopicException(ResultCodeEnum.TOPIC_COLLECTION_ERROR);
            }
        } else {
            
            TopicCollection newCollection = new TopicCollection();
            newCollection.setTopicId(id);
            newCollection.setUserId(userId);
            int insert = topicCollectionMapper.insert(newCollection);
            if (insert <= 0) {
                throw new TopicException(ResultCodeEnum.TOPIC_COLLECTION_ERROR);
            }
            try {
                
                stringRedisTemplate.opsForZSet().add(RedisConstant.USER_COLLECTIONS_PREFIX + userId, String.valueOf(id), System.currentTimeMillis());
            } catch (Exception e) {
                throw new TopicException(ResultCodeEnum.TOPIC_COLLECTION_ERROR);
            }
        }
    }

    

    public List<TopicCollectionVo> collectionList() {
        
        boolean userCollectionExists = isUserCollectionExists();
        if (!userCollectionExists) {
            return null;
        }

        
        Map<String, Double> topicIdScoreMap = getUserAllCollectionTopicIdsWithScores();
        if (topicIdScoreMap == null || topicIdScoreMap.isEmpty()) {
            return null;
        }

        
        List<Long> topicIds = topicIdScoreMap.keySet().stream()
                .map(Long::valueOf)
                .toList();

        
        List<TopicCollectionVo> topicCollectionVos = new ArrayList<>();

        
        for (Long topicId : topicIds) {
            LambdaQueryWrapper<Topic> topicLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicLambdaQueryWrapper.eq(Topic::getId, topicId);
            topicLambdaQueryWrapper.eq(Topic::getStatus, StatusEnums.NORMAL.getCode());
            Topic topic = topicMapper.selectOne(topicLambdaQueryWrapper);
            if (topic != null) {
                TopicCollectionVo topicCollectionVo = new TopicCollectionVo();
                BeanUtils.copyProperties(topic, topicCollectionVo);
                
                LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getTopicId, topicId);
                TopicSubjectTopic topicSubjectTopic = topicSubjectTopicMapper.selectOne(topicSubjectTopicLambdaQueryWrapper);
                if (topicSubjectTopic != null) {
                    LambdaQueryWrapper<TopicSubject> topicSubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
                    topicSubjectLambdaQueryWrapper.eq(TopicSubject::getId, topicSubjectTopic.getSubjectId());
                    topicSubjectLambdaQueryWrapper.eq(TopicSubject::getStatus, StatusEnums.NORMAL.getCode());
                    
                    TopicSubject topicSubject = topicSubjectMapper.selectOne(topicSubjectLambdaQueryWrapper);
                    if (topicSubject != null) {
                        topicCollectionVo.setSubjectId(topicSubject.getId());
                    }
                }
                
                Double score = topicIdScoreMap.get(topicId.toString());
                if (score != null) {
                    
                    Long timestamp = score.longValue();

                    
                    LocalDateTime dateTime = LocalDateTime.ofInstant(
                            Instant.ofEpochMilli(timestamp),
                            ZoneId.systemDefault()
                    );

                    
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    String formattedTime = dateTime.format(formatter);

                    topicCollectionVo.setCollectionTime(formattedTime);
                }
                
                LambdaQueryWrapper<TopicLabelTopic> topicLabelTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicLabelTopicLambdaQueryWrapper.eq(TopicLabelTopic::getTopicId, topicId);
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
                topicCollectionVo.setLabelNames(labelNames);
                topicCollectionVos.add(topicCollectionVo);
            }
        }
        return topicCollectionVos;
    }

    

    public boolean isUserCollectionExists() {
        Long userId = SecurityUtils.getCurrentId();
        String key = RedisConstant.USER_COLLECTIONS_PREFIX + userId;

        Boolean hasKey = stringRedisTemplate.hasKey(key);
        return Boolean.TRUE.equals(hasKey);
    }

    

    public Map<String, Double> getUserAllCollectionTopicIdsWithScores() {
        Long userId = SecurityUtils.getCurrentId();
        String key = RedisConstant.USER_COLLECTIONS_PREFIX + userId;

        
        Set<ZSetOperations.TypedTuple<String>> tuples = stringRedisTemplate.opsForZSet().rangeWithScores(key, 0, -1);

        if (tuples == null || tuples.isEmpty()) {
            return Collections.emptyMap();
        }

        
        Map<String, Double> result = new HashMap<>();
        for (ZSetOperations.TypedTuple<String> tuple : tuples) {
            result.put(tuple.getValue(), tuple.getScore());
        }

        return result;
    }

    

    public void count(TopicRecordCountDto topicRecordCountDto) {
        
        if (topicRecordCountDto.getTopicId() == null || topicRecordCountDto.getSubjectId() == null) {
            return;
        }
        
        Long userId = SecurityUtils.getCurrentId();
        
        String currentRole = SecurityUtils.getCurrentRole();
        String currentName;
        
        if (StringUtils.isEmpty(topicRecordCountDto.getNickname())) {
            
            currentName = SecurityUtils.getCurrentName();
        } else {
            currentName = topicRecordCountDto.getNickname();
        }
        
        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        
        LambdaQueryWrapper<TopicRecord> topicRecordLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicRecordLambdaQueryWrapper.eq(TopicRecord::getUserId, userId);
        topicRecordLambdaQueryWrapper.eq(TopicRecord::getTopicId, topicRecordCountDto.getTopicId());
        
        topicRecordLambdaQueryWrapper.eq(TopicRecord::getTopicTime, date);
        TopicRecord topicRecord = topicRecordMapper.selectOne(topicRecordLambdaQueryWrapper);
        if (topicRecord == null) {
            
            topicRecord = new TopicRecord();
            topicRecord.setTopicId(topicRecordCountDto.getTopicId());
            topicRecord.setSubjectId(topicRecordCountDto.getSubjectId());
            topicRecord.setCount(1L);
            topicRecord.setUserId(userId);
            topicRecord.setNickname(currentName);
            topicRecord.setTopicTime(new Date());
            topicRecordMapper.insert(topicRecord);
        } else {
            
            topicRecord.setCount(topicRecord.getCount() + 1);
            topicRecord.setTopicTime(new Date());
            topicRecordMapper.updateById(topicRecord);
        }
        
        Boolean hasKey = stringRedisTemplate.hasKey(RedisConstant.TOPIC_RANK_TODAY_PREFIX + date);
        if (Boolean.TRUE.equals(hasKey)) {
            
            stringRedisTemplate.opsForZSet().incrementScore(
                    RedisConstant.TOPIC_RANK_TODAY_PREFIX + date,
                    String.valueOf(userId),
                    1);
        } else {
            stringRedisTemplate.opsForZSet().add(RedisConstant.TOPIC_RANK_TODAY_PREFIX + date, String.valueOf(userId), 1);
        }
        
        Boolean aBoolean = stringRedisTemplate.hasKey(RedisConstant.TOPIC_RANK_PREFIX);
        if (Boolean.TRUE.equals(aBoolean)) {
            
            stringRedisTemplate.opsForZSet().incrementScore(
                    RedisConstant.TOPIC_RANK_PREFIX,
                    String.valueOf(userId),
                    1);
        } else {
            
            stringRedisTemplate.opsForZSet().add(RedisConstant.TOPIC_RANK_PREFIX, String.valueOf(userId), 1);
        }
        
        Map<String, String> userInfo = new HashMap<>();
        userInfo.put("nickname", currentName);
        userInfo.put("avatar", topicRecordCountDto.getAvatar());
        userInfo.put("role", currentRole);
        stringRedisTemplate.opsForHash().putAll(RedisConstant.USER_RANK_PREFIX + userId, userInfo);
    }

}
