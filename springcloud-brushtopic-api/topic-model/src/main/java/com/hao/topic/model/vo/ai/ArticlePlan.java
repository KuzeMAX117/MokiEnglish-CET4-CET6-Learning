package com.hao.topic.model.vo.ai;

import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * AI 短文生成结构化大纲（Step 1 输出）
 * <p>
 * 通过 Spring AI Structured Output 将 AI 返回的 JSON 自动映射为此 Java 对象。
 * 这一步让 AI "先想清楚再写"，而非一股脑直接输出全文。
 * </p>
 * <p>
 * 叙事一致性保障：通过 narrativeThread（叙事主线）+ paragraphTransitions（段间过渡）
 * + settingConstraints（场景约束）三层机制，确保全文讲同一个故事。
 * </p>
 */
@Data
public class ArticlePlan {

    /** 文章标题 */
    private String title;

    /** 主题方向（如：campus life, technology, environment） */
    private String theme;

    /** 体裁: narrative / expository / argumentative */
    private String genre;

    // ==================== 叙事一致性保障字段 ====================

    /**
     * 叙事主线 —— 用一句话概括全文的核心故事/论点。
     * <p>
     * 示例："一个大学生在图书馆备考时，通过一次意外的对话重新理解了坚持的意义"
     * </p>
     * <p>
     * 这是保障故事一体性的核心字段：生成和评估阶段都会引用它，
     * 确保每一段都服务于同一条主线，而非各讲各的。
     * </p>
     */
    private String narrativeThread;

    /**
     * 场景约束 —— 定义故事的时间、地点、人物，锁定叙事背景。
     * <p>
     * 示例："时间：周末下午；地点：大学图书馆和校园咖啡厅；人物：主人公小李和室友"
     * </p>
     * <p>
     * 防止 AI 在不同段落突然切换场景（如从校园跳到太空）。
     * </p>
     */
    private String settingConstraints;

    /**
     * 段落间过渡策略 —— 明确每两段之间如何衔接。
     * <p>
     * 示例：["从图书馆场景自然过渡到回忆过去", "从回忆回到现实，室友的出现打断思绪"]
     * </p>
     * <p>
     * 数组长度 = outline.size() - 1（即段与段之间的连接数）。
     * </p>
     */
    private List<String> paragraphTransitions;

    // ==================== 原有字段 ====================

    /** 段落大纲，每段一行描述（必须服务于 narrativeThread） */
    private List<String> outline;

    /** 每个目标单词的使用策略：key=单词, value=计划使用的语境描述 */
    private Map<String, String> wordUsageStrategy;

    /** 预计文章难度: easy / medium / hard */
    private String difficulty;
}
