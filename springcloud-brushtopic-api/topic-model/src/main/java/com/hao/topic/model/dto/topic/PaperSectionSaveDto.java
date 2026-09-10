package com.hao.topic.model.dto.topic;

import lombok.Data;

import java.util.List;

/**
 * 试卷管理：按板块分段保存
 */
@Data
public class PaperSectionSaveDto {
    private Long paperId;

    /**
     * 大板块 writing/listening/reading/translation
     */
    private String section;

    private List<SubSectionDto> subSections;

    @Data
    public static class SubSectionDto {
        /**
         * 子板块 news/conversation/passage/cloze/matching/reading_1/reading_2/writing/translation
         */
        private String subSection;

        /**
         * 子板块文章原文（文章类板块使用，写入该组每一题）
         */
        private String article;

        private List<TopicItemDto> topics;
    }

    @Data
    public static class TopicItemDto {
        private String topicName;
        private List<PaperOptionDto> options;
        private String correctOption;
        private String answer;
        private String analysis;

        /**
         * 单题文章（可选，优先于子板块 article）
         */
        private String article;
    }
}
