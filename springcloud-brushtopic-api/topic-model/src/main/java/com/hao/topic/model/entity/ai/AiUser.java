package com.hao.topic.model.entity.ai;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class AiUser extends BaseEntity {
    
    private String account;
    
    private Long userId;
    
    private Long aiCount;
    
    private Long count;
    
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime recentlyUsedTime;
    
    private Integer status;
    private String roleName;
}
