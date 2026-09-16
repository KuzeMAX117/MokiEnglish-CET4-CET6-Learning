package com.hao.topic.model.dto.ai;

import lombok.Data;

import java.util.List;

/**
 * 翻译批改请求 DTO
 * <p>
 * 前端逐句提交原文、参考翻译和用户译文，
 * 由 AI 服务进行多维度批改并返回结构化结果。
 * </p>
 */
@Data
public class TranslationCorrectDto {

    /** 翻译方向：cn2en（中→英）/ en2cn（英→中） */
    private String direction;

    /** 题目难度等级：4 / 6 */
    private Integer level;

    /** 题目标题（用于 AI 了解语境） */
    private String topic;

    /** 关联翻译ID（用于追踪AI使用记录） */
    private Long translationId;

    /** 逐句翻译内容 */
    private List<Item> items;

    @Data
    public static class Item {

        /** 原文句子 */
        private String source;

        /** 参考翻译 */
        private String reference;

        /** 用户译文 */
        private String userTranslation;
    }
}
