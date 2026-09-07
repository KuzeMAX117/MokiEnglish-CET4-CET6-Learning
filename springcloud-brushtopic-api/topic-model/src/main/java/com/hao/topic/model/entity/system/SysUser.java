package com.hao.topic.model.entity.system;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SysUser extends BaseEntity {
    private String account;
    private String avatar;
    private String password;
    private String email;
    private Integer status;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime memberTime;
    private String nickname;
}
