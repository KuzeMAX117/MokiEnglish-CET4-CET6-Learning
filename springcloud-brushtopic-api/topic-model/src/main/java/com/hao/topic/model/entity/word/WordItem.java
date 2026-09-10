package com.hao.topic.model.entity.word;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class WordItem extends BaseEntity {
    private Long bookId;
    private String word;
    private String phonetic;
    private String meaning;
    private String phrase;
    private String syllableWord;
    private String example;
    private String exampleTranslate;
}
