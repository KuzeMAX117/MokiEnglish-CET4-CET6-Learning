package com.hao.topic.security.handle;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hao.topic.common.enums.ResultCodeEnum;
import lombok.SneakyThrows;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.server.WebFilterExchange;
import org.springframework.security.web.server.authentication.logout.ServerLogoutSuccessHandler;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import java.util.HashMap;

@Component
public class LogoutSuccessHandler implements ServerLogoutSuccessHandler {

    

    @SneakyThrows
    @Override
    public Mono<Void> onLogoutSuccess(WebFilterExchange webFilterExchange, Authentication authentication) {
        
        ServerHttpResponse response = webFilterExchange.getExchange().getResponse();

        
        HttpHeaders httpHeaders = response.getHeaders();
        httpHeaders.add("Content-Type", "application/json; charset=UTF-8");
        httpHeaders.add("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");

        
        HashMap<String, Object> map = new HashMap<>();
        
        response.addCookie(ResponseCookie.from("token", "logout").maxAge(0).path("/").build());
        map.put("code", ResultCodeEnum.LOGOUT_SUCCESS.getCode());
        map.put("message", ResultCodeEnum.LOGOUT_SUCCESS.getMessage());

        
        ObjectMapper mapper = new ObjectMapper();
        DataBuffer bodyDataBuffer = response.bufferFactory().wrap(mapper.writeValueAsBytes(map));

        
        return response.writeWith(Mono.just(bodyDataBuffer));
    }
}
