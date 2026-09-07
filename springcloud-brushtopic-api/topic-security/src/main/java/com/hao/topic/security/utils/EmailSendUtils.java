package com.hao.topic.security.utils;

import com.hao.topic.security.constant.EmailConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.swing.*;
import java.util.Arrays;
import java.util.concurrent.TimeUnit;
import java.util.stream.Stream;

@Service
public class EmailSendUtils {
    
    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private RedisTemplate redisTemplate;

    
    @Value("${spring.mail.username}")
    private String userName;

    
    private final StringBuilder EMAIL_CODE = new StringBuilder();

    

    public void sendVerificationEmail(String to) {
        try {
            
            SimpleMailMessage message = new SimpleMailMessage();
            
            generateRandomCode(to);
            
            message.setFrom(userName);
            
            message.setTo(to);
            
            message.setSubject(EmailConstant.EMAIL_TITLE.getValue());
            
            message.setText(EmailConstant.EMAIL_MESSAGE.getValue() + EMAIL_CODE + EmailConstant.EMAIL_OUT_TIME.getValue());
            
            mailSender.send(message);
        } finally {
            
            EMAIL_CODE.setLength(0);
        }
    }

    

    public void generateRandomCode(String email) {
        
        String str = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        
        String[] newStr = str.split("");
        
        for (int i = 0; i < 6; i++) {
            
            EMAIL_CODE.append(newStr[(int) (Math.random() * 62)]);
        }
        
        redisTemplate.opsForValue().set(EmailConstant.EMAIL_CODE.getValue() + ":" + email, EMAIL_CODE, 5, TimeUnit.MINUTES);
    }
}