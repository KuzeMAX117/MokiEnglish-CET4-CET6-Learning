package com.hao.topic.system.content.service;

import com.hao.topic.model.dto.content.TranslationDto;
import com.hao.topic.model.dto.content.TranslationListDto;

import java.util.Map;

public interface TranslationService {
    Map<String, Object> translationList(TranslationListDto dto);
    void add(TranslationDto dto);
    void update(TranslationDto dto);
    void delete(Long[] ids);
}
