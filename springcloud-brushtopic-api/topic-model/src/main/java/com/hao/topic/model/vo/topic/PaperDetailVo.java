package com.hao.topic.model.vo.topic;

import lombok.Data;

import java.util.List;

@Data
public class PaperDetailVo {
    private Long id;
    private Integer level;
    private Integer examYear;
    private Integer examHalf;
    private String title;
    private Long totalScore;
    private List<PaperSectionVo> sections;

    @Data
    public static class PaperSectionVo {
        

        private String section;
        private List<PaperTopicVo> topics;
    }
}
