package com.hao.topic.system.content.controller;

import com.hao.topic.common.result.Result;
import com.hao.topic.model.dto.content.ArticleDto;
import com.hao.topic.model.dto.content.ArticleListDto;
import com.hao.topic.system.content.service.ArticleService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/system/content/article")
@AllArgsConstructor
public class ArticleController {

    private final ArticleService articleService;

    @GetMapping("/list")
    @PreAuthorize("hasAuthority('admin')")
    public Result<Map<String, Object>> list(ArticleListDto dto) {
        return Result.success(articleService.articleList(dto));
    }

    @PostMapping("/add")
    @PreAuthorize("hasAuthority('admin')")
    public Result add(@RequestBody ArticleDto dto) {
        articleService.add(dto);
        return Result.success();
    }

    @PutMapping("/update")
    @PreAuthorize("hasAuthority('admin')")
    public Result update(@RequestBody ArticleDto dto) {
        articleService.update(dto);
        return Result.success();
    }

    @DeleteMapping("/delete/{ids}")
    @PreAuthorize("hasAuthority('admin')")
    public Result delete(@PathVariable Long[] ids) {
        articleService.delete(ids);
        return Result.success();
    }
}
