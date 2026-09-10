package com.hao.topic.model.vo.word;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class WordCollectionVo {
    private Long id;
    private String word;
    private String phonetic;
    private String meaning;
    private String example;
    private String exampleTranslate;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
}
