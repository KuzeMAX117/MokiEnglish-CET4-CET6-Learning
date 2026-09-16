package com.hao.topic.system.content.service;

import com.hao.topic.model.dto.content.EssayDto;
import com.hao.topic.model.dto.content.EssayListDto;

import java.util.Map;

public interface EssayService {
    Map<String, Object> essayList(EssayListDto dto);
    void add(EssayDto dto);
    void update(EssayDto dto);
    void delete(Long[] ids);
}
