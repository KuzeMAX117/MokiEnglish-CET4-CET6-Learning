package com.hao.topic.model.vo.system;

import lombok.Data;

@Data
public class SysNoticeVo {
    private Long id;
    private String account;
    private Integer status;
    private String content;
    
    private String timeDesc;
}
