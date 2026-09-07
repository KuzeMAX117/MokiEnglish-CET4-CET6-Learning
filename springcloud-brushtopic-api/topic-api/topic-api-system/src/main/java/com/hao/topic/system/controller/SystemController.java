package com.hao.topic.system.controller;

import com.hao.topic.common.result.Result;
import com.hao.topic.model.entity.system.WebConfig;
import com.hao.topic.model.vo.system.UserInfoVo;
import com.hao.topic.system.service.SystemService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("system")
public class SystemController {

    @Autowired
    private SystemService service;

    

    @GetMapping("/captchaImage")
    public void getCode(HttpServletResponse response) {
        service.getCode(response);
    }

    

    @GetMapping("/config/{status}")
    public Result<WebConfig> getConfig(@PathVariable Integer status) {
        WebConfig config = service.getConfig(status);
        return Result.success(config);
    }
}
