package com.hao.topic.client.system;

import com.hao.topic.common.auth.TokenInterceptor;
import com.hao.topic.model.entity.system.SysMenu;
import com.hao.topic.model.entity.system.SysRole;
import com.hao.topic.model.entity.system.SysUser;
import com.hao.topic.model.vo.system.SysMenuVo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@FeignClient(name = "service-system", configuration = TokenInterceptor.class)
public interface SystemFeignClient {
    

    @GetMapping("/system/menu/userMenu/{roleId}")
    public List<SysMenuVo> userMenu(@PathVariable Long roleId);

    

    @GetMapping("/system/role/{id}")
    public SysRole getById(@PathVariable Long id);

    

    @GetMapping("/system/role/key/{role}")
    public SysRole getByRoleKey(@PathVariable String role);

}
