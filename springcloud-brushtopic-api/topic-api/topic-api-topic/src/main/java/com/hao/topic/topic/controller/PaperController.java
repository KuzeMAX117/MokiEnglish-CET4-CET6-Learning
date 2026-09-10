package com.hao.topic.topic.controller;

import com.hao.topic.common.result.Result;
import com.hao.topic.model.dto.topic.PaperAnswerDto;
import com.hao.topic.model.vo.topic.PaperAnswerVo;
import com.hao.topic.model.vo.topic.PaperDetailVo;
import com.hao.topic.model.vo.topic.PaperProgressVo;
import com.hao.topic.model.vo.topic.PaperVo;
import com.hao.topic.topic.service.PaperService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/topic/paper")
@AllArgsConstructor
public class PaperController {

    private final PaperService paperService;

    

    @GetMapping("/list")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member') || hasAuthority('user')")
    public Result<List<PaperVo>> list(@RequestParam Integer level) {
        return Result.success(paperService.paperList(level));
    }

    

    @GetMapping("/detail/{id}")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member') || hasAuthority('user')")
    public Result<PaperDetailVo> detail(@PathVariable Long id) {
        return Result.success(paperService.paperDetail(id));
    }

    

    @PostMapping("/answer")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member') || hasAuthority('user')")
    public Result<PaperAnswerVo> answer(@RequestBody PaperAnswerDto paperAnswerDto) {
        return Result.success(paperService.answer(paperAnswerDto));
    }

    

    @GetMapping("/progress/{paperId}")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member') || hasAuthority('user')")
    public Result<List<PaperProgressVo>> progress(@PathVariable Long paperId) {
        return Result.success(paperService.progress(paperId));
    }

    

    @PostMapping("/reset/{paperId}")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member') || hasAuthority('user')")
    public Result<Boolean> reset(@PathVariable Long paperId) {
        paperService.resetProgress(paperId);
        return Result.success(true);
    }
}
