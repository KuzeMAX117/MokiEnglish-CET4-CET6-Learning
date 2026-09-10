package com.hao.topic.model.dto.word;

import lombok.Data;

@Data
public class WordCollectionDto {
    /** 单词（必填，后端统一转小写存储） */
    private String word;
    /** 音标快照（可选，前端已查得则携带，避免后端重复查词） */
    private String phonetic;
    /** 释义快照（可选，为空时后端调用 lookupWord 兜底填充） */
    private String meaning;
    /** 例句快照（可选） */
    private String example;
    /** 例句翻译快照（可选） */
    private String exampleTranslate;
}
