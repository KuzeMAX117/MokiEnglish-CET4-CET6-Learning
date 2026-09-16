package com.hao.topic.system.content.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.content.EssayDto;
import com.hao.topic.model.dto.content.EssayListDto;
import com.hao.topic.model.entity.content.Essay;
import com.hao.topic.system.content.mapper.EssayMapper;
import com.hao.topic.system.content.service.EssayService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
@Slf4j
public class EssayServiceImpl implements EssayService {

    private final EssayMapper essayMapper;

    @Override
    public Map<String, Object> essayList(EssayListDto dto) {
        LambdaQueryWrapper<Essay> wrapper = new LambdaQueryWrapper<>();

        if (!StringUtils.isEmpty(dto.getTitle())) {
            wrapper.like(Essay::getTitle, dto.getTitle());
        }
        if (!StringUtils.isEmpty(dto.getCategory())) {
            wrapper.eq(Essay::getCategory, dto.getCategory());
        }
        if (dto.getDifficulty() != null) {
            wrapper.eq(Essay::getDifficulty, dto.getDifficulty());
        }
        if (!StringUtils.isEmpty(dto.getCreateBy())) {
            wrapper.like(Essay::getCreateBy, dto.getCreateBy());
        }
        if (dto.getStatus() != null) {
            wrapper.eq(Essay::getStatus, dto.getStatus());
        }
        if (!StringUtils.isEmpty(dto.getBeginCreateTime()) && !StringUtils.isEmpty(dto.getEndCreateTime())) {
            wrapper.between(Essay::getCreateTime, dto.getBeginCreateTime(), dto.getEndCreateTime());
        }
        wrapper.orderByDesc(Essay::getCreateTime);

        if (dto.getPageNum() == null || dto.getPageSize() == null) {
            List<Essay> list = essayMapper.selectList(wrapper);
            return Map.of("total", list.size(), "rows", list);
        } else {
            Page<Essay> page = new Page<>(dto.getPageNum(), dto.getPageSize());
            Page<Essay> result = essayMapper.selectPage(page, wrapper);
            return Map.of("total", result.getTotal(), "rows", result.getRecords());
        }
    }

    @Override
    public void add(EssayDto dto) {
        if (StringUtils.isEmpty(dto.getTitle())) {
            throw new TopicException("作文题目不能为空");
        }
        String username = SecurityUtils.getCurrentName();
        Essay essay = new Essay();
        BeanUtils.copyProperties(dto, essay);
        essay.setCreateBy(username);
        essay.setViewCount(0L);
        essay.setStatus(0);
        essayMapper.insert(essay);
    }

    @Override
    public void update(EssayDto dto) {
        if (dto.getId() == null) {
            throw new TopicException("作文ID不能为空");
        }
        Essay essay = essayMapper.selectById(dto.getId());
        if (essay == null) {
            throw new TopicException("作文不存在");
        }
        BeanUtils.copyProperties(dto, essay);
        essayMapper.updateById(essay);
    }

    @Override
    public void delete(Long[] ids) {
        if (ids == null || ids.length == 0) {
            throw new TopicException("请选择要删除的作文");
        }
        for (Long id : ids) {
            essayMapper.deleteById(id);
        }
    }
}
