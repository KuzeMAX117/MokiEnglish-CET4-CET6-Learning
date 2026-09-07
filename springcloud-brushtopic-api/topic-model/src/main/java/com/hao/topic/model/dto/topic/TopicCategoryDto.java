package com.hao.topic.model.dto.topic;

import lombok.Data;

import java.io.Serializable;

@Data
public class TopicCategoryDto implements Serializable {
    private String categoryName;
    private Long id;
}
