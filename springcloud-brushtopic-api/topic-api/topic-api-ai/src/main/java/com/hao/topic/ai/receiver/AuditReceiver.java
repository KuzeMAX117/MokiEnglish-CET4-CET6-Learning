package com.hao.topic.ai.receiver;

import com.alibaba.excel.util.StringUtils;
import com.alibaba.fastjson2.JSON;
import com.hao.topic.ai.service.ModelService;
import com.hao.topic.api.utils.constant.RabbitConstant;
import com.hao.topic.common.constant.RedisConstant;
import com.hao.topic.model.dto.audit.TopicAudit;
import com.hao.topic.model.dto.audit.TopicAuditCategory;
import com.hao.topic.model.dto.audit.TopicAuditLabel;
import com.hao.topic.model.dto.audit.TopicAuditSubject;
import com.rabbitmq.client.Channel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.Exchange;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.QueueBinding;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

@Component
@Slf4j
public class AuditReceiver {

    @Autowired
    private ModelService modelService;
    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    

    @RabbitListener(
            bindings = @QueueBinding(value = @Queue(value = RabbitConstant.CATEGORY_AUDIT_QUEUE_NAME),
                    exchange = @Exchange(value = RabbitConstant.CATEGORY_AUDIT_EXCHANGE),
                    key = {RabbitConstant.CATEGORY_AUDIT_ROUTING_KEY_NAME}))
    public void auditCategory(String topicAuditCategoryJson, Message message, Channel channel) {
        log.info("接收到分类审核消息{}", topicAuditCategoryJson);
        
        TopicAuditCategory topicAuditCategory = JSON.parseObject(topicAuditCategoryJson, TopicAuditCategory.class);
        
        String lockKey = RedisConstant.CATEGORY_AUDIT_KEY_PREFIX + topicAuditCategory.getId();
        
        String lockValue = String.valueOf(topicAuditCategory.getId());
        try {
            
            Boolean acquiredLock = stringRedisTemplate.opsForValue().setIfAbsent(lockKey, lockValue, RedisConstant.AUDIT_EXPIRE_TIME, TimeUnit.MINUTES);
            if (acquiredLock == null || !acquiredLock) {
                log.info("分类审核消息正在处理中，忽略重复消息: {}", topicAuditCategory.getId());
                
                channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
                return;
            }
            
            modelService.auditCategory(topicAuditCategory);
            
            
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
        } catch (Exception e) {
            modelService.recordAuditLog("服务器发生异常", topicAuditCategory.getAccount(), topicAuditCategory.getUserId());
        } finally {
            stringRedisTemplate.delete(lockKey);
        }
    }

    

    @RabbitListener(
            bindings = @QueueBinding(value = @Queue(value = RabbitConstant.SUBJECT_AUDIT_QUEUE_NAME),
                    exchange = @Exchange(value = RabbitConstant.SUBJECT_AUDIT_EXCHANGE),
                    key = {RabbitConstant.SUBJECT_AUDIT_ROUTING_KEY_NAME}))
    public void auditSubject(String topicAuditSubjectJson, Message message, Channel channel) {
        log.info("接收到专题审核消息{}", topicAuditSubjectJson);
        
        TopicAuditSubject topicAuditSubject = JSON.parseObject(topicAuditSubjectJson, TopicAuditSubject.class);
        
        String lockKey = RedisConstant.SUBJECT_AUDIT_KEY_PREFIX + topicAuditSubject.getId();
        
        String lockValue = String.valueOf(topicAuditSubject.getId());
        try {
            
            Boolean acquiredLock = stringRedisTemplate.opsForValue().setIfAbsent(lockKey, lockValue, RedisConstant.AUDIT_EXPIRE_TIME, TimeUnit.MINUTES);
            if (acquiredLock == null || !acquiredLock) {
                log.info("审核消息正在处理中，忽略重复消息: {}", topicAuditSubject.getId());
                
                channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
                return;
            }
            
            modelService.auditSubject(topicAuditSubject);
            
            
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
        } catch (Exception e) {
            modelService.recordAuditLog("服务器发生异常", topicAuditSubject.getAccount(), topicAuditSubject.getUserId());
        } finally {
            stringRedisTemplate.delete(lockKey);
        }
    }

    

    @RabbitListener(
            bindings = @QueueBinding(value = @Queue(value = RabbitConstant.LABEL_AUDIT_QUEUE_NAME),
                    exchange = @Exchange(value = RabbitConstant.LABEL_AUDIT_EXCHANGE),
                    key = {RabbitConstant.LABEL_AUDIT_ROUTING_KEY_NAME}))
    public void auditLabel(String topicAuditLabelJson, Message message, Channel channel) {
        log.info("接收到标签审核消息{}", topicAuditLabelJson);
        
        TopicAuditLabel topicAuditLabel = JSON.parseObject(topicAuditLabelJson, TopicAuditLabel.class);
        
        String lockKey = RedisConstant.LABEL_AUDIT_KEY_PREFIX + topicAuditLabel.getId();
        
        String lockValue = String.valueOf(topicAuditLabel.getId());
        try {
            
            Boolean acquiredLock = stringRedisTemplate.opsForValue().setIfAbsent(lockKey, lockValue, RedisConstant.AUDIT_EXPIRE_TIME, TimeUnit.MINUTES);
            if (acquiredLock == null || !acquiredLock) {
                log.info("审核消息正在处理中，忽略重复消息: {}", topicAuditLabel.getId());
                
                channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
                return;
            }
            
            modelService.auditLabel(topicAuditLabel);
            
            
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
        } catch (Exception e) {
            modelService.recordAuditLog("服务器发生异常", topicAuditLabel.getAccount(), topicAuditLabel.getUserId());
        } finally {
            stringRedisTemplate.delete(lockKey);
        }
    }

    

    @RabbitListener(
            bindings = @QueueBinding(value = @Queue(value = RabbitConstant.TOPIC_AUDIT_QUEUE_NAME),
                    exchange = @Exchange(value = RabbitConstant.TOPIC_AUDIT_EXCHANGE),
                    key = {RabbitConstant.TOPIC_AUDIT_ROUTING_KEY_NAME}))
    public void auditTopic(String topicAuditJson, Message message, Channel channel) {
        log.info("接收到题目审核消息{}", topicAuditJson);

        
        TopicAudit topicAudit = JSON.parseObject(topicAuditJson, TopicAudit.class);
        
        String lockKey = RedisConstant.TOPIC_AUDIT_KEY_PREFIX + topicAudit.getId();
        
        String lockValue = String.valueOf(topicAudit.getId());
        try {
            
            Boolean acquiredLock = stringRedisTemplate.opsForValue().setIfAbsent(lockKey, lockValue, RedisConstant.AUDIT_EXPIRE_TIME, TimeUnit.MINUTES);
            if (acquiredLock == null || !acquiredLock) {
                log.info("审核消息正在处理中，忽略重复消息: {}", topicAudit.getId());
                
                channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
                return;
            }
            
            modelService.auditTopic(topicAudit);
            
            
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
        } catch (Exception e) {
            modelService.recordAuditLog("服务器发生异常", topicAudit.getAccount(), topicAudit.getUserId());
        }
    }

    

    @RabbitListener(
            bindings = @QueueBinding(value = @Queue(value = RabbitConstant.AI_ANSWER_QUEUE_NAME),
                    exchange = @Exchange(value = RabbitConstant.AI_ANSWER_EXCHANGE),
                    key = {RabbitConstant.AI_ANSWER_ROUTING_KEY_NAME}))
    public void generateAnswer(String topicAuditJson, Message message, Channel channel) {
        log.info("接收到题目生成答案消息{}", topicAuditJson);
        
        TopicAudit topicAudit = JSON.parseObject(topicAuditJson, TopicAudit.class);
        try {
            
            modelService.generateAnswer(topicAudit);
            
            
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
        } catch (Exception e) {
            modelService.recordAuditLog("服务器发生异常", topicAudit.getAccount(), topicAudit.getUserId());
        }
    }
}

