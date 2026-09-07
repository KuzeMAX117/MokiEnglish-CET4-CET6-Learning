package com.hao.topic.system.service;

import com.hao.topic.model.entity.system.WebConfig;
import com.hao.topic.model.vo.system.UserInfoVo;
import jakarta.servlet.http.HttpServletResponse;

public interface SystemService {
    void getCode(HttpServletResponse response);

    WebConfig getConfig(Integer status);
}
