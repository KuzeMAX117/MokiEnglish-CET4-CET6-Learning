package com.hao.topic.system.content.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.content.ArticleDto;
import com.hao.topic.model.dto.content.ArticleListDto;
import com.hao.topic.model.entity.content.Article;
import com.hao.topic.system.content.mapper.ArticleMapper;
import com.hao.topic.system.content.service.ArticleService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
@Slf4j
public class ArticleServiceImpl implements ArticleService {

    private final ArticleMapper articleMapper;

    @Override
    public Map<String, Object> articleList(ArticleListDto dto) {
        LambdaQueryWrapper<Article> wrapper = new LambdaQueryWrapper<>();

        if (!StringUtils.isEmpty(dto.getTitle())) {
            wrapper.like(Article::getTitle, dto.getTitle());
        }
        if (!StringUtils.isEmpty(dto.getCategory())) {
            wrapper.eq(Article::getCategory, dto.getCategory());
        }
        if (!StringUtils.isEmpty(dto.getCreateBy())) {
            wrapper.like(Article::getCreateBy, dto.getCreateBy());
        }
        if (dto.getStatus() != null) {
            wrapper.eq(Article::getStatus, dto.getStatus());
        }
        if (!StringUtils.isEmpty(dto.getBeginCreateTime()) && !StringUtils.isEmpty(dto.getEndCreateTime())) {
            wrapper.between(Article::getCreateTime, dto.getBeginCreateTime(), dto.getEndCreateTime());
        }
        wrapper.orderByDesc(Article::getCreateTime);

        if (dto.getPageNum() == null || dto.getPageSize() == null) {
            List<Article> list = articleMapper.selectList(wrapper);
            return Map.of("total", list.size(), "rows", list);
        } else {
            Page<Article> page = new Page<>(dto.getPageNum(), dto.getPageSize());
            Page<Article> result = articleMapper.selectPage(page, wrapper);
            return Map.of("total", result.getTotal(), "rows", result.getRecords());
        }
    }

    @Override
    public void add(ArticleDto dto) {
        if (StringUtils.isEmpty(dto.getTitle())) {
            throw new TopicException("文章标题不能为空");
        }
        String username = SecurityUtils.getCurrentName();
        Article article = new Article();
        BeanUtils.copyProperties(dto, article);
        article.setCreateBy(username);
        article.setViewCount(0L);
        article.setStatus(0);
        articleMapper.insert(article);
    }

    @Override
    public void update(ArticleDto dto) {
        if (dto.getId() == null) {
            throw new TopicException("文章ID不能为空");
        }
        Article article = articleMapper.selectById(dto.getId());
        if (article == null) {
            throw new TopicException("文章不存在");
        }
        BeanUtils.copyProperties(dto, article);
        articleMapper.updateById(article);
    }

    @Override
    public void delete(Long[] ids) {
        if (ids == null || ids.length == 0) {
            throw new TopicException("请选择要删除的文章");
        }
        for (Long id : ids) {
            articleMapper.deleteById(id);
        }
    }
}
