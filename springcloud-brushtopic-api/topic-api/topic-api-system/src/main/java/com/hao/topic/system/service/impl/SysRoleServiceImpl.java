package com.hao.topic.system.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hao.topic.client.security.SecurityFeignClient;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.model.dto.system.SysRoleDto;
import com.hao.topic.model.entity.system.SysRole;
import com.hao.topic.model.entity.system.SysRoleMenu;
import com.hao.topic.model.entity.system.SysUserRole;
import com.hao.topic.model.vo.system.SysMenuVo;
import com.hao.topic.security.mapper.SysUserRoleMapper;
import com.hao.topic.system.mapper.SysRoleMapper;
import com.hao.topic.system.mapper.SysRoleMenuMapper;
import com.hao.topic.system.service.SysMenuService;
import com.hao.topic.system.service.SysRoleService;
import lombok.AllArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRole> implements SysRoleService {
    private final SysMenuService service;
    private final SysRoleMenuMapper sysRoleMenuMapper;
    private final SecurityFeignClient securityFeignClient;
    private final SysRoleMapper sysRoleMapper;

    

    public Map<String, Object> roleList(SysRole sysRole) {
        
        Page<SysRole> sysRolePage = new Page<>(sysRole.getPageNum(), sysRole.getPageSize());
        LambdaQueryWrapper<SysRole> sysRoleLambdaQueryWrapper = new LambdaQueryWrapper<>();
        
        if (sysRole.getName() != null) {
            sysRoleLambdaQueryWrapper.like(SysRole::getName, sysRole.getName());
        }
        
        Page<SysRole> sysRolePageResult = baseMapper.selectPage(sysRolePage, sysRoleLambdaQueryWrapper);

        
        return Map.of(
                "total", sysRolePageResult.getTotal(),
                "rows", sysRolePageResult.getRecords()
        );
    }

    

    public void add(SysRoleDto sysRoleDto) {
        
        SysRole sysRole = new SysRole();
        BeanUtils.copyProperties(sysRoleDto, sysRole);
        baseMapper.insert(sysRole);
        
        if (sysRoleDto.getMenuIds() != null && sysRoleDto.getMenuIds().size() > 0) {
            
            List<SysRoleMenu> list = sysRoleDto.getMenuIds().stream().map(id -> {
                SysRoleMenu sysRoleMenu = new SysRoleMenu();
                sysRoleMenu.setRoleId(sysRole.getId());
                sysRoleMenu.setMenuId(id);
                return sysRoleMenu;
            }).toList();
            
            for (SysRoleMenu sysRoleMenu : list) {
                sysRoleMenuMapper.insert(sysRoleMenu);
            }
        }
    }

    

    public void update(SysRoleDto sysRole) {
        SysRole sysRoleDb = baseMapper.selectById(sysRole.getId());
        if (sysRoleDb == null) {
            throw new TopicException(ResultCodeEnum.ROLE_NOT_EXIST);
        }
        BeanUtils.copyProperties(sysRole, sysRoleDb);
        
        baseMapper.updateById(sysRoleDb);
        
        LambdaQueryWrapper<SysRoleMenu> sysRoleMenuLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysRoleMenuLambdaQueryWrapper.eq(SysRoleMenu::getRoleId, sysRole.getId());
        sysRoleMenuMapper.delete(sysRoleMenuLambdaQueryWrapper);
        
        if (!CollectionUtils.isEmpty(sysRole.getMenuIds())) {
            
            for (Long menuId : sysRole.getMenuIds()) {
                SysRoleMenu sysRoleMenu = new SysRoleMenu();
                sysRoleMenu.setRoleId(sysRole.getId());
                sysRoleMenu.setMenuId(menuId);
                sysRoleMenuMapper.insert(sysRoleMenu);
            }
        }
    }

    

    public void delete(Long roleId) {
        
        if (roleId == null) {
            throw new TopicException(ResultCodeEnum.DEL_ROLE_ERROR);
        }
        
        Boolean byRoleId = securityFeignClient.getByRoleId(roleId);
        if (!byRoleId) {
            throw new TopicException(ResultCodeEnum.ROLE_USER_ERROR);
        }
        
        LambdaQueryWrapper<SysRoleMenu> sysRoleMenuLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysRoleMenuLambdaQueryWrapper.eq(SysRoleMenu::getRoleId, roleId);
        sysRoleMenuMapper.delete(sysRoleMenuLambdaQueryWrapper);
        
        baseMapper.deleteById(roleId);
    }

    

    public List<SysMenuVo> getRoleMenu(Long roleId) {
        
        if (roleId == null) {
            return null;
        }
        try {
            
            return service.getUserMenu(roleId);
        } catch (Exception e) {
            return null;
        }
    }

    

    public SysRole getRoleKey(String roleKey) {
        LambdaQueryWrapper<SysRole> sysRoleLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysRoleLambdaQueryWrapper.eq(SysRole::getRoleKey, roleKey);
        SysRole sysRole = sysRoleMapper.selectOne(sysRoleLambdaQueryWrapper);
        if (sysRole == null) {
            return null;
        }
        return sysRole;
    }
}
