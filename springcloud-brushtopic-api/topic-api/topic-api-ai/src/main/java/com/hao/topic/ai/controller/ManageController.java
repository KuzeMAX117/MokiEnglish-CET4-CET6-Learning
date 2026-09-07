package com.hao.topic.ai.controller;

import com.hao.topic.ai.service.ManageService;
import com.hao.topic.common.result.Result;
import com.hao.topic.model.dto.ai.AiUserDto;
import com.hao.topic.model.dto.system.SysRoleDto;
import com.hao.topic.model.dto.system.SysUserListDto;
import com.hao.topic.model.entity.ai.AiUser;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/ai/manage")
@AllArgsConstructor
public class ManageController {

    private final ManageService manageService;

    

    @GetMapping("/list")
    @PreAuthorize("hasAuthority('admin')")
    public Result<Map<String, Object>> list(AiUserDto aiUserDto) {
        return Result.success(manageService.list(aiUserDto));
    }

    

    @PutMapping("/update")
    @PreAuthorize("hasAuthority('admin')")
    public Result update(@RequestBody AiUser aiUser) {
        manageService.update(aiUser);
        return Result.success();
    }

}
