package com.hao.topic.system.content.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.content.TranslationDto;
import com.hao.topic.model.dto.content.TranslationListDto;
import com.hao.topic.model.entity.content.Translation;
import com.hao.topic.system.content.mapper.TranslationMapper;
import com.hao.topic.system.content.service.TranslationService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
@Slf4j
public class TranslationServiceImpl implements TranslationService {

    private final TranslationMapper translationMapper;

    @Override
    public Map<String, Object> translationList(TranslationListDto dto) {
        LambdaQueryWrapper<Translation> wrapper = new LambdaQueryWrapper<>();

        if (!StringUtils.isEmpty(dto.getTitle())) {
            wrapper.like(Translation::getTitle, dto.getTitle());
        }
        if (!StringUtils.isEmpty(dto.getCategory())) {
            wrapper.eq(Translation::getCategory, dto.getCategory());
        }
        if (dto.getDifficulty() != null) {
            wrapper.eq(Translation::getDifficulty, dto.getDifficulty());
        }
        if (!StringUtils.isEmpty(dto.getSourceLang())) {
            wrapper.eq(Translation::getSourceLang, dto.getSourceLang());
        }
        if (!StringUtils.isEmpty(dto.getTargetLang())) {
            wrapper.eq(Translation::getTargetLang, dto.getTargetLang());
        }
        if (!StringUtils.isEmpty(dto.getCreateBy())) {
            wrapper.like(Translation::getCreateBy, dto.getCreateBy());
        }
        if (dto.getStatus() != null) {
            wrapper.eq(Translation::getStatus, dto.getStatus());
        }
        if (!StringUtils.isEmpty(dto.getBeginCreateTime()) && !StringUtils.isEmpty(dto.getEndCreateTime())) {
            wrapper.between(Translation::getCreateTime, dto.getBeginCreateTime(), dto.getEndCreateTime());
        }
        wrapper.orderByDesc(Translation::getCreateTime);

        if (dto.getPageNum() == null || dto.getPageSize() == null) {
            List<Translation> list = translationMapper.selectList(wrapper);
            return Map.of("total", list.size(), "rows", list);
        } else {
            Page<Translation> page = new Page<>(dto.getPageNum(), dto.getPageSize());
            Page<Translation> result = translationMapper.selectPage(page, wrapper);
            return Map.of("total", result.getTotal(), "rows", result.getRecords());
        }
    }

    @Override
    public void add(TranslationDto dto) {
        if (StringUtils.isEmpty(dto.getTitle())) {
            throw new TopicException("翻译题目标题不能为空");
        }
        if (StringUtils.isEmpty(dto.getSourceText())) {
            throw new TopicException("原文不能为空");
        }
        String username = SecurityUtils.getCurrentName();
        Translation translation = new Translation();
        BeanUtils.copyProperties(dto, translation);
        translation.setCreateBy(username);
        translation.setViewCount(0L);
        translation.setStatus(0);
        translationMapper.insert(translation);
    }

    @Override
    public void update(TranslationDto dto) {
        if (dto.getId() == null) {
            throw new TopicException("翻译ID不能为空");
        }
        Translation translation = translationMapper.selectById(dto.getId());
        if (translation == null) {
            throw new TopicException("翻译不存在");
        }
        BeanUtils.copyProperties(dto, translation);
        translationMapper.updateById(translation);
    }

    @Override
    public void delete(Long[] ids) {
        if (ids == null || ids.length == 0) {
            throw new TopicException("请选择要删除的翻译");
        }
        for (Long id : ids) {
            translationMapper.deleteById(id);
        }
    }
}
