package com.hao.topic.security;

import com.hao.topic.common.config.FeignConfig;
import com.hao.topic.common.config.MyMetaObjectHandler;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;

@SpringBootApplication
@EnableDiscoveryClient
@ComponentScan(basePackages = {
        "com.hao.topic.common.handler",  
})
@EnableFeignClients(basePackages = {"com.hao.topic.client.system"})
@Import({FeignConfig.class, MyMetaObjectHandler.class})
public class TopicSecurityApplication {

    public static void main(String[] args) {
        SpringApplication.run(TopicSecurityApplication.class, args);
        System.out.println("  _   _             \n" +
                " | | | | __ _  ___  \n" +
                " | |_| |/ _` |/ _ \\ \n" +
                " |  _  | (_| | (_) |\n" +
                " |_| |_|\\__,_|\\___/ \n" +
                " >>> 认证服务启动成功 <<<\n");
    }
}
