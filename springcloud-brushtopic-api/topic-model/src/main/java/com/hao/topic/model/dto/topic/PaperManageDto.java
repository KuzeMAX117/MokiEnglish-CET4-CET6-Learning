package com.hao.topic.model.dto.topic;

import lombok.Data;

/**
 * 试卷管理：新建 / 修改试卷元信息
 */
@Data
public class PaperManageDto {
    private Long id;
    private Integer level;
    private Integer examYear;
    private Integer examHalf;
    private String title;
    private Long totalScore;
}
