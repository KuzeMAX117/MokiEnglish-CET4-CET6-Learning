package com.hao.topic.security.filter;

import com.hao.topic.common.utils.JWTUtils;
import com.hao.topic.security.exception.NoFoundToken;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpCookie;
import org.springframework.http.HttpHeaders;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.server.WebFilter;
import org.springframework.web.server.WebFilterChain;
import reactor.core.publisher.Mono;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

@Slf4j
@Component
public class CookieToHeadersFilter implements WebFilter {

    

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, WebFilterChain chain) {
        try {
            HttpCookie cookie = exchange.getRequest().getCookies().getFirst("token");
            if (cookie != null) {
                String token = cookie.getValue();
                if (token == null) {
                    log.error("Cookie的值为空");
                    throw new NoFoundToken("Cookie的值为空");
                }

                
                exchange = exchange.mutate()
                        .request(exchange.getRequest().mutate()
                                .header(HttpHeaders.AUTHORIZATION, token)
                                .build())
                        .build();
            }
        } catch (NoFoundToken e) {
            log.error(e.getMsg());
        }
        return chain.filter(exchange);
    }

}
