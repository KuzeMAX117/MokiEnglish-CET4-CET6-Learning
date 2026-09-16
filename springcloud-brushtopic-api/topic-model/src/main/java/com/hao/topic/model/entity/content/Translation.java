package com.hao.topic.model.entity.content;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class Translation extends BaseEntity {
    private String title;
    private String sourceLang;
    private String targetLang;
    private String sourceText;
    private String referenceAnswer;
    private String analysis;
    private Integer difficulty;
    private String category;
    private Long viewCount;
    private Integer isMember;
    private Integer status;
    private String createBy;
}
