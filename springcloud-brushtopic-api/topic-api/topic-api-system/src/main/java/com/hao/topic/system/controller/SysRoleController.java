package com.hao.topic.system.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hao.topic.client.security.SecurityFeignClient;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.result.Result;
import com.hao.topic.model.dto.system.SysRoleDto;
import com.hao.topic.model.entity.system.SysMenu;
import com.hao.topic.model.entity.system.SysRole;
import com.hao.topic.model.vo.system.SysMenuListVo;
import com.hao.topic.model.vo.system.SysMenuVo;
import com.hao.topic.system.mapper.SysRoleMapper;
import com.hao.topic.system.service.SysRoleService;
import jakarta.annotation.Resource;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/system/role")
public class SysRoleController {

    @Autowired
    private SysRoleService sysRoleService;

    

    @GetMapping("/list")
    @PreAuthorize("hasAuthority('admin')")
    public Result<Map<String, Object>> list(SysRole sysRole) {
        Map<String, Object> map = sysRoleService.roleList(sysRole);
        return Result.success(map);
    }

    

    @PostMapping("/add")
    @PreAuthorize("hasAuthority('admin')")
    public Result add(@RequestBody @Validated SysRoleDto sysRoleDto) {
        sysRoleService.add(sysRoleDto);
        return Result.success();
    }

    

    @PutMapping("/update")
    @PreAuthorize("hasAuthority('admin')")
    public Result update(@RequestBody @Validated SysRoleDto sysRoleDto) {
        sysRoleService.update(sysRoleDto);
        return Result.success();
    }

    

    @DeleteMapping("/delete/{id}")
    @PreAuthorize("hasAuthority('admin')")
    public Result delete(@PathVariable Long id) {
        sysRoleService.delete(id);
        return Result.success();
    }

    

    @GetMapping("/{id}")
    public SysRole getById(@PathVariable Long id) {
        return sysRoleService.getById(id);
    }

    

    @GetMapping("/key/{role}")
    public SysRole getByRoleKey(@PathVariable String role) {
        return sysRoleService.getRoleKey(role);
    }

    

    @GetMapping("/menu/{roleId}")
    @PreAuthorize("hasAuthority('admin')")
    public Result<List<SysMenuVo>> getRoleMenu(@PathVariable Long roleId) {
        List<SysMenuVo> sysMenuVoList = sysRoleService.getRoleMenu(roleId);
        return Result.success(sysMenuVoList);
    }

    

    @GetMapping("/identify/{identify}")
    public SysRole getByRoleIdentify(@PathVariable Long identify) {
        LambdaQueryWrapper<SysRole> sysRoleLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysRoleLambdaQueryWrapper.eq(SysRole::getIdentify, identify);
        return sysRoleService.getOne(sysRoleLambdaQueryWrapper);
    }
}
