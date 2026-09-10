package com.hao.topic.model.vo.topic;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Map;

/**
 * 试卷管理：列表行
 */
@Data
public class PaperManageVo {
    private Long id;
    private Integer level;
    private Integer examYear;
    private Integer examHalf;
    private String title;
    private Long totalScore;

    /**
     * 0正常 1停用 2草稿
     */
    private Integer status;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    private Long topicCount;

    /**
     * 各板块题数 writing/listening/reading/translation
     */
    private Map<String, Long> sectionCounts;
}
