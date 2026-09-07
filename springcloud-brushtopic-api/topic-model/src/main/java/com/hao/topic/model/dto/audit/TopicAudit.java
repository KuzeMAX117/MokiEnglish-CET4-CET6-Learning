package com.hao.topic.model.dto.audit;

import lombok.Data;

import java.io.Serializable;

@Data
public class TopicAudit implements Serializable {
    private String topicName;
    private Long id;
    private String answer;
    private String account;
    private Long userId;
    private String topicSubjectName;
    private String topicLabelName;
}
