package com.hao.topic.topic.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hao.topic.common.result.Result;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.model.entity.topic.PkRecord;
import com.hao.topic.model.vo.topic.PkRankVo;
import com.hao.topic.topic.mapper.PkRecordMapper;
import com.hao.topic.topic.service.PkService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/topic/pk")
@AllArgsConstructor
public class PkController {

    private final PkService pkService;
    private final PkRecordMapper pkRecordMapper;

    @PostMapping("/match")
    public Result<Void> startMatch() {
        Long userId = SecurityUtils.getCurrentId();
        pkService.startMatch(userId);
        return Result.success();
    }

    @PostMapping("/cancel")
    public Result<Void> cancelMatch() {
        Long userId = SecurityUtils.getCurrentId();
        pkService.cancelMatch(userId);
        return Result.success();
    }

    @PostMapping("/answer")
    public Result<Map<String, Object>> submitAnswer(@RequestBody Map<String, Object> body) {
        Long userId = SecurityUtils.getCurrentId();
        String roomId = (String) body.get("roomId");
        int questionIndex = (int) body.get("questionIndex");
        String answer = (String) body.get("answer");
        Map<String, Object> result = pkService.submitAnswer(userId, roomId, questionIndex, answer);
        return Result.success(result);
    }

    @GetMapping("/rank/{type}")
    public Result<List<PkRankVo>> getRank(
            @PathVariable String type,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        List<PkRankVo> ranks = pkService.getRank(type, page, size);
        return Result.success(ranks);
    }

    @GetMapping("/stats")
    public Result<Map<String, Object>> getMyPkStats() {
        Long userId = SecurityUtils.getCurrentId();
        Map<String, Object> stats = pkService.getMyPkStats(userId);
        return Result.success(stats);
    }

    @PostMapping("/warmup/answer")
    public Result<Map<String, Object>> submitWarmUp(@RequestBody Map<String, Object> body) {
        Long userId = SecurityUtils.getCurrentId();
        String roomId = (String) body.get("roomId");
        int questionIndex = (int) body.get("questionIndex");
        String answer = (String) body.get("answer");
        Map<String, Object> result = pkService.submitWarmUp(userId, roomId, questionIndex, answer);
        return Result.success(result);
    }

    @GetMapping("/level")
    public Result<Map<String, Object>> getUserLevel() {
        Long userId = SecurityUtils.getCurrentId();
        int level = pkService.getUserLevel(userId);
        Map<String, Object> result = new java.util.HashMap<>();
        result.put("level", level);
        result.put("levelName", switch (level) {
            case 1 -> "Lv1 初学者";
            case 2 -> "Lv2 进阶者";
            case 3 -> "Lv3 挑战者";
            case 4 -> "Lv4 大师";
            default -> "Lv1 初学者";
        });
        return Result.success(result);
    }

    @GetMapping("/records")
    public Result<Map<String, Object>> getRecords(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword) {
        LambdaQueryWrapper<PkRecord> wrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.like(PkRecord::getRoomId, keyword);
        }
        wrapper.orderByDesc(PkRecord::getEndTime);
        
        long total = pkRecordMapper.selectCount(wrapper);
        long start = (long) (page - 1) * size;
        List<PkRecord> records = pkRecordMapper.selectList(wrapper.last("LIMIT " + start + ", " + size));
        
        Map<String, Object> result = new HashMap<>();
        result.put("records", records);
        result.put("total", total);
        return Result.success(result);
    }
}
