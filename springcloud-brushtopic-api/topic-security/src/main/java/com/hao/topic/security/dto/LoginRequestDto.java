package com.hao.topic.security.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class LoginRequestDto {
    @NotBlank(message = "账户不能为空")
    private String username;
    @NotBlank(message = "账户密码不能为空")
    private String password;
    @NotBlank(message = "验证码不能为空")
    private String code;
    private Boolean remember;
}
