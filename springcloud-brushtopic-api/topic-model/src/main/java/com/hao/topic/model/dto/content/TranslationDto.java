package com.hao.topic.model.dto.content;

import lombok.Data;

import java.io.Serializable;

@Data
public class TranslationDto implements Serializable {
    private Long id;
    private String title;
    private String sourceLang;
    private String targetLang;
    private String sourceText;
    private String referenceAnswer;
    private String analysis;
    private Integer difficulty;
    private String category;
    private Integer isMember;
}
