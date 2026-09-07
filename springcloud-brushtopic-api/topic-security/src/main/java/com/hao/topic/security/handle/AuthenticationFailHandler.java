package com.hao.topic.security.handle;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hao.topic.common.constant.ExceptionConstant;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.server.WebFilterExchange;
import org.springframework.security.web.server.authentication.ServerAuthenticationFailureHandler;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import java.util.HashMap;

@Slf4j
@Component
public class AuthenticationFailHandler implements ServerAuthenticationFailureHandler {

    

    @SneakyThrows
    @Override
    public Mono<Void> onAuthenticationFailure(WebFilterExchange webFilterExchange, AuthenticationException e) {
        
        ServerHttpResponse response = webFilterExchange.getExchange().getResponse();
        
        response.setStatusCode(HttpStatus.FORBIDDEN);
        
        response.getHeaders().add("Content-Type", "application/json; charset=UTF-8");

        
        HashMap<String, String> map = new HashMap<>();
        map.put("code", String.valueOf(ExceptionConstant.AUTH_ERROR_CODE));
        map.put("message", e.getMessage());

        
        log.error("认证失败路径={}", webFilterExchange.getExchange().getRequest().getPath());

        
        ObjectMapper objectMapper = new ObjectMapper();
        DataBuffer dataBuffer = response.bufferFactory().wrap(objectMapper.writeValueAsBytes(map));

        
        return response.writeWith(Mono.just(dataBuffer));
    }
}
