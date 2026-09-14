package com.hao.topic.topic.service.impl;

import com.alibaba.excel.EasyExcel;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hao.topic.api.utils.enums.StatusEnums;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.audit.TopicAuditCategory;
import com.hao.topic.model.dto.topic.TopicCategoryDto;
import com.hao.topic.model.dto.topic.TopicCategoryListDto;
import com.hao.topic.model.entity.topic.TopicCategory;
import com.hao.topic.model.entity.topic.TopicCategorySubject;
import com.hao.topic.model.excel.topic.TopicCategoryExcel;
import com.hao.topic.model.excel.topic.TopicCategoryExcelExport;
import com.hao.topic.model.vo.topic.TopicCategoryVo;
import com.hao.topic.topic.mapper.TopicCategoryMapper;
import com.hao.topic.topic.mapper.TopicCategorySubjectMapper;
import com.hao.topic.topic.service.TopicCategoryService;
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
public class TopicCategoryServiceImpl implements TopicCategoryService {
    private final TopicCategoryMapper topicCategoryMapper;
    private final TopicCategorySubjectMapper topicCategorySubjectMapper;

    

    public Map<String, Object> categoryList(TopicCategoryListDto topicCategoryDto) {
        
        String username = SecurityUtils.getCurrentName();
        
        Long currentId = SecurityUtils.getCurrentId();
        log.info("当前用户登录名称和id：{},{}", username, currentId);
        
        LambdaQueryWrapper<TopicCategory> topicCategoryLambdaQueryWrapper = new LambdaQueryWrapper<>();
        
        if (currentId != 1L) {
            
            topicCategoryLambdaQueryWrapper.like(TopicCategory::getCreateBy, username);
        } else {
            
            
            if (!StringUtils.isEmpty(topicCategoryDto.getCreateBy())) {
                topicCategoryLambdaQueryWrapper.like(TopicCategory::getCreateBy, topicCategoryDto.getCreateBy());
            }
        }
        
        if (!StringUtils.isEmpty(topicCategoryDto.getCategoryName())) {
            topicCategoryLambdaQueryWrapper.like(TopicCategory::getCategoryName, topicCategoryDto.getCategoryName());
        }
        
        if (!StringUtils.isEmpty(topicCategoryDto.getBeginCreateTime()) && !StringUtils.isEmpty(topicCategoryDto.getEndCreateTime())) {
            topicCategoryLambdaQueryWrapper.between(TopicCategory::getCreateTime, topicCategoryDto.getBeginCreateTime(), topicCategoryDto.getEndCreateTime());
        }
        topicCategoryLambdaQueryWrapper.orderByDesc(TopicCategory::getCreateTime);
        if (topicCategoryDto.getPageNum() == null || topicCategoryDto.getPageSize() == null) {
            if (topicCategoryDto.getStatus() != null) {
                topicCategoryLambdaQueryWrapper.eq(TopicCategory::getStatus, topicCategoryDto.getStatus());
            }
            List<TopicCategory> categories = topicCategoryMapper.selectList(topicCategoryLambdaQueryWrapper);
            return Map.of("total", categories.size(), "rows", categories);
        } else {
            
            Page<TopicCategory> topicCategoryPage = new Page<>(topicCategoryDto.getPageNum(), topicCategoryDto.getPageSize());
            
            Page<TopicCategory> topicCategoryList = topicCategoryMapper.selectPage(topicCategoryPage, topicCategoryLambdaQueryWrapper);
            return Map.of("total", topicCategoryList.getTotal(), "rows", topicCategoryList.getRecords());
        }
    }

    

    public void add(TopicCategoryDto topicCategoryDto) {
        
        if (StringUtils.isEmpty(topicCategoryDto.getCategoryName())) {
            throw new TopicException(ResultCodeEnum.CATEGORY_NAME_IS_NULL);
        }
        LambdaQueryWrapper<TopicCategory> topicCategoryLambdaQueryWrapper = new LambdaQueryWrapper<>();
        topicCategoryLambdaQueryWrapper.eq(TopicCategory::getCategoryName, topicCategoryDto.getCategoryName());
        
        TopicCategory topicCategoryDb = topicCategoryMapper.selectOne(topicCategoryLambdaQueryWrapper);
        if (topicCategoryDb != null) {
            throw new TopicException(ResultCodeEnum.CATEGORY_NAME_EXIST);
        }
        
        String username = SecurityUtils.getCurrentName();
        
        Long currentId = SecurityUtils.getCurrentId();
        TopicCategory topicCategory = new TopicCategory();
        topicCategory.setCategoryName(topicCategoryDto.getCategoryName());
        topicCategory.setCreateBy(username);
        if (currentId == 1L) {
            
            topicCategory.setStatus(StatusEnums.NORMAL.getCode());
            topicCategoryMapper.insert(topicCategory);
        } else {
            
            topicCategory.setStatus(StatusEnums.AUDITING.getCode());
            topicCategoryMapper.insert(topicCategory);
            topicCategoryDto.setId(topicCategory.getId());
            
            TopicAuditCategory topicAuditCategory = new TopicAuditCategory();
            BeanUtils.copyProperties(topicCategoryDto, topicAuditCategory);
            
            topicAuditCategory.setAccount(username);
            
            topicAuditCategory.setUserId(currentId);
            
            String jsonString = JSON.toJSONString(topicAuditCategory);
            log.info("发送的消息：{}", jsonString);
            
        }
    }

    

    public void update(TopicCategoryDto topicCategoryDto) {
        
        if (StringUtils.isEmpty(topicCategoryDto.getCategoryName())) {
            throw new TopicException(ResultCodeEnum.CATEGORY_NAME_IS_NULL);
        }
        
        TopicCategory topicCategory = topicCategoryMapper.selectById(topicCategoryDto.getId());
        if (topicCategory == null) {
            throw new TopicException(ResultCodeEnum.CATEGORY_UPDATE_IS_NULL);
        }
        
        Long currentId = SecurityUtils.getCurrentId();
        
        if (!topicCategory.getCategoryName().equals(topicCategoryDto.getCategoryName())) {
            
            if (currentId == 1L) {
                
                topicCategory.setStatus(StatusEnums.NORMAL.getCode());
            } else {
                
                topicCategory.setStatus(StatusEnums.AUDITING.getCode());
                
                TopicAuditCategory topicAuditCategory = new TopicAuditCategory();
                BeanUtils.copyProperties(topicCategoryDto, topicAuditCategory);
                
                topicAuditCategory.setAccount(SecurityUtils.getCurrentName());
                
                topicAuditCategory.setUserId(currentId);
                
                String jsonString = JSON.toJSONString(topicAuditCategory);
                log.info("发送的消息：{}", jsonString);
                
            }
            topicCategory.setFailMsg("");
        }
        
        topicCategory.setCategoryName(topicCategoryDto.getCategoryName());
        topicCategoryMapper.updateById(topicCategory);
    }

    

    public void delete(Long[] ids) {
        
        if (ids == null) {
            throw new TopicException(ResultCodeEnum.CATEGORY_DELETE_IS_NULL);
        }
        for (Long id : ids) {
            LambdaQueryWrapper<TopicCategorySubject> topicCategorySubjectLambdaQueryWrapper = new LambdaQueryWrapper<>();
            
            topicCategorySubjectLambdaQueryWrapper.eq(TopicCategorySubject::getCategoryId, id);
            List<TopicCategorySubject> topicCategorySubjects = topicCategorySubjectMapper.selectList(topicCategorySubjectLambdaQueryWrapper);
            if (!CollectionUtils.isEmpty(topicCategorySubjects)) {
                throw new TopicException(ResultCodeEnum.CATEGORY_DELETE_TOPIC_ERROR);
            }
            
            topicCategoryMapper.deleteById(id);
        }
    }

    

    public List<TopicCategoryExcelExport> getExcelVo(TopicCategoryListDto topicCategoryDto, Long[] ids) {
        
        if (ids[0] != 0) {
            
            List<TopicCategory> topicCategories = topicCategoryMapper.selectBatchIds(Arrays.asList(ids));
            if (CollectionUtils.isEmpty(topicCategories)) {
                throw new TopicException(ResultCodeEnum.EXPORT_ERROR);
            }
            return topicCategories.stream().map(topicCategory -> {
                TopicCategoryExcelExport topicCategoryExcelExport = new TopicCategoryExcelExport();
                BeanUtils.copyProperties(topicCategory, topicCategoryExcelExport);
                
                topicCategoryExcelExport.setStatus(StatusEnums.getMessageByCode(topicCategory.getStatus()));
                return topicCategoryExcelExport;
            }).collect(Collectors.toList());
        } else {
            Map<String, Object> map = categoryList(topicCategoryDto);
            if (map.get("rows") == null) {
                throw new TopicException(ResultCodeEnum.EXPORT_ERROR);
            }
            List<TopicCategory> categories = (List<TopicCategory>) map.get("rows");
            
            return categories.stream().map(topicCategory -> {
                TopicCategoryExcelExport topicCategoryExcelExport = new TopicCategoryExcelExport();
                BeanUtils.copyProperties(topicCategory, topicCategoryExcelExport);
                
                topicCategoryExcelExport.setStatus(StatusEnums.getMessageByCode(topicCategory.getStatus()));
                return topicCategoryExcelExport;
            }).collect(Collectors.toList());
        }
    }

    

    public String importExcel(MultipartFile multipartFile, Boolean updateSupport) throws IOException {
        
        String username = SecurityUtils.getCurrentName();
        
        List<TopicCategoryExcel> excelVoList = EasyExcel.read(multipartFile.getInputStream())
                
                .head(TopicCategoryExcel.class)
                
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
        
        for (TopicCategoryExcel topicCategoryExcel : excelVoList) {
            try {
                LambdaQueryWrapper<TopicCategory> topicCategoryLambdaQueryWrapper = new LambdaQueryWrapper<>();
                topicCategoryLambdaQueryWrapper.eq(TopicCategory::getCategoryName, topicCategoryExcel.getCategoryName());
                TopicCategory topicCategory = topicCategoryMapper.selectOne(topicCategoryLambdaQueryWrapper);
                if (StringUtils.isNull(topicCategory)) {
                    
                    TopicCategory topicCategoryDb = new TopicCategory();
                    BeanUtils.copyProperties(topicCategoryExcel, topicCategoryDb);
                    topicCategoryDb.setCreateBy(username);
                    if (currentId == 1L) {
                        
                        topicCategoryDb.setStatus(StatusEnums.NORMAL.getCode());
                        topicCategoryMapper.insert(topicCategoryDb);
                    } else {
                        
                        topicCategoryDb.setStatus(StatusEnums.AUDITING.getCode());
                        topicCategoryMapper.insert(topicCategoryDb);
                        
                        TopicCategoryDto topicCategoryDto = new TopicCategoryDto();
                        topicCategoryDto.setCategoryName(topicCategoryExcel.getCategoryName());
                        topicCategoryDto.setId(topicCategoryDb.getId());
                        
                        TopicAuditCategory topicAuditCategory = new TopicAuditCategory();
                        BeanUtils.copyProperties(topicCategoryDto, topicAuditCategory);
                        
                        topicAuditCategory.setAccount(SecurityUtils.getCurrentName());
                        
                        topicAuditCategory.setUserId(currentId);
                        
                        String jsonString = JSON.toJSONString(topicAuditCategory);
                        log.info("发送消息{}", jsonString);
                        
                    }
                    successNum++;
                    successMsg.append("<br/>").append(successNum).append("-题目分类：").append(topicCategoryDb.getCategoryName()).append("-导入成功");
                } else if (updateSupport) {
                    
                    if (!topicCategory.getCategoryName().equals(topicCategoryExcel.getCategoryName())) {
                        
                        if (currentId == 1L) {
                            
                            topicCategory.setStatus(StatusEnums.NORMAL.getCode());
                        } else {
                            
                            topicCategory.setStatus(StatusEnums.AUDITING.getCode());
                            
                            TopicCategoryDto topicCategoryDto = new TopicCategoryDto();
                            topicCategoryDto.setCategoryName(topicCategory.getCategoryName());
                            topicCategoryDto.setId(topicCategory.getId());
                            
                            TopicAuditCategory topicAuditCategory = new TopicAuditCategory();
                            BeanUtils.copyProperties(topicCategoryDto, topicAuditCategory);
                            
                            topicAuditCategory.setAccount(SecurityUtils.getCurrentName());
                            
                            topicAuditCategory.setUserId(currentId);
                            
                            String jsonString = JSON.toJSONString(topicAuditCategory);
                            log.info("发送消息{}", jsonString);
                            
                        }
                        topicCategory.setFailMsg("");
                    }
                    
                    BeanUtils.copyProperties(topicCategoryExcel, topicCategory);
                    topicCategoryMapper.updateById(topicCategory);
                    successNum++;
                    successMsg.append("<br/>").append(successNum).append("-题目分类：").append(topicCategory.getCategoryName()).append("-更新成功");
                } else {
                    
                    failureNum++;
                    failureMsg.append("<br/>").append(failureNum).append("-题目分类：").append(topicCategory.getCategoryName()).append("-已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "-题目分类： " + topicCategoryExcel.getCategoryName() + " 导入失败：";
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

    

    public void auditCategory(TopicCategory topicCategory) {
        
        TopicCategory topicCategoryDb = topicCategoryMapper.selectById(topicCategory.getId());
        if (topicCategoryDb == null) {
            throw new TopicException(ResultCodeEnum.CATEGORY_UPDATE_IS_NULL);
        }
        
        BeanUtils.copyProperties(topicCategory, topicCategoryDb);
        
        if (Objects.equals(topicCategory.getStatus(), StatusEnums.NORMAL.getCode())) {
            topicCategory.setFailMsg("");
        }
        topicCategoryMapper.updateById(topicCategory);
    }

    

    public List<TopicCategoryVo> category(Boolean isCustomQuestion) {
        
        String createBy = SecurityUtils.getCurrentName();
        
        String role = SecurityUtils.getCurrentRole();
        
        List<TopicCategory> topicCategoriesAll = null;
        
        List<TopicCategory> topicCategoriesMember = null;
        
        LambdaQueryWrapper<TopicCategory> objectLambdaQueryWrapper = new LambdaQueryWrapper<>();
        objectLambdaQueryWrapper.eq(TopicCategory::getStatus, StatusEnums.NORMAL.getCode())
                .eq(TopicCategory::getCreateBy, "admin")
                .orderByDesc(TopicCategory::getCreateTime);
        topicCategoriesAll = topicCategoryMapper.selectList(objectLambdaQueryWrapper);
        if (role.equals("member")) {
            if (isCustomQuestion) {
                
                
                LambdaQueryWrapper<TopicCategory> lambdaQueryWrapper = new LambdaQueryWrapper<>();
                lambdaQueryWrapper.eq(TopicCategory::getStatus, StatusEnums.NORMAL.getCode());
                lambdaQueryWrapper.orderByDesc(TopicCategory::getCreateTime);
                lambdaQueryWrapper.eq(TopicCategory::getCreateBy, createBy);
                topicCategoriesMember = topicCategoryMapper.selectList(lambdaQueryWrapper);
            }
        }
        
        if (!CollectionUtils.isEmpty(topicCategoriesMember)) {
            
            topicCategoriesAll.addAll(0, topicCategoriesMember);
        }
        return topicCategoriesAll.stream().map(topicCategory -> {
            TopicCategoryVo topicCategoryVo = new TopicCategoryVo();
            BeanUtils.copyProperties(topicCategory, topicCategoryVo);
            return topicCategoryVo;
        }).toList();
    }
}
