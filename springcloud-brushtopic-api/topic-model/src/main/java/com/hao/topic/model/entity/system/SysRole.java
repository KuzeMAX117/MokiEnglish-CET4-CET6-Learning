package com.hao.topic.model.entity.system;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class SysRole extends BaseEntity {
    private String name;
    private Integer identify;
    private String remark;
    private String roleKey;
}
