package com.hao.topic.topic;

import com.hao.topic.api.utils.config.MybatisPlusConfig;
import com.hao.topic.common.config.MyMetaObjectHandler;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScans;
import org.springframework.context.annotation.Import;
import org.springframework.security.config.annotation.method.configuration.EnableReactiveMethodSecurity;
import org.springframework.security.config.annotation.web.reactive.EnableWebFluxSecurity;

@SpringBootApplication
@MapperScan("com.hao.topic.**.mapper")
@EnableDiscoveryClient
@ComponentScans({
        @ComponentScan("com.hao.topic.common.security")
        , @ComponentScan("com.hao.topic.common.handler"),
})
@Import({MyMetaObjectHandler.class, MybatisPlusConfig.class})  
@ComponentScan({"com.hao.topic.api.utils", "com.hao.topic.common.auth"})
@EnableFeignClients(basePackages = {"com.hao.topic.client.security","com.hao.ai.client.ai"})
public class TopicTopicApplication {
    public static void main(String[] args) {
        SpringApplication.run(TopicTopicApplication.class, args);
        System.out.println("""
                
                    ("`-/")_.-'"``-._
                     . . `; -._    )-;-,_`)
                    (v_,)'  _  )`-.\\  ``-'
                   _.- _..-_/ / ((.'
                 ((,.-'   ((,/
                """);
        System.out.println("=====/*AVA:所有都准备就绪，就差你了！*/======");
    }
}
