package com.hao.topic.system.content.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.content.WordBookDto;
import com.hao.topic.model.dto.content.WordBookListDto;
import com.hao.topic.model.entity.word.WordBook;
import com.hao.topic.system.word.mapper.WordBookMapper;
import com.hao.topic.system.content.service.WordBookManageService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
@Slf4j
public class WordBookManageServiceImpl implements WordBookManageService {

    private final WordBookMapper wordBookMapper;

    @Override
    public Map<String, Object> wordBookList(WordBookListDto dto) {
        LambdaQueryWrapper<WordBook> wrapper = new LambdaQueryWrapper<>();

        if (!StringUtils.isEmpty(dto.getName())) {
            wrapper.like(WordBook::getName, dto.getName());
        }
        if (dto.getType() != null) {
            wrapper.eq(WordBook::getType, dto.getType());
        }
        wrapper.orderByDesc(WordBook::getCreateTime);

        if (dto.getPageNum() == null || dto.getPageSize() == null) {
            List<WordBook> list = wordBookMapper.selectList(wrapper);
            return Map.of("total", list.size(), "rows", list);
        } else {
            Page<WordBook> page = new Page<>(dto.getPageNum(), dto.getPageSize());
            Page<WordBook> result = wordBookMapper.selectPage(page, wrapper);
            return Map.of("total", result.getTotal(), "rows", result.getRecords());
        }
    }

    @Override
    public void add(WordBookDto dto) {
        if (StringUtils.isEmpty(dto.getName())) {
            throw new TopicException("词书名称不能为空");
        }
        LambdaQueryWrapper<WordBook> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WordBook::getName, dto.getName());
        WordBook exist = wordBookMapper.selectOne(wrapper);
        if (exist != null) {
            throw new TopicException("词书名称已存在");
        }
        WordBook wordBook = new WordBook();
        BeanUtils.copyProperties(dto, wordBook);
        wordBook.setTotalCount(0);
        wordBookMapper.insert(wordBook);
    }

    @Override
    public void update(WordBookDto dto) {
        if (dto.getId() == null) {
            throw new TopicException("词书ID不能为空");
        }
        WordBook wordBook = wordBookMapper.selectById(dto.getId());
        if (wordBook == null) {
            throw new TopicException("词书不存在");
        }
        BeanUtils.copyProperties(dto, wordBook);
        wordBookMapper.updateById(wordBook);
    }

    @Override
    public void delete(Long[] ids) {
        if (ids == null || ids.length == 0) {
            throw new TopicException("请选择要删除的词书");
        }
        for (Long id : ids) {
            wordBookMapper.deleteById(id);
        }
    }
}
