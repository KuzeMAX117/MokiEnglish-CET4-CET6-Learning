package com.hao.topic.api.utils.mq;

import jakarta.annotation.PostConstruct;
import org.springframework.amqp.core.ReturnedMessage;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MQProducerAckConfig implements RabbitTemplate.ReturnsCallback, RabbitTemplate.ConfirmCallback {
    
    
    @Autowired
    private RabbitTemplate rabbitTemplate;

    
    
    @PostConstruct
    public void init() {
        rabbitTemplate.setReturnsCallback(this);
        rabbitTemplate.setConfirmCallback(this);
    }

    

    @Override
    public void confirm(CorrelationData correlationData, boolean ack, String cause) {
        if (ack) {
            System.out.println("消息发送成功！");
        } else {
            System.out.println("消息发送失败！" + cause);
        }
    }

    

    @Override
    public void returnedMessage(ReturnedMessage returnedMessage) {
        System.out.println("消息主体: " + returnedMessage.getMessage());
        System.out.println("应答码: " + returnedMessage.getReplyCode());
        System.out.println("描述：" + returnedMessage);
        System.out.println("消息使用的交换器 exchange : " + returnedMessage.getExchange());
        System.out.println("消息使用的路由键 routing : " + returnedMessage.getRoutingKey());
    }
}
