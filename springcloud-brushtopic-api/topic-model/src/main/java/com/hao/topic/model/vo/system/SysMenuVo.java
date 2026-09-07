package com.hao.topic.model.vo.system;

import lombok.Data;

import java.util.List;

@Data
public class SysMenuVo {
    
    private String key;
    
    private String icon;
    
    private String label;
    
    private Long id;
    
    private List<SysMenuVo> children;
}
