package com.hao.topic.model.vo.topic;

import lombok.Data;

import java.util.List;

@Data
public class TopicDetailVo {

    private String topicName;
    private Boolean isCollected;
    private Integer isMember;
    List<String> labelNames;

}
