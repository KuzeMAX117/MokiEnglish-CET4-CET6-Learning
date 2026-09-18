package com.hao.topic.ai.enums;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor

public enum AiStatusEnums {
    
    SEND_TOPIC(0, "发送题目"),
    
    EVALUATE_ANSWER(1, "评估答案");

    private Integer code;
    private String message;

    public Integer getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }
}
