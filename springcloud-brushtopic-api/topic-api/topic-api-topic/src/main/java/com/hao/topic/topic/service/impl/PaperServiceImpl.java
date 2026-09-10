package com.hao.topic.topic.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.model.dto.topic.PaperAnswerDto;
import com.hao.topic.model.entity.topic.Paper;
import com.hao.topic.model.entity.topic.PaperTopic;
import com.hao.topic.model.entity.topic.Topic;
import com.hao.topic.model.entity.topic.TopicRecord;
import com.hao.topic.model.vo.topic.PaperAnswerVo;
import com.hao.topic.model.vo.topic.PaperDetailVo;
import com.hao.topic.model.vo.topic.PaperProgressVo;
import com.hao.topic.model.vo.topic.PaperTopicVo;
import com.hao.topic.model.vo.topic.PaperVo;
import com.hao.topic.topic.mapper.PaperMapper;
import com.hao.topic.topic.mapper.PaperTopicMapper;
import com.hao.topic.topic.mapper.TopicMapper;
import com.hao.topic.topic.mapper.TopicRecordMapper;
import com.hao.topic.topic.service.PaperService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
@AllArgsConstructor
public class PaperServiceImpl implements PaperService {

    private final PaperMapper paperMapper;
    private final PaperTopicMapper paperTopicMapper;
    private final TopicMapper topicMapper;
    private final TopicRecordMapper topicRecordMapper;

    @Override
    public List<PaperVo> paperList(Integer level) {
        LambdaQueryWrapper<Paper> paperLambdaQueryWrapper = new LambdaQueryWrapper<>();
        paperLambdaQueryWrapper.eq(Paper::getLevel, level);
        paperLambdaQueryWrapper.eq(Paper::getStatus, 0);
        paperLambdaQueryWrapper.orderByDesc(Paper::getExamYear);
        paperLambdaQueryWrapper.orderByDesc(Paper::getExamHalf);
        paperLambdaQueryWrapper.orderByDesc(Paper::getCreateTime);
        List<Paper> papers = paperMapper.selectList(paperLambdaQueryWrapper);
        if (CollectionUtils.isEmpty(papers)) {
            return Collections.emptyList();
        }
        
        Long currentId = SecurityUtils.getCurrentId();
        List<PaperVo> paperVos = new ArrayList<>();
        for (Paper paper : papers) {
            PaperVo paperVo = new PaperVo();
            paperVo.setId(paper.getId());
            paperVo.setLevel(paper.getLevel());
            paperVo.setExamYear(paper.getExamYear());
            paperVo.setExamHalf(paper.getExamHalf());
            paperVo.setTitle(paper.getTitle());
            paperVo.setTotalScore(paper.getTotalScore());
            
            LambdaQueryWrapper<PaperTopic> paperTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
            paperTopicLambdaQueryWrapper.eq(PaperTopic::getPaperId, paper.getId());
            paperVo.setTopicCount(paperTopicMapper.selectCount(paperTopicLambdaQueryWrapper));
            
            paperVo.setDoneCount(countDone(paper.getId(), currentId));
            paperVos.add(paperVo);
        }
        return paperVos;
    }

    @Override
    public PaperDetailVo paperDetail(Long id) {
        Paper paper = paperMapper.selectById(id);
        if (paper == null || paper.getStatus() != 0) {
            throw new TopicException(ResultCodeEnum.FAIL);
        }
        PaperDetailVo paperDetailVo = new PaperDetailVo();
        paperDetailVo.setId(paper.getId());
        paperDetailVo.setLevel(paper.getLevel());
        paperDetailVo.setExamYear(paper.getExamYear());
        paperDetailVo.setExamHalf(paper.getExamHalf());
        paperDetailVo.setTitle(paper.getTitle());
        paperDetailVo.setTotalScore(paper.getTotalScore());
        
        LambdaQueryWrapper<PaperTopic> paperTopicLambdaQueryWrapper = new LambdaQueryWrapper<>();
        paperTopicLambdaQueryWrapper.eq(PaperTopic::getPaperId, id);
        paperTopicLambdaQueryWrapper.orderByAsc(PaperTopic::getSorted);
        List<PaperTopic> paperTopics = paperTopicMapper.selectList(paperTopicLambdaQueryWrapper);
        Map<String, List<PaperTopicVo>> sectionMap = new LinkedHashMap<>();
        int index = 1;
        for (PaperTopic paperTopic : paperTopics) {
            Topic topic = topicMapper.selectById(paperTopic.getTopicId());
            if (topic == null || topic.getStatus() != 0) {
                continue;
            }
            PaperTopicVo paperTopicVo = new PaperTopicVo();
            paperTopicVo.setTopicId(topic.getId());
            paperTopicVo.setTopicName(topic.getTopicName());
            paperTopicVo.setOptions(topic.getOptions());
            paperTopicVo.setQuestionType(topic.getQuestionType());
            paperTopicVo.setArticle(topic.getArticle());
            paperTopicVo.setCorrectOption(topic.getCorrectOption());
            paperTopicVo.setAnalysis(topic.getAnalysis());
            paperTopicVo.setSubSection(paperTopic.getSubSection());
            paperTopicVo.setSection(paperTopic.getSection());
            paperTopicVo.setSorted(index++);
            String groupKey = paperTopic.getSection() + "|" + (paperTopic.getSubSection() != null ? paperTopic.getSubSection() : "");
            sectionMap.computeIfAbsent(groupKey, k -> new ArrayList<>()).add(paperTopicVo);
        }
        List<PaperDetailVo.PaperSectionVo> sections = new ArrayList<>();
        for (Map.Entry<String, List<PaperTopicVo>> entry : sectionMap.entrySet()) {
            PaperDetailVo.PaperSectionVo sectionVo = new PaperDetailVo.PaperSectionVo();
            String[] parts = entry.getKey().split("\\|", -1);
            sectionVo.setSection(parts[0]);
            sectionVo.setSubSection(parts.length > 1 ? parts[1] : null);
            sectionVo.setTopics(entry.getValue());
            sections.add(sectionVo);
        }
        paperDetailVo.setSections(sections);
        return paperDetailVo;
    }

    @Override
    @Transactional
    public PaperAnswerVo answer(PaperAnswerDto paperAnswerDto) {
        if (paperAnswerDto.getPaperId() == null || paperAnswerDto.getTopicId() == null
                || paperAnswerDto.getSelected() == null) {
            throw new TopicException(ResultCodeEnum.FAIL);
        }
        Topic topic = topicMapper.selectById(paperAnswerDto.getTopicId());
        if (topic == null || topic.getStatus() != 0) {
            throw new TopicException(ResultCodeEnum.FAIL);
        }
        
        String correctOption = topic.getCorrectOption();
        boolean correct = correctOption != null && correctOption.equalsIgnoreCase(paperAnswerDto.getSelected());
        
        saveRecord(paperAnswerDto, correct);
        PaperAnswerVo paperAnswerVo = new PaperAnswerVo();
        paperAnswerVo.setCorrect(correct);
        paperAnswerVo.setSelected(paperAnswerDto.getSelected());
        paperAnswerVo.setCorrectOption(correctOption);
        paperAnswerVo.setAnalysis(topic.getAnalysis());
        paperAnswerVo.setAnswer(topic.getAnswer());
        return paperAnswerVo;
    }

    @Override
    public List<PaperProgressVo> progress(Long paperId) {
        Long currentId = SecurityUtils.getCurrentId();
        LambdaQueryWrapper<TopicRecord> recordLambdaQueryWrapper = new LambdaQueryWrapper<>();
        recordLambdaQueryWrapper.eq(TopicRecord::getUserId, currentId);
        recordLambdaQueryWrapper.eq(TopicRecord::getPaperId, paperId);
        recordLambdaQueryWrapper.orderByAsc(TopicRecord::getUpdateTime);
        List<TopicRecord> records = topicRecordMapper.selectList(recordLambdaQueryWrapper);
        if (CollectionUtils.isEmpty(records)) {
            return Collections.emptyList();
        }
        
        Map<Long, TopicRecord> latest = new LinkedHashMap<>();
        for (TopicRecord record : records) {
            latest.put(record.getTopicId(), record);
        }
        return latest.values().stream().map(record -> {
            PaperProgressVo paperProgressVo = new PaperProgressVo();
            paperProgressVo.setTopicId(record.getTopicId());
            paperProgressVo.setSelected(record.getSelected());
            paperProgressVo.setCorrect(record.getCorrect() != null && record.getCorrect() == 1);
            return paperProgressVo;
        }).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void resetProgress(Long paperId) {
        if (paperId == null) {
            throw new TopicException(ResultCodeEnum.FAIL);
        }
        Long userId = SecurityUtils.getCurrentId();
        LambdaQueryWrapper<TopicRecord> recordLambdaQueryWrapper = new LambdaQueryWrapper<>();
        recordLambdaQueryWrapper.eq(TopicRecord::getUserId, userId);
        recordLambdaQueryWrapper.eq(TopicRecord::getPaperId, paperId);
        topicRecordMapper.delete(recordLambdaQueryWrapper);
    }

    

    private Long countDone(Long paperId, Long userId) {
        LambdaQueryWrapper<TopicRecord> recordLambdaQueryWrapper = new LambdaQueryWrapper<>();
        recordLambdaQueryWrapper.eq(TopicRecord::getUserId, userId);
        recordLambdaQueryWrapper.eq(TopicRecord::getPaperId, paperId);
        recordLambdaQueryWrapper.select(TopicRecord::getTopicId);
        return topicRecordMapper.selectList(recordLambdaQueryWrapper).stream()
                .map(TopicRecord::getTopicId).distinct().count();
    }

    

    private void saveRecord(PaperAnswerDto paperAnswerDto, boolean correct) {
        Long userId = SecurityUtils.getCurrentId();
        String currentName = SecurityUtils.getCurrentName();
        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        LambdaQueryWrapper<TopicRecord> recordLambdaQueryWrapper = new LambdaQueryWrapper<>();
        recordLambdaQueryWrapper.eq(TopicRecord::getUserId, userId);
        recordLambdaQueryWrapper.eq(TopicRecord::getTopicId, paperAnswerDto.getTopicId());
        recordLambdaQueryWrapper.eq(TopicRecord::getPaperId, paperAnswerDto.getPaperId());
        TopicRecord topicRecord = topicRecordMapper.selectOne(recordLambdaQueryWrapper);
        if (topicRecord == null) {
            topicRecord = new TopicRecord();
            topicRecord.setUserId(userId);
            topicRecord.setNickname(currentName);
            topicRecord.setTopicId(paperAnswerDto.getTopicId());
            topicRecord.setPaperId(paperAnswerDto.getPaperId());
            topicRecord.setSubjectId(0L);
            topicRecord.setCount(1L);
            topicRecord.setTopicTime(new Date());
            topicRecord.setUpdateTime(java.time.LocalDateTime.now());
        } else {
            topicRecord.setCount(topicRecord.getCount() + 1);
            topicRecord.setTopicTime(new Date());
            topicRecord.setUpdateTime(java.time.LocalDateTime.now());
        }
        topicRecord.setSelected(paperAnswerDto.getSelected());
        topicRecord.setCorrect(correct ? 1 : 0);
        if (topicRecord.getId() == null) {
            topicRecordMapper.insert(topicRecord);
        } else {
            topicRecordMapper.updateById(topicRecord);
        }
    }
}
