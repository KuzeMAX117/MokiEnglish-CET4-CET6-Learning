package com.hao.topic.common.auth;

import feign.RequestInterceptor;
import feign.RequestTemplate;
import org.springframework.stereotype.Component;

@Component
public class TokenInterceptor implements RequestInterceptor {

    

    private static final ThreadLocal<String> tokenThreadLocal = new ThreadLocal<>();

    

    public static void setToken(String token) {
        tokenThreadLocal.set(token);
    }

    

    public static void clearToken() {
        tokenThreadLocal.remove();
    }

    

    @Override
    public void apply(RequestTemplate requestTemplate) {
        
        String token = tokenThreadLocal.get();
        System.out.println("token:" + token);
        if (token != null) {
            
            requestTemplate.header("Authorization", token);
        }
    }
}
