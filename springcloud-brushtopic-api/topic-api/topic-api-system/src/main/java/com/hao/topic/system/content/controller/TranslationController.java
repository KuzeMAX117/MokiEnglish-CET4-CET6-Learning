package com.hao.topic.system.content.controller;

import com.hao.topic.common.result.Result;
import com.hao.topic.model.dto.content.TranslationDto;
import com.hao.topic.model.dto.content.TranslationListDto;
import com.hao.topic.system.content.service.TranslationService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/system/content/translation")
@AllArgsConstructor
public class TranslationController {

    private final TranslationService translationService;

    @GetMapping("/list")
    @PreAuthorize("hasAuthority('admin')")
    public Result<Map<String, Object>> list(TranslationListDto dto) {
        return Result.success(translationService.translationList(dto));
    }

    @PostMapping("/add")
    @PreAuthorize("hasAuthority('admin')")
    public Result add(@RequestBody TranslationDto dto) {
        translationService.add(dto);
        return Result.success();
    }

    @PutMapping("/update")
    @PreAuthorize("hasAuthority('admin')")
    public Result update(@RequestBody TranslationDto dto) {
        translationService.update(dto);
        return Result.success();
    }

    @DeleteMapping("/delete/{ids}")
    @PreAuthorize("hasAuthority('admin')")
    public Result delete(@PathVariable Long[] ids) {
        translationService.delete(ids);
        return Result.success();
    }
}
