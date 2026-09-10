package com.hao.topic.topic.controller;

import com.hao.topic.common.result.Result;
import com.hao.topic.model.dto.topic.PaperManageDto;
import com.hao.topic.model.dto.topic.PaperManageQueryDto;
import com.hao.topic.model.dto.topic.PaperParseDto;
import com.hao.topic.model.dto.topic.PaperSectionSaveDto;
import com.hao.topic.model.vo.topic.PaperManageDetailVo;
import com.hao.topic.model.vo.topic.PaperParseResultVo;
import com.hao.topic.topic.service.PaperManageService;
import com.hao.topic.topic.service.PaperParseService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

/**
 * 试卷管理（后台）
 */
@RestController
@RequestMapping("/topic/paper/manage")
@AllArgsConstructor
public class PaperManageController {

    private final PaperManageService paperManageService;
    private final PaperParseService paperParseService;

    @GetMapping("/list")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result<Map<String, Object>> list(PaperManageQueryDto query) {
        return Result.success(paperManageService.paperManageList(query));
    }

    @PostMapping("/add")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result<Long> add(@RequestBody PaperManageDto dto) {
        return Result.success(paperManageService.add(dto));
    }

    @PutMapping("/update")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result update(@RequestBody PaperManageDto dto) {
        paperManageService.update(dto);
        return Result.success();
    }

    @DeleteMapping("/delete/{ids}")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result delete(@PathVariable Long[] ids) {
        paperManageService.delete(ids);
        return Result.success();
    }

    @GetMapping("/detail/{id}")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result<PaperManageDetailVo> detail(@PathVariable Long id) {
        return Result.success(paperManageService.detail(id));
    }

    @PostMapping("/section/save")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result<Map<String, Object>> saveSection(@RequestBody PaperSectionSaveDto dto) {
        return Result.success(paperManageService.saveSection(dto));
    }

    @PostMapping("/publish/{id}")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result<Map<String, Object>> publish(@PathVariable Long id) {
        return Result.success(paperManageService.publish(id));
    }

    @PostMapping("/unpublish/{id}")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result unpublish(@PathVariable Long id) {
        paperManageService.unpublish(id);
        return Result.success();
    }

    @PostMapping("/parse/text")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result<PaperParseResultVo> parseText(@RequestBody PaperParseDto dto) {
        return Result.success(paperParseService.parseText(dto));
    }

    @PostMapping("/parse/docx")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result<PaperParseResultVo> parseDocx(@RequestParam("file") MultipartFile file,
                                                @RequestParam(value = "section", required = false) String section,
                                                @RequestParam(value = "paperId", required = false) Long paperId) {
        return Result.success(paperParseService.parseDocx(file, section, paperId));
    }
}
