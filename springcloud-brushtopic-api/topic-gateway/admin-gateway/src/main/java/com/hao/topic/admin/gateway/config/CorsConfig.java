package com.hao.topic.admin.gateway.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.web.server.SecurityWebFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.reactive.CorsWebFilter;
import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;
import org.springframework.web.util.pattern.PathPatternParser;

@Configuration
public class CorsConfig {

    

    @Bean
    public SecurityWebFilterChain springSecurityFilterChain(ServerHttpSecurity http) {
        http.csrf(ServerHttpSecurity.CsrfSpec::disable);
        return http.build();
    }

    

    @Bean
    public CorsWebFilter corsFilter() {
        
        CorsConfiguration config = new CorsConfiguration();
        
        config.addAllowedMethod("*");
        
        config.addAllowedOrigin("*");
        
        config.addAllowedHeader("*");

        
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource(new PathPatternParser());
        
        source.registerCorsConfiguration("/**", config);

        
        return new CorsWebFilter(source);
    }
}
