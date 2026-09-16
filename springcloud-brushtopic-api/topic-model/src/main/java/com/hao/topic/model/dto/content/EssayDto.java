package com.hao.topic.model.dto.content;

import lombok.Data;

import java.io.Serializable;

@Data
public class EssayDto implements Serializable {
    private Long id;
    private String title;
    private String content;
    private String referenceAnswer;
    private String analysis;
    private String category;
    private Integer difficulty;
    private Integer timeLimit;
    private String wordCount;
    private Integer isMember;
}
