package com.hao.topic.security.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class LoginTypeDto {
    
    @NotNull(message = "登录类型不能为空")
    private Integer loginType;
    private String account;
    @NotBlank(message = "登录密码不能为空")
    private String password;
    private String email;
}
