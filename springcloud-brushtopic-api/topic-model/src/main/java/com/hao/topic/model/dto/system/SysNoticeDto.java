package com.hao.topic.model.dto.system;

import lombok.Data;

@Data
public class SysNoticeDto {
    private String content;
    private Integer status;
    private Long recipientsId;
}
