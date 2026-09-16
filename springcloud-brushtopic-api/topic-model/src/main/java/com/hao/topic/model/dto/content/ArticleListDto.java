package com.hao.topic.model.dto.content;

import lombok.Data;

import java.io.Serializable;

@Data
public class ArticleListDto implements Serializable {
    private String title;
    private String category;
    private String createBy;
    private Integer status;
    private String beginCreateTime;
    private String endCreateTime;
    private Integer pageNum;
    private Integer pageSize;
}
