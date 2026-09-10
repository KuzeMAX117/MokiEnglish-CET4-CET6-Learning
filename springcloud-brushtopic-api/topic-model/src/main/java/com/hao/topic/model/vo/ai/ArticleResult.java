package com.hao.topic.model.vo.ai;

import lombok.Data;

import java.util.List;

/**
 * 短文生成最终结果 VO
 * <p>
 * 包含短文正文、词汇注释卡片、AI 评估信息等，供前端结构化渲染。
 * 通过 SSE 以 JSON 字符串形式在文章末尾推送。
 * </p>
 */
@Data
public class ArticleResult {

    /** 文章标题 */
    private String title;

    /** 文章正文（Markdown 格式，目标单词加粗） */
    private String content;

    /** 中文翻译 */
    private String translation;

    /** 词汇注释卡片列表 */
    private List<VocabNote> vocabulary;

    /** AI 质量评估摘要 */
    private EvalSummary evaluation;

    /** 文章主题 */
    private String theme;

    /** 体裁 */
    private String genre;

    /** 难度标签 */
    private String difficulty;

    @Data
    public static class VocabNote {
        /** 单词 */
        private String word;
        /** 音标 */
        private String phonetic;
        /** 释义 */
        private String meaning;
        /** 在文中的出现次数 */
        private Integer appearCount;
        /** AI 给出的使用语境 */
        private String usageContext;
    }

    @Data
    public static class EvalSummary {
        /** 综合评分 0-100 */
        private Integer score;
        /** 单词覆盖率百分比 */
        private Integer coveragePercent;
        /** 难度是否匹配 */
        private boolean difficultyMatched;
        /** 是否经过重试优化 */
        private boolean refined;
    }
}
