package com.hao.topic.ai.service;

import com.hao.topic.model.dto.ai.AiUserDto;
import com.hao.topic.model.entity.ai.AiUser;

import java.util.Map;

public interface ManageService {
    Map<String, Object> list(AiUserDto aiUserDto);

    void update(AiUser aiUser);
}
