package com.hao.topic.common.security.config;

import com.hao.topic.common.security.filter.JwtAuthenticationFilter;
import com.hao.topic.common.security.handler.AccessDeniedHandlerImpl;
import com.hao.topic.security.handle.AuthenticationFailHandler;
import com.hao.topic.security.security.AuthenticationEntryPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

    

    @Autowired
    private AccessDeniedHandlerImpl authenticationFailHandler;

    

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/system/captchaImage").permitAll()
                        .requestMatchers("/system/role/**").permitAll()  
                        .requestMatchers("/system/user/**").permitAll()  
                        .requestMatchers("/ai/model/**").permitAll()          
                        .requestMatchers("/ai/article/**").permitAll()
                        .requestMatchers("/topic/category/audit").permitAll()          
                        .requestMatchers("/topic/subject/audit").permitAll()          
                        .requestMatchers("/topic/label/audit").permitAll()          
                        .requestMatchers("/topic/topic/audit").permitAll()          
                        .requestMatchers("/topic/topic/answer").permitAll()          
                        .requestMatchers("/topic/ai/**").permitAll()          
                        .requestMatchers(HttpMethod.GET).authenticated()  
                        .requestMatchers(HttpMethod.POST).authenticated() 
                        .requestMatchers(HttpMethod.PUT).authenticated()  
                        .requestMatchers(HttpMethod.DELETE).authenticated() 
                        .anyRequest().authenticated()
                )
                
                .addFilterBefore(jwtAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class)
                .csrf(AbstractHttpConfigurer::disable)
                .cors(AbstractHttpConfigurer::disable)
                
                .exceptionHandling(ex -> ex
                        
                        .authenticationEntryPoint(authenticationFailHandler)
                );
        
        return http.build();
    }

    

    @Bean
    public JwtAuthenticationFilter jwtAuthenticationFilter() {
        return new JwtAuthenticationFilter();
    }
}
