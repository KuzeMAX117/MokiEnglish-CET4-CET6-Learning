package com.hao.topic.common.security.filter;

import com.hao.topic.common.constant.RedisConstant;
import com.hao.topic.common.utils.JWTUtils;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

@Slf4j
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    

    @Autowired
    private RedisTemplate redisTemplate;

    

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        
        String token = request.getHeader("Authorization");
        log.info("获取到的令牌: {}", token);
        
        if (token != null) {
            try {
                
                Map<String, Object> userMap = JWTUtils.getTokenInfo(token);
                String username = (String) userMap.get("username");

                
                String result = (String) redisTemplate.opsForValue().get(username);
                if (result == null || !result.equals(token)) {
                    log.info("令牌无效或未找到");
                } else {
                    
                    Collection<SimpleGrantedAuthority> authorities = new ArrayList<>();
                    String role = (String) userMap.get("role");
                    log.info("用户角色: {}", role);

                    
                    authorities.add(new SimpleGrantedAuthority(role));
                    
                    UsernamePasswordAuthenticationToken authentication =
                            new UsernamePasswordAuthenticationToken(username, null, authorities);
                    SecurityContextHolder.getContext().setAuthentication(authentication);
                }
            } catch (Exception e) {
                
                log.error("加载安全上下文时发生异常: {}", e.getMessage());
                SecurityContextHolder.clearContext();  
            }
        } else {
            log.info("未找到令牌");
        }
        
        filterChain.doFilter(request, response);
    }
}
