package com.hao.topic.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.model.entity.system.SysMenu;
import com.hao.topic.model.entity.system.SysRoleMenu;
import com.hao.topic.model.vo.system.SysMenuListVo;
import com.hao.topic.model.vo.system.SysMenuVo;
import com.hao.topic.system.mapper.SysMenuMapper;
import com.hao.topic.system.mapper.SysRoleMenuMapper;
import com.hao.topic.system.service.SysMenuService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.*;

@Service
@AllArgsConstructor
@Slf4j
public class SysMenuServiceImpl extends ServiceImpl<SysMenuMapper, SysMenu> implements SysMenuService {

    private final SysRoleMenuMapper sysRoleMenuMapper;
    private final SysMenuMapper sysMenuMapper;

    

    public List<SysMenuVo> getUserMenu(Long roleId) {
        if (roleId == null) {
            throw new TopicException(ResultCodeEnum.NO_ROLE_FAIL);
        }
        LambdaQueryWrapper<SysRoleMenu> sysRoleMenuLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysRoleMenuLambdaQueryWrapper.eq(SysRoleMenu::getRoleId, roleId);
        List<SysRoleMenu> sysRoleMenus = sysRoleMenuMapper.selectList(sysRoleMenuLambdaQueryWrapper);
        if (CollectionUtils.isEmpty(sysRoleMenus)) {
            throw new TopicException(ResultCodeEnum.NO_ROLE_FAIL);
        }
        
        List<Long> menuIdList = sysRoleMenus.stream().map(SysRoleMenu::getMenuId).toList();
        if (CollectionUtils.isEmpty(menuIdList)) {
            throw new TopicException(ResultCodeEnum.NO_MENU_FAIL);
        }
        
        List<SysMenu> sysMenus = sysMenuMapper.selectBatchIds(menuIdList);
        if (CollectionUtils.isEmpty(sysMenus)) {
            throw new TopicException(ResultCodeEnum.NO_MENU_FAIL);
        }
        
        sysMenus.sort(Comparator.comparing(SysMenu::getSorted));
        
        List<SysMenuVo> sysMenuVoList = new ArrayList<>();
        for (SysMenu sysMenu : sysMenus) {
            
            if (sysMenu.getParentId() == 0) {
                SysMenuVo sysMenuVo = new SysMenuVo();
                sysMenuVo.setKey(sysMenu.getRoute());
                sysMenuVo.setIcon(sysMenu.getIcon());
                sysMenuVo.setLabel(sysMenu.getMenuName());
                sysMenuVo.setId(sysMenu.getId());
                
                sysMenuVo.setChildren(getMenuChildren(sysMenu, sysMenus));
                sysMenuVoList.add(sysMenuVo);
            }
        }
        
        for (SysMenu sysMenuDb : sysMenus) {
            boolean hasParent = sysMenus.stream()
                    .anyMatch(menu -> menu.getId().equals(sysMenuDb.getParentId()));
            if (!hasParent && sysMenuDb.getParentId() != 0) {
                
                SysMenuVo sysMenuVo = new SysMenuVo();
                sysMenuVo.setKey(sysMenuDb.getRoute());
                sysMenuVo.setIcon(sysMenuDb.getIcon());
                sysMenuVo.setLabel(sysMenuDb.getMenuName());
                sysMenuVo.setId(sysMenuDb.getId());
                sysMenuVoList.add(sysMenuVo);
            }
        }
        log.info("菜单信息：{}", sysMenuVoList.toArray());
        
        return sysMenuVoList;
    }

    

    public List<SysMenuListVo> menuList(SysMenu sysMenu) {
        
        LambdaQueryWrapper<SysMenu> sysMenuLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysMenuLambdaQueryWrapper.orderByAsc(SysMenu::getSorted);
        
        if (sysMenu.getMenuName() != null) {
            sysMenuLambdaQueryWrapper.like(SysMenu::getMenuName, sysMenu.getMenuName());
        }
        
        List<SysMenu> sysMenus = sysMenuMapper.selectList(sysMenuLambdaQueryWrapper);
        
        if (CollectionUtils.isEmpty(sysMenus)) {
            return new ArrayList<>();
        }
        
        List<SysMenuListVo> sysMenuListVos = new ArrayList<>();
        
        for (SysMenu sysMenuDb : sysMenus) {
            if (sysMenuDb.getParentId() == 0) {
                
                SysMenuListVo sysMenuVo = new SysMenuListVo();
                BeanUtils.copyProperties(sysMenuDb, sysMenuVo);
                
                if (sysMenu.getMenuName() != null) {
                    LambdaQueryWrapper<SysMenu> sysMenuLambdaQuery = new LambdaQueryWrapper<>();
                    sysMenuLambdaQuery.eq(SysMenu::getParentId, sysMenuDb.getId());
                    List<SysMenu> sysMenuChildren = sysMenuMapper.selectList(sysMenuLambdaQuery);
                    
                    sysMenuVo.setChildren(getMenuListChildren(sysMenuVo, sysMenuChildren));
                } else {
                    
                    sysMenuVo.setChildren(getMenuListChildren(sysMenuVo, sysMenus));
                }
                sysMenuListVos.add(sysMenuVo);
            }
        }
        
        for (SysMenu sysMenuDb : sysMenus) {
            boolean hasParent = sysMenus.stream()
                    .anyMatch(menu -> menu.getId().equals(sysMenuDb.getParentId()));
            if (!hasParent && sysMenuDb.getParentId() != 0) {
                
                SysMenuListVo sysMenuVo = new SysMenuListVo();
                BeanUtils.copyProperties(sysMenuDb, sysMenuVo);
                sysMenuListVos.add(sysMenuVo);
            }
        }
        return sysMenuListVos;
    }

    

    public void add(SysMenu sysMenu) {
        sysMenuMapper.insert(sysMenu);
    }

    

    public void update(SysMenu sysMenu) {
        
        if (sysMenu.getId() == null) {
            throw new TopicException(ResultCodeEnum.MENU_ID_NOT_EXIST);
        }
        
        SysMenu sysMenuDb = sysMenuMapper.selectById(sysMenu.getId());
        if (sysMenuDb == null) {
            throw new TopicException(ResultCodeEnum.MENU_ID_NOT_EXIST);
        }
        sysMenuMapper.updateById(sysMenu);
    }

    

    public void delete(Long id) {
        
        SysMenu sysMenu = sysMenuMapper.selectById(id);
        if (sysMenu == null) {
            throw new TopicException(ResultCodeEnum.MENU_ID_NOT_EXIST);
        }
        
        LambdaQueryWrapper<SysMenu> sysMenuLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysMenuLambdaQueryWrapper.eq(SysMenu::getParentId, id);
        if (sysMenuMapper.selectCount(sysMenuLambdaQueryWrapper) > 0) {
            throw new TopicException(ResultCodeEnum.MENU_HAS_CHILDREN);
        }
        sysMenuMapper.deleteById(id);
    }

    

    private List<SysMenuListVo> getMenuListChildren(SysMenuListVo sysMenuVo, List<SysMenu> records) {
        List<SysMenuListVo> children = records.stream()
                .filter(menu -> menu.getParentId().equals(sysMenuVo.getId()))
                .sorted(Comparator.comparingInt(SysMenu::getSorted))
                .map(item -> {
                    SysMenuListVo sysMenuListVo = new SysMenuListVo();
                    BeanUtils.copyProperties(item, sysMenuListVo);
                    sysMenuListVo.setChildren(getMenuListChildren(sysMenuListVo, records));
                    return sysMenuListVo;
                }).toList();
        
        return children.isEmpty() ? null : children;
    }

    

    private List<SysMenuVo> getMenuChildren(SysMenu sysMenu, List<SysMenu> sysMenus) {
        
        List<SysMenuVo> children = sysMenus.stream()
                .filter(menu1 -> menu1.getParentId().equals(sysMenu.getId()))
                .sorted(Comparator.comparingInt(SysMenu::getSorted)) 
                .map(item -> {
                    SysMenuVo sysMenuVo = new SysMenuVo();
                    sysMenuVo.setKey(item.getRoute());
                    sysMenuVo.setIcon(item.getIcon());
                    sysMenuVo.setLabel(item.getMenuName());
                    sysMenuVo.setId(item.getId());
                    sysMenuVo.setChildren(getMenuChildren(item, sysMenus));
                    return sysMenuVo;
                }).toList();
        
        return children.isEmpty() ? null : children;
    }

}
