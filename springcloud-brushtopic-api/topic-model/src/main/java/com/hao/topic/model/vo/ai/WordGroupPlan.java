package com.hao.topic.model.vo.ai;

import lombok.Data;

import java.util.List;

/**
 * 单词语义聚类分组结果（Step 0 输出）
 * <p>
 * 当目标单词数量较多（如 45+）且语义相关性低时，强行塞进同一篇短文会显得
 * 生硬且每个单词只能出现一次。通过 AI 语义聚类把单词拆成若干组，
 * 每组独立生成一篇主题聚焦的短文，提升自然度与词汇复现率。
 * </p>
 * <p>
 * 通过 Spring AI Structured Output 将 AI 返回的 JSON 自动映射为此对象。
 * </p>
 */
@Data
public class WordGroupPlan {

    /** 分组列表，每组对应一篇短文 */
    private List<Group> groups;

    @Data
    public static class Group {
        /** 该组的主题方向（英文，如 campus life / technology） */
        private String theme;
        /** 属于该组的单词（原词形，需与输入单词一致） */
        private List<String> words;
    }
}
