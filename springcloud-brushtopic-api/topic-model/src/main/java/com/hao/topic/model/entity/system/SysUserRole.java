package com.hao.topic.model.entity.system;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class SysUserRole extends BaseEntity {
    private Long userId;
    private Long roleId;
}
