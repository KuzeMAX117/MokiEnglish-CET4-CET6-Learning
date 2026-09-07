package com.hao.topic.model.dto.system;

import com.hao.topic.model.entity.system.SysUser;
import lombok.Data;

@Data
public class SysUserDto extends SysUser {
    private String roleName;
    private Long roleId;
}
