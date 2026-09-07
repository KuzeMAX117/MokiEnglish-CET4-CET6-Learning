package com.hao.topic.model.dto.ai;

import lombok.Data;

@Data
public class AiHistoryDto {
    private Long id;
    private String title;
    private Integer pageNum;
    private Integer pageSize;
    private String mode;

}
