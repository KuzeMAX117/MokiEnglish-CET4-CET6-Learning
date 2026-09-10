package com.hao.topic.model.vo.topic;

import com.hao.topic.model.dto.topic.PaperOptionDto;
import lombok.Data;

import java.util.List;

/**
 * 试卷管理：编辑器详情（含草稿卷）
 */
@Data
public class PaperManageDetailVo {
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

    private List<ManageSectionVo> sections;

    @Data
    public static class ManageSectionVo {
        private String section;
        private String subSection;
        private List<ManageTopicVo> topics;
    }

    @Data
    public static class ManageTopicVo {
        private Long topicId;
        private String topicName;
        private List<PaperOptionDto> options;
        private String correctOption;
        private String answer;
        private String analysis;
        private String article;
        private String questionType;
    }
}
