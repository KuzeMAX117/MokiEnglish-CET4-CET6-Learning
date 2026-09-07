package com.hao.topic.model.dto.topic;

import lombok.Data;

@Data
public class TopicSubjectListDto {

    private String subjectName;
    private String createBy;
    private String beginCreateTime;
    private String endCreateTime;
    private String categoryName;
    private Integer pageNum;
    private Integer pageSize;
}
