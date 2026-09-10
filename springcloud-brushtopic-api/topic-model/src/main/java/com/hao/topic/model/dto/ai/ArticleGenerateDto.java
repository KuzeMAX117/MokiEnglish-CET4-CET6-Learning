package com.hao.topic.model.dto.ai;

import lombok.Data;

import java.util.List;

/**
 * 短文生成请求 DTO
 * <p>
 * 前端传入今日单词列表和难度等级，后端执行多阶段 AI Pipeline 生成短文
 * </p>
 */
@Data
public class ArticleGenerateDto {

    /** 目标单词列表（包含单词、释义、例句） */
    private List<WordInfo> words;

    /** 难度等级: CET-4 / CET-6 */
    private String level;

    /** 用户昵称 */
    private String nickname;

    @Data
    public static class WordInfo {
        /** 单词 */
        private String word;
        /** 释义 */
        private String meaning;
        /** 音标 */
        private String phonetic;
        /** 例句 */
        private String example;
        /** 例句翻译 */
        private String exampleTranslate;
        /** 用户对该词的熟练度 0-5 */
        private Integer proficiency;
    }
}
