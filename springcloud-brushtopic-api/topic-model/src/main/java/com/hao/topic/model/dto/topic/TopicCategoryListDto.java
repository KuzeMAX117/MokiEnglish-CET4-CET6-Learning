package com.hao.topic.model.dto.topic;

import lombok.Data;

@Data
public class TopicCategoryListDto {
    private String categoryName;
    private String createBy;
    private String beginCreateTime;
    private String endCreateTime;
    private Integer status;
    private Integer pageNum;
    private Integer pageSize;
}
