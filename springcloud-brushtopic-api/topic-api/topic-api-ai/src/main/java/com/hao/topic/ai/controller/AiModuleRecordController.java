package com.hao.topic.ai.controller;

import com.hao.topic.ai.service.AiModuleRecordService;
import com.hao.topic.common.result.Result;
import com.hao.topic.model.vo.topic.TopicDataVo;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/ai/module")
@AllArgsConstructor
public class AiModuleRecordController {
    
    private final AiModuleRecordService aiModuleRecordService;
    
    @GetMapping("/count/{moduleType}/{date}")
    public Result<Long> countModuleByDate(@PathVariable String moduleType, @PathVariable String date) {
        Long count = aiModuleRecordService.countModuleUsage(moduleType, date);
        return Result.success(count);
    }
    
    @GetMapping("/count/{moduleType}")
    public Result<Long> countModuleTotal(@PathVariable String moduleType) {
        Long count = aiModuleRecordService.countModuleUsage(moduleType, null);
        return Result.success(count);
    }
    
    @GetMapping("/trend/{moduleType}")
    public Result<List<TopicDataVo>> countModuleTrend(@PathVariable String moduleType) {
        List<TopicDataVo> trend = aiModuleRecordService.countModuleTrend7Days(moduleType);
        return Result.success(trend);
    }
    
    @GetMapping("/count/user/{moduleType}")
    public Result<Long> countModuleByUser(@PathVariable String moduleType) {
        // 从SecurityUtils获取当前用户ID，这里简化处理
        Long userId = 1L; // 实际应该从SecurityUtils.getCurrentId()获取
        Long count = aiModuleRecordService.countModuleUsageByUser(userId, moduleType);
        return Result.success(count);
    }
    
    @GetMapping("/count/all/{date}")
    public Result<List<Map<String, Object>>> countAllModulesByDate(@PathVariable String date) {
        List<Map<String, Object>> result = aiModuleRecordService.countAllModulesByDate(date);
        return Result.success(result);
    }
    
    @GetMapping("/trend/all")
    public Result<List<Map<String, Object>>> countAllModulesTrend() {
        List<Map<String, Object>> result = aiModuleRecordService.countAllModulesTrend(7);
        return Result.success(result);
    }
    
    @GetMapping("/count/business/{businessId}/{businessType}")
    public Result<Long> countBusinessUsage(@PathVariable Long businessId, @PathVariable String businessType) {
        Long count = aiModuleRecordService.countBusinessUsage(businessId, businessType);
        return Result.success(count);
    }
}