package com.hao.topic.system.word.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hao.topic.model.dto.word.SelectBookDto;
import com.hao.topic.model.dto.word.StudyResultDto;
import com.hao.topic.model.dto.word.WordCollectionDto;
import com.hao.topic.model.entity.word.UserWordRecord;
import com.hao.topic.model.entity.word.UserWordSetting;
import com.hao.topic.model.entity.word.WordBook;
import com.hao.topic.model.entity.word.WordItem;
import com.hao.topic.model.entity.word.UserWordCollection;
import com.hao.topic.model.vo.word.UserWordSettingVo;
import com.hao.topic.model.vo.word.WordBookVo;
import com.hao.topic.model.vo.word.WordCalendarVo;
import com.hao.topic.model.vo.word.WordCollectionVo;
import com.hao.topic.model.vo.word.WordItemVo;
import com.hao.topic.model.vo.word.WordStatsVo;
import com.hao.topic.model.entity.word.WordDictionary;
import com.hao.ai.client.ai.AiFeignClient;
import com.hao.topic.system.word.mapper.UserWordRecordMapper;
import com.hao.topic.system.word.mapper.UserWordSettingMapper;
import com.hao.topic.system.word.mapper.UserWordCollectionMapper;
import com.hao.topic.system.word.mapper.WordBookMapper;
import com.hao.topic.system.word.mapper.WordDictionaryMapper;
import com.hao.topic.system.word.mapper.WordItemMapper;
import com.hao.topic.system.word.service.WordService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class WordServiceImpl implements WordService {

    private final WordBookMapper wordBookMapper;
    private final WordItemMapper wordItemMapper;
    private final WordDictionaryMapper wordDictionaryMapper;
    private final UserWordSettingMapper userWordSettingMapper;
    private final UserWordRecordMapper userWordRecordMapper;
    private final UserWordCollectionMapper userWordCollectionMapper;
    private final AiFeignClient aiFeignClient;

    @Override
    public List<WordBookVo> listBooks() {
        List<WordBook> books = wordBookMapper.selectList(null);
        return books.stream().map(book -> {
            WordBookVo vo = new WordBookVo();
            BeanUtils.copyProperties(book, vo);
            return vo;
        }).collect(Collectors.toList());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void selectBook(Long userId, SelectBookDto dto) {
        LambdaQueryWrapper<UserWordSetting> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserWordSetting::getUserId, userId);
        UserWordSetting setting = userWordSettingMapper.selectOne(wrapper);

        if (setting == null) {
            setting = new UserWordSetting();
            setting.setUserId(userId);
            setting.setBookId(dto.getBookId());
            setting.setDailyCount(dto.getDailyCount());
            userWordSettingMapper.insert(setting);
        } else {
            setting.setBookId(dto.getBookId());
            setting.setDailyCount(dto.getDailyCount());
            userWordSettingMapper.updateById(setting);
        }

        Long count = userWordRecordMapper.countByUserAndBook(userId, dto.getBookId());
        if (count == null || count == 0) {
            List<Long> wordIds = wordItemMapper.selectIdsByBookId(dto.getBookId());
            if (!wordIds.isEmpty()) {
                List<UserWordRecord> records = new ArrayList<>();
                for (Long wordId : wordIds) {
                    UserWordRecord record = new UserWordRecord();
                    record.setUserId(userId);
                    record.setWordId(wordId);
                    record.setBookId(dto.getBookId());
                    record.setStatus(0);
                    record.setProficiency(0);
                    record.setReviewCount(0);
                    records.add(record);
                }
                for (UserWordRecord record : records) {
                    userWordRecordMapper.insert(record);
                }
            }
        }
    }

    @Override
    public UserWordSettingVo getSetting(Long userId) {
        LambdaQueryWrapper<UserWordSetting> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserWordSetting::getUserId, userId);
        UserWordSetting setting = userWordSettingMapper.selectOne(wrapper);
        if (setting == null) {
            return null;
        }
        UserWordSettingVo vo = new UserWordSettingVo();
        BeanUtils.copyProperties(setting, vo);
        return vo;
    }

    @Override
    public List<WordItemVo> getTodayWords(Long userId) {
        LambdaQueryWrapper<UserWordSetting> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserWordSetting::getUserId, userId);
        UserWordSetting setting = userWordSettingMapper.selectOne(wrapper);
        if (setting == null) {
            return new ArrayList<>();
        }

        List<UserWordRecord> records = userWordRecordMapper.selectTodayWords(
                userId, setting.getBookId(), setting.getDailyCount());
        return toWordItemVos(records);
    }

    @Override
    public List<WordItemVo> getTodayLearnedWords(Long userId) {
        LambdaQueryWrapper<UserWordSetting> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserWordSetting::getUserId, userId);
        UserWordSetting setting = userWordSettingMapper.selectOne(wrapper);
        if (setting == null) {
            return new ArrayList<>();
        }

        // 今日实际学习过的单词（last_study_time 为今天），供 AI 短文基于真实学习记录生成
        List<UserWordRecord> records = userWordRecordMapper.selectTodayLearnedWords(
                userId, setting.getBookId());
        return toWordItemVos(records);
    }

    /**
     * 将学习记录转换为单词 VO 列表，并填充熟练度与状态。
     * 保持 records 的原始顺序（selectBatchIds 不保证顺序）。
     */
    private List<WordItemVo> toWordItemVos(List<UserWordRecord> records) {
        if (records == null || records.isEmpty()) {
            return new ArrayList<>();
        }
        List<Long> wordIds = records.stream().map(UserWordRecord::getWordId).collect(Collectors.toList());
        List<WordItem> items = wordItemMapper.selectBatchIds(wordIds);
        Map<Long, WordItem> itemMap = items.stream()
                .collect(Collectors.toMap(WordItem::getId, i -> i));
        List<WordItemVo> result = new ArrayList<>();
        for (UserWordRecord record : records) {
            WordItem item = itemMap.get(record.getWordId());
            if (item == null) {
                continue;
            }
            WordItemVo vo = new WordItemVo();
            BeanUtils.copyProperties(item, vo);
            vo.setProficiency(record.getProficiency());
            vo.setStatus(record.getStatus());
            result.add(vo);
        }
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void submitResult(Long userId, StudyResultDto dto) {
        LambdaQueryWrapper<UserWordRecord> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserWordRecord::getUserId, userId);
        wrapper.eq(UserWordRecord::getWordId, dto.getWordId());
        UserWordRecord record = userWordRecordMapper.selectOne(wrapper);
        if (record == null) {
            return;
        }

        Boolean known = dto.getKnown();
        if (known == null) {
            known = false;
        }

        if (known) {
            record.setProficiency(Math.min(record.getProficiency() + 1, 5));
            record.setStatus(record.getProficiency() >= 4 ? 2 : 1);
        } else {
            record.setProficiency(Math.max(record.getProficiency() - 1, 0));
            record.setStatus(1);
        }

        record.setReviewCount(record.getReviewCount() + 1);
        record.setLastStudyTime(LocalDateTime.now());
        long hours = (long) Math.pow(2, record.getProficiency());
        record.setNextReviewTime(LocalDateTime.now().plusHours(hours));
        userWordRecordMapper.updateById(record);
    }

    @Override
    public WordStatsVo getStats(Long userId) {
        WordStatsVo vo = new WordStatsVo();
        vo.setLearned(userWordRecordMapper.countLearned(userId));
        vo.setMastered(userWordRecordMapper.countMastered(userId));
        vo.setReviewDue(userWordRecordMapper.countReviewDue(userId));
        vo.setToLearn(userWordRecordMapper.countToLearn(userId));
        vo.setTodayLearned(userWordRecordMapper.countTodayLearned(userId));

        LambdaQueryWrapper<UserWordSetting> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserWordSetting::getUserId, userId);
        UserWordSetting setting = userWordSettingMapper.selectOne(wrapper);
        if (setting != null) {
            Long bookId = setting.getBookId();
            Long learned = userWordRecordMapper.countLearnedByBook(userId, bookId);
            WordBook book = wordBookMapper.selectById(bookId);
            vo.setCet4Total(book != null ? (long) book.getTotalCount() : 0L);
            if (bookId == 1) {
                vo.setCet4Learned(learned);
                vo.setCet6Total(0L);
                vo.setCet6Learned(0L);
            } else if (bookId == 2) {
                vo.setCet4Total(0L);
                vo.setCet4Learned(0L);
                vo.setCet6Total(book != null ? (long) book.getTotalCount() : 0L);
                vo.setCet6Learned(learned);
            }
        } else {
            vo.setCet4Total(0L);
            vo.setCet4Learned(0L);
            vo.setCet6Total(0L);
            vo.setCet6Learned(0L);
        }
        return vo;
    }

    @Override
    public WordItemVo lookupWord(String word) {
        String w = word.toLowerCase().trim();

        // 1. 精确匹配：先查词书库
        WordItemVo result = lookupInWordItem(w);
        if (result != null) return result;

        // 2. 精确匹配：再查词典库（兜底）
        result = lookupInDictionary(w);
        if (result != null) return result;

        // 3. 词形还原：尝试常见变形后缀，去掉后再查
        for (String base : generateBaseForms(w)) {
            result = lookupInWordItem(base);
            if (result != null) return result;
        }
        for (String base : generateBaseForms(w)) {
            result = lookupInDictionary(base);
            if (result != null) return result;
        }

        // 4. 复合词拆分：本地词库/词典查不到时，尝试拆成两个已知词组合释义（healthcare → health + care）
        result = lookupCompound(w);
        if (result != null) return result;

        // 5. AI 翻译兜底：以上都查不到时，调用 AI 翻译
        try {
            String translation = aiFeignClient.translateText(Map.of("text", w)).getData();
            if (translation != null && !translation.isBlank()) {
                WordItemVo vo = new WordItemVo();
                vo.setWord(w);
                vo.setMeaning(translation);
                return vo;
            }
        } catch (Exception ignored) {
            // AI 调用失败时静默处理，返回 null
        }

        return null;
    }

    /**
     * 复合词兜底查询：把一个未收录的长单词拆成前后两段，
     * 若两段都能在词典中查到，则组合它们的释义返回。
     * 例：healthcare → health + care
     */
    private WordItemVo lookupCompound(String word) {
        // 过短的单词不做拆分，避免误匹配
        if (word.length() < 6) return null;
        // 拆分点从第 3 位到倒数第 3 位，保证前后两段都有足够长度
        for (int i = 3; i <= word.length() - 3; i++) {
            WordItemVo head = lookupInDictionary(word.substring(0, i));
            if (head == null) continue;
            WordItemVo tail = lookupInDictionary(word.substring(i));
            if (tail == null) continue;
            WordItemVo vo = new WordItemVo();
            vo.setWord(word);
            vo.setMeaning(head.getMeaning() + "；" + tail.getMeaning());
            return vo;
        }
        return null;
    }

    private WordItemVo lookupInWordItem(String word) {
        LambdaQueryWrapper<WordItem> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WordItem::getWord, word);
        wrapper.last("LIMIT 1");
        WordItem item = wordItemMapper.selectOne(wrapper);
        if (item == null) return null;
        WordItemVo vo = new WordItemVo();
        BeanUtils.copyProperties(item, vo);
        return vo;
    }

    private WordItemVo lookupInDictionary(String word) {
        LambdaQueryWrapper<WordDictionary> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WordDictionary::getWord, word);
        wrapper.last("LIMIT 1");
        WordDictionary dict = wordDictionaryMapper.selectOne(wrapper);
        if (dict == null) return null;
        WordItemVo vo = new WordItemVo();
        vo.setWord(dict.getWord());
        vo.setMeaning(dict.getTranslation());
        return vo;
    }

    /**
     * 简单的英语词形还原，生成可能的原形候选词
     * 例：walls→wall, went→go(不覆盖), running→run, bigger→big
     */
    private List<String> generateBaseForms(String word) {
        List<String> candidates = new ArrayList<>();
        if (word.length() <= 2) return candidates;

        // -ies → -y (stories → story)
        if (word.endsWith("ies") && word.length() > 4) {
            candidates.add(word.substring(0, word.length() - 3) + "y");
        }
        // -ied → -y (carried → carry)
        if (word.endsWith("ied") && word.length() > 4) {
            candidates.add(word.substring(0, word.length() - 3) + "y");
        }
        // -es → 去es (goes → go, boxes → box)
        if (word.endsWith("es") && word.length() > 3) {
            candidates.add(word.substring(0, word.length() - 2));
        }
        // -s → 去s (walls → wall, cats → cat)
        if (word.endsWith("s") && !word.endsWith("ss") && word.length() > 2) {
            candidates.add(word.substring(0, word.length() - 1));
        }
        // -ing → 去ing (playing → play)
        if (word.endsWith("ing") && word.length() > 4) {
            candidates.add(word.substring(0, word.length() - 3));
            // -ing → 去ing加e (making → make)
            candidates.add(word.substring(0, word.length() - 3) + "e");
        }
        // -ed → 去ed (played → play)
        if (word.endsWith("ed") && word.length() > 3) {
            candidates.add(word.substring(0, word.length() - 2));
            // -ed → 去ed加e (liked → like)
            candidates.add(word.substring(0, word.length() - 2) + "e");
        }
        // -ly → 去ly (quickly → quick)
        if (word.endsWith("ly") && word.length() > 3) {
            candidates.add(word.substring(0, word.length() - 2));
        }
        // -er → 去er (bigger → big)
        if (word.endsWith("er") && word.length() > 3) {
            candidates.add(word.substring(0, word.length() - 2));
        }
        // -est → 去est (biggest → big)
        if (word.endsWith("est") && word.length() > 4) {
            candidates.add(word.substring(0, word.length() - 3));
        }

        return candidates;
    }

    @Override
    public List<WordCalendarVo> getCalendar(Long userId, Integer days) {
        if (days == null || days <= 0) {
            days = 90;
        }
        String startDate = LocalDateTime.now()
                .minusDays(days)
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        List<Map<String, Object>> rawList = userWordRecordMapper.selectDailyCounts(userId, startDate);
        return rawList.stream().map(row -> {
            WordCalendarVo vo = new WordCalendarVo();
            Object dateVal = row.get("study_date");
            vo.setDate(dateVal != null ? dateVal.toString() : "");
            Object countVal = row.get("study_count");
            vo.setCount(countVal != null ? ((Number) countVal).intValue() : 0);
            return vo;
        }).collect(Collectors.toList());
    }

    @Override
    public List<WordCollectionVo> listCollection(Long userId) {
        List<UserWordCollection> list = userWordCollectionMapper.selectByUser(userId);
        return list.stream().map(item -> {
            WordCollectionVo vo = new WordCollectionVo();
            BeanUtils.copyProperties(item, vo);
            return vo;
        }).collect(Collectors.toList());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addCollection(Long userId, WordCollectionDto dto) {
        if (dto == null || dto.getWord() == null) return;
        String word = dto.getWord().toLowerCase().trim();
        if (word.isEmpty()) return;

        // 释义快照：优先用前端携带的，缺失时后端查词兼底
        String phonetic = dto.getPhonetic();
        String meaning = dto.getMeaning();
        String example = dto.getExample();
        String exampleTranslate = dto.getExampleTranslate();
        if (meaning == null || meaning.isBlank()) {
            WordItemVo looked = lookupWord(word);
            if (looked != null) {
                if (phonetic == null || phonetic.isBlank()) phonetic = looked.getPhonetic();
                meaning = looked.getMeaning();
                if (example == null || example.isBlank()) example = looked.getExample();
                if (exampleTranslate == null || exampleTranslate.isBlank()) exampleTranslate = looked.getExampleTranslate();
            }
        }

        UserWordCollection existing = userWordCollectionMapper.selectByUserAndWord(userId, word);
        if (existing == null) {
            UserWordCollection entity = new UserWordCollection();
            entity.setUserId(userId);
            entity.setWord(word);
            entity.setPhonetic(phonetic);
            entity.setMeaning(meaning);
            entity.setExample(example);
            entity.setExampleTranslate(exampleTranslate);
            userWordCollectionMapper.insert(entity);
        } else if (existing.getIsDeleted() != null && existing.getIsDeleted() == 1) {
            // 之前移除过，复活并刷新快照
            userWordCollectionMapper.revive(existing.getId(), phonetic, meaning, example, exampleTranslate);
        }
        // 已存在且未删除：幂等忽略
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void removeCollection(Long userId, String word) {
        if (word == null) return;
        String w = word.toLowerCase().trim();
        if (w.isEmpty()) return;
        userWordCollectionMapper.softDeleteByUserAndWord(userId, w);
    }
}
