package com.hao.topic.model.entity.content;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class Essay extends BaseEntity {
    private String title;
    private String content;
    private String referenceAnswer;
    private String analysis;
    private String category;
    private Integer difficulty;
    private Integer timeLimit;
    private String wordCount;
    private Long viewCount;
    private Integer isMember;
    private Integer status;
    private String createBy;
}
