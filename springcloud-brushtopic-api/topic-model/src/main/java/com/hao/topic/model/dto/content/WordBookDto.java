package com.hao.topic.model.dto.content;

import lombok.Data;

import java.io.Serializable;

@Data
public class WordBookDto implements Serializable {
    private Long id;
    private String name;
    private Integer type;
}
