package com.hao.topic.topic.service.impl;

import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hao.topic.api.utils.enums.StatusEnums;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.topic.PaperManageDto;
import com.hao.topic.model.dto.topic.PaperManageQueryDto;
import com.hao.topic.model.dto.topic.PaperOptionDto;
import com.hao.topic.model.dto.topic.PaperSectionSaveDto;
import com.hao.topic.model.entity.topic.Paper;
import com.hao.topic.model.entity.topic.PaperTopic;
import com.hao.topic.model.entity.topic.Topic;
import com.hao.topic.model.entity.topic.TopicRecord;
import com.hao.topic.model.vo.topic.PaperManageDetailVo;
import com.hao.topic.model.vo.topic.PaperManageVo;
import com.hao.topic.topic.mapper.PaperMapper;
import com.hao.topic.topic.mapper.PaperTopicMapper;
import com.hao.topic.topic.mapper.TopicMapper;
import com.hao.topic.topic.mapper.TopicRecordMapper;
import com.hao.topic.topic.service.PaperManageService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
@AllArgsConstructor
public class PaperManageServiceImpl implements PaperManageService {

    private final PaperMapper paperMapper;
    private final PaperTopicMapper paperTopicMapper;
    private final TopicMapper topicMapper;
    private final TopicRecordMapper topicRecordMapper;

    /**
     * 卷内板块顺序
     */
    private static final List<String> SECTION_ORDER = List.of("writing", "listening", "reading", "translation");

    private static final Map<String, String> SECTION_NAME = Map.of(
            "writing", "写作",
            "listening", "听力",
            "reading", "阅读",
            "translation", "翻译");

    private static final Map<String, String> SUB_SECTION_NAME = Map.ofEntries(
            Map.entry("writing", "写作"),
            Map.entry("news", "新闻"),
            Map.entry("conversation", "长对话"),
            Map.entry("passage", "篇章"),
            Map.entry("cloze", "选词填空"),
            Map.entry("matching", "长篇匹配"),
            Map.entry("reading_1", "仔细阅读一"),
            Map.entry("reading_2", "仔细阅读二"),
            Map.entry("translation", "翻译"));

    /**
     * 各板块题数达标线
     */
    private static final Map<String, Integer> SECTION_TARGET = Map.of(
            "writing", 1,
            "listening", 25,
            "reading", 30,
            "translation", 1);

    /**
     * 预期有选项的子板块
     */
    private static final Set<String> CHOICE_SUB_SECTIONS = Set.of(
            "news", "conversation", "passage", "cloze", "matching", "reading_1", "reading_2");

    /**
     * 试卷状态：0正常 1停用 2草稿
     */
    private static final Integer PAPER_STATUS_NORMAL = 0;
    private static final Integer PAPER_STATUS_STOP = 1;
    private static final Integer PAPER_STATUS_DRAFT = 2;

    /**
     * topic_name 列长度上限
     */
    private static final int TOPIC_NAME_MAX_LENGTH = 2000;

    @Override
    public Map<String, Object> paperManageList(PaperManageQueryDto query) {
        LambdaQueryWrapper<Paper> wrapper = new LambdaQueryWrapper<>();
        if (query.getLevel() != null) {
            wrapper.eq(Paper::getLevel, query.getLevel());
        }
        if (query.getStatus() != null) {
            wrapper.eq(Paper::getStatus, query.getStatus());
        }
        if (query.getExamYear() != null) {
            wrapper.eq(Paper::getExamYear, query.getExamYear());
        }
        if (!StringUtils.isEmpty(query.getTitle())) {
            wrapper.like(Paper::getTitle, query.getTitle());
        }
        wrapper.orderByDesc(Paper::getExamYear).orderByDesc(Paper::getExamHalf).orderByDesc(Paper::getCreateTime);

        List<Paper> papers;
        Long total;
        if (query.getPageNum() != null && query.getPageSize() != null) {
            Page<Paper> paperPage = paperMapper.selectPage(new Page<>(query.getPageNum(), query.getPageSize()), wrapper);
            papers = paperPage.getRecords();
            total = paperPage.getTotal();
        } else {
            papers = paperMapper.selectList(wrapper);
            total = (long) papers.size();
        }

        List<PaperManageVo> rows = papers.stream().map(paper -> {
            PaperManageVo paperManageVo = new PaperManageVo();
            BeanUtils.copyProperties(paper, paperManageVo);
            LambdaQueryWrapper<PaperTopic> ptWrapper = new LambdaQueryWrapper<>();
            ptWrapper.eq(PaperTopic::getPaperId, paper.getId());
            List<PaperTopic> paperTopics = paperTopicMapper.selectList(ptWrapper);
            Map<String, Long> sectionCounts = new LinkedHashMap<>();
            for (String section : SECTION_ORDER) {
                sectionCounts.put(section, 0L);
            }
            for (PaperTopic paperTopic : paperTopics) {
                sectionCounts.merge(paperTopic.getSection(), 1L, Long::sum);
            }
            paperManageVo.setSectionCounts(sectionCounts);
            paperManageVo.setTopicCount((long) paperTopics.size());
            return paperManageVo;
        }).toList();

        Map<String, Object> map = new HashMap<>();
        map.put("total", total);
        map.put("rows", rows);
        return map;
    }

    @Override
    @Transactional
    public Long add(PaperManageDto dto) {
        if (dto.getLevel() == null || dto.getExamYear() == null || dto.getExamHalf() == null
                || StringUtils.isEmpty(dto.getTitle())) {
            throw new TopicException("级别、考试年份、上下半年、试卷标题不能为空");
        }
        if (dto.getLevel() != 4 && dto.getLevel() != 6) {
            throw new TopicException("级别只能是 4（四级）或 6（六级）");
        }
        if (dto.getTitle().length() > 100) {
            throw new TopicException("试卷标题不能超过 100 字");
        }
        Paper paper = new Paper();
        BeanUtils.copyProperties(dto, paper);
        paper.setId(null);
        if (paper.getTotalScore() == null) {
            paper.setTotalScore(710L);
        }
        paper.setStatus(PAPER_STATUS_DRAFT);
        paperMapper.insert(paper);
        log.info("新建试卷草稿：id={}, title={}", paper.getId(), paper.getTitle());
        return paper.getId();
    }

    @Override
    @Transactional
    public void update(PaperManageDto dto) {
        if (dto.getId() == null) {
            throw new TopicException("试卷ID不能为空");
        }
        Paper paper = paperMapper.selectById(dto.getId());
        if (paper == null) {
            throw new TopicException("试卷不存在");
        }
        if (dto.getLevel() != null) {
            if (dto.getLevel() != 4 && dto.getLevel() != 6) {
                throw new TopicException("级别只能是 4（四级）或 6（六级）");
            }
            paper.setLevel(dto.getLevel());
        }
        if (dto.getExamYear() != null) {
            paper.setExamYear(dto.getExamYear());
        }
        if (dto.getExamHalf() != null) {
            paper.setExamHalf(dto.getExamHalf());
        }
        if (!StringUtils.isEmpty(dto.getTitle())) {
            if (dto.getTitle().length() > 100) {
                throw new TopicException("试卷标题不能超过 100 字");
            }
            paper.setTitle(dto.getTitle());
        }
        if (dto.getTotalScore() != null) {
            paper.setTotalScore(dto.getTotalScore());
        }
        paperMapper.updateById(paper);
    }

    @Override
    @Transactional
    public void delete(Long[] ids) {
        if (ids == null || ids.length == 0) {
            throw new TopicException("请选择要删除的试卷");
        }
        for (Long id : ids) {
            Paper paper = paperMapper.selectById(id);
            if (paper == null) {
                continue;
            }
            removePaperTopics(id, null);
            paperMapper.deleteById(id);
            log.info("删除试卷：id={}, title={}", id, paper.getTitle());
        }
    }

    @Override
    public PaperManageDetailVo detail(Long id) {
        Paper paper = paperMapper.selectById(id);
        if (paper == null) {
            throw new TopicException("试卷不存在");
        }
        PaperManageDetailVo detailVo = new PaperManageDetailVo();
        detailVo.setId(paper.getId());
        detailVo.setLevel(paper.getLevel());
        detailVo.setExamYear(paper.getExamYear());
        detailVo.setExamHalf(paper.getExamHalf());
        detailVo.setTitle(paper.getTitle());
        detailVo.setTotalScore(paper.getTotalScore());
        detailVo.setStatus(paper.getStatus());

        LambdaQueryWrapper<PaperTopic> ptWrapper = new LambdaQueryWrapper<>();
        ptWrapper.eq(PaperTopic::getPaperId, id).orderByAsc(PaperTopic::getSorted);
        List<PaperTopic> paperTopics = paperTopicMapper.selectList(ptWrapper);

        Map<String, PaperManageDetailVo.ManageSectionVo> sectionMap = new LinkedHashMap<>();
        for (PaperTopic paperTopic : paperTopics) {
            Topic topic = topicMapper.selectById(paperTopic.getTopicId());
            if (topic == null || topic.getStatus() == null || topic.getStatus().intValue() != StatusEnums.NORMAL.getCode()) {
                continue;
            }
            String groupKey = paperTopic.getSection() + "|" + (paperTopic.getSubSection() == null ? "" : paperTopic.getSubSection());
            PaperManageDetailVo.ManageSectionVo sectionVo = sectionMap.computeIfAbsent(groupKey, k -> {
                PaperManageDetailVo.ManageSectionVo vo = new PaperManageDetailVo.ManageSectionVo();
                vo.setSection(paperTopic.getSection());
                vo.setSubSection(paperTopic.getSubSection());
                vo.setTopics(new ArrayList<>());
                return vo;
            });
            PaperManageDetailVo.ManageTopicVo topicVo = new PaperManageDetailVo.ManageTopicVo();
            topicVo.setTopicId(topic.getId());
            topicVo.setTopicName(topic.getTopicName());
            topicVo.setOptions(parseOptions(topic.getOptions()));
            topicVo.setCorrectOption(topic.getCorrectOption());
            topicVo.setAnswer(topic.getAnswer());
            topicVo.setAnalysis(topic.getAnalysis());
            topicVo.setArticle(topic.getArticle());
            topicVo.setQuestionType(topic.getQuestionType());
            sectionVo.getTopics().add(topicVo);
        }
        detailVo.setSections(new ArrayList<>(sectionMap.values()));
        return detailVo;
    }

    @Override
    @Transactional
    public Map<String, Object> saveSection(PaperSectionSaveDto dto) {
        if (dto.getPaperId() == null) {
            throw new TopicException("试卷ID不能为空");
        }
        if (StringUtils.isEmpty(dto.getSection()) || !SECTION_ORDER.contains(dto.getSection())) {
            throw new TopicException("板块类型不正确，只能是 writing/listening/reading/translation");
        }
        Paper paper = paperMapper.selectById(dto.getPaperId());
        if (paper == null) {
            throw new TopicException("试卷不存在");
        }

        List<String> warnings = new ArrayList<>();
        
        validateSection(dto, warnings);
        
        checkDuplicate(dto, paper.getId(), warnings);

        
        removePaperTopics(dto.getPaperId(), dto.getSection());

        
        String username = SecurityUtils.getCurrentName();
        long order = 1;
        int savedCount = 0;
        if (CollectionUtils.isNotEmpty(dto.getSubSections())) {
            for (PaperSectionSaveDto.SubSectionDto subSection : dto.getSubSections()) {
                if (CollectionUtils.isEmpty(subSection.getTopics())) {
                    continue;
                }
                for (PaperSectionSaveDto.TopicItemDto item : subSection.getTopics()) {
                    Topic topic = new Topic();
                    topic.setTopicName(item.getTopicName().trim());
                    topic.setAnswer(item.getAnswer());
                    topic.setOptions(buildOptionsJson(item.getOptions()));
                    topic.setCorrectOption(!StringUtils.isEmpty(item.getCorrectOption())
                            ? item.getCorrectOption().trim().toUpperCase() : null);
                    topic.setQuestionType(mapQuestionType(dto.getSection(), subSection.getSubSection()));
                    topic.setAnalysis(item.getAnalysis());
                    String article = !StringUtils.isEmpty(item.getArticle()) ? item.getArticle() : subSection.getArticle();
                    topic.setArticle(article);
                    topic.setStatus(StatusEnums.NORMAL.getCode());
                    topic.setCreateBy(username);
                    topicMapper.insert(topic);

                    PaperTopic paperTopic = new PaperTopic();
                    paperTopic.setPaperId(dto.getPaperId());
                    paperTopic.setTopicId(topic.getId());
                    paperTopic.setSection(dto.getSection());
                    paperTopic.setSubSection(subSection.getSubSection());
                    paperTopic.setSorted(order++);
                    paperTopicMapper.insert(paperTopic);
                    savedCount++;
                }
            }
        }

        
        reorderPaperSorted(dto.getPaperId());

        log.info("试卷分段保存：paperId={}, section={}, saved={}, warnings={}",
                dto.getPaperId(), dto.getSection(), savedCount, warnings.size());
        Map<String, Object> result = new HashMap<>();
        result.put("savedCount", savedCount);
        result.put("warnings", warnings);
        return result;
    }

    @Override
    @Transactional
    public Map<String, Object> publish(Long id) {
        if (id == null) {
            throw new TopicException("试卷ID不能为空");
        }
        Paper paper = paperMapper.selectById(id);
        if (paper == null) {
            throw new TopicException("试卷不存在");
        }
        LambdaQueryWrapper<PaperTopic> ptWrapper = new LambdaQueryWrapper<>();
        ptWrapper.eq(PaperTopic::getPaperId, id).orderByAsc(PaperTopic::getSorted);
        List<PaperTopic> paperTopics = paperTopicMapper.selectList(ptWrapper);
        if (CollectionUtils.isEmpty(paperTopics)) {
            throw new TopicException("试卷还没有任何题目，不能发布");
        }

        List<String> warnings = new ArrayList<>();
        Map<String, Long> counts = new HashMap<>();
        for (PaperTopic paperTopic : paperTopics) {
            counts.merge(paperTopic.getSection(), 1L, Long::sum);
        }
        for (String section : SECTION_ORDER) {
            int target = SECTION_TARGET.get(section);
            long count = counts.getOrDefault(section, 0L);
            if (count < target) {
                warnings.add(SECTION_NAME.get(section) + "题数 " + count + "/" + target + " 未达标");
            }
        }
        for (PaperTopic paperTopic : paperTopics) {
            Topic topic = topicMapper.selectById(paperTopic.getTopicId());
            if (topic == null) {
                continue;
            }
            if (!StringUtils.isEmpty(topic.getOptions()) && StringUtils.isEmpty(topic.getCorrectOption())) {
                warnings.add("第 " + paperTopic.getSorted() + " 题（" + brief(topic.getTopicName()) + "）缺少正确答案");
            }
        }

        paper.setStatus(PAPER_STATUS_NORMAL);
        paperMapper.updateById(paper);
        log.info("发布试卷：id={}, title={}, warnings={}", id, paper.getTitle(), warnings.size());

        Map<String, Object> result = new HashMap<>();
        result.put("warnings", warnings);
        return result;
    }

    @Override
    @Transactional
    public void unpublish(Long id) {
        if (id == null) {
            throw new TopicException("试卷ID不能为空");
        }
        Paper paper = paperMapper.selectById(id);
        if (paper == null) {
            throw new TopicException("试卷不存在");
        }
        paper.setStatus(PAPER_STATUS_STOP);
        paperMapper.updateById(paper);
        log.info("下架试卷：id={}, title={}", id, paper.getTitle());
    }

    

    /**
     * 校验分段保存提交的题目数据，错误直接抛出（含题号定位），警告写入 warnings
     */
    private void validateSection(PaperSectionSaveDto dto, List<String> warnings) {
        String sectionName = SECTION_NAME.getOrDefault(dto.getSection(), dto.getSection());
        if (CollectionUtils.isEmpty(dto.getSubSections())) {
            return;
        }
        int no = 0;
        for (PaperSectionSaveDto.SubSectionDto subSection : dto.getSubSections()) {
            if (CollectionUtils.isEmpty(subSection.getTopics())) {
                continue;
            }
            String subName = StringUtils.isEmpty(subSection.getSubSection())
                    ? "" : SUB_SECTION_NAME.getOrDefault(subSection.getSubSection(), subSection.getSubSection());
            String location = "【" + sectionName + (subName.isEmpty() ? "" : "/" + subName) + "】";
            for (PaperSectionSaveDto.TopicItemDto item : subSection.getTopics()) {
                no++;
                String prefix = location + "第" + no + "题";
                if (StringUtils.isEmpty(item.getTopicName())) {
                    throw new TopicException(prefix + "：题干不能为空");
                }
                if (item.getTopicName().trim().length() > TOPIC_NAME_MAX_LENGTH) {
                    throw new TopicException(prefix + "：题干长度超过 " + TOPIC_NAME_MAX_LENGTH + " 字，请精简后保存");
                }
                if (!StringUtils.isEmpty(item.getCorrectOption())
                        && item.getCorrectOption().trim().length() > 5) {
                    throw new TopicException(prefix + "：正确答案最多 5 个字符");
                }
                List<PaperOptionDto> options = item.getOptions();
                if (CollectionUtils.isNotEmpty(options)) {
                    Set<String> labels = new HashSet<>();
                    for (PaperOptionDto option : options) {
                        if (StringUtils.isEmpty(option.getLabel())) {
                            throw new TopicException(prefix + "：存在缺少选项号的选项");
                        }
                        if (StringUtils.isEmpty(option.getContent())) {
                            throw new TopicException(prefix + "：选项 " + option.getLabel().trim() + " 的内容为空");
                        }
                        String label = option.getLabel().trim().toUpperCase();
                        if (!labels.add(label)) {
                            throw new TopicException(prefix + "：选项号 " + label + " 重复");
                        }
                    }
                    if (!StringUtils.isEmpty(item.getCorrectOption())) {
                        String correct = item.getCorrectOption().trim().toUpperCase();
                        if (!labels.contains(correct)) {
                            throw new TopicException(prefix + "：正确答案 " + correct + " 不在选项范围内");
                        }
                    } else {
                        warnings.add(prefix + "（" + brief(item.getTopicName()) + "）缺少正确答案，发布后无法对答案");
                    }
                } else if (CHOICE_SUB_SECTIONS.contains(subSection.getSubSection())) {
                    warnings.add(prefix + "（" + brief(item.getTopicName()) + "）未录入选项，发布后用户无法作答");
                }
            }
        }
    }

    /**
     * 题干重复检查（与题库/其他试卷，以及本次提交内部），仅警告不阻断
     */
    private void checkDuplicate(PaperSectionSaveDto dto, Long paperId, List<String> warnings) {
        if (CollectionUtils.isEmpty(dto.getSubSections())) {
            return;
        }
        List<String> names = new ArrayList<>();
        for (PaperSectionSaveDto.SubSectionDto subSection : dto.getSubSections()) {
            if (CollectionUtils.isEmpty(subSection.getTopics())) {
                continue;
            }
            for (PaperSectionSaveDto.TopicItemDto item : subSection.getTopics()) {
                if (!StringUtils.isEmpty(item.getTopicName())) {
                    names.add(item.getTopicName().trim());
                }
            }
        }
        if (names.isEmpty()) {
            return;
        }

        Set<String> reported = new HashSet<>();
        
        Set<String> seen = new HashSet<>();
        for (String name : names) {
            if (!seen.add(name) && reported.add(name)) {
                warnings.add("题干「" + brief(name) + "」在本次提交中重复出现");
            }
        }

        
        Set<Long> myTopicIds = paperTopicMapper.selectList(new LambdaQueryWrapper<PaperTopic>()
                        .eq(PaperTopic::getPaperId, paperId))
                .stream().map(PaperTopic::getTopicId).collect(Collectors.toSet());
        List<String> distinctNames = names.stream().distinct().toList();
        for (int i = 0; i < distinctNames.size(); i += 200) {
            List<String> batch = distinctNames.subList(i, Math.min(i + 200, distinctNames.size()));
            List<Topic> duplicates = topicMapper.selectList(new LambdaQueryWrapper<Topic>()
                    .in(Topic::getTopicName, batch));
            for (Topic duplicate : duplicates) {
                if (myTopicIds.contains(duplicate.getId())) {
                    continue;
                }
                if (reported.add(duplicate.getTopicName())) {
                    warnings.add("题干「" + brief(duplicate.getTopicName()) + "」与题库或其他试卷已有题目重复，请检查");
                }
            }
        }
    }

    /**
     * 删除试卷关联；旧题目无作答记录则逻辑删除，有作答记录则停用保留；仍被其他试卷引用则保留
     */
    private void removePaperTopics(Long paperId, String section) {
        LambdaQueryWrapper<PaperTopic> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(PaperTopic::getPaperId, paperId);
        if (!StringUtils.isEmpty(section)) {
            wrapper.eq(PaperTopic::getSection, section);
        }
        List<PaperTopic> oldList = paperTopicMapper.selectList(wrapper);
        if (CollectionUtils.isEmpty(oldList)) {
            return;
        }
        paperTopicMapper.delete(wrapper);
        for (PaperTopic old : oldList) {
            Long topicId = old.getTopicId();
            
            Long refCount = paperTopicMapper.selectCount(new LambdaQueryWrapper<PaperTopic>()
                    .eq(PaperTopic::getTopicId, topicId));
            if (refCount != null && refCount > 0) {
                continue;
            }
            Topic topic = topicMapper.selectById(topicId);
            if (topic == null) {
                continue;
            }
            Long recordCount = topicRecordMapper.selectCount(new LambdaQueryWrapper<TopicRecord>()
                    .eq(TopicRecord::getTopicId, topicId));
            if (recordCount != null && recordCount > 0) {
                
                topic.setStatus(StatusEnums.STOP.getCode());
                topicMapper.updateById(topic);
            } else {
                topicMapper.deleteById(topicId);
            }
        }
    }

    /**
     * 全卷题序重排：板块按 writing→listening→reading→translation，板块内保持录入顺序，连续 1..N
     */
    private void reorderPaperSorted(Long paperId) {
        List<PaperTopic> all = paperTopicMapper.selectList(new LambdaQueryWrapper<PaperTopic>()
                .eq(PaperTopic::getPaperId, paperId));
        if (CollectionUtils.isEmpty(all)) {
            return;
        }
        all.sort(Comparator
                .comparingInt((PaperTopic pt) -> {
                    int index = SECTION_ORDER.indexOf(pt.getSection());
                    return index < 0 ? SECTION_ORDER.size() : index;
                })
                .thenComparing(PaperTopic::getSorted, Comparator.nullsLast(Comparator.naturalOrder()))
                .thenComparing(PaperTopic::getId));
        long sorted = 1;
        for (PaperTopic paperTopic : all) {
            if (paperTopic.getSorted() == null || paperTopic.getSorted() != sorted) {
                paperTopic.setSorted(sorted);
                paperTopicMapper.updateById(paperTopic);
            }
            sorted++;
        }
    }

    /**
     * 子板块 → question_type 映射
     */
    private String mapQuestionType(String section, String subSection) {
        if ("writing".equals(section)) {
            return "writing";
        }
        if ("listening".equals(section)) {
            return "listening";
        }
        if ("translation".equals(section)) {
            return "translation";
        }
        if ("cloze".equals(subSection)) {
            return "cloze";
        }
        return "reading";
    }

    private String buildOptionsJson(List<PaperOptionDto> options) {
        if (CollectionUtils.isEmpty(options)) {
            return null;
        }
        List<PaperOptionDto> normalized = options.stream().map(option -> {
            PaperOptionDto item = new PaperOptionDto();
            item.setLabel(option.getLabel().trim().toUpperCase());
            item.setContent(option.getContent().trim());
            return item;
        }).toList();
        return JSON.toJSONString(normalized);
    }

    private List<PaperOptionDto> parseOptions(String optionsJson) {
        if (StringUtils.isEmpty(optionsJson)) {
            return new ArrayList<>();
        }
        try {
            List<PaperOptionDto> options = JSON.parseArray(optionsJson, PaperOptionDto.class);
            return options == null ? new ArrayList<>() : options;
        } catch (Exception e) {
            log.warn("解析题目选项失败：{}", optionsJson);
            return new ArrayList<>();
        }
    }

    private String brief(String text) {
        if (text == null) {
            return "";
        }
        return text.length() <= 20 ? text : text.substring(0, 20) + "...";
    }
}
