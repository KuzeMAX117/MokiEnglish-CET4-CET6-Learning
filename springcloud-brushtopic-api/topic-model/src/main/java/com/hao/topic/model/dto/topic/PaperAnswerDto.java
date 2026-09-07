package com.hao.topic.model.dto.topic;

import lombok.Data;

@Data
public class PaperAnswerDto {
    private Long paperId;
    private Long topicId;
    

    private String selected;
}
