package com.hao.topic.system.content.controller;

import com.hao.topic.common.result.Result;
import com.hao.topic.model.dto.content.WordBookDto;
import com.hao.topic.model.dto.content.WordBookListDto;
import com.hao.topic.system.content.service.WordBookManageService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/system/content/wordbook")
@AllArgsConstructor
public class WordBookManageController {

    private final WordBookManageService wordBookManageService;

    @GetMapping("/list")
    @PreAuthorize("hasAuthority('admin')")
    public Result<Map<String, Object>> list(WordBookListDto dto) {
        return Result.success(wordBookManageService.wordBookList(dto));
    }

    @PostMapping("/add")
    @PreAuthorize("hasAuthority('admin')")
    public Result add(@RequestBody WordBookDto dto) {
        wordBookManageService.add(dto);
        return Result.success();
    }

    @PutMapping("/update")
    @PreAuthorize("hasAuthority('admin')")
    public Result update(@RequestBody WordBookDto dto) {
        wordBookManageService.update(dto);
        return Result.success();
    }

    @DeleteMapping("/delete/{ids}")
    @PreAuthorize("hasAuthority('admin')")
    public Result delete(@PathVariable Long[] ids) {
        wordBookManageService.delete(ids);
        return Result.success();
    }
}
