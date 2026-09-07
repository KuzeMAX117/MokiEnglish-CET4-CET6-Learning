package com.hao.topic.system.service.impl;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import cn.hutool.captcha.generator.RandomGenerator;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.hao.topic.common.utils.JWTUtils;
import com.hao.topic.model.entity.system.WebConfig;
import com.hao.topic.model.vo.system.UserInfoVo;
import com.hao.topic.system.constant.SystemConstant;
import com.hao.topic.system.mapper.WebConfigMapper;
import com.hao.topic.system.service.SystemService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Service
public class SystemServiceImpl implements SystemService {
    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private WebConfigMapper webConfigMapper;

    public void getCode(HttpServletResponse response) {
        
        RandomGenerator randomGenerator = new RandomGenerator("0123456789", 4);
        LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(SystemConstant.IMAGE_WIDTH, SystemConstant.IMAGE_HEIGHT);
        lineCaptcha.setGenerator(randomGenerator);
        
        lineCaptcha.createCode();
        
        response.setContentType("image/jpeg");
        
        response.setHeader("Pragma", "No-cache");
        try {
            
            lineCaptcha.write(response.getOutputStream());
            
            response.getOutputStream().close();
            
            stringRedisTemplate.opsForValue().set(lineCaptcha.getCode(), lineCaptcha.getCode(), SystemConstant.CODE_EXPIRE_TIME, TimeUnit.SECONDS);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    

    public WebConfig getConfig(Integer status) {
        LambdaQueryWrapper<WebConfig> webConfigLambdaQueryWrapper = new LambdaQueryWrapper<>();
        webConfigLambdaQueryWrapper.eq(WebConfig::getStatus, status);
        return webConfigMapper.selectOne(webConfigLambdaQueryWrapper);
    }

}
