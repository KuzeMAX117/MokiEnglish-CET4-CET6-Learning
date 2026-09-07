package com.hao.topic.model.dto.topic;

import lombok.Data;

@Data
public class TopicLabelListDto {
    private String labelName;
    private String createBy;
    private String beginCreateTime;
    private String endCreateTime;
    private Integer pageNum;
    private Integer pageSize;
}
