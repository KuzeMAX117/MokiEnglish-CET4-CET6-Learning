package com.hao.topic.topic.controller;

import com.hao.topic.common.result.Result;
import com.hao.topic.model.vo.ai.AiTrendVo;
import com.hao.topic.model.vo.system.SysUserTrentVo;
import com.hao.topic.model.vo.topic.*;
import com.hao.topic.topic.mapper.TopicRecordMapper;
import com.hao.topic.topic.service.TopicDataService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/topic/data")
@AllArgsConstructor
public class TopicDataController {
    private final TopicDataService topicDataService;

    

    @GetMapping("/webHomeCount")
    public Result webTopicCount() {
        Map<String, Object> map = topicDataService.webHomeCount();
        return Result.success(map);
    }

    

    @GetMapping("/rank")
    public Result<List<TopicUserRankVo>> rank() {
        List<TopicUserRankVo> topicUserRankVos = topicDataService.rank();
        return Result.success(topicUserRankVos);
    }

    

    @GetMapping("/userRank")
    public Result<TopicUserRankVo> userRank() {
        TopicUserRankVo topicUserRankVo = topicDataService.userRank();
        return Result.success(topicUserRankVo);
    }

    

    @GetMapping("/topicTodayVo")
    public Result<List<TopicTodayVo>> topicTodayVo() {
        List<TopicTodayVo> list = topicDataService.topicTodayVo();
        return Result.success(list);
    }

    

    @GetMapping("/adminHomeCount")
    public Result<Map<String, Object>> adminHomeData() {
        Map<String, Object> map = topicDataService.adminHomeCount();
        return Result.success(map);
    }

    

    @GetMapping("/adminHomeCategory")
    public Result<List<TopicCategoryDataVo>> adminHomeCategory() {
        List<TopicCategoryDataVo> list = topicDataService.adminHomeCategory();
        return Result.success(list);
    }

    

    @GetMapping("/topicTrend")
    public Result<TopicTrendVo> topicTrend() {
        TopicTrendVo topicTrend = topicDataService.topicTrend();
        return Result.success(topicTrend);
    }

    

    @GetMapping("/userTrend")
    public Result<SysUserTrentVo> userTrend() {
        SysUserTrentVo SysUserTrentVo = topicDataService.userTrend();
        return Result.success(SysUserTrentVo);
    }

    

    @GetMapping("/aiTrend")
    public Result<AiTrendVo> aiTrend() {
        AiTrendVo aiTrendVo = topicDataService.aiTrend();
        return Result.success(aiTrendVo);
    }

    

    @GetMapping("/userHomeCount")
    public Result<Map<String, Object>> userHomeData() {
        Map<String, Object> map = topicDataService.userHomeData();
        return Result.success(map);
    }

    

    @GetMapping("/userHomeCategory")
    public Result<List<TopicCategoryUserDataVo>> userHomeCategory() {
        List<TopicCategoryUserDataVo> list = topicDataService.userHomeCategory();
        return Result.success(list);
    }

    

    @GetMapping("/userTopicCount/{date}")
    public Result<List<TopicDataVo>> userTopicDateCount(@PathVariable String date) {
        List<TopicDataVo> list = topicDataService.userTopicDateCount(date);
        return Result.success(list);
    }

    

    @GetMapping("/flush/{id}")
    public Result flushTopic(@PathVariable Long id) {
         topicDataService.flushTopic(id);
        return Result.success();
    }
}
