package com.hao.topic.system.service;

import com.hao.topic.model.entity.system.SysMenu;
import com.hao.topic.model.vo.system.SysMenuListVo;
import com.hao.topic.model.vo.system.SysMenuVo;

import java.util.List;
import java.util.Map;

public interface SysMenuService {
    List<SysMenuVo> getUserMenu(Long roleId);

    List<SysMenuListVo> menuList(SysMenu sysMenu);

    void add(SysMenu sysMenu);

    void update(SysMenu sysMenu);

    void delete(Long id);
}
