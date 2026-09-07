package com.hao.topic.security.handle;

import com.auth0.jwt.exceptions.JWTDecodeException;
import com.hao.topic.common.utils.JWTUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpCookie;
import org.springframework.http.ResponseCookie;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.server.WebFilterExchange;
import org.springframework.security.web.server.authentication.logout.ServerLogoutHandler;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import java.util.Map;

@Component
@Slf4j
public class LogoutHandler implements ServerLogoutHandler {

    @Autowired
    private RedisTemplate redisTemplate;

    

    @Override
    public Mono<Void> logout(WebFilterExchange webFilterExchange, Authentication authentication) {
        
        ServerHttpResponse response = webFilterExchange.getExchange().getResponse();

        
        HttpCookie cookie = webFilterExchange.getExchange().getRequest().getCookies().getFirst("token");
        try {
            if (cookie != null) {
                
                Map<String, Object> userMap = JWTUtils.getTokenInfo(cookie.getValue());
                
                redisTemplate.delete((String) userMap.get("username"));

                
                ResponseCookie deletedCookie = ResponseCookie.from("token", "")
                        .path("/") 
                        .httpOnly(true) 
                        .secure(true) 
                        .maxAge(0) 
                        .build();
                response.addCookie(deletedCookie);
            }
        } catch (JWTDecodeException e) {
            
            log.error("JWT令牌解析失败: {}", e.getMessage());
            return Mono.error(e);
        }

        
        return Mono.empty();
    }
}
