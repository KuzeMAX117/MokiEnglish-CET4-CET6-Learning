package com.hao.topic.model.dto.topic;

import lombok.Data;

@Data
public class TopicListDto {
    private String topicName;
    private String createBy;
    private String beginCreateTime;
    private String endCreateTime;
    private Integer pageNum;
    private Integer pageSize;
}
