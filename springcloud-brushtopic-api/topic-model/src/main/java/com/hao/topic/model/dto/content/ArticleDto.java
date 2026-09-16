package com.hao.topic.model.dto.content;

import lombok.Data;

import java.io.Serializable;

@Data
public class ArticleDto implements Serializable {
    private Long id;
    private String title;
    private String content;
    private String summary;
    private String coverImage;
    private String category;
    private String source;
    private Integer isMember;
}
