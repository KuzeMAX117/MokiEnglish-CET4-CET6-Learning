package com.hao.topic.model.vo.topic;

import lombok.Data;

@Data
public class PaperVo {
    private Long id;
    private Integer level;
    private Integer examYear;
    private Integer examHalf;
    private String title;
    private Long totalScore;
    

    private Long topicCount;
    

    private Long doneCount;
}
