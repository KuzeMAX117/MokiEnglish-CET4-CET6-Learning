package com.hao.topic.system.content.service;

import com.hao.topic.model.dto.content.ArticleDto;
import com.hao.topic.model.dto.content.ArticleListDto;

import java.util.Map;

public interface ArticleService {
    Map<String, Object> articleList(ArticleListDto dto);
    void add(ArticleDto dto);
    void update(ArticleDto dto);
    void delete(Long[] ids);
}
