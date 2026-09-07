package com.hao.topic.model.dto.audit;

import lombok.Data;

import java.io.Serializable;

@Data
public class TopicAuditCategory implements Serializable {
    private String categoryName;
    private Long id;
    private String account;
    private Long userId;
}
