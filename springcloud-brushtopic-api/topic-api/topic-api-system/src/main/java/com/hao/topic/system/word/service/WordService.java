package com.hao.topic.system.word.service;

import com.hao.topic.model.dto.word.SelectBookDto;
import com.hao.topic.model.dto.word.StudyResultDto;
import com.hao.topic.model.dto.word.WordCollectionDto;
import com.hao.topic.model.vo.word.UserWordSettingVo;
import com.hao.topic.model.vo.word.WordBookVo;
import com.hao.topic.model.vo.word.WordCalendarVo;
import com.hao.topic.model.vo.word.WordCollectionVo;
import com.hao.topic.model.vo.word.WordItemVo;
import com.hao.topic.model.vo.word.WordStatsVo;

import java.util.List;
import java.util.Map;

public interface WordService {
    List<WordBookVo> listBooks();

    void selectBook(Long userId, SelectBookDto dto);

    UserWordSettingVo getSetting(Long userId);

    List<WordItemVo> getTodayWords(Long userId);

    List<WordItemVo> getTodayLearnedWords(Long userId);

    void submitResult(Long userId, StudyResultDto dto);

    WordStatsVo getStats(Long userId);

    List<WordCalendarVo> getCalendar(Long userId, Integer days);

    WordItemVo lookupWord(String word);

    /** 用户生词本：查询全部收藏 */
    List<WordCollectionVo> listCollection(Long userId);

    /** 用户生词本：收藏一个单词（已存在则忽略，已软删则复活） */
    void addCollection(Long userId, WordCollectionDto dto);

    /** 用户生词本：移除一个收藏单词 */
    void removeCollection(Long userId, String word);

    /** 获取连续打卡排行榜（总榜） */
    List<Map<String, Object>> getStreakRank();

    /** 获取今日打卡排行榜（日榜） */
    List<Map<String, Object>> getTodayStreakRank();

    /** 获取当前用户连续打卡信息 */
    Map<String, Object> getUserStreak(Long userId);
}
