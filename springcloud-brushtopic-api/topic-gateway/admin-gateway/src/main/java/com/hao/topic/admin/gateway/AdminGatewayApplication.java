package com.hao.topic.admin.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class AdminGatewayApplication {
    public static void main(String[] args) {
        SpringApplication.run(AdminGatewayApplication.class, args);
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
