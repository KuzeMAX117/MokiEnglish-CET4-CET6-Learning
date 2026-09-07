package com.hao.topic.model.vo.system;

import com.hao.topic.model.entity.system.SysMenu;
import lombok.Data;

import java.util.List;

@Data
public class UserInfoVo {
    private String account;
    private String nickname;
    private String avatar;
    private Integer identity;
    private Long id;
    
    private List<SysMenuVo> menuList;
}
