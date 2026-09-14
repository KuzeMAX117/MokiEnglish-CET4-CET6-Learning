package com.hao.topic.model.vo.ai;

import lombok.Data;

import java.util.List;

/**
 * 作文批改结果 VO
 * <p>
 * 严格依据《全国大学英语四、六级考试大纲（2016修订版）》作文评分标准，
 * 采用总体印象评分法（满分15分，5档+0分档）。
 * </p>
 */
@Data
public class EssayCorrectionVo {

    /** 总分 0-15 */
    private Double score;

    /** 档次：14 / 11 / 8 / 5 / 2 / 0 */
    private Integer band;

    /** 档次标签，如「14分档（13–15分）」 */
    private String bandLabel;

    /** 档次原文（严格原样引用大纲描述） */
    private String bandDescription;

    /** 定档依据 */
    private String bandReason;

    /** 评分场景说明（四级/六级） */
    private String levelScene;

    /** 总体评语（一句话总评 + 综合评语） */
    private String overall;

    /** 内容 0-5：切题、内容充实、观点明确 */
    private Double content;

    /** 语言 0-5：语法准确、句式多样 */
    private Double language;

    /** 词汇 0-5：词汇丰富、用词恰当 */
    private Double vocabulary;

    /** 结构 0-5：篇章结构清晰、逻辑连贯 */
    private Double structure;

    /** 语法错误列表 */
    private List<GrammarError> grammarErrors;

    /** 词汇建议列表 */
    private List<VocabularySuggestion> vocabularySuggestions;

    /** 考生自查清单 */
    private List<String> selfCheckList;

    /**
     * 语法错误
     */
    @Data
    public static class GrammarError {

        /** 错误类型：grammar / spelling / punctuation / tense / subject_verb_agreement */
        private String type;

        /** 错误分级：serious（严重错误）/ minor（轻微小错） */
        private String severity;

        /** 原句 */
        private String original;

        /** 修正后的句子 */
        private String correction;

        /** 错误解释 */
        private String explanation;

        /** 错误影响：会降档 / 仅小幅扣分，不影响档次 */
        private String impact;
    }

    /**
     * 词汇建议
     */
    @Data
    public static class VocabularySuggestion {

        /** 原始词汇/短语 */
        private String original;

        /** 建议替换 */
        private String suggestion;

        /** 建议原因 */
        private String reason;
    }
}
