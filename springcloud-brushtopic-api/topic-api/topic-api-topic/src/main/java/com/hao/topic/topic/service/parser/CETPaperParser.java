package com.hao.topic.topic.service.parser;

import com.hao.topic.model.dto.topic.PaperOptionDto;
import com.hao.topic.model.vo.topic.PaperParseResultVo;
import com.hao.topic.model.vo.topic.PaperParseResultVo.ParseSubSectionVo;
import com.hao.topic.model.vo.topic.PaperParseResultVo.ParseTopicVo;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * CET 试卷纯文本解析器（规则移植自已验证的 import_cet.py，增强双格式兼容）
 * 无状态：文本 -> 草稿结构，解析质量由人工在编辑器核对后保存
 */
public class CETPaperParser {

    private static final String WRITING = "writing";
    private static final String LISTENING = "listening";
    private static final String READING = "reading";
    private static final String TRANSLATION = "translation";

    /**
     * 选项标记：行首或空白后的 A-D 加 ) . ） : 等分隔
     */
    private static final Pattern OPTION_MARK = Pattern.compile("(?:^|[\\s\u3000])([A-D])\\s*[).\\]）:：]\\s");

    /**
     * 题号行：如 "26. xxx" "1、xxx" "46) xxx"
     */
    private static final Pattern QUESTION_LINE = Pattern.compile("^\\s*(\\d{1,2})\\s*[.)\\]）】:：]\\s*(.*)$");

    /**
     * 区间答案：【1-5】CBDAA / 1-5:CBDAA / 【36-40】JGOKB
     */
    private static final Pattern RANGE_ANSWER = Pattern.compile("[【\\[]?\\s*(\\d+)[-–—](\\d+)\\s*[】\\]]?\\s*[：:]?\\s*([A-Za-z]{1,20})");

    /**
     * 单行答案：1. A  2. B
     */
    private static final Pattern SINGLE_ANSWER = Pattern.compile("(\\d+)\\s*[.)\\]）】]\\s*([A-D])\\b");

    /**
     * Part 标记行
     */
    private static final Pattern PART_LINE = Pattern.compile("^\\s*Part\\s*([IVX]+)\\b.*$", Pattern.CASE_INSENSITIVE);

    /**
     * 听力子板块声明：Questions 1 to 3 are based on the news report / long conversation / passage
     */
    private static final Pattern LISTEN_DECLARE = Pattern.compile(
            "Questions?\\s+(\\d+)\\s+(?:to|and)\\s+(\\d+)\\s+are\\s+based\\s+on\\s+(?:the\\s+|these\\s+)?([a-zA-Z]+)");

    /**
     * Section 行：Section A/B/C
     */
    private static final Pattern SECTION_LINE = Pattern.compile("^\\s*Section\\s+([ABC])\\b.*$", Pattern.CASE_INSENSITIVE);

    /**
     * cloze 题号空白：___26___ 或 " 26 "
     */
    private static final Pattern BLANK_NUM = Pattern.compile("_\\s*(\\d{2})\\s*_|(?<![\\d.])(\\d{2})(?![\\d.])");

    /**
     * 词库行（带字母，可能一行多个）：A) wore  I) intense
     */
    private static final Pattern WORD_BANK_ENTRY = Pattern.compile("([A-O])\\s*[).、]\\s*([a-zA-Z][a-zA-Z'\\-]{1,19})");

    /**
     * 词库行（无字母，老格式）
     */
    private static final Pattern BARE_WORD = Pattern.compile("^[a-zA-Z][a-zA-Z'\\-]{1,19}$");

    /**
     * 段落标记：[A]
     */
    private static final Pattern PARA_MARK = Pattern.compile("^\\s*\\[([A-O])\\]\\s*");

    /**
     * 说明行（不并入题目块）
     */
    private static final Pattern IGNORE_IN_BLOCK = Pattern.compile(
            "^(Directions.*|Section\\s+[ABC].*|Part\\s+.+|Questions?\\s+\\d+.*|Passage\\s+(One|Two|1|2).*)$",
            Pattern.CASE_INSENSITIVE);

    private static final Pattern CHINESE = Pattern.compile("[\\u4e00-\\u9fff]");

    private static final char[] LETTERS = "ABCDEFGHIJKLMNO".toCharArray();

    /**
     * 选词填空空号范围（标准卷 26-35，老编号卷 36-45）
     */
    private static final int MIN_BLANK_NO = 26;

    private static final int MAX_BLANK_NO = 45;

    /**
     * 解析入口
     *
     * @param lines          文本行（docx 解析时已含表格单元格文本，保持文档顺序）
     * @param sectionHint    文本无 Part 标记时按此大板块兜底（可空）
     * @param subSectionHint 粘贴单子板块时的目标子板块（可空）
     */
    public PaperParseResultVo parse(List<String> lines, String sectionHint, String subSectionHint) {
        PaperParseResultVo result = new PaperParseResultVo();
        List<String> text = normalize(lines);
        if (text.isEmpty()) {
            result.addWarning("文本为空，未解析出内容");
            return result;
        }

        // 1. 提取答案区（文档后部）
        List<String> contentLines = new ArrayList<>();
        List<String> answerLines = new ArrayList<>();
        splitAnswerArea(text, contentLines, answerLines);
        Map<Integer, String> answers = parseAnswerArea(answerLines);
        if (answers.isEmpty()) {
            result.addWarning("未识别到答案区，所有题目需人工核对补充答案");
        }

        // 2. 大板块切分
        Map<String, List<String>> parts = splitParts(contentLines);

        if (!parts.isEmpty()) {
            parsePart(WRITING, parts.get(WRITING), answers, result, subSectionHint);
            parsePart(LISTENING, parts.get(LISTENING), answers, result, subSectionHint);
            parsePart(READING, parts.get(READING), answers, result, subSectionHint);
            parsePart(TRANSLATION, parts.get(TRANSLATION), answers, result, subSectionHint);
            // 有听力区域但未解析出题目（部分真题卷注明听力与其他套重复而未给出）
            List<String> listenLines = parts.get(LISTENING);
            boolean hasListenResult = result.getSubSections().stream()
                    .anyMatch(s -> LISTENING.equals(s.getSection()));
            if (listenLines != null && !listenLines.isEmpty() && !hasListenResult) {
                result.addWarning("听力部分未解析出题目（该真题可能注明听力与其他套重复而未给出，或排版特殊），请人工补充");
            }
        } else if (!isEmpty(sectionHint)) {
            // 无 Part 标记：按前端传入的大板块兜底
            parsePart(sectionHint, contentLines, answers, result, subSectionHint);
        }

        if (result.getSubSections().isEmpty()) {
            result.addWarning("未解析出题目：文本缺少 Part/Section 标记或格式不受支持，可尝试粘贴单个板块文本");
        }
        // 答案区中的参考范文/参考译文回填写作与翻译
        fillSpecialAnswers(result, answerLines);
        return result;
    }

    // ==================== 文本归一化 ====================

    private List<String> normalize(List<String> raw) {
        List<String> lines = new ArrayList<>();
        for (String line : raw) {
            if (line == null) {
                continue;
            }
            String s = line.replace("\r", "").replace("\u3000", " ")
                    .replace("\u2160", "I").replace("\u2161", "II")
                    .replace("\u2162", "III").replace("\u2163", "IV");
            s = s.trim();
            if (!s.isEmpty()) {
                lines.add(s);
            }
        }
        return lines;
    }

    // ==================== 答案区 ====================

    /**
     * 切分正文与答案区：从"参考答案"或后部的【x-y】样式行开始视为答案区
     */
    private void splitAnswerArea(List<String> lines, List<String> content, List<String> answer) {
        int start = -1;
        int half = lines.size() / 2;
        for (int i = half; i < lines.size(); i++) {
            if (lines.get(i).contains("参考答案")) {
                start = i;
                break;
            }
        }
        if (start == -1) {
            for (int i = half; i < lines.size(); i++) {
                String line = lines.get(i).trim();
                if (line.matches("^[【\\[（(\\s]*\\d+[-–—]\\d+.*") || RANGE_ANSWER.matcher(line).lookingAt()) {
                    start = i;
                    break;
                }
            }
        }
        if (start == -1) {
            content.addAll(lines);
            return;
        }
        content.addAll(lines.subList(0, start));
        answer.addAll(lines.subList(start, lines.size()));
    }

    /**
     * 解析答案区：区间字母（【1-5】CBDAA）、单词答案、单行答案
     */
    private Map<Integer, String> parseAnswerArea(List<String> lines) {
        Map<Integer, String> answers = new TreeMap<>();
        if (lines.isEmpty()) {
            return answers;
        }
        String text = String.join("\n", lines);

        Matcher rm = RANGE_ANSWER.matcher(text);
        while (rm.find()) {
            int start = Integer.parseInt(rm.group(1));
            int end = Integer.parseInt(rm.group(2));
            String ansStr = rm.group(3).toUpperCase();
            if (end >= start && end - start + 1 == ansStr.length()) {
                for (int i = 0; i < ansStr.length(); i++) {
                    answers.put(start + i, String.valueOf(ansStr.charAt(i)));
                }
            }
        }

        // 单词答案：【26-30】word1  word2 （两个以上空格分隔）
        Pattern wordRange = Pattern.compile("[【\\[]?\\s*(\\d+)[-–—](\\d+)\\s*[】\\]]?\\s*[：:]?\\s*(.+?)(?=[【\\[]?\\s*\\d+[-–—]\\d+|$)");
        Matcher wm = wordRange.matcher(text);
        while (wm.find()) {
            int start = Integer.parseInt(wm.group(1));
            int end = Integer.parseInt(wm.group(2));
            String wordsText = wm.group(3).trim();
            if (wordsText.matches("^[A-Za-z]{1,20}$") || wordsText.isEmpty()) {
                continue;
            }
            String[] parts = wordsText.split("\\s{2,}|\t|\\n");
            List<String> words = new ArrayList<>();
            for (String w : parts) {
                if (!w.trim().isEmpty()) {
                    words.add(w.trim());
                }
            }
            if (end >= start && words.size() == end - start + 1) {
                for (int i = 0; i < words.size(); i++) {
                    answers.put(start + i, words.get(i));
                }
            }
        }

        Matcher sm = SINGLE_ANSWER.matcher(text);
        while (sm.find()) {
            int num = Integer.parseInt(sm.group(1));
            answers.putIfAbsent(num, sm.group(2));
        }
        return answers;
    }

    /**
     * 答案区里的参考范文/参考译文回填写作与翻译题
     */
    private void fillSpecialAnswers(PaperParseResultVo result, List<String> answerLines) {
        if (answerLines.isEmpty()) {
            return;
        }
        String writingSample = extractMarkedText(answerLines,
                new String[]{"参考范文", "范文", "Sample"}, new String[]{"翻译参考译文", "参考译文", "Reference Translation"});
        String translationRef = extractMarkedText(answerLines,
                new String[]{"翻译参考译文", "参考译文", "Reference Translation"}, new String[]{"参考范文", "范文"});
        for (ParseSubSectionVo sub : result.getSubSections()) {
            if (WRITING.equals(sub.getSection()) && writingSample != null) {
                for (ParseTopicVo topic : sub.getTopics()) {
                    if (isEmpty(topic.getAnswer())) {
                        topic.setAnswer(writingSample);
                        topic.setWarning(null);
                    }
                }
            }
            if (TRANSLATION.equals(sub.getSection()) && translationRef != null) {
                for (ParseTopicVo topic : sub.getTopics()) {
                    if (isEmpty(topic.getAnswer())) {
                        topic.setAnswer(translationRef);
                        topic.setWarning(null);
                    }
                }
            }
        }
    }

    private String extractMarkedText(List<String> lines, String[] markers, String[] stopMarkers) {
        int idx = -1;
        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            for (String marker : markers) {
                if (line.contains(marker)) {
                    idx = i;
                    break;
                }
            }
            if (idx >= 0) {
                break;
            }
        }
        if (idx == -1) {
            return null;
        }
        StringBuilder sb = new StringBuilder();
        for (int i = idx + 1; i < lines.size(); i++) {
            String line = lines.get(i);
            boolean stop = line.startsWith("Part") || RANGE_ANSWER.matcher(line).find();
            for (String stopMarker : stopMarkers) {
                if (line.contains(stopMarker)) {
                    stop = true;
                    break;
                }
            }
            if (stop) {
                break;
            }
            if (sb.length() > 0) {
                sb.append(sb.indexOf("。") >= 0 || CHINESE.matcher(line).find() ? "" : " ");
            }
            sb.append(line);
            if (CHINESE.matcher(line).find()) {
                sb.append("\n");
            }
        }
        String text = sb.toString().trim();
        return text.isEmpty() ? null : text;
    }

    // ==================== 大板块切分 ====================

    /**
     * 按 Part 标记切分正文；返回 section -> 行列表（找不到 Part 时返回空 Map）
     */
    private Map<String, List<String>> splitParts(List<String> lines) {
        Map<String, List<String>> parts = new LinkedHashMap<>();
        String current = null;
        for (String line : lines) {
            if (line.trim().startsWith("Part")) {
                String part = detectPart(line);
                if (part != null) {
                    current = part;
                    parts.putIfAbsent(current, new ArrayList<>());
                    continue;
                }
            }
            if (current != null) {
                parts.get(current).add(line);
            }
        }
        return parts;
    }

    private String detectPart(String line) {
        String lower = line.toLowerCase();
        if (lower.contains("writing") || lower.contains("作文")) {
            return WRITING;
        }
        if (lower.contains("listening") || lower.contains("听力")) {
            return LISTENING;
        }
        if (lower.contains("reading") || lower.contains("阅读")) {
            return READING;
        }
        if (lower.contains("translation") || lower.contains("翻译")) {
            return TRANSLATION;
        }
        Matcher m = Pattern.compile("Part\\s*([IVX]+)(?![A-Za-z])", Pattern.CASE_INSENSITIVE).matcher(line);
        if (m.find()) {
            return switch (m.group(1).toUpperCase()) {
                case "I" -> WRITING;
                case "II" -> LISTENING;
                case "III" -> READING;
                case "IV" -> TRANSLATION;
                default -> null;
            };
        }
        return null;
    }

    private void parsePart(String section, List<String> lines, Map<Integer, String> answers,
                           PaperParseResultVo result, String subSectionHint) {
        if (lines == null || lines.isEmpty()) {
            return;
        }
        switch (section) {
            case WRITING -> parseWriting(lines, answers, result);
            case LISTENING -> parseListening(lines, answers, result);
            case READING -> parseReading(lines, answers, result, subSectionHint);
            case TRANSLATION -> parseTranslation(lines, answers, result);
            default -> {
            }
        }
    }

    // ==================== 写作 ====================

    private void parseWriting(List<String> lines, Map<Integer, String> answers, PaperParseResultVo result) {
        int dirIdx = -1;
        for (int i = 0; i < lines.size(); i++) {
            if (lines.get(i).startsWith("Directions")) {
                dirIdx = i;
                break;
            }
        }
        if (dirIdx == -1) {
            return;
        }
        StringBuilder sb = new StringBuilder();
        for (int i = dirIdx; i < lines.size(); i++) {
            String line = lines.get(i);
            if (line.startsWith("Part") || line.startsWith("Section")) {
                break;
            }
            if (sb.length() > 0) {
                sb.append("\n");
            }
            sb.append(line);
        }
        String topicName = sb.toString().trim();
        if (topicName.isEmpty()) {
            return;
        }
        ParseSubSectionVo sub = newSubSection(result, WRITING, WRITING, null);
        ParseTopicVo topic = newTopic(sub);
        topic.setTopicName(topicName);
        topic.setOptions(new ArrayList<>());
        String sample = extractWritingSample(lines);
        if (sample != null) {
            topic.setAnswer(sample);
        } else {
            topic.setWarning("未解析到参考范文，可人工补充 answer");
        }
    }

    /**
     * 写作区内含【参考范文】/ Sample 标记时提取范文
     */
    private String extractWritingSample(List<String> lines) {
        int idx = -1;
        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            if (line.contains("参考范文") || line.contains("范文") || line.startsWith("Sample")) {
                idx = i;
                break;
            }
        }
        if (idx == -1) {
            return null;
        }
        StringBuilder sb = new StringBuilder();
        for (int i = idx + 1; i < lines.size(); i++) {
            String line = lines.get(i);
            if (line.startsWith("Part") || RANGE_ANSWER.matcher(line).find()) {
                break;
            }
            if (sb.length() > 0) {
                sb.append("\n");
            }
            sb.append(line);
        }
        String text = sb.toString().trim();
        return text.isEmpty() ? null : text;
    }

    // ==================== 听力 ====================

    private void parseListening(List<String> lines, Map<Integer, String> answers, PaperParseResultVo result) {
        // 1. 声明区间：Questions 1 to 3 are based on the news report...
        Map<Integer, String> declareMap = new LinkedHashMap<>();
        for (String line : lines) {
            Matcher dm = LISTEN_DECLARE.matcher(line);
            while (dm.find()) {
                int start = Integer.parseInt(dm.group(1));
                int end = Integer.parseInt(dm.group(2));
                String type = classifyListenType(dm.group(3));
                for (int n = start; n <= end; n++) {
                    declareMap.put(n, type);
                }
            }
        }
        boolean hasNews = lines.stream().anyMatch(l -> l.toLowerCase().contains("news report"));

        // 2. 按题号切块
        Map<Integer, List<String>> blocks = splitNumberedBlocks(lines, 1, 25);
        if (blocks.isEmpty()) {
            return;
        }

        Map<String, ParseSubSectionVo> subs = new LinkedHashMap<>();
        int missingStem = 0;
        for (Map.Entry<Integer, List<String>> entry : blocks.entrySet()) {
            int no = entry.getKey();
            Blank blank = splitBlock(entry.getValue());

            String subSection = declareMap.get(no);
            if (subSection == null) {
                subSection = fallbackListen(no, hasNews);
            }
            ParseSubSectionVo sub = subs.computeIfAbsent(subSection,
                    k -> newSubSection(result, LISTENING, k, null));
            ParseTopicVo topic = newTopic(sub);
            if (blank.stem.isEmpty()) {
                topic.setTopicName("Q" + no);
                missingStem++;
            } else {
                topic.setTopicName("Q" + no + ": " + blank.stem);
            }
            topic.setOptions(blank.options);
            String answer = answers.get(no);
            if (answer != null) {
                topic.setAnswer(answer);
                if (answer.length() == 1 && answer.matches("[A-D]")) {
                    topic.setCorrectOption(answer);
                }
            } else {
                topic.setWarning("未匹配到答案");
            }
            if (blank.options.size() < 2) {
                topic.setWarning(join(topic.getWarning(), "未解析到完整选项，请人工核对"));
            }
        }
        if (missingStem > 0) {
            result.addWarning("听力部分有 " + missingStem + " 题无书面题干（原文在音频中），已用题号占位，可人工补充");
        }
    }

    private String classifyListenType(String word) {
        String w = word.toLowerCase();
        if (w.startsWith("news")) {
            return "news";
        }
        if (w.startsWith("conversation")) {
            return "conversation";
        }
        return "passage";
    }

    /**
     * 无声明行时的听力子板块兜底：含 news 关键词按 1-7/8-15/16-25，否则按老格式 1-8/9-25
     */
    private String fallbackListen(int no, boolean hasNews) {
        if (hasNews) {
            if (no <= 7) {
                return "news";
            }
            return no <= 15 ? "conversation" : "passage";
        }
        return no <= 8 ? "conversation" : "passage";
    }

    // ==================== 阅读 ====================

    private void parseReading(List<String> lines, Map<Integer, String> answers,
                              PaperParseResultVo result, String subSectionHint) {
        // 按 Section A/B/C 切分
        Map<String, List<String>> sections = new LinkedHashMap<>();
        String current = null;
        for (String line : lines) {
            Matcher sm = SECTION_LINE.matcher(line);
            if (sm.matches()) {
                current = sm.group(1).toUpperCase();
                sections.putIfAbsent(current, new ArrayList<>());
                continue;
            }
            if (current != null) {
                sections.get(current).add(line);
            }
        }
        if (!sections.isEmpty()) {
            if (sections.containsKey("A")) {
                parseCloze(sections.get("A"), answers, result);
            }
            if (sections.containsKey("B")) {
                parseMatching(sections.get("B"), answers, result);
            }
            if (sections.containsKey("C")) {
                parseCarefulReading(sections.get("C"), answers, result, "One", 46);
            }
            return;
        }
        // 无 Section 标记：优先按目标子板块解析
        if ("cloze".equals(subSectionHint)) {
            parseCloze(lines, answers, result);
            return;
        }
        if ("matching".equals(subSectionHint)) {
            parseMatching(lines, answers, result);
            return;
        }
        if ("reading_1".equals(subSectionHint) || "reading_2".equals(subSectionHint)) {
            parseCarefulReading(lines, answers, result,
                    "reading_1".equals(subSectionHint) ? "One" : "Two",
                    "reading_1".equals(subSectionHint) ? 46 : 51);
            return;
        }
        // 结构兜底：含 Passage 视为仔细阅读，含 [A] 视为匹配，含空白题号视为选词填空
        boolean hasPassage = lines.stream().anyMatch(l -> l.matches("^\\s*Passage\\s+.*"));
        boolean hasParaMark = lines.stream().anyMatch(this::isParaMark);
        boolean hasBlank = lines.stream().anyMatch(l -> !findBlankNums(l).isEmpty());
        if (hasPassage) {
            parseCarefulReading(lines, answers, result, "One", 46);
        } else if (hasParaMark) {
            parseMatching(lines, answers, result);
        } else if (hasBlank) {
            parseCloze(lines, answers, result);
        }
    }

    /**
     * 选词填空（Section A）：题号兼容 ___26___ 与 26 空格样式，词库兼容带字母与裸单词
     */
    private void parseCloze(List<String> lines, Map<Integer, String> answers, PaperParseResultVo result) {
        List<String> body = skipDirections(lines);
        // 最后一道题号所在行
        int lastQIdx = -1;
        for (int i = 0; i < body.size(); i++) {
            String line = body.get(i);
            if (line.matches("^Questions?\\s+\\d+\\s+to\\s+\\d+.*")) {
                continue;
            }
            if (!findBlankNums(line).isEmpty()) {
                lastQIdx = i;
            }
        }
        if (lastQIdx == -1) {
            return;
        }
        List<String> articleLines = new ArrayList<>();
        List<String> bankLines = new ArrayList<>();
        for (int i = 0; i < body.size(); i++) {
            String line = body.get(i);
            // 跳过 "Questions 26 to 35 are based on the following passage." 声明行，避免干扰题号定位
            if (line.matches("^Questions?\\s+\\d+\\s+to\\s+\\d+.*")) {
                continue;
            }
            if (i <= lastQIdx) {
                articleLines.add(line);
            } else {
                bankLines.add(line);
            }
        }
        String article = String.join("\n", articleLines);

        Map<String, String> wordBank = extractWordBank(bankLines);
        if (wordBank.size() != 15) {
            result.addWarning("选词填空词库解析出 " + wordBank.size() + " 个词（应为 15 个），请人工核对");
        }

        ParseSubSectionVo sub = newSubSection(result, READING, "cloze", "Cloze Passage:\n" + article);

        // 题号定位：标准卷 26-35，老编号卷 36-45（按候选空号的最优连续 10 号窗口判定）
        Set<Integer> candidates = new TreeSet<>();
        for (String line : articleLines) {
            candidates.addAll(findBlankNums(line));
        }
        int startNo = MIN_BLANK_NO;
        int bestScore = -1;
        for (int s = MIN_BLANK_NO; s <= MAX_BLANK_NO - 9; s++) {
            int score = 0;
            for (int n = s; n <= s + 9; n++) {
                if (candidates.contains(n)) {
                    score++;
                }
            }
            if (score > bestScore) {
                bestScore = score;
                startNo = s;
            }
        }
        Map<Integer, Integer> numPos = new TreeMap<>();
        int from = 0;
        for (int n = startNo; n <= startNo + 9; n++) {
            int pos = findBlankNum(article, n, from);
            if (pos >= 0) {
                numPos.put(n, pos);
                from = pos + 1;
            }
        }
        if (numPos.size() != 10) {
            result.addWarning("选词填空仅定位到 " + numPos.size() + " 个题号（应为 10 个），请人工核对");
        }

        List<PaperOptionDto> bankOptions = new ArrayList<>();
        for (Map.Entry<String, String> e : wordBank.entrySet()) {
            PaperOptionDto option = new PaperOptionDto();
            option.setLabel(e.getKey());
            option.setContent(e.getValue());
            bankOptions.add(option);
        }

        for (Map.Entry<Integer, Integer> e : numPos.entrySet()) {
            int no = e.getKey();
            ParseTopicVo topic = newTopic(sub);
            topic.setTopicName(no + ". " + extractSentence(article, e.getValue()));
            topic.setOptions(new ArrayList<>(bankOptions));
            String answer = answers.get(no);
            if (answer != null) {
                topic.setAnswer(wordBank.getOrDefault(answer.toUpperCase(), answer));
                if (answer.length() == 1) {
                    topic.setCorrectOption(answer.toUpperCase());
                }
            } else {
                topic.setWarning("未匹配到答案");
            }
            if (bankOptions.isEmpty()) {
                topic.setWarning(join(topic.getWarning(), "未解析到词库"));
            }
        }
    }

    /**
     * 提取词库：带字母条目按字母映射；裸词按出现顺序收集（混合格式将裸词按序补入空缺字母位）
     */
    private Map<String, String> extractWordBank(List<String> bankLines) {
        Map<String, String> lettered = new LinkedHashMap<>();
        List<String> bare = new ArrayList<>();
        for (String line : bankLines) {
            if (!findBlankNums(line).isEmpty()) {
                continue;
            }
            Matcher m = WORD_BANK_ENTRY.matcher(line);
            boolean hasEntry = false;
            while (m.find()) {
                lettered.putIfAbsent(m.group(1), m.group(2));
                hasEntry = true;
            }
            if (hasEntry) {
                if (lettered.size() + bare.size() >= 15) {
                    break;
                }
                continue;
            }
            // 无字母行：按 2+ 空格或 tab 拆词
            boolean nonWord = false;
            for (String part : line.split("\\s{2,}|\t")) {
                String w = part.trim();
                if (w.isEmpty()) {
                    continue;
                }
                if (BARE_WORD.matcher(w).matches()) {
                    bare.add(w);
                } else {
                    nonWord = true;
                    break;
                }
            }
            if (nonWord) {
                // 已收集成规模（>=10）视为词库结束；否则清掉杂项积累继续扫描
                if (lettered.size() >= 10 || bare.size() >= 10) {
                    break;
                }
                bare.clear();
            }
            if (lettered.size() + bare.size() >= 15) {
                break;
            }
        }
        Map<String, String> bank = new LinkedHashMap<>();
        if (lettered.size() + bare.size() < 15) {
            return bank;
        }
        if (lettered.isEmpty()) {
            // 老格式：裸词按序映射 A-O
            for (int i = 0; i < 15; i++) {
                bank.put(String.valueOf(LETTERS[i]), bare.get(i));
            }
            return bank;
        }
        // 混合格式：带字母条目为准，裸词按序补入空缺字母位
        int idx = 0;
        for (char c : LETTERS) {
            String key = String.valueOf(c);
            if (lettered.containsKey(key)) {
                bank.put(key, lettered.get(key));
            } else if (idx < bare.size()) {
                bank.put(key, bare.get(idx++));
            }
        }
        return bank;
    }

    /**
     * 长篇匹配（Section B）：[A]-[O] 段落文章 + 36-45 语句
     */
    private void parseMatching(List<String> lines, Map<Integer, String> answers, PaperParseResultVo result) {
        List<String> body = skipDirections(lines);
        // 文章：[A] 标记行范围
        int firstPara = -1;
        int lastPara = -1;
        for (int i = 0; i < body.size(); i++) {
            if (isParaMark(body.get(i))) {
                if (firstPara == -1) {
                    firstPara = i;
                }
                lastPara = i;
            }
        }
        if (firstPara == -1) {
            return;
        }
        String title = firstPara > 0 ? body.get(firstPara - 1) : null;
        if (title != null && (title.startsWith("Directions") || title.startsWith("Section")
                || title.matches("^Questions?\\s+\\d+.*"))) {
            title = null;
        }
        StringBuilder article = new StringBuilder();
        if (title != null) {
            article.append(title).append("\n\n");
        }
        Set<Integer> articleIdx = new HashSet<>();
        for (int i = firstPara; i <= lastPara; i++) {
            article.append(body.get(i)).append("\n");
            articleIdx.add(i);
        }
        String articleText = article.toString().trim();

        ParseSubSectionVo sub = newSubSection(result, READING, "matching", articleText);

        List<PaperOptionDto> options = new ArrayList<>();
        for (char c : LETTERS) {
            Pattern mark = Pattern.compile("(?m)(^|\\n)\\s*\\[?" + c + "\\s*[).、）\\]]");
            if (mark.matcher(articleText).find()) {
                PaperOptionDto option = new PaperOptionDto();
                option.setLabel(String.valueOf(c));
                option.setContent("Paragraph " + c);
                options.add(option);
            }
        }

        // 题目：编号行（标准 36-45，老编号卷 46-55 等）
        List<String> questionLines = new ArrayList<>();
        for (int i = 0; i < body.size(); i++) {
            if (!articleIdx.contains(i)) {
                questionLines.add(body.get(i));
            }
        }
        int startNo = 36;
        for (String line : questionLines) {
            Matcher qm = QUESTION_LINE.matcher(line);
            if (qm.matches()) {
                int no = Integer.parseInt(qm.group(1));
                if (no >= 26 && no <= 65) {
                    startNo = no;
                    break;
                }
            }
        }
        Map<Integer, List<String>> blocks = splitNumberedBlocks(questionLines, startNo, startNo + 9);
        if (blocks.isEmpty()) {
            // 无编号：按每行一条语句兜底
            int no = startNo;
            for (String line : questionLines) {
                if (line.length() > 3 && no <= startNo + 9) {
                    blocks.computeIfAbsent(no++, k -> new ArrayList<>()).add(line);
                }
            }
        }
        for (Map.Entry<Integer, List<String>> entry : blocks.entrySet()) {
            ParseTopicVo topic = newTopic(sub);
            String stem = String.join(" ", entry.getValue()).trim();
            topic.setTopicName(entry.getKey() + ". " + stem);
            topic.setOptions(new ArrayList<>(options));
            String answer = answers.get(entry.getKey());
            if (answer != null) {
                topic.setAnswer(answer);
                topic.setCorrectOption(answer);
            } else {
                topic.setWarning("未匹配到答案");
            }
        }
        if (options.isEmpty()) {
            for (ParseTopicVo topic : sub.getTopics()) {
                topic.setWarning(join(topic.getWarning(), "文章缺少 [A]-[O] 段落标记"));
            }
        }
    }

    /**
     * 段落标记判定：兼容 [A] 与 "A) 长文本"（匹配文章段落）两种排版
     */
    private boolean isParaMark(String line) {
        if (PARA_MARK.matcher(line).find()) {
            return true;
        }
        Matcher m = Pattern.compile("^\\s*([A-O])\\s*[).、）]\\s*(.+)$").matcher(line);
        if (m.matches()) {
            return m.group(2).trim().length() >= 40;
        }
        return false;
    }

    /**
     * 仔细阅读（Section C）：Passage One/Two + 46-55
     */
    private void parseCarefulReading(List<String> lines, Map<Integer, String> answers,
                                     PaperParseResultVo result, String fallbackName, int fallbackStartNo) {
        List<String> body = skipDirections(lines);
        int p1 = -1;
        int p2 = -1;
        for (int i = 0; i < body.size(); i++) {
            String line = body.get(i);
            if (line.matches("^Passage\\s+(One|1)\\b.*")) {
                p1 = i;
            } else if (line.matches("^Passage\\s+(Two|2)\\b.*")) {
                p2 = i;
            }
        }
        if (p1 == -1) {
            parseOnePassage(body, fallbackName, detectPassageStartNo(body, fallbackStartNo), answers, result);
            return;
        }
        int end1 = p2 == -1 ? body.size() : p2;
        List<String> pass1 = body.subList(p1, end1);
        int s1 = detectPassageStartNo(pass1, fallbackStartNo);
        parseOnePassage(pass1, "One", s1, answers, result);
        if (p2 != -1) {
            List<String> pass2 = body.subList(p2, body.size());
            parseOnePassage(pass2, "Two", detectPassageStartNo(pass2, s1 + 5), answers, result);
        }
    }

    /**
     * 动态识别仔细阅读起始题号（标准 46/51，老编号卷 56/61），兼容首题无编号
     */
    private int detectPassageStartNo(List<String> lines, int defStart) {
        for (int i = 0; i < lines.size(); i++) {
            Matcher qm = QUESTION_LINE.matcher(lines.get(i));
            if (qm.matches()) {
                int no = Integer.parseInt(qm.group(1));
                if (no >= 26 && no <= 65) {
                    // 首编号前存在无编号题块时，真实起始号为其前若干题
                    int structStart = detectUnnumberedBlockBefore(lines, i);
                    if (structStart >= 0) {
                        return no - unnumberedBlockCount(i - structStart);
                    }
                    return no;
                }
            }
        }
        return defStart;
    }

    private void parseOnePassage(List<String> lines, String name, int startNo,
                                 Map<Integer, String> answers, PaperParseResultVo result) {
        String subSection = name.equals("One") ? "reading_1" : "reading_2";
        // 题目区起点：46/51 开头的编号行
        int firstQ = -1;
        for (int i = 0; i < lines.size(); i++) {
            Matcher qm = QUESTION_LINE.matcher(lines.get(i));
            if (qm.matches()) {
                int no = Integer.parseInt(qm.group(1));
                if (no >= startNo && no <= startNo + 4) {
                    firstQ = i;
                    break;
                }
            }
        }
        Map<Integer, List<String>> blocks;
        String article;
        if (firstQ >= 0) {
            // 特例：首编号前有无编号题块（单块或多块连排）时，向前捕获这些题块
            int structStart = -1;
            Matcher fq = QUESTION_LINE.matcher(lines.get(firstQ));
            if (fq.matches() && Integer.parseInt(fq.group(1)) > startNo) {
                structStart = detectUnnumberedBlockBefore(lines, firstQ);
            }
            if (structStart >= 0) {
                article = articleFromPassage(lines.subList(0, structStart), name);
                blocks = new LinkedHashMap<>();
                int rowCount = firstQ - structStart;
                int blockCount = unnumberedBlockCount(rowCount);
                int per = rowCount / blockCount;
                int firstNo = Integer.parseInt(fq.group(1));
                for (int b = 0; b < blockCount; b++) {
                    int from = structStart + b * per;
                    int to = (b == blockCount - 1) ? firstQ : from + per;
                    blocks.put(firstNo - (blockCount - b), new ArrayList<>(lines.subList(from, to)));
                }
                blocks.putAll(splitNumberedBlocks(lines.subList(firstQ, lines.size()), startNo + 1, startNo + 4));
            } else {
                blocks = splitNumberedBlocks(lines.subList(firstQ, lines.size()), startNo, startNo + 4);
                article = articleFromPassage(lines.subList(0, firstQ), name);
            }
        } else {
            // 全无编号（题干 + 无字母选项连排，如部分卷的仔细阅读）：从区域末尾按 5 行一组向上识别题块
            int k = countTailUnnumberedBlocks(lines);
            if (k >= 4) {
                int start = lines.size() - k * 5;
                article = articleFromPassage(lines.subList(0, start), name);
                blocks = new LinkedHashMap<>();
                for (int b = 0; b < k; b++) {
                    blocks.put(startNo + b, new ArrayList<>(lines.subList(start + b * 5, start + (b + 1) * 5)));
                }
            } else {
                // 老格式：题干无编号，按"题干行 + 选项行"结构切分
                int split = findStructureQuestionStart(lines);
                if (split < 0) {
                    return;
                }
                article = articleFromPassage(lines.subList(0, split), name);
                blocks = splitStructureBlocks(lines.subList(split, lines.size()), startNo, startNo + 4);
            }
        }

        if (blocks.isEmpty()) {
            result.addWarning("仔细阅读 Passage " + name + " 未解析出题目，请人工处理");
            return;
        }
        ParseSubSectionVo sub = newSubSection(result, READING, subSection, article);
        int idx = 0;
        for (Map.Entry<Integer, List<String>> entry : blocks.entrySet()) {
            if (idx >= 5) {
                break;
            }
            int no = entry.getKey() > 0 ? entry.getKey() : startNo + idx;
            idx++;
            Blank blank = splitBlock(entry.getValue());
            ParseTopicVo topic = newTopic(sub);
            topic.setTopicName(no + ". " + blank.stem);
            topic.setOptions(blank.options);
            String answer = answers.get(no);
            if (answer != null) {
                topic.setAnswer(answer);
                if (answer.length() == 1 && answer.matches("[A-D]")) {
                    topic.setCorrectOption(answer);
                }
            } else {
                topic.setWarning("未匹配到答案");
            }
            if (blank.options.size() < 2) {
                topic.setWarning(join(topic.getWarning(), "未解析到完整选项"));
            }
        }
        if (sub.getTopics().size() < 5) {
            result.addWarning("仔细阅读 Passage " + name + " 仅解析出 " + sub.getTopics().size() + " 题（应为 5 题）");
        }
    }

    /**
     * 从 Passage 头部提取文章（标题 + 正文）
     */
    private String articleFromPassage(List<String> lines, String name) {
        List<String> clean = skipDirections(lines);
        if (clean.isEmpty()) {
            return null;
        }
        String title = null;
        int idx = 0;
        String first = clean.get(0);
        Matcher pm = Pattern.compile("^Passage\\s+(One|Two|1|2)\\s*[:：]?\\s*(.*)$").matcher(first);
        if (pm.matches()) {
            title = pm.group(2).trim();
            idx = 1;
            if (title.isEmpty() && idx < clean.size()) {
                String next = clean.get(idx);
                if (isTitleLike(next)) {
                    title = next;
                    idx = 2;
                }
            }
        } else if (isTitleLike(first)) {
            title = first;
            idx = 1;
        }
        StringBuilder sb = new StringBuilder("Passage ").append(name);
        if (title != null && !title.isEmpty()) {
            sb.append(": ").append(title);
        }
        sb.append("\n\n");
        for (int i = idx; i < clean.size(); i++) {
            String line = clean.get(i);
            if (line.matches("^Questions?\\s+\\d+.*") || line.matches("^Passage\\s+.*")
                    || line.startsWith("Section") || line.startsWith("Part")) {
                continue;
            }
            sb.append(line).append("\n");
        }
        return sb.toString().trim();
    }

    private boolean isTitleLike(String line) {
        return line.length() < 120 && !line.startsWith("Questions")
                && !line.matches("^\\d+.*") && !line.matches("^[A-D]\\s*[).\\]）:：].*");
    }

    /**
     * 检测 firstQ 之前是否存在无编号首题的题块，支持两种排版：
     * A) 无编号题干 + 无字母短行选项（2017 卷 46 题样式）：向上收集 4-5 个裸短行；
     * B) 无编号题干 + 带字母选项（如 A) 行，含单列/双列）：向上收集选项行后遇到的第一个裸短行即题干。
     */
    private int detectUnnumberedBlockBefore(List<String> lines, int firstQ) {
        int i = firstQ - 1;
        int bareCount = 0;
        int optionMarks = 0;
        while (i >= 0 && firstQ - i <= 21) {
            String line = lines.get(i);
            if (line.length() >= 120 || line.matches("^\\d+\\s*[.)\\]）】:：].*")
                    || IGNORE_IN_BLOCK.matcher(line).matches()) {
                break;
            }
            int marks = findStructureOptionCount(line);
            if (marks > 0) {
                optionMarks += marks;
            } else {
                // 模式 B：裸短行紧贴已收集的选项行（>=3 个标记）之上，即为无编号题干
                if (optionMarks >= 3) {
                    return i;
                }
                bareCount++;
            }
            i--;
        }
        // 模式 A：连续裸短行组 = 5n 行（n 个"题干 + 4 无字母选项"块；4 行兼容非标准排版）
        if (optionMarks == 0 && (bareCount == 4 || (bareCount >= 5 && bareCount <= 20 && bareCount % 5 == 0))) {
            return firstQ - bareCount;
        }
        return -1;
    }

    /**
     * 无编号区域行数换算块数：按每 5 行一块，非 5 的倍数（含 4 行兼容、模式 B）为 1 块
     */
    private int unnumberedBlockCount(int rowCount) {
        if (rowCount >= 5 && rowCount <= 40 && rowCount % 5 == 0) {
            return rowCount / 5;
        }
        return 1;
    }

    /**
     * 全无编号 Passage 的块定位：从区域末尾按 5 行一组向上步进（1 题干 + 4 选项），
     * 组首为问句/题干（非中文、非说明行）且其余行均为短行时计为一题块
     */
    private int countTailUnnumberedBlocks(List<String> lines) {
        int count = 0;
        int end = lines.size();
        while (end >= 5 && count < 5) {
            List<String> group = lines.subList(end - 5, end);
            String head = group.get(0);
            if (head.length() < 20 || CHINESE.matcher(head).find()
                    || IGNORE_IN_BLOCK.matcher(head).matches()) {
                break;
            }
            boolean ok = true;
            for (int j = 1; j < 5; j++) {
                if (group.get(j).length() >= 120 || IGNORE_IN_BLOCK.matcher(group.get(j)).matches()) {
                    ok = false;
                    break;
                }
            }
            if (!ok) {
                break;
            }
            count++;
            end -= 5;
        }
        return count;
    }

    /**
     * 老格式（题干无编号）题目区起始判定：第一个"后续 3 行内出现选项行"的非选项行
     */
    private int findStructureQuestionStart(List<String> lines) {
        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            if (line.matches("^[A-D]\\s*[).\\]）:：].*") || line.matches("^Questions?\\s+\\d+.*")
                    || line.matches("^Passage\\s+.*") || line.startsWith("Section")
                    || findStructureOptionCount(line) > 0) {
                continue;
            }
            for (int j = i + 1; j < Math.min(i + 4, lines.size()); j++) {
                if (lines.get(j).matches("^[A-D]\\s*[).\\]）:：].*") || findStructureOptionCount(lines.get(j)) > 0) {
                    return i;
                }
            }
        }
        return -1;
    }

    private int findStructureOptionCount(String line) {
        Matcher m = OPTION_MARK.matcher(line);
        int count = 0;
        while (m.find()) {
            count++;
        }
        return count;
    }

    /**
     * 结构切块：题干行开始，收集选项行（兼容两列布局）
     */
    private Map<Integer, List<String>> splitStructureBlocks(List<String> lines, int startNo, int endNo) {
        Map<Integer, List<String>> blocks = new LinkedHashMap<>();
        List<String> current = null;
        int no = startNo;
        for (String line : lines) {
            boolean isOptionLine = line.matches("^[A-D]\\s*[).\\]）:：].*") || findStructureOptionCount(line) > 0;
            if (!isOptionLine && (current == null || hasOptions(current))) {
                if (current != null) {
                    blocks.put(no++, current);
                }
                if (no > endNo) {
                    break;
                }
                current = new ArrayList<>();
                current.add(line);
            } else if (current != null) {
                current.add(line);
            }
        }
        if (current != null && !current.isEmpty() && no <= endNo) {
            blocks.put(no, current);
        }
        return blocks;
    }

    private boolean hasOptions(List<String> block) {
        return block.stream().anyMatch(l -> l.matches("^[A-D]\\s*[).\\]）:：].*"))
                || block.stream().anyMatch(l -> findStructureOptionCount(l) > 0);
    }

    // ==================== 翻译 ====================

    private void parseTranslation(List<String> lines, Map<Integer, String> answers, PaperParseResultVo result) {
        StringBuilder sb = new StringBuilder();
        for (String line : lines) {
            if (line.startsWith("Directions") || line.startsWith("Section") || line.startsWith("Part")) {
                continue;
            }
            if (CHINESE.matcher(line).find()) {
                sb.append(line);
            }
        }
        String text = sb.toString().trim();
        if (text.isEmpty()) {
            return;
        }
        ParseSubSectionVo sub = newSubSection(result, TRANSLATION, TRANSLATION, null);
        ParseTopicVo topic = newTopic(sub);
        topic.setTopicName(text);
        topic.setOptions(new ArrayList<>());
        String ref = extractTranslationRef(lines);
        if (ref != null) {
            topic.setAnswer(ref);
        } else {
            topic.setWarning("未解析到参考译文，可人工补充 answer");
        }
    }

    private String extractTranslationRef(List<String> lines) {
        int idx = -1;
        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            if (line.contains("翻译参考译文") || line.contains("Reference Translation") || line.contains("参考译文")) {
                idx = i;
                break;
            }
        }
        if (idx == -1) {
            return null;
        }
        StringBuilder sb = new StringBuilder();
        for (int i = idx + 1; i < lines.size(); i++) {
            String line = lines.get(i);
            if (line.startsWith("Part") || line.contains("参考范文") || RANGE_ANSWER.matcher(line).find()) {
                break;
            }
            if (sb.length() > 0) {
                sb.append(" ");
            }
            sb.append(line);
        }
        String text = sb.toString().trim();
        return text.isEmpty() ? null : text;
    }

    // ==================== 通用工具 ====================

    /**
     * 跳过 Directions 说明行（仅跳过以 Directions 开头及已知的说明续行）
     */
    private List<String> skipDirections(List<String> lines) {
        List<String> result = new ArrayList<>();
        boolean skipping = false;
        for (String line : lines) {
            if (line.startsWith("Directions")) {
                skipping = true;
                continue;
            }
            if (skipping) {
                String lower = line.toLowerCase();
                boolean continuation = lower.startsWith("you may not") || lower.startsWith("read the passage")
                        || lower.startsWith("in this section") || lower.startsWith("you should")
                        || lower.startsWith("write your answer") || lower.startsWith("answer sheet")
                        || lower.startsWith("mark the corresponding") || lower.startsWith("each choice")
                        || lower.startsWith("please") || lower.startsWith("for this part")
                        || lower.startsWith("you are required") || lower.startsWith("there is a passage");
                if (continuation) {
                    continue;
                }
                skipping = false;
            }
            result.add(line);
        }
        return result;
    }

    /**
     * 按行首题号切块：[startNo, endNo] 区间；说明行不并入块
     */
    private Map<Integer, List<String>> splitNumberedBlocks(List<String> lines, int startNo, int endNo) {
        Map<Integer, List<String>> blocks = new LinkedHashMap<>();
        Integer current = null;
        for (String line : lines) {
            if (IGNORE_IN_BLOCK.matcher(line).matches()) {
                continue;
            }
            Matcher qm = QUESTION_LINE.matcher(line);
            if (qm.matches()) {
                int no = Integer.parseInt(qm.group(1));
                if (no >= startNo && no <= endNo && (current == null || no > current)) {
                    current = no;
                    blocks.computeIfAbsent(no, k -> new ArrayList<>());
                    String rest = qm.group(2).trim();
                    if (!rest.isEmpty()) {
                        blocks.get(no).add(rest);
                    }
                    continue;
                }
            }
            if (current != null) {
                blocks.get(current).add(line);
            }
        }
        return blocks;
    }

    /**
     * 块解析：题干 + 选项（兼容单列/两列布局）
     */
    private Blank splitBlock(List<String> block) {
        Blank blank = new Blank();
        String text = String.join("\n", block);
        Matcher m = OPTION_MARK.matcher(text);
        List<int[]> marks = new ArrayList<>();
        List<String> labels = new ArrayList<>();
        Set<String> used = new HashSet<>();
        while (m.find()) {
            String label = m.group(1);
            if (used.contains(label)) {
                continue;
            }
            used.add(label);
            marks.add(new int[]{m.start(1), m.end()});
            labels.add(label);
        }
        if (marks.isEmpty()) {
            blank.stem = text.replaceAll("\\s+", " ").trim();
            return blank;
        }
        String stem = text.substring(0, marks.get(0)[0]).replaceAll("\\s+", " ").trim();
        stem = stem.replaceFirst("^\\d{1,2}\\s*[.)\\]）】:：]\\s*", "").trim();
        blank.stem = stem;

        Map<String, String> optionMap = new LinkedHashMap<>();
        for (int i = 0; i < marks.size(); i++) {
            int start = marks.get(i)[1];
            int end = i + 1 < marks.size() ? marks.get(i + 1)[0] : text.length();
            String content = text.substring(start, end).replaceAll("\\s+", " ").trim();
            optionMap.put(labels.get(i), content);
        }
        for (char c : new char[]{'A', 'B', 'C', 'D'}) {
            String content = optionMap.get(String.valueOf(c));
            if (content != null && !content.isEmpty()) {
                PaperOptionDto option = new PaperOptionDto();
                option.setLabel(String.valueOf(c));
                option.setContent(content);
                blank.options.add(option);
            }
        }
        return blank;
    }

    /**
     * 行中查找空号（26-45，兼容标准卷 26-35 与老编号卷 36-45）
     */
    private List<Integer> findBlankNums(String line) {
        List<Integer> nums = new ArrayList<>();
        Matcher m = BLANK_NUM.matcher(line);
        while (m.find()) {
            String g = m.group(1) != null ? m.group(1) : m.group(2);
            int n = Integer.parseInt(g);
            if (n >= MIN_BLANK_NO && n <= MAX_BLANK_NO) {
                nums.add(n);
            }
        }
        return nums;
    }

    /**
     * 在 article 中从 from 起找题号 n 的位置（___n___ 或 " n " 空白）
     */
    private int findBlankNum(String article, int n, int from) {
        Pattern p = Pattern.compile("_\\s*" + n + "\\s*_|(?<![\\d.])" + n + "(?![\\d.])");
        Matcher m = p.matcher(article);
        if (m.find(from)) {
            return m.start();
        }
        return -1;
    }

    /**
     * 提取包含题号的句子：前后到句界或限定窗口，题号替换为 ___
     */
    private String extractSentence(String article, int pos) {
        int start = Math.max(0, pos - 140);
        int end = Math.min(article.length(), pos + 140);
        for (int i = pos; i > start; i--) {
            char c = article.charAt(i - 1);
            if (c == '.' || c == '?' || c == '!' || c == '\n' || c == '。') {
                start = i;
                break;
            }
        }
        for (int i = pos; i < end; i++) {
            char c = article.charAt(i);
            if (c == '.' || c == '?' || c == '!' || c == '\n' || c == '。') {
                end = i + 1;
                break;
            }
        }
        // 词边界修正，避免切到单词中间
        if (start > 0 && Character.isLetter(article.charAt(start)) && Character.isLetter(article.charAt(start - 1))) {
            while (start < end && Character.isLetter(article.charAt(start))) {
                start++;
            }
        }
        if (end < article.length() && Character.isLetter(article.charAt(end - 1)) && Character.isLetter(article.charAt(end))) {
            while (end < article.length() && Character.isLetter(article.charAt(end))) {
                end++;
            }
        }
        String sentence = article.substring(start, end);
        // 句内所有空号（26-45）统一替换为空位
        sentence = sentence.replaceAll("_+\\s*(2[6-9]|3[0-9]|4[0-5])\\s*_+", " ___ ");
        sentence = sentence.replaceAll("(?<![\\d.])(2[6-9]|3[0-9]|4[0-5])(?![\\d.])", " ___ ");
        return sentence.replaceAll("\\s+", " ").trim();
    }

    private ParseSubSectionVo newSubSection(PaperParseResultVo result, String section, String subSection, String article) {
        ParseSubSectionVo sub = new ParseSubSectionVo();
        sub.setSection(section);
        sub.setSubSection(subSection);
        sub.setArticle(article);
        result.getSubSections().add(sub);
        return sub;
    }

    private ParseTopicVo newTopic(ParseSubSectionVo sub) {
        ParseTopicVo topic = new ParseTopicVo();
        sub.getTopics().add(topic);
        return topic;
    }

    private String join(String a, String b) {
        if (a == null || a.isEmpty()) {
            return b;
        }
        return a + "；" + b;
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }

    /**
     * 块解析结果
     */
    private static class Blank {
        String stem = "";
        List<PaperOptionDto> options = new ArrayList<>();
    }
}
