package com.hao.topic.security.constant;

import lombok.Getter;

@Getter
public enum EmailConstant {
    
    EMAIL_SEND_SUCCESS("验证码已发送，请注意查收邮件"),

    
    EMAIL_MESSAGE("您的 学习平台 验证码为："),

    
    EMAIL_OUT_TIME("，验证码有效期为5分钟，请及时填写。"),

    
    EMAIL_TITLE("学习平台 邮箱验证码"),

    
    EMAIL_CODE("ai:email:code:"),

    
    EMAIL_CODE_ERROR("验证码错误，请重新输入正确的验证码。"),

    
    NOT_EXIST_EMAIL("该邮箱未注册，请确认邮箱是否正确");

    private final String Value;

    EmailConstant(String value) {
        this.Value = value;
    }
}