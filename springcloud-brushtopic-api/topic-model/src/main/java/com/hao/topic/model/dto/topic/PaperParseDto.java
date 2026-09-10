package com.hao.topic.model.dto.topic;

import lombok.Data;

/**
 * 试卷管理：粘贴文本解析请求
 */
@Data
public class PaperParseDto {

    /**
     * 当前大板块 writing/listening/reading/translation（文本无 Part 标记时按此兜底）
     */
    private String section;

    /**
     * 目标子板块（粘贴单个子板块时可选）
     */
    private String subSection;

    /**
     * 粘贴的题目文本
     */
    private String text;
}
