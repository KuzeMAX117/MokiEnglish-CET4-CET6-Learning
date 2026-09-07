package com.hao.topic.topic.service.impl;

import com.alibaba.excel.EasyExcel;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hao.topic.api.utils.constant.RabbitConstant;
import com.hao.topic.api.utils.enums.StatusEnums;
import com.hao.topic.api.utils.mq.RabbitService;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.audit.TopicAuditSubject;
import com.hao.topic.model.dto.topic.TopicSubjectDto;
import com.hao.topic.model.dto.topic.TopicSubjectListDto;
import com.hao.topic.model.entity.topic.*;
import com.hao.topic.model.excel.topic.TopicSubjectExcel;
import com.hao.topic.model.excel.topic.TopicSubjectExcelExport;
import com.hao.topic.model.vo.system.TopicSubjectWebVo;
import com.hao.topic.model.vo.topic.TopicNameVo;
import com.hao.topic.model.vo.topic.TopicSubjectDetailAndTopicVo;
import com.hao.topic.model.vo.topic.TopicSubjectVo;
import com.hao.topic.topic.mapper.*;
import com.hao.topic.topic.service.TopicSubjectService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
@Slf4j
public class TopicSubjectServiceImpl implements TopicSubjectService {
    private final TopicSubjectMapper topicSubjectMapper;
    private final TopicSubjectTopicMapper topicSubjectTopicMapper;
    private final TopicCategorySubjectMapper topicCategorySubjectMapper;
    private final TopicCategoryMapper topicCategoryMapper;
    private final RabbitService rabbitService;
    private final TopicMapper topicMapper;

    

    public Map<String, Object> subjectList(TopicSubjectListDto topicSubjectListDto) {
        
        String username = SecurityUtils.getCurrentName();
        
        Long currentId = SecurityUtils.getCurrentId();
        log.info("当前用户登录名称和id：{},{}", username, currentId);
        
        LambdaQueryWrapper<TopicSubject> topicSubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
        
        if (currentId != 1L) {
            
            topicSubjectLambdaQueryWrapper.like(TopicSubject::getCreateBy, username);
        } else {
            
            
            if (!StringUtils.isEmpty(topicSubjectListDto.getCreateBy())) {
                topicSubjectLambdaQueryWrapper.like(TopicSubject::getCreateBy, topicSubjectListDto.getCreateBy());
            }
        }
        
        if (!StringUtils.isEmpty(topicSubjectListDto.getSubjectName())) {
            topicSubjectLambdaQueryWrapper.like(TopicSubject::getSubjectName, topicSubjectListDto.getSubjectName());
        }
        
        if (!StringUtils.isEmpty(topicSubjectListDto.getBeginCreateTime()) && !StringUtils.isEmpty(topicSubjectListDto.getEndCreateTime())) {
            topicSubjectLambdaQueryWrapper.between(TopicSubject::getCreateTime, topicSubjectListDto.getBeginCreateTime(), topicSubjectListDto.getEndCreateTime());
        }
        topicSubjectLambdaQueryWrapper.orderByDesc(TopicSubject::getCreateTime);
        
        if (topicSubjectListDto.getPageNum() == null || topicSubjectListDto.getPageSize() == null) {
            List<TopicSubject> topicSubjects = topicSubjectMapper.selectList(topicSubjectLambdaQueryWrapper);
            
            for (TopicSubject topicSubject : topicSubjects) {
                
                LambdaQueryWrapper<TopicCategorySubject> topicCategorySubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicCategorySubjectLambdaQueryWrapper.eq(TopicCategorySubject::getSubjectId, topicSubject.getId());
                TopicCategorySubject topicCategorySubject = topicCategorySubjectMapper.selectOne(topicCategorySubjectLambdaQueryWrapper);
                if (topicCategorySubject != null) {
                    TopicCategory topicCategory = topicCategoryMapper.selectById(topicCategorySubject.getCategoryId());
                    if (topicCategory != null) {
                        topicSubject.setCategoryName(topicCategory.getCategoryName());
                    }
                }
            }
            
            if (topicSubjectListDto.getCategoryName() != null) {
                
                topicSubjects.removeIf(topicSubject -> !topicSubject.getCategoryName().contains(topicSubjectListDto.getCategoryName()));
            }
            return Map.of("total", topicSubjects.size(), "rows", topicSubjects);
        } else {
            
            Page<TopicSubject> topicSubjectPage = new Page<>(topicSubjectListDto.getPageNum(), topicSubjectListDto.getPageSize());
            
            Page<TopicSubject> topicSubjectPageResult = topicSubjectMapper.selectPage(topicSubjectPage, topicSubjectLambdaQueryWrapper);
            topicSubjectPageResult.getRecords().forEach(topicSubject -> {
                
                LambdaQueryWrapper<TopicCategorySubject> topicCategorySubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicCategorySubjectLambdaQueryWrapper.eq(TopicCategorySubject::getSubjectId, topicSubject.getId());
                TopicCategorySubject topicCategorySubject = topicCategorySubjectMapper.selectOne(topicCategorySubjectLambdaQueryWrapper);
                if (topicCategorySubject != null) {
                    TopicCategory topicCategory = topicCategoryMapper.selectById(topicCategorySubject.getCategoryId());
                    if (topicCategory != null) {
                        topicSubject.setCategoryName(topicCategory.getCategoryName());
                    }
                }
            });
            
            if (topicSubjectListDto.getCategoryName() != null) {
                
                topicSubjectPageResult.getRecords().removeIf(topicSubject -> !topicSubject.getCategoryName().contains(topicSubjectListDto.getCategoryName()));
            }
            return Map.of("total", topicSubjectPageResult.getTotal(), "rows", topicSubjectPageResult.getRecords());
        }
    }

    

    @Transactional
    public void add(TopicSubjectDto topicSubjectDto) {
        
        TopicSubject topicSubjectDb = topicSubjectMapper.selectById(topicSubjectDto.getId());
        if (topicSubjectDb != null) {
            throw new TopicException(ResultCodeEnum.SUBJECT_NAME_EXIST);
        }
        
        TopicSubject topicSubjectDbByName = topicSubjectMapper.selectOne(new LambdaQueryWrapper<TopicSubject>().
                eq(TopicSubject::getSubjectName, topicSubjectDto.getSubjectName()));
        if(topicSubjectDbByName != null){
            throw new TopicException(ResultCodeEnum.SUBJECT_NAME_EXIST);
        }
        
        TopicCategory topicCategoryDb = topicCategoryMapper
                .selectOne(new LambdaQueryWrapper<TopicCategory>().
                        eq(TopicCategory::getCategoryName, topicSubjectDto.getCategoryName()));
        if (topicCategoryDb == null) {
            throw new TopicException(ResultCodeEnum.SUBJECT_SELECT_ERROR);
        }
        
        String username = SecurityUtils.getCurrentName();
        TopicSubject topicSubject = new TopicSubject();
        BeanUtils.copyProperties(topicSubjectDto, topicSubject);
        topicSubject.setCreateBy(username);

        
        Long currentId = SecurityUtils.getCurrentId();
        if (currentId == 1L) {
            
            topicSubject.setStatus(StatusEnums.NORMAL.getCode());
            topicSubjectMapper.insert(topicSubject);

        } else {
            
            topicSubject.setStatus(StatusEnums.AUDITING.getCode());
            topicSubjectMapper.insert(topicSubject);
            
            TopicAuditSubject topicAuditSubject = new TopicAuditSubject();
            topicAuditSubject.setSubjectName(topicSubject.getSubjectName());
            topicAuditSubject.setCategoryName(topicCategoryDb.getCategoryName());
            topicAuditSubject.setId(topicSubject.getId());
            topicAuditSubject.setSubjectDesc(topicSubject.getSubjectDesc());
            topicAuditSubject.setAccount(username);
            topicAuditSubject.setUserId(currentId);
            
            String topicAuditSubjectJson = JSON.toJSONString(topicAuditSubject);
            log.info("发送消息{}", topicAuditSubjectJson);
            
            rabbitService.sendMessage(RabbitConstant.SUBJECT_AUDIT_EXCHANGE, RabbitConstant.SUBJECT_AUDIT_ROUTING_KEY_NAME, topicAuditSubjectJson);
        }

        
        TopicCategorySubject topicCategorySubject = new TopicCategorySubject();
        topicCategorySubject.setCategoryId(topicCategoryDb.getId());
        topicCategorySubject.setSubjectId(topicSubject.getId());
        topicCategorySubjectMapper.insert(topicCategorySubject);

        topicCategoryDb.setSubjectCount(topicCategoryDb.getSubjectCount() + 1);
        
        topicCategoryMapper.updateById(topicCategoryDb);
    }

    

    @Transactional
    public void update(TopicSubjectDto topicSubjectDto) {
        
        TopicSubject topicSubjectDb = topicSubjectMapper.selectById(topicSubjectDto.getId());
        if (topicSubjectDb == null) {
            throw new TopicException(ResultCodeEnum.SUBJECT_UPDATE_IS_NULL);
        }
        
        TopicCategory topicCategoryDb = topicCategoryMapper
                .selectOne(new LambdaQueryWrapper<TopicCategory>().
                        eq(TopicCategory::getCategoryName, topicSubjectDto.getCategoryName()));
        if (topicCategoryDb == null) {
            throw new TopicException(ResultCodeEnum.SUBJECT_SELECT_ERROR);
        }
        
        topicCategorySubjectMapper
                .delete(new LambdaQueryWrapper<TopicCategorySubject>()
                        .eq(TopicCategorySubject::getSubjectId, topicSubjectDto.getId()));
        
        if (!topicSubjectDb.getSubjectName().equals(topicSubjectDto.getSubjectName())
                || !topicSubjectDb.getSubjectDesc().equals(topicSubjectDto.getSubjectDesc())) {
            
            Long currentId = SecurityUtils.getCurrentId();
            if (currentId == 1L) {
                
                topicSubjectDb.setStatus(StatusEnums.NORMAL.getCode());
            } else {
                
                topicSubjectDb.setStatus(StatusEnums.AUDITING.getCode());
                
                TopicAuditSubject topicAuditSubject = new TopicAuditSubject();
                topicAuditSubject.setSubjectName(topicSubjectDb.getSubjectName());
                topicAuditSubject.setCategoryName(topicCategoryDb.getCategoryName());
                topicAuditSubject.setUserId(currentId);
                topicAuditSubject.setAccount(SecurityUtils.getCurrentName());
                topicAuditSubject.setId(topicSubjectDb.getId());
                topicAuditSubject.setSubjectDesc(topicSubjectDto.getSubjectDesc());
                String topicAuditSubjectJson = JSON.toJSONString(topicAuditSubject);
                log.info("发送消息{}", topicAuditSubjectJson);
                rabbitService.sendMessage(RabbitConstant.SUBJECT_AUDIT_EXCHANGE, RabbitConstant.SUBJECT_AUDIT_ROUTING_KEY_NAME, topicAuditSubjectJson);
            }
            topicSubjectDb.setFailMsg("");
        }
        BeanUtils.copyProperties(topicSubjectDto, topicSubjectDb);
        topicSubjectMapper.updateById(topicSubjectDb);
        
        TopicCategorySubject topicCategorySubject = new TopicCategorySubject();
        topicCategorySubject.setCategoryId(topicCategoryDb.getId());
        topicCategorySubject.setSubjectId(topicSubjectDb.getId());
        topicCategorySubjectMapper.insert(topicCategorySubject);
    }

    

    @Override
    public void delete(Long[] ids) {
        
        if (ids == null) {
            throw new TopicException(ResultCodeEnum.SUBJECT_DELETE_IS_NULL);
        }
        for (Long id : ids) {
            
            LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getSubjectId, id);
            TopicSubjectTopic topicSubjectTopic = topicSubjectTopicMapper.selectOne(topicSubjectTopicLambdaQueryWrapper);
            if (topicSubjectTopic != null) {
                throw new TopicException(ResultCodeEnum.SUBJECT_DELETE_TOPIC_ERROR);
            }
            
            LambdaQueryWrapper<TopicCategorySubject> topicCategorySubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicCategorySubjectLambdaQueryWrapper.eq(TopicCategorySubject::getSubjectId, id);
            TopicCategorySubject topicCategorySubject = topicCategorySubjectMapper.selectOne(topicCategorySubjectLambdaQueryWrapper);
            if (topicCategorySubject != null) {
                TopicCategory topicCategory = topicCategoryMapper.selectById(topicCategorySubject.getCategoryId());
                if (topicCategory != null) {
                    topicCategory.setSubjectCount(topicCategory.getSubjectCount() - 1);
                    
                    topicCategoryMapper.updateById(topicCategory);
                }
            }
            
            topicCategorySubjectMapper.delete(topicCategorySubjectLambdaQueryWrapper);
            
            topicSubjectMapper.deleteById(id);
        }
    }

    

    public List<TopicSubjectExcelExport> getExcelVo(TopicSubjectListDto topicSubjectListDto, Long[] ids) {
        
        if (ids[0] != 0) {
            
            List<TopicSubject> topicSubjects = topicSubjectMapper.selectBatchIds(Arrays.asList(ids));
            if (CollectionUtils.isEmpty(topicSubjects)) {
                throw new TopicException(ResultCodeEnum.EXPORT_ERROR);
            }
            return topicSubjects.stream().map(topicSubject -> {
                TopicSubjectExcelExport topicSubjectExcelExport = new TopicSubjectExcelExport();
                BeanUtils.copyProperties(topicSubject, topicSubjectExcelExport);
                
                topicSubjectExcelExport.setStatus(StatusEnums.getMessageByCode(topicSubject.getStatus()));
                
                
                LambdaQueryWrapper<TopicCategorySubject> topicCategorySubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicCategorySubjectLambdaQueryWrapper.eq(TopicCategorySubject::getSubjectId, topicSubject.getId());
                TopicCategorySubject topicCategorySubject = topicCategorySubjectMapper.selectOne(topicCategorySubjectLambdaQueryWrapper);
                if (topicCategorySubject != null) {
                    TopicCategory topicCategory = topicCategoryMapper.selectById(topicCategorySubject.getCategoryId());
                    if (topicCategory != null) {
                        topicSubjectExcelExport.setCategoryName(topicCategory.getCategoryName());
                    }
                }
                return topicSubjectExcelExport;
            }).collect(Collectors.toList());
        } else {
            Map<String, Object> map = subjectList(topicSubjectListDto);
            if (map.get("rows") == null) {
                throw new TopicException(ResultCodeEnum.EXPORT_ERROR);
            }
            List<TopicSubject> categories = (List<TopicSubject>) map.get("rows");
            
            return categories.stream().map(topicSubject -> {
                TopicSubjectExcelExport topicSubjectExcelExport = new TopicSubjectExcelExport();
                BeanUtils.copyProperties(topicSubject, topicSubjectExcelExport);
                
                topicSubjectExcelExport.setStatus(StatusEnums.getMessageByCode(topicSubject.getStatus()));
                return topicSubjectExcelExport;
            }).collect(Collectors.toList());
        }
    }

    

    @Transactional
    public String importExcel(MultipartFile multipartFile, Boolean updateSupport) throws IOException {
        
        String username = SecurityUtils.getCurrentName();
        Long currentId = SecurityUtils.getCurrentId();
        
        List<TopicSubjectExcel> excelVoList = EasyExcel.read(multipartFile.getInputStream())
                
                .head(TopicSubjectExcel.class)
                
                .sheet()
                
                .doReadSync();
        
        if (CollectionUtils.isEmpty(excelVoList)) {
            throw new TopicException(ResultCodeEnum.IMPORT_ERROR);
        }
        
        int successNum = 0;
        
        int failureNum = 0;
        
        StringBuilder successMsg = new StringBuilder();
        
        StringBuilder failureMsg = new StringBuilder();
        
        for (TopicSubjectExcel topicSubjectExcel : excelVoList) {
            if (StringUtils.isNull(topicSubjectExcel.getSubjectName()) || StringUtils.isNull(topicSubjectExcel.getSubjectDesc()) || StringUtils.isNull(topicSubjectExcel.getImageUrl()) || StringUtils.isNull(topicSubjectExcel.getCategoryName())) {
                throw new TopicException(ResultCodeEnum.IMPORT_ERROR);
            }
            
            TopicCategory topicCategoryDb = topicCategoryMapper
                    .selectOne(new LambdaQueryWrapper<TopicCategory>().
                            eq(TopicCategory::getCategoryName, topicSubjectExcel.getCategoryName()));
            if (topicCategoryDb == null) {
                failureNum++;
                String msg = "<br/>" + failureNum + "-题目专题： " + topicSubjectExcel.getSubjectName() + " 导入失败题目分类不存在：";
                failureMsg.append(msg);
                throw new TopicException(failureMsg.toString());
            }
        }

        
        for (TopicSubjectExcel topicSubjectExcel : excelVoList) {
            try {
                LambdaQueryWrapper<TopicSubject> topicSubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicSubjectLambdaQueryWrapper.eq(TopicSubject::getSubjectName, topicSubjectExcel.getSubjectName());
                TopicSubject topicSubject = topicSubjectMapper.selectOne(topicSubjectLambdaQueryWrapper);
                if (StringUtils.isNull(topicSubject)) {
                    
                    TopicSubject topicSubjectDb = new TopicSubject();
                    BeanUtils.copyProperties(topicSubjectExcel, topicSubjectDb);
                    topicSubjectDb.setCreateBy(username);
                    
                    if (currentId == 1L) {
                        
                        topicSubjectDb.setStatus(StatusEnums.NORMAL.getCode());
                        topicSubjectMapper.insert(topicSubjectDb);
                    } else {
                        
                        topicSubjectDb.setStatus(StatusEnums.AUDITING.getCode());
                        topicSubjectMapper.insert(topicSubjectDb);
                        
                        TopicAuditSubject topicAuditSubject = new TopicAuditSubject();
                        topicAuditSubject.setSubjectName(topicSubjectDb.getSubjectName());
                        topicAuditSubject.setCategoryName(topicSubjectExcel.getCategoryName());
                        topicAuditSubject.setId(topicSubjectDb.getId());
                        topicAuditSubject.setAccount(SecurityUtils.getCurrentName());
                        topicAuditSubject.setSubjectDesc(topicSubjectDb.getSubjectDesc());
                        topicAuditSubject.setUserId(currentId);
                        String topicAuditSubjectJson = JSON.toJSONString(topicAuditSubject);
                        log.info("发送消息{}", topicAuditSubjectJson);
                        rabbitService.sendMessage(RabbitConstant.SUBJECT_AUDIT_EXCHANGE, RabbitConstant.SUBJECT_AUDIT_ROUTING_KEY_NAME, topicAuditSubjectJson);
                    }
                    TopicCategory topicCategory = topicCategoryMapper.selectOne(new LambdaQueryWrapper<TopicCategory>()
                            .eq(TopicCategory::getCategoryName, topicSubjectExcel.getCategoryName()));
                    
                    TopicCategorySubject topicCategorySubject = new TopicCategorySubject();
                    topicCategorySubject.setCategoryId(topicCategory.getId());
                    topicCategorySubject.setSubjectId(topicSubjectDb.getId());
                    if (topicCategorySubjectMapper != null) {
                        topicCategorySubjectMapper.insert(topicCategorySubject);
                    }
                    topicCategory.setSubjectCount(topicCategory.getSubjectCount() + 1);
                    successNum++;
                    successMsg.append("<br/>").append(successNum).append("-题目专题：").append(topicSubjectDb.getSubjectName()).append("-导入成功");
                } else if (updateSupport) {
                    
                    if (currentId == 1L) {
                        
                        topicSubject.setStatus(StatusEnums.NORMAL.getCode());
                    } else {
                        
                        if (!topicSubjectExcel.getSubjectName().equals(topicSubject.getSubjectName())
                                || !topicSubjectExcel.getSubjectDesc().equals(topicSubject.getSubjectDesc())
                        ) {
                            
                            
                            TopicAuditSubject topicAuditSubject = new TopicAuditSubject();
                            topicAuditSubject.setSubjectName(topicSubjectExcel.getSubjectName());
                            topicAuditSubject.setCategoryName(topicSubjectExcel.getCategoryName());
                            topicAuditSubject.setId(topicSubject.getId());
                            topicAuditSubject.setAccount(SecurityUtils.getCurrentName());
                            topicAuditSubject.setUserId(currentId);
                            topicAuditSubject.setSubjectDesc(topicSubjectExcel.getSubjectDesc());
                            String topicAuditSubjectJson = JSON.toJSONString(topicAuditSubject);
                            log.info("发送消息{}", topicAuditSubjectJson);
                            rabbitService.sendMessage(RabbitConstant.SUBJECT_AUDIT_EXCHANGE, RabbitConstant.SUBJECT_AUDIT_ROUTING_KEY_NAME, topicAuditSubjectJson);
                        }
                        topicSubject.setFailMsg("");
                    }
                    
                    BeanUtils.copyProperties(topicSubjectExcel, topicSubject);
                    topicSubjectMapper.updateById(topicSubject);
                    
                    LambdaQueryWrapper<TopicCategorySubject> topicCategorySubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
                    topicCategorySubjectLambdaQueryWrapper.eq(TopicCategorySubject::getSubjectId, topicSubject.getId());
                    topicCategorySubjectMapper.delete(topicCategorySubjectLambdaQueryWrapper);
                    TopicCategory topicCategory = topicCategoryMapper.selectOne(new LambdaQueryWrapper<TopicCategory>()
                            .eq(TopicCategory::getCategoryName, topicSubjectExcel.getCategoryName()));
                    
                    TopicCategorySubject topicCategorySubject = new TopicCategorySubject();
                    topicCategorySubject.setCategoryId(topicCategory.getId());
                    topicCategorySubject.setSubjectId(topicSubject.getId());
                    topicCategorySubjectMapper.insert(topicCategorySubject);
                    successNum++;
                    successMsg.append("<br/>").append(successNum).append("-题目专题：").append(topicSubject.getSubjectName()).append("-更新成功");
                } else {
                    
                    failureNum++;
                    failureMsg.append("<br/>").append(failureNum).append("-题目专题：").append(topicSubject.getSubjectName()).append("-已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "-题目专题： " + topicSubjectExcel.getSubjectName() + " 导入失败：";
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

    

    public List<TopicSubjectVo> list() {
        
        String username = SecurityUtils.getCurrentName();
        
        Long currentId = SecurityUtils.getCurrentId();
        log.info("当前用户登录名称和id：{},{}", username, currentId);
        
        LambdaQueryWrapper<TopicSubject> topicSubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicSubjectLambdaQueryWrapper.eq(TopicSubject::getStatus, 0);
        
        if (currentId != 1L) {

        } else {
            topicSubjectLambdaQueryWrapper.eq(TopicSubject::getCreateBy, username);
        }
        return topicSubjectMapper.selectList(topicSubjectLambdaQueryWrapper).stream().map(topicSubject -> {
            TopicSubjectVo topicSubjectVo = new TopicSubjectVo();
            BeanUtils.copyProperties(topicSubject, topicSubjectVo);
            return topicSubjectVo;
        }).collect(Collectors.toList());
    }

    

    public void auditSubject(TopicSubject topicSubject) {
        
        TopicSubject topicSubjectDb = topicSubjectMapper.selectById(topicSubject.getId());
        if (topicSubjectDb == null) {
            throw new TopicException(ResultCodeEnum.SUBJECT_UPDATE_IS_NULL);
        }
        
        BeanUtils.copyProperties(topicSubject, topicSubjectDb);
        
        if (Objects.equals(topicSubject.getStatus(), StatusEnums.NORMAL.getCode())) {
            topicSubject.setFailMsg("");
        }
        topicSubjectMapper.updateById(topicSubject);
    }

    

    public List<TopicSubjectWebVo> subject(Long categoryId) {
        List<TopicSubjectWebVo> topicSubjectWebVos = new ArrayList<>();
        
        LambdaQueryWrapper<TopicCategorySubject> topicCategorySubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicCategorySubjectLambdaQueryWrapper.eq(TopicCategorySubject::getCategoryId, categoryId);
        List<TopicCategorySubject> topicCategorySubjects = topicCategorySubjectMapper.selectList(topicCategorySubjectLambdaQueryWrapper);
        if (CollectionUtils.isEmpty(topicCategorySubjects)) {
            return null;
        }
        
        List<Long> subjectIds = topicCategorySubjects.stream().map(TopicCategorySubject::getSubjectId).toList();
        
        for (Long subjectId : subjectIds) {
            LambdaQueryWrapper<TopicSubject> topicSubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicSubjectLambdaQueryWrapper.eq(TopicSubject::getId, subjectId);
            topicSubjectLambdaQueryWrapper.eq(TopicSubject::getStatus, StatusEnums.NORMAL.getCode());
            TopicSubject topicSubject = topicSubjectMapper.selectOne(topicSubjectLambdaQueryWrapper);
            if (topicSubject != null) {
                TopicSubjectWebVo topicSubjectWebVo = new TopicSubjectWebVo();
                BeanUtils.copyProperties(topicSubject, topicSubjectWebVo);
                topicSubjectWebVos.add(topicSubjectWebVo);
            }
        }
        
        topicSubjectWebVos.sort(Comparator.comparing(TopicSubjectWebVo::getId));
        return topicSubjectWebVos;
    }

    

    public TopicSubjectDetailAndTopicVo subjectDetail(Long id) {
        
        if (id == null) {
            return null;
        }
        TopicSubject topicSubject = topicSubjectMapper.selectById(id);
        if (topicSubject == null) {
            return null;
        }
        
        topicSubject.setViewCount(topicSubject.getViewCount() + 1);
        topicSubjectMapper.updateById(topicSubject);
        TopicSubjectDetailAndTopicVo topicSubjectDetailAndTopicVo = new TopicSubjectDetailAndTopicVo();
        BeanUtils.copyProperties(topicSubject, topicSubjectDetailAndTopicVo);
        
        LambdaQueryWrapper<TopicSubjectTopic> topicSubjectTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicSubjectTopicLambdaQueryWrapper.eq(TopicSubjectTopic::getSubjectId, id);
        List<TopicSubjectTopic> topicSubjectTopics = topicSubjectTopicMapper.selectList(topicSubjectTopicLambdaQueryWrapper);
        
        List<TopicNameVo> topicNameVos = new ArrayList<>();
        
        for (TopicSubjectTopic topicSubjectTopic : topicSubjectTopics) {
            LambdaQueryWrapper<Topic> topicLambdaQueryWrapper = new LambdaQueryWrapper<>();
            topicLambdaQueryWrapper.eq(Topic::getId, topicSubjectTopic.getTopicId());
            topicLambdaQueryWrapper.eq(Topic::getStatus, StatusEnums.NORMAL.getCode());
            topicLambdaQueryWrapper.orderByDesc(Topic::getSorted);
            topicLambdaQueryWrapper.orderByDesc(Topic::getCreateTime);
            Topic topic = topicMapper.selectOne(topicLambdaQueryWrapper);
            if (topic != null) {
                TopicNameVo topicNameVo = new TopicNameVo();
                topicNameVo.setTopicName(topic.getTopicName());
                topicNameVo.setId(topic.getId());
                topicNameVos.add(topicNameVo);
            }
        }
        topicSubjectDetailAndTopicVo.setTopicNameVos(topicNameVos);
        return topicSubjectDetailAndTopicVo;
    }

}
