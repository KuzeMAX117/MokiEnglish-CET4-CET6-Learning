package com.hao.topic.admin.gateway.filter;

import com.hao.topic.admin.gateway.properties.IgnoreWhiteProperties;
import com.hao.topic.common.utils.JWTUtils;
import com.hao.topic.common.utils.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpHeaders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.Arrays;
import java.util.Map;

@Component
@Slf4j
public class AuthorizeFilter implements Ordered, GlobalFilter {
    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private IgnoreWhiteProperties ignoreWhiteProperties;

    

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        
        ServerHttpRequest request = exchange.getRequest();
        ServerHttpResponse response = exchange.getResponse();

        String url = request.getURI().getPath();
        
        if (StringUtils.matches(url, ignoreWhiteProperties.getWhites())) {
            return chain.filter(exchange);
        }

        
        String token = request.getHeaders().getFirst(HttpHeaders.AUTHORIZATION);

        
        if (com.alibaba.nacos.common.utils.StringUtils.isBlank(token)) {
            response.setStatusCode(HttpStatus.UNAUTHORIZED);
            return response.setComplete();
        }

        try {
            
            Map<String, Object> userInfo = JWTUtils.getTokenInfo(token);
            String username = (String) userInfo.get("username");

            
            String cachedToken = (String) redisTemplate.opsForValue().get(username);
            if (!token.equals(cachedToken)) {
                log.warn("Token验证失败: {}", username);
                response.setStatusCode(HttpStatus.UNAUTHORIZED);
                return response.setComplete();
            }

            
            ServerHttpRequest newRequest = request.mutate()
                    .header("userId", String.valueOf(userInfo.get("userId")))
                    .header("username", username)
                    .header("role", String.valueOf(userInfo.get("role")))
                    .build();

            return chain.filter(exchange.mutate().request(newRequest).build());

        } catch (Exception e) {
            log.error("Token解析失败: {}", e.getMessage());
            response.setStatusCode(HttpStatus.UNAUTHORIZED);
            return response.setComplete();
        }
    }

    

    @Override
    public int getOrder() {
        return -1;
    }
}
