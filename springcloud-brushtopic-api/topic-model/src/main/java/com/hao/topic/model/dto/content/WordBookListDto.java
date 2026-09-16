package com.hao.topic.model.dto.content;

import lombok.Data;

import java.io.Serializable;

@Data
public class WordBookListDto implements Serializable {
    private String name;
    private Integer type;
    private Integer pageNum;
    private Integer pageSize;
}
