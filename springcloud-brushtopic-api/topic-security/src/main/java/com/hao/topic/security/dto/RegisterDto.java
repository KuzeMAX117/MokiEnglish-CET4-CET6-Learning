package com.hao.topic.security.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class RegisterDto {
    @NotBlank(message = "邮箱不能为空")
    private String email;
    @NotBlank(message = "账号不能为空")
    private String account;
    private String nickname;
    @NotBlank(message = "验证码不能为空")
    private String code;
    @NotBlank(message = "密码不能为空")
    private String password;
}
