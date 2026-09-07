package com.hao.topic.model.entity.system;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class SysMenu extends BaseEntity {
    private String menuName;
    private Integer sorted;
    private String route;
    private String icon;
    private Long parentId;
}
