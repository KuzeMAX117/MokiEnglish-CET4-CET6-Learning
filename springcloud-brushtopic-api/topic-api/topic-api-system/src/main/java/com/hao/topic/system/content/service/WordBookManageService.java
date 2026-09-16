package com.hao.topic.system.content.service;

import com.hao.topic.model.dto.content.WordBookDto;
import com.hao.topic.model.dto.content.WordBookListDto;

import java.util.Map;

public interface WordBookManageService {
    Map<String, Object> wordBookList(WordBookListDto dto);
    void add(WordBookDto dto);
    void update(WordBookDto dto);
    void delete(Long[] ids);
}
