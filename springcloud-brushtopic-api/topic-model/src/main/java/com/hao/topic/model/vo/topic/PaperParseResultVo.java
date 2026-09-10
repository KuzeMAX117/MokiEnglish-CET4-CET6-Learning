package com.hao.topic.model.vo.topic;

import com.hao.topic.model.dto.topic.PaperOptionDto;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * 试卷管理：解析结果（不落库，供前端核对后填入编辑器）
 */
@Data
public class PaperParseResultVo {

    /**
     * 解析出的子板块分组（可能跨多个大板块）
     */
    private List<ParseSubSectionVo> subSections = new ArrayList<>();

    /**
     * 全局警告清单
     */
    private List<String> warnings = new ArrayList<>();

    /**
     * docx 解析失败时的原始文本，供人工处理
     */
    private String rawText;

    public void addWarning(String warning) {
        this.warnings.add(warning);
    }

    /**
     * 子板块分组
     */
    @Data
    public static class ParseSubSectionVo {
        /**
         * 所属大板块 writing/listening/reading/translation
         */
        private String section;

        /**
         * 子板块 news/conversation/passage/cloze/matching/reading_1/reading_2/writing/translation
         */
        private String subSection;

        /**
         * 文章原文（阅读类为子板块共享；听力题级文章在 topic.article）
         */
        private String article;

        private List<ParseTopicVo> topics = new ArrayList<>();
    }

    /**
     * 解析出的单题
     */
    @Data
    public static class ParseTopicVo {
        private String topicName;
        private List<PaperOptionDto> options = new ArrayList<>();
        private String correctOption;
        private String answer;
        private String analysis;

        /**
         * 单题文章（听力材料等）
         */
        private String article;

        /**
         * 该题警告（前端标色提示）
         */
        private String warning;
    }
}
