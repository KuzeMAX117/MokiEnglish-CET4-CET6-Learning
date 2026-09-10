package com.hao.topic.system.word.controller;

import com.hao.topic.common.result.Result;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.model.dto.word.SelectBookDto;
import com.hao.topic.model.dto.word.StudyResultDto;
import com.hao.topic.model.dto.word.WordCollectionDto;
import com.hao.topic.model.vo.word.UserWordSettingVo;
import com.hao.topic.model.vo.word.WordBookVo;
import com.hao.topic.model.vo.word.WordCalendarVo;
import com.hao.topic.model.vo.word.WordCollectionVo;
import com.hao.topic.model.vo.word.WordItemVo;
import com.hao.topic.model.vo.word.WordStatsVo;
import com.hao.topic.system.word.service.WordService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/system/word")
@RequiredArgsConstructor
public class WordController {

    private final WordService wordService;

    @GetMapping("/books")
    public Result<List<WordBookVo>> listBooks() {
        return Result.success(wordService.listBooks());
    }

    @PostMapping("/selectBook")
    public Result<Void> selectBook(@RequestBody SelectBookDto dto) {
        Long userId = SecurityUtils.getCurrentId();
        wordService.selectBook(userId, dto);
        return Result.success();
    }

    @GetMapping("/setting")
    public Result<UserWordSettingVo> getSetting() {
        Long userId = SecurityUtils.getCurrentId();
        return Result.success(wordService.getSetting(userId));
    }

    @GetMapping("/today")
    public Result<List<WordItemVo>> getTodayWords() {
        Long userId = SecurityUtils.getCurrentId();
        return Result.success(wordService.getTodayWords(userId));
    }

    @GetMapping("/todayLearned")
    public Result<List<WordItemVo>> getTodayLearnedWords() {
        Long userId = SecurityUtils.getCurrentId();
        return Result.success(wordService.getTodayLearnedWords(userId));
    }

    @PostMapping("/studyResult")
    public Result<Void> submitResult(@RequestBody StudyResultDto dto) {
        Long userId = SecurityUtils.getCurrentId();
        wordService.submitResult(userId, dto);
        return Result.success();
    }

    @GetMapping("/stats")
    public Result<WordStatsVo> getStats() {
        Long userId = SecurityUtils.getCurrentId();
        return Result.success(wordService.getStats(userId));
    }

    @GetMapping("/calendar")
    public Result<List<WordCalendarVo>> getCalendar(
            @RequestParam(required = false, defaultValue = "90") Integer days) {
        Long userId = SecurityUtils.getCurrentId();
        return Result.success(wordService.getCalendar(userId, days));
    }

    @GetMapping("/lookup")
    public Result<WordItemVo> lookupWord(@RequestParam String word) {
        return Result.success(wordService.lookupWord(word));
    }

    @GetMapping("/collection")
    public Result<List<WordCollectionVo>> listCollection() {
        Long userId = SecurityUtils.getCurrentId();
        return Result.success(wordService.listCollection(userId));
    }

    @PostMapping("/collection/add")
    public Result<Void> addCollection(@RequestBody WordCollectionDto dto) {
        Long userId = SecurityUtils.getCurrentId();
        wordService.addCollection(userId, dto);
        return Result.success();
    }

    @PostMapping("/collection/remove")
    public Result<Void> removeCollection(@RequestParam String word) {
        Long userId = SecurityUtils.getCurrentId();
        wordService.removeCollection(userId, word);
        return Result.success();
    }

    @GetMapping("/streakRank")
    public Result<List<Map<String, Object>>> getStreakRank() {
        return Result.success(wordService.getStreakRank());
    }

    @GetMapping("/todayStreakRank")
    public Result<List<Map<String, Object>>> getTodayStreakRank() {
        return Result.success(wordService.getTodayStreakRank());
    }

    @GetMapping("/userStreak")
    public Result<Map<String, Object>> getUserStreak() {
        Long userId = SecurityUtils.getCurrentId();
        return Result.success(wordService.getUserStreak(userId));
    }
}
