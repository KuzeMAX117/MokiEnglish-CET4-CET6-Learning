package com.hao.topic.topic.service.impl;

import com.alibaba.excel.EasyExcel;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hao.topic.api.utils.constant.RabbitConstant;
import com.hao.topic.api.utils.enums.StatusEnums;
import com.hao.topic.api.utils.mq.RabbitService;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.audit.TopicAuditLabel;
import com.hao.topic.model.dto.topic.TopicLabelDto;
import com.hao.topic.model.dto.topic.TopicLabelListDto;
import com.hao.topic.model.entity.topic.*;
import com.hao.topic.model.entity.topic.TopicLabel;
import com.hao.topic.model.excel.topic.TopicLabelExcel;
import com.hao.topic.model.excel.topic.TopicLabelExcelExport;
import com.hao.topic.model.vo.topic.TopicLabelVo;
import com.hao.topic.topic.mapper.TopicLabelMapper;
import com.hao.topic.topic.mapper.TopicLabelTopicMapper;
import com.hao.topic.topic.service.TopicLabelService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
@Slf4j
public class TopicLabelServiceImpl implements TopicLabelService {

    private final TopicLabelMapper topicLabelMapper;
    private final TopicLabelTopicMapper topicLabelTopicMapper;
    private final RabbitService rabbitService;

    

    public Map<String, Object> labelList(TopicLabelListDto topicLabelListDto) {
        
        String username = SecurityUtils.getCurrentName();
        
        Long currentId = SecurityUtils.getCurrentId();
        log.info("当前用户登录名称和id：{},{}", username, currentId);
        
        LambdaQueryWrapper<TopicLabel> topiclabelLambdaQueryWrapper = new LambdaQueryWrapper<>();
        
        if (currentId != 1L) {
            
            topiclabelLambdaQueryWrapper.like(TopicLabel::getCreateBy, username);
        } else {
            
            
            if (!StringUtils.isEmpty(topicLabelListDto.getCreateBy())) {
                topiclabelLambdaQueryWrapper.like(TopicLabel::getCreateBy, topicLabelListDto.getCreateBy());
            }
        }
        
        if (!StringUtils.isEmpty(topicLabelListDto.getLabelName())) {
            topiclabelLambdaQueryWrapper.like(TopicLabel::getLabelName, topicLabelListDto.getLabelName());
        }
        
        if (!StringUtils.isEmpty(topicLabelListDto.getBeginCreateTime()) && !StringUtils.isEmpty(topicLabelListDto.getEndCreateTime())) {
            topiclabelLambdaQueryWrapper.between(TopicLabel::getCreateTime, topicLabelListDto.getBeginCreateTime(), topicLabelListDto.getEndCreateTime());
        }
        topiclabelLambdaQueryWrapper.orderByDesc(TopicLabel::getCreateTime);
        if (topicLabelListDto.getPageNum() == null || topicLabelListDto.getPageSize() == null) {
            List<TopicLabel> topicLabels = topicLabelMapper.selectList(topiclabelLambdaQueryWrapper);
            return Map.of("total", topicLabels.size(), "rows", topicLabels);
        } else {
            
            Page<TopicLabel> topicLabelPage = new Page<>(topicLabelListDto.getPageNum(), topicLabelListDto.getPageSize());
            
            Page<TopicLabel> topicLabelList = topicLabelMapper.selectPage(topicLabelPage, topiclabelLambdaQueryWrapper);
            return Map.of("total", topicLabelList.getTotal(), "rows", topicLabelList.getRecords());
        }
    }

    

    public void add(TopicLabelDto topicLabelDto) {
        LambdaQueryWrapper<TopicLabel> topicLabelLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicLabelLambdaQueryWrapper.eq(TopicLabel::getLabelName, topicLabelDto.getLabelName());
        
        TopicLabel topicLabelDb = topicLabelMapper.selectOne(topicLabelLambdaQueryWrapper);
        if (topicLabelDb != null) {
            throw new TopicException(ResultCodeEnum.LABEL_NAME_EXIST);
        }
        
        String username = SecurityUtils.getCurrentName();
        TopicLabel topicLabel = new TopicLabel();
        topicLabel.setLabelName(topicLabelDto.getLabelName());
        topicLabel.setCreateBy(username);
        
        Long currentId = SecurityUtils.getCurrentId();
        if (currentId == 1L) {
            
            topicLabel.setStatus(StatusEnums.NORMAL.getCode());
            topicLabelMapper.insert(topicLabel);
        } else {
            
            topicLabel.setStatus(StatusEnums.AUDITING.getCode());
            topicLabelMapper.insert(topicLabel);
            
            TopicAuditLabel topicAuditLabel = new TopicAuditLabel();
            topicAuditLabel.setLabelName(topicLabelDto.getLabelName());
            topicAuditLabel.setAccount(username);
            topicAuditLabel.setUserId(currentId);
            topicAuditLabel.setId(topicLabel.getId());
            String topicAuditLabelJson = JSON.toJSONString(topicAuditLabel);
            log.info("发送消息{}", topicAuditLabelJson);
            rabbitService.sendMessage(RabbitConstant.LABEL_AUDIT_EXCHANGE, RabbitConstant.LABEL_AUDIT_ROUTING_KEY_NAME, topicAuditLabelJson);
        }
    }

    

    @Override
    public void update(TopicLabelDto topicLabelDto) {
        
        TopicLabel topicLabel = topicLabelMapper.selectById(topicLabelDto.getId());
        if (topicLabel == null) {
            throw new TopicException(ResultCodeEnum.CATEGORY_UPDATE_IS_NULL);
        }
        
        if (!topicLabel.getLabelName().equals(topicLabelDto.getLabelName())) {
            
            
            
            Long currentId = SecurityUtils.getCurrentId();
            if (currentId == 1L) {
                
                topicLabel.setStatus(StatusEnums.NORMAL.getCode());
            } else {
                
                topicLabel.setStatus(StatusEnums.AUDITING.getCode());
                
                TopicAuditLabel topicAuditLabel = new TopicAuditLabel();
                topicAuditLabel.setLabelName(topicLabelDto.getLabelName());
                topicAuditLabel.setAccount(SecurityUtils.getCurrentName());
                topicAuditLabel.setUserId(currentId);
                topicAuditLabel.setId(topicLabelDto.getId());
                String topicAuditLabelJson = JSON.toJSONString(topicAuditLabel);
                log.info("发送消息{}", topicAuditLabelJson);
                rabbitService.sendMessage(RabbitConstant.LABEL_AUDIT_EXCHANGE, RabbitConstant.LABEL_AUDIT_ROUTING_KEY_NAME, topicAuditLabelJson);
            }
            topicLabel.setFailMsg("");
        }
        
        topicLabel.setLabelName(topicLabelDto.getLabelName());
        topicLabelMapper.updateById(topicLabel);
    }

    

    public void delete(Long[] ids) {
        
        if (ids == null) {
            throw new TopicException(ResultCodeEnum.LABEL_DELETE_IS_NULL);
        }
        for (Long id : ids) {
            LambdaQueryWrapper<TopicLabelTopic> topicLabelTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
            
            topicLabelTopicLambdaQueryWrapper.eq(TopicLabelTopic::getLabelId, id);
            TopicLabelTopic topicLabelTopic = topicLabelTopicMapper.selectOne(topicLabelTopicLambdaQueryWrapper);
            if (topicLabelTopic != null) {
                throw new TopicException(ResultCodeEnum.LABEL_DELETE_TOPIC_ERROR);
            }
            
            topicLabelMapper.deleteById(id);
        }
    }

    

    public List<TopicLabelExcelExport> getExcelVo(TopicLabelListDto topicLabelDto, Long[] ids) {
        
        if (ids[0] != 0) {
            
            List<TopicLabel> topicLabels = topicLabelMapper.selectBatchIds(Arrays.asList(ids));
            if (CollectionUtils.isEmpty(topicLabels)) {
                throw new TopicException(ResultCodeEnum.EXPORT_ERROR);
            }
            return topicLabels.stream().map(TopicLabel -> {
                TopicLabelExcelExport TopicLabelExcelExport = new TopicLabelExcelExport();
                BeanUtils.copyProperties(TopicLabel, TopicLabelExcelExport);
                
                TopicLabelExcelExport.setStatus(StatusEnums.getMessageByCode(TopicLabel.getStatus()));
                return TopicLabelExcelExport;
            }).collect(Collectors.toList());
        } else {
            Map<String, Object> map = labelList(topicLabelDto);
            if (map.get("rows") == null) {
                throw new TopicException(ResultCodeEnum.EXPORT_ERROR);
            }
            List<TopicLabel> topicLabels = (List<TopicLabel>) map.get("rows");
            
            return topicLabels.stream().map(TopicLabel -> {
                TopicLabelExcelExport TopicLabelExcelExport = new TopicLabelExcelExport();
                BeanUtils.copyProperties(TopicLabel, TopicLabelExcelExport);
                
                TopicLabelExcelExport.setStatus(StatusEnums.getMessageByCode(TopicLabel.getStatus()));
                return TopicLabelExcelExport;
            }).collect(Collectors.toList());
        }
    }

    

    public String importExcel(MultipartFile multipartFile, Boolean updateSupport) throws IOException {
        
        String username = SecurityUtils.getCurrentName();
        Long currentId = SecurityUtils.getCurrentId();
        
        List<TopicLabelExcel> excelVoList = EasyExcel.read(multipartFile.getInputStream())
                
                .head(TopicLabelExcel.class)
                
                .sheet()
                
                .doReadSync();
        
        if (CollectionUtils.isEmpty(excelVoList)) {
            throw new TopicException(ResultCodeEnum.IMPORT_ERROR);
        }
        
        int successNum = 0;
        
        int failureNum = 0;
        
        StringBuilder successMsg = new StringBuilder();
        
        StringBuilder failureMsg = new StringBuilder();
        
        for (TopicLabelExcel topicLabelExcel : excelVoList) {
            try {
                LambdaQueryWrapper<TopicLabel> topicLabelLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicLabelLambdaQueryWrapper.eq(TopicLabel::getLabelName, topicLabelExcel.getLabelName());
                TopicLabel topicLabel = topicLabelMapper.selectOne(topicLabelLambdaQueryWrapper);
                if (StringUtils.isNull(topicLabel)) {
                    
                    TopicLabel topicLabelDb = new TopicLabel();
                    BeanUtils.copyProperties(topicLabelExcel, topicLabelDb);
                    topicLabelDb.setCreateBy(username);
                    
                    if (currentId == 1L) {
                        
                        topicLabelDb.setStatus(StatusEnums.NORMAL.getCode());
                        topicLabelMapper.insert(topicLabelDb);
                    } else {
                        
                        topicLabelDb.setStatus(StatusEnums.AUDITING.getCode());
                        topicLabelMapper.insert(topicLabelDb);
                        
                        TopicAuditLabel topicAuditLabel = new TopicAuditLabel();
                        
                        topicAuditLabel.setAccount(username);
                        topicAuditLabel.setUserId(currentId);
                        topicAuditLabel.setLabelName(topicLabelDb.getLabelName());
                        topicAuditLabel.setId(topicLabelDb.getId());
                        
                        String jsonString = JSON.toJSONString(topicAuditLabel);
                        log.info("发送消息{}", jsonString);
                        
                        rabbitService.sendMessage(RabbitConstant.LABEL_AUDIT_EXCHANGE, RabbitConstant.LABEL_AUDIT_ROUTING_KEY_NAME, jsonString);
                    }
                    successNum++;
                    successMsg.append("<br/>").append(successNum).append("-题目标签：").append(topicLabelDb.getLabelName()).append("-导入成功");
                } else if (updateSupport) {
                    
                    if (!topicLabel.getLabelName().equals(topicLabelExcel.getLabelName())) {
                        
                        if (currentId == 1L) {
                            
                            topicLabel.setStatus(StatusEnums.NORMAL.getCode());
                        } else {
                            
                            topicLabel.setStatus(StatusEnums.AUDITING.getCode());
                            
                            TopicAuditLabel topicAuditLabel = new TopicAuditLabel();
                            topicAuditLabel.setAccount(username);
                            topicAuditLabel.setUserId(currentId);
                            topicAuditLabel.setLabelName(topicLabelExcel.getLabelName());
                            topicAuditLabel.setId(topicLabel.getId());
                            String jsonString = JSON.toJSONString(topicAuditLabel);
                            log.info("发送消息{}", jsonString);
                            rabbitService.sendMessage(RabbitConstant.LABEL_AUDIT_EXCHANGE, RabbitConstant.LABEL_AUDIT_ROUTING_KEY_NAME, jsonString);
                        }
                        topicLabel.setFailMsg("");
                    }
                    
                    BeanUtils.copyProperties(topicLabelExcel, topicLabel);
                    topicLabelMapper.updateById(topicLabel);
                    successNum++;
                    successMsg.append("<br/>").append(successNum).append("-题目标签：").append(topicLabel.getLabelName()).append("-更新成功");
                } else {
                    
                    failureNum++;
                    failureMsg.append("<br/>").append(failureNum).append("-题目标签：").append(topicLabel.getLabelName()).append("-已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "-题目标签： " + topicLabelExcel.getLabelName() + " 导入失败：";
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

    

    @Override
    public List<TopicLabelVo> list() {
        
        String username = SecurityUtils.getCurrentName();
        
        Long currentId = SecurityUtils.getCurrentId();
        log.info("当前用户登录名称和id：{},{}", username, currentId);
        
        LambdaQueryWrapper<TopicLabel> topicLabelLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicLabelLambdaQueryWrapper.eq(TopicLabel::getStatus, 0);
        
        if (currentId != 1L) {

        } else {
            topicLabelLambdaQueryWrapper.eq(TopicLabel::getCreateBy, username);
        }
        return topicLabelMapper.selectList(topicLabelLambdaQueryWrapper).stream().map(topicLabel -> {
            TopicLabelVo topicLabelVo = new TopicLabelVo();
            BeanUtils.copyProperties(topicLabel, topicLabelVo);
            return topicLabelVo;
        }).collect(Collectors.toList());
    }

    

    public void auditLabel(TopicLabel topicLabel) {
        
        TopicLabel topicLabelDb = topicLabelMapper.selectById(topicLabel.getId());
        if (topicLabelDb == null) {
            throw new TopicException(ResultCodeEnum.LABEL_NOT_EXIST);
        }
        
        BeanUtils.copyProperties(topicLabel, topicLabelDb);
        
        if (Objects.equals(topicLabel.getStatus(), StatusEnums.NORMAL.getCode())) {
            topicLabel.setFailMsg("");
        }
        topicLabelMapper.updateById(topicLabel);
    }
}
