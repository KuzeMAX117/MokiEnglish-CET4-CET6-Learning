package com.hao.topic.model.vo.ai;

import lombok.Data;

/**
 * AI 短文质量评估结果（Step 3 输出）
 * <p>
 * 通过 Structured Output 让 AI 对自己的生成结果进行自评，
 * 实现 Agent 的"感知-规划-执行-评估"循环。
 * </p>
 */
@Data
public class ArticleEvaluation {

    /** 综合评分 0-100 */
    private Integer overallScore;

    /** 目标单词覆盖率 0.0-1.0 */
    private Double wordCoverage;

    /** 难度匹配度: too_easy / appropriate / too_hard */
    private String difficultyMatch;

    /** 篇章连贯性评分 0-100 */
    private Integer coherenceScore;

    /** 语言自然度评分 0-100 */
    private Integer naturalnessScore;

    /** 是否通过质量门控 */
    private boolean passed;

    /** 改进建议（未通过时用于指导重新生成） */
    private String improvementFeedback;
}
