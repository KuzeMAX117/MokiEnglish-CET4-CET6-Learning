package com.hao.topic.security.dto;

import lombok.Data;

@Data
public class UserDto {
    private String avatar;
    private Long id;
    private String password;
    private String newPassword;
    private String confirmPassword;
    private String nickname;
    private String email;
    private String code;
}
