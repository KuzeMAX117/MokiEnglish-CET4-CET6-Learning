package com.hao.topic.model.dto.topic;

import lombok.Data;

/**
 * 试卷管理：列表查询参数
 */
@Data
public class PaperManageQueryDto {
    private Integer pageNum;
    private Integer pageSize;
    private Integer level;
    private Integer status;
    private Integer examYear;
    private String title;
}
