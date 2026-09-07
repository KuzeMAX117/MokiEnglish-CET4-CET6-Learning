package com.hao.topic.model.entity.topic;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class TopicSubjectTopic extends BaseEntity {
    private Long topicId;
    private Long subjectId;
}
