package com.hao.topic.model.entity.topic;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class TopicCategorySubject extends BaseEntity {

    private Long categoryId;
    private Long subjectId;
}
