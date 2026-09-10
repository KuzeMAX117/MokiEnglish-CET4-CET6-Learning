package com.hao.topic.model.entity.word;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class WordBook extends BaseEntity {
    private String name;
    private Integer type;
    private Integer totalCount;
}
