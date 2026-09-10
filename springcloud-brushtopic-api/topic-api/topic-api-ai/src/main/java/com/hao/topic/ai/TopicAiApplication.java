package com.hao.topic.ai;

import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.hao.topic.api.utils.config.MybatisPlusConfig;
import com.hao.topic.common.config.MyMetaObjectHandler;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScans;
import org.springframework.context.annotation.Import;
import org.springframework.scheduling.annotation.EnableAsync;

@EnableDiscoveryClient
@SpringBootApplication
@ComponentScans({
        @ComponentScan("com.hao.topic.common.security")
        , @ComponentScan("com.hao.topic.common.handler"),
})
@Import({MyMetaObjectHandler.class, MybatisPlusConfig.class})  
@ComponentScan({"com.hao.topic.common.auth"})
@EnableFeignClients(basePackages = {"com.hao.topic.client.system", "com.hao.topic.client.topic"})
@EnableAsync
public class TopicAiApplication {

    public static void main(String[] args) {
        // 覆盖原生 DashScope SDK 默认旧域名，使 sk-ws- 密钥可正常鉴权
        String dashscopeBaseUrl = System.getenv("DASHSCOPE_BASE_URL");
        if (dashscopeBaseUrl != null && !dashscopeBaseUrl.isEmpty()) {
            System.setProperty("dashscope.base.http.api.url", dashscopeBaseUrl);
        }
        SpringApplication.run(TopicAiApplication.class, args);
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
