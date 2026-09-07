package com.hao.topic.model.vo.topic;

import lombok.Data;

@Data
public class PaperTopicVo {
    private Long topicId;
    private String topicName;
    

    private String options;
    private String questionType;
    

    private String section;
    

    private Integer sorted;
}
