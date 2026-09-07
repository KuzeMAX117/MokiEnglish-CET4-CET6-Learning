package com.hao.topic.security.config;

import com.hao.topic.security.filter.CookieToHeadersFilter;
import com.hao.topic.security.handle.*;
import com.hao.topic.security.security.AuthenticationEntryPoint;
import com.hao.topic.security.security.SecurityRepository;
import com.hao.topic.security.service.SecurityUserDetailsService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.DelegatingReactiveAuthenticationManager;
import org.springframework.security.authentication.ReactiveAuthenticationManager;
import org.springframework.security.authentication.UserDetailsRepositoryReactiveAuthenticationManager;
import org.springframework.security.authorization.AuthorizationManager;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.reactive.EnableWebFluxSecurity;
import org.springframework.security.config.web.server.SecurityWebFiltersOrder;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.web.server.SecurityWebFilterChain;
import reactor.core.publisher.Mono;

import java.util.LinkedList;

@Configuration
@Slf4j
@EnableWebFluxSecurity
@EnableMethodSecurity
public class WebSecurityConfig {
    
    @Autowired
    SecurityUserDetailsService securityUserDetailsService;
    
    @Autowired
    AccessDeniedHandler accessDeniedHandler;
    
    @Autowired
    AuthenticationSuccessHandler authenticationSuccessHandler;
    
    @Autowired
    AuthenticationFailHandler authenticationFailHandler;
    
    @Autowired
    SecurityRepository securityRepository;
    
    @Autowired
    CookieToHeadersFilter cookieToHeadersFilter;
    
    @Autowired
    LogoutSuccessHandler logoutSuccessHandler;
    
    @Autowired
    LogoutHandler logoutHandler;
    
    @Autowired
    AuthenticationEntryPoint authenticationEntryPoint;
    @Resource
    private SecurityConfig securityConfig;

    @Bean
    public SecurityWebFilterChain springSecurityFilterChain(ServerHttpSecurity http) {
        http.csrf(ServerHttpSecurity.CsrfSpec::disable)
                .securityContextRepository(securityRepository)
                .authenticationManager(reactiveAuthenticationManager())  
                .addFilterBefore(cookieToHeadersFilter, SecurityWebFiltersOrder.HTTP_HEADERS_WRITER)
                .authorizeExchange(exchanges -> exchanges
                        .pathMatchers("/security/user/login").permitAll()  
                        .pathMatchers("/system/captcha").permitAll()       
                        .pathMatchers("/security/user/logout").permitAll()       
                        .pathMatchers("/security/user/count").permitAll()       
                        .pathMatchers("/security/user/**").permitAll()       
                        .pathMatchers("/ai/model/**").permitAll()          
                        .pathMatchers("/ai/model/count").permitAll()          
                        .pathMatchers("/ai/model/countDate").permitAll()          
                        .anyExchange().authenticated()                     
                )

                .exceptionHandling(exceptionHandlingSpec -> exceptionHandlingSpec
                        .authenticationEntryPoint(authenticationEntryPoint)
                        .accessDeniedHandler(accessDeniedHandler)
                )
                .logout(logoutSpec -> logoutSpec
                        .logoutUrl("/security/user/logout")
                        .logoutHandler(logoutHandler)
                        .logoutSuccessHandler(logoutSuccessHandler)
                );

        return http.build();
    }

    @Bean
    public ReactiveAuthenticationManager reactiveAuthenticationManager() {
        LinkedList<ReactiveAuthenticationManager> managers = new LinkedList<>();
        UserDetailsRepositoryReactiveAuthenticationManager userDetailsManager =
                new UserDetailsRepositoryReactiveAuthenticationManager(securityUserDetailsService);
        userDetailsManager.setPasswordEncoder(securityConfig.passwordEncoder());
        managers.add(userDetailsManager);

        
        managers.add(authentication -> {
            if (authentication.isAuthenticated()) {
                return Mono.just(authentication);
            }
            return Mono.empty();
        });

        return new DelegatingReactiveAuthenticationManager(managers);
    }
}
 
 
 
 