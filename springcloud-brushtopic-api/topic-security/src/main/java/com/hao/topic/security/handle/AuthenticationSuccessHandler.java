package com.hao.topic.security.handle;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.utils.JWTUtils;
import com.hao.topic.security.constant.JwtConstant;
import com.hao.topic.security.properties.AuthProperties;
import com.hao.topic.security.service.SecurityUserDetails;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.server.WebFilterExchange;
import org.springframework.security.web.server.authentication.WebFilterChainServerAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.time.Duration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

@Component
@Slf4j
public class AuthenticationSuccessHandler extends WebFilterChainServerAuthenticationSuccessHandler {

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private AuthProperties ignoreWhiteProperties;

    

    @SneakyThrows
    @Override
    public Mono<Void> onAuthenticationSuccess(WebFilterExchange webFilterExchange, Authentication authentication) {
        
        ServerWebExchange exchange = webFilterExchange.getExchange();
        
        ServerHttpResponse response = exchange.getResponse();
        
        Object remember_obj = exchange.getAttribute("remember");
        boolean remember_me = remember_obj != null && (remember_obj instanceof Boolean ? (Boolean) remember_obj : Boolean.parseBoolean(remember_obj.toString()));

        
        HttpHeaders httpHeaders = response.getHeaders();
        httpHeaders.add("Content-Type", "application/json; charset=UTF-8");
        httpHeaders.add("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");

        
        HashMap<String, String> map = new HashMap<>();

        ObjectMapper mapper = new ObjectMapper();
        
        List<? extends GrantedAuthority> list = authentication.getAuthorities().stream().toList();
        try {
            
            SecurityUserDetails userDetails = (SecurityUserDetails) authentication.getPrincipal();
            
            Map<String, String> load = new HashMap<>();
            load.put("username", authentication.getName());
            load.put("id", String.valueOf(userDetails.getUserId()));
            load.put("role", list.get(0).getAuthority()); 

            String token;
            log.info(authentication.toString());

            
            if (!remember_me) {
                
                token = JWTUtils.creatToken(load, JwtConstant.EXPIRE_TIME * ignoreWhiteProperties.getTimeout());
                response.addCookie(ResponseCookie.from("token", token).path("/").build());
                
                redisTemplate.opsForValue().set(authentication.getName(), token, ignoreWhiteProperties.getTimeout(), TimeUnit.DAYS);
            } else {
                
                token = JWTUtils.creatToken(load, JwtConstant.EXPIRE_TIME * ignoreWhiteProperties.getRememberMe());
                
                response.addCookie(ResponseCookie.from("token", token).maxAge(Duration.ofDays(ignoreWhiteProperties.getRememberMe())).path("/").build());
                
                redisTemplate.opsForValue().set(authentication.getName(), token, ignoreWhiteProperties.getRememberMe(), TimeUnit.DAYS);
            }

            
            map.put("code", String.valueOf(ResultCodeEnum.SUCCESS.getCode()));
            map.put("message", ResultCodeEnum.SUCCESS.getMessage());
            map.put("token", token);
        } catch (
                Exception ex) {
            ex.printStackTrace();
            
            map.put("code", String.valueOf(ResultCodeEnum.FAIL.getCode()));
            map.put("message", ResultCodeEnum.FAIL.getMessage());
        }

        
        DataBuffer bodyDataBuffer = response.bufferFactory().wrap(mapper.writeValueAsBytes(map));
        
        return response.writeWith(Mono.just(bodyDataBuffer));
    }
}
