package com.hao.topic.system.content.controller;

import com.hao.topic.common.result.Result;
import com.hao.topic.model.dto.content.EssayDto;
import com.hao.topic.model.dto.content.EssayListDto;
import com.hao.topic.system.content.service.EssayService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/system/content/essay")
@AllArgsConstructor
public class EssayController {

    private final EssayService essayService;

    @GetMapping("/list")
    @PreAuthorize("hasAuthority('admin')")
    public Result<Map<String, Object>> list(EssayListDto dto) {
        return Result.success(essayService.essayList(dto));
    }

    @PostMapping("/add")
    @PreAuthorize("hasAuthority('admin')")
    public Result add(@RequestBody EssayDto dto) {
        essayService.add(dto);
        return Result.success();
    }

    @PutMapping("/update")
    @PreAuthorize("hasAuthority('admin')")
    public Result update(@RequestBody EssayDto dto) {
        essayService.update(dto);
        return Result.success();
    }

    @DeleteMapping("/delete/{ids}")
    @PreAuthorize("hasAuthority('admin')")
    public Result delete(@PathVariable Long[] ids) {
        essayService.delete(ids);
        return Result.success();
    }
}
