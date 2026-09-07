package com.hao.topic.model.dto.system;

import com.hao.topic.model.entity.system.SysRole;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.NonNull;

import java.util.List;

@Data
public class SysRoleDto {
    
    private List<Long> menuIds;
    @NotBlank(message = "角色名称不能为空")
    private String name;
    @NotNull(message = "角色标识不能为空")
    private Integer identify;
    @NotBlank(message = "角色描述不能为空")
    private String remark;
    @NotBlank(message = "角色标识不能为空")
    private String roleKey;
    private Long id;
}
