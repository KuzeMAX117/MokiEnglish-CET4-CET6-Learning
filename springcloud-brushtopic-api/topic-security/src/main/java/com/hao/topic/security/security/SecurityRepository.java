package com.hao.topic.security.security;

import com.hao.topic.common.utils.JWTUtils;
import com.hao.topic.security.properties.AuthProperties;
import com.hao.topic.security.service.SecurityUserDetails;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpHeaders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.ReactiveSecurityContextHolder;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.security.web.server.context.ServerSecurityContextRepository;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.server.WebFilter;
import org.springframework.web.server.WebFilterChain;
import reactor.core.publisher.Mono;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Map;

@Slf4j
@Component
public class SecurityRepository implements ServerSecurityContextRepository {

    

    @Override
    public Mono<Void> save(ServerWebExchange exchange, SecurityContext context) {
        return Mono.empty();
    }

    

    @Override
    public Mono<SecurityContext> load(ServerWebExchange exchange) {
        String token = exchange.getRequest().getHeaders().getFirst(HttpHeaders.AUTHORIZATION);
        log.info("获取到的令牌: {}", token);
        
        if (token == null || !JWTUtils.verifyToken(token)) {
            token = null;
        }
        if (token != null) {
            Map<String, Object> tokenInfo = JWTUtils.getTokenInfo(token);
            String username = (String) tokenInfo.get("username");
            String role = (String) tokenInfo.get("role");

            Collection<GrantedAuthority> authorities = new ArrayList<>();
            
            authorities.add(new SimpleGrantedAuthority(role));
            Authentication authentication = new UsernamePasswordAuthenticationToken(
                    username, null, authorities
            );

            SecurityContext context = SecurityContextHolder.createEmptyContext();
            context.setAuthentication(authentication);
            log.info("创建的SecurityContext: {}", context);

            return Mono.just(context);
        }
        return Mono.empty();
    }

}
