package com.hao.topic.system.controller;

import com.hao.topic.common.result.Result;
import com.hao.topic.model.dto.system.SysNoticeDto;
import com.hao.topic.model.dto.system.SysNoticeReadDto;
import com.hao.topic.model.vo.system.SysNoticeVo;
import com.hao.topic.system.service.SysNoticeService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/system/notice")
@AllArgsConstructor
public class SysNoticeController {

    private final SysNoticeService sysNoticeService;

    

    @PostMapping("/record")
    public Result recordNotice(@RequestBody SysNoticeDto sysNoticeDto) {
        sysNoticeService.recordNotice(sysNoticeDto);
        return Result.success();
    }

    

    @GetMapping("/list")
    public Result list() {
        List<SysNoticeVo> sysNoticeVos = sysNoticeService.list();
        return Result.success(sysNoticeVos);
    }

    

    @GetMapping("/has")
    public Result has() {
        Boolean isHas = sysNoticeService.has();
        return Result.success(isHas);
    }

    

    @PutMapping("/read")
    public Result read(@RequestBody SysNoticeReadDto sysNoticeReadDto) {
        sysNoticeService.read(sysNoticeReadDto);
        return Result.success();
    }

    

    @PutMapping("/clear")
    public Result clearNotice() {
        sysNoticeService.clearNotice();
        return Result.success();
    }

}
