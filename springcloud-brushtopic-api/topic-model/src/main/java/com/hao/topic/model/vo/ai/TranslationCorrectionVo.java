package com.hao.topic.model.vo.ai;

import lombok.Data;

import java.util.List;

/**
 * 翻译批改结果 VO
 * <p>
 * 严格依据《全国大学英语四、六级考试大纲（2016 修订版）》翻译评分原文标准，
 * 采用总体印象评分法（满分 15 分，5 档 + 0 分档）。承载档次评分、定档依据、
 * 核心信息点核查、逐句错误分级与影响分析、两版修改建议、考生自查清单。
 * </p>
 */
@Data
public class TranslationCorrectionVo {

    /** 档次：14 / 11 / 8 / 5 / 2 / 0 */
    private Integer band;

    /** 总分 0-15，必须落在所选 band 区间内 */
    private Double score;

    /** 档次标签，如「11分档（10–12分）」 */
    private String bandLabel;

    /** 档次原文（严格原样引用大纲描述，由后端强制校准） */
    private String bandDescription;

    /** 定档依据（区分【大纲原文规则】与【阅卷实操隐性规则】并标注来源） */
    private String bandReason;

    /** 评分场景说明（四级/六级；同一译文六级估分适当下调） */
    private String levelScene;

    /** 准确度 0-5：信息准确、翻译完整程度 */
    private Double accuracy;

    /** 流畅度 0-5：语句可读连贯 */
    private Double fluency;

    /** 语法 0-5：语法与拼写 */
    private Double grammar;

    /** 总体评语（一句话总评 + 综合评语） */
    private String overall;

    /** 核心信息点核查（标记漏译/错译） */
    private List<CoreInfoItem> coreInfoCheck;

    /** 考生自查清单 */
    private List<String> selfCheckList;

    /** 逐句批改明细（与提交顺序一致） */
    private List<Detail> details;

    /**
     * 核心信息点核查项。
     */
    @Data
    public static class CoreInfoItem {

        /** 原文核心信息点 */
        private String point;

        /** 状态：ok（译出）/ missing（漏译）/ wrong（错译） */
        private String status;

        /** 说明 */
        private String note;
    }

    @Data
    public static class Detail {

        /** 原文句子 */
        private String source;

        /** 用户译文 */
        private String userTranslation;

        /** 参考翻译 */
        private String reference;

        /** 该句翻译完整程度简评（是否漏译核心信息） */
        private String completeness;

        /** 修改优化——保守稳妥版（适合应试拿分） */
        private String polishedConservative;

        /** 修改优化——进阶润色版（适合冲击高分） */
        private String polishedAdvanced;

        /** 错误标识列表 */
        private List<ErrorItem> errors;

        /** 该句点评（从翻译完整程度/语法/拼写三方面） */
        private String comment;
    }

    @Data
    public static class ErrorItem {

        /** 错误类型：spelling / grammar / word_choice / expression / omission / completeness */
        private String type;

        /** 错误分级：serious（严重错误，会降档）/ minor（轻微小错） */
        private String severity;

        /** 用户译文中出错的原文片段（必须是 userTranslation 中逐字出现的子串，用于前端高亮标识；漏译为空串） */
        private String errorText;

        /** 错误解释 */
        private String explanation;

        /** 建议替换词/替换表达（可为空） */
        private String suggestion;

        /** 错误影响：「会降档」或「仅小幅扣分，不影响档次」 */
        private String impact;
    }
}
