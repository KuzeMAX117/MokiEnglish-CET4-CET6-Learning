package com.hao.topic.system.controller;

import com.hao.topic.common.result.Result;
import com.hao.topic.model.entity.system.SysMenu;
import com.hao.topic.model.vo.system.SysMenuListVo;
import com.hao.topic.model.vo.system.SysMenuVo;
import com.hao.topic.system.service.SysMenuService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/system/menu")
@AllArgsConstructor
public class SysMenuController {
    private final SysMenuService sysMenuService;

    

    @GetMapping("/list")
    @PreAuthorize("hasAuthority('admin')")
    public Result<List<SysMenuListVo>> list(SysMenu sysMenu) {
        List<SysMenuListVo> sysMenuListVoList = sysMenuService.menuList(sysMenu);
        return Result.success(sysMenuListVoList);
    }

    

    @PostMapping("/add")
    @PreAuthorize("hasAuthority('admin')")
    public Result add(@RequestBody SysMenu sysMenu) {
        sysMenuService.add(sysMenu);
        return Result.success();
    }

    

    @PutMapping("/update")
    @PreAuthorize("hasAuthority('admin')")
    public Result update(@RequestBody SysMenu sysMenu) {
        sysMenuService.update(sysMenu);
        return Result.success();
    }

    

    @DeleteMapping("/delete/{id}")
    @PreAuthorize("hasAuthority('admin')")
    public Result delete(@PathVariable Long id) {
        sysMenuService.delete(id);
        return Result.success();
    }

    

    @GetMapping("userMenu/{roleId}")
    public List<SysMenuVo> userMenu(@PathVariable Long roleId) {
        return sysMenuService.getUserMenu(roleId);
    }

}
