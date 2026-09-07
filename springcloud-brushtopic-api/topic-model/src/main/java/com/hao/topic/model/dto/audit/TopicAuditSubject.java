package com.hao.topic.model.dto.audit;

import lombok.Data;

import java.io.Serializable;

@Data
public class TopicAuditSubject implements Serializable {
    private Long id;
    private String subjectName;
    private String categoryName;
    private String subjectDesc;
    private String account;
    private Long userId;
}
