package com.hao.topic.common.security.handler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.result.Result;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Slf4j
@Component
public class AccessDeniedHandlerImpl implements AccessDeniedHandler, AuthenticationEntryPoint {

    

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException e)
            throws IOException, ServletException {
        
        log.error("认证失败：{}", e.getMessage());

        
        response.setContentType("application/json;charset=UTF-8");

        
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

        
        ObjectMapper mapper = new ObjectMapper();

        
        mapper.writeValue(response.getOutputStream(),
                Result.fail(ResultCodeEnum.LOGIN_ERROR));
    }

    

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException e)
            throws IOException, ServletException {
        
        log.error("授权失败：{}", e.getMessage());

        
        response.setContentType("application/json;charset=UTF-8");

        
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);

        
        ObjectMapper mapper = new ObjectMapper();

        
        mapper.writeValue(response.getOutputStream(),
                Result.fail(ResultCodeEnum.LOGIN_ERROR_SECURITY));
    }
}
