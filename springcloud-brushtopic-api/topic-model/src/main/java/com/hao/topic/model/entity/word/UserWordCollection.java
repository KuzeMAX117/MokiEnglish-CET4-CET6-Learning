package com.hao.topic.model.entity.word;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class UserWordCollection extends BaseEntity {
    private Long userId;
    private String word;
    private String phonetic;
    private String meaning;
    private String example;
    private String exampleTranslate;
}
