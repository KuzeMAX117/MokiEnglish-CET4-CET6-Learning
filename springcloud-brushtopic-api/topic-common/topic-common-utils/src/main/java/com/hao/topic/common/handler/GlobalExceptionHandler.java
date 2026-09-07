package com.hao.topic.common.handler;

import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.result.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@Slf4j
@RestControllerAdvice
@Order(-1)
public class GlobalExceptionHandler {

    

    @ExceptionHandler(UsernameNotFoundException.class)
    @ResponseStatus(HttpStatus.OK)
    public Mono<Result<String>> handleUsernameNotFoundException(UsernameNotFoundException e, ServerWebExchange exchange) {
        return Mono.just(Result.fail(e.getMessage()));
    }

    

    @ExceptionHandler(BadCredentialsException.class)
    @ResponseStatus(HttpStatus.OK)
    public Mono<Result<String>> handleBadCredentialsException(BadCredentialsException e, ServerWebExchange exchange) {
        log.error("用户名或密码错误: {}", e.getMessage());
        return Mono.just(Result.fail(ResultCodeEnum.PASSWORD_ERROR));
    }

    

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.OK)
    public Mono<Result<String>> handleException(Exception e, ServerWebExchange exchange) {
        log.error("系统异常: ", e);
        return Mono.just(Result.fail(e.getMessage()));
    }

    

    @ExceptionHandler(TopicException.class)
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<Result> handleTopicException(TopicException e) {
        
        System.out.println("自定义异常" + e);
        e.printStackTrace();
        
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Result.fail(e.getMessage(), e.getCode()));
    }
}
