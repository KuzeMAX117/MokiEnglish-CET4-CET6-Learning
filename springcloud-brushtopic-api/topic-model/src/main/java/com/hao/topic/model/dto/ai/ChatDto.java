package com.hao.topic.model.dto.ai;

import lombok.Data;

@Data
public class ChatDto {
    
    private String prompt;
    
    private String chatId;
    
    private String model;
    
    private String content;
    
    private Long memoryId;
    
    private String nickname;

}
