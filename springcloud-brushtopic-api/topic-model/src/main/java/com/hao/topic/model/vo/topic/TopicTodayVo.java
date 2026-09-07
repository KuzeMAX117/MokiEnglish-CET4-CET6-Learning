package com.hao.topic.model.vo.topic;

import lombok.Data;

import java.util.List;

@Data
public class TopicTodayVo {
    private Long id;
    private Long topicId;
    private Long subjectId;
    private String topicName;
    private Integer status;
    List<String> labelNames;

}
