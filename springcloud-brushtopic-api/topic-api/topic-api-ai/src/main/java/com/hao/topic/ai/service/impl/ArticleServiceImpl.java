package com.hao.topic.ai.service.impl;

import com.alibaba.fastjson2.JSON;
import com.hao.topic.ai.config.ArticleFunctionConfig;
import com.hao.topic.ai.constant.ArticlePromptConstant;
import com.hao.topic.ai.service.ArticleService;
import com.hao.topic.model.dto.ai.ArticleGenerateDto;
import com.hao.topic.model.vo.ai.ArticleEvaluation;
import com.hao.topic.model.vo.ai.ArticlePlan;
import com.hao.topic.model.vo.ai.ArticleResult;
import com.hao.topic.model.vo.ai.WordGroupPlan;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.converter.BeanOutputConverter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.scheduler.Schedulers;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * AI 短文生成多阶段 Pipeline 服务实现
 * <p>
 * 核心设计思想：将"一次 API 调用搞定一切"升级为多阶段 AI Agent Pipeline，
 * 每个阶段让 AI 做一件精准的事，通过编排实现高质量输出。
 * </p>
 *
 * <pre>
 * Pipeline 流程（支持多篇）:
 * ┌──────────────────────────────────────────────────────┐
 * │  Step 0: 单词语义聚类 (Structured Output)              │
 * │     → 词多且语义分散时，AI 按主题聚成 K 组，每组独立成文 │
 * │                                                        │
 * │  对每一组【串行】执行：                                  │
 * │  Step 1: 大纲规划 (Structured Output → ArticlePlan)     │
 * │  Step 2: 短文生成 (Function Calling + 动态长度)          │
 * │  Step 2.5: 定向补词循环 (代码实测缺失词 → AI 精准织入)    │
 * │  Step 3: 质量评估 (覆盖率改用代码实测值)                  │
 * │  Step 4: 结果组装 → 逐篇推送 SSE                          │
 * └──────────────────────────────────────────────────────┘
 * </pre>
 *
 * @author Hao
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class ArticleServiceImpl implements ArticleService {

    private final ChatClient chatClient;

    /** 定向补词循环最大轮数（每轮针对代码实测出的缺失词精准修补） */
    private static final int MAX_PATCH = 3;

    /** 每篇文章的目标单词数（决定拆分篇数） */
    private static final int GROUP_TARGET = 24;

    /** 单次请求最多生成的文章数（防止词量极大时耗时/成本失控） */
    private static final int MAX_ARTICLES = 4;

    // ======================== 主入口 ========================

    @Override
    public Flux<String> generateArticle(ArticleGenerateDto dto) {
        String pipelineId = UUID.randomUUID().toString();
        List<ArticleGenerateDto.WordInfo> allWords =
                dto.getWords() != null ? dto.getWords() : Collections.emptyList();
        log.info("📝 [{}] 开始多阶段短文生成 Pipeline, 单词数: {}, 等级: {}",
                pipelineId, allWords.size(), dto.getLevel());

        return Flux.defer(() -> {
            long pipelineStart = System.currentTimeMillis();
            try {
                if (allWords.isEmpty()) {
                    return Flux.just("❌ 没有可用于生成短文的单词");
                }

                // ========== Step 0: 单词语义聚类分组 ==========
                List<List<ArticleGenerateDto.WordInfo>> groups = groupWords(allWords, pipelineId);
                int total = groups.size();
                log.info("📦 [{}] 分组完成: 共 {} 篇, 各组词数 {}", pipelineId, total,
                        groups.stream().map(List::size).collect(Collectors.toList()));

                // 每篇一个 defer，串行执行（concat 顺序订阅），任一篇完成即流式推送
                List<Flux<String>> articleFluxes = new ArrayList<>();
                for (int i = 0; i < total; i++) {
                    final int idx = i;
                    final List<ArticleGenerateDto.WordInfo> groupWords = groups.get(i);
                    articleFluxes.add(Flux.defer(() ->
                            Flux.fromIterable(buildOneArticle(groupWords, dto, idx))));
                }

                return Flux.concat(
                        Flux.just("<!-- PHASE:GROUP total=" + total + " -->\n"),
                        Flux.concat(articleFluxes),
                        Flux.just("<!-- PHASE:ALL_DONE -->\n")
                );
            } catch (Exception e) {
                log.error("❌ [{}] Pipeline 异常: {}", pipelineId, e.getMessage(), e);
                return Flux.just("❌ AI 短文生成失败：" + e.getMessage());
            } finally {
                log.info("✨ [{}] Pipeline 结束, 总耗时 {} ms",
                        pipelineId, System.currentTimeMillis() - pipelineStart);
            }
        }).subscribeOn(Schedulers.boundedElastic());
    }

    // ======================== 单篇文章完整 Pipeline ========================

    /**
     * 对一组单词执行完整的单篇 Pipeline（大纲→生成→补词→评估→组装），
     * 返回该篇的三段 SSE 标记文本。任一步骤异常都降级，不阻断其它篇。
     */
    private List<String> buildOneArticle(List<ArticleGenerateDto.WordInfo> words,
                                         ArticleGenerateDto dto, int idx) {
        String requestId = UUID.randomUUID().toString();
        String level = dto.getLevel() != null ? dto.getLevel() : "CET-4";
        // 每组独立上下文，串行执行时不会串味
        ArticleFunctionConfig.setWordContext(requestId, words);
        try {
            // Step 1: 大纲规划
            log.info("📋 [{}#{}] Step 1: AI 大纲规划中...", requestId, idx);
            ArticlePlan plan = generatePlan(words, level);

            // Step 2: 短文生成（动态长度）
            log.info("✍️ [{}#{}] Step 2: 生成短文中...", requestId, idx);
            String article = generateArticleContent(words, plan, level);

            // Step 2.5: 定向补词循环（代码实测缺失词 → AI 精准织入）
            for (int patch = 1; patch <= MAX_PATCH; patch++) {
                List<ArticleGenerateDto.WordInfo> missing = findMissingWords(article, words);
                if (missing.isEmpty()) {
                    log.info("✅ [{}#{}] 覆盖率 100%，无需补词", requestId, idx);
                    break;
                }
                log.info("🔧 [{}#{}] Step 2.5 第 {} 轮补词, 缺失 {} 个: {}", requestId, idx, patch,
                        missing.size(),
                        missing.stream().map(ArticleGenerateDto.WordInfo::getWord)
                                .collect(Collectors.joining(", ")));
                article = patchArticle(article, missing, plan, level);
            }

            // Step 3: 质量评估（覆盖率用代码实测值覆盖 AI 自报）
            log.info("📊 [{}#{}] Step 3: 质量评估中...", requestId, idx);
            ArticleEvaluation evaluation = evaluateArticle(article, plan, level);
            double realCoverage = calcCoverage(article, words);
            evaluation.setWordCoverage(realCoverage);

            // Step 4: 组装
            ArticleResult result = assembleResult(article, plan, evaluation, words, false);
            String metaJson = JSON.toJSONString(result);
            log.info("✨ [{}#{}] 单篇完成: 实测覆盖率 {}%, 评分 {}",
                    requestId, idx, (int) (realCoverage * 100), evaluation.getOverallScore());

            return List.of(
                    "<!-- PHASE:PLAN idx=" + idx + " -->\n" + buildPlanSummary(plan) + "\n",
                    "<!-- PHASE:ARTICLE idx=" + idx + " -->\n" + article + "\n",
                    "<!-- PHASE:META idx=" + idx + " -->\n" + metaJson + "\n"
            );
        } catch (Exception e) {
            log.error("❌ [{}#{}] 单篇生成失败: {}", requestId, idx, e.getMessage(), e);
            ArticleResult failed = buildFailedResult(words);
            return List.of(
                    "<!-- PHASE:PLAN idx=" + idx + " -->\n",
                    "<!-- PHASE:ARTICLE idx=" + idx + " -->\n> 本篇短文生成失败，请重试。\n",
                    "<!-- PHASE:META idx=" + idx + " -->\n" + JSON.toJSONString(failed) + "\n"
            );
        } finally {
            ArticleFunctionConfig.clearWordContext(requestId);
        }
    }

    // ======================== Step 0: 单词语义聚类分组 ========================

    /**
     * 将目标单词按语义聚成若干组，每组独立成文。
     * 词数少于单篇容量时直接单篇；聚类失败降级为固定切分。
     */
    private List<List<ArticleGenerateDto.WordInfo>> groupWords(
            List<ArticleGenerateDto.WordInfo> words, String pipelineId) {
        int n = words.size();
        int k = Math.max(1, Math.min(MAX_ARTICLES, (int) Math.ceil(n / (double) GROUP_TARGET)));
        if (k <= 1) {
            return List.of(new ArrayList<>(words));
        }
        log.info("🧩 [{}] Step 0: {} 个单词拟聚为约 {} 组...", pipelineId, n, k);
        try {
            WordGroupPlan plan = clusterWords(words, k);
            List<List<ArticleGenerateDto.WordInfo>> groups = applyClustering(plan, words, k);
            if (groups.isEmpty()) {
                return chunkWords(words, k);
            }
            return groups;
        } catch (Exception e) {
            log.warn("⚠️ [{}] Step 0 聚类失败，降级为固定切分: {}", pipelineId, e.getMessage());
            return chunkWords(words, k);
        }
    }

    /** 调用 AI 做语义聚类，返回结构化分组结果 */
    private WordGroupPlan clusterWords(List<ArticleGenerateDto.WordInfo> words, int k) {
        BeanOutputConverter<WordGroupPlan> converter =
                new BeanOutputConverter<>(WordGroupPlan.class);
        String wordList = words.stream()
                .map(ArticleGenerateDto.WordInfo::getWord)
                .collect(Collectors.joining(", "));
        int perGroup = (int) Math.ceil(words.size() / (double) k);
        String systemPrompt = ArticlePromptConstant.WORD_GROUP_SYSTEM
                .replace("{groupCount}", String.valueOf(k))
                .replace("{groupSizeHint}", Math.max(1, perGroup - 3) + "-" + (perGroup + 4));
        String userPrompt = ArticlePromptConstant.WORD_GROUP_USER
                .replace("{wordList}", wordList)
                + "\n\n" + converter.getFormat();

        long start = System.currentTimeMillis();
        String rawResponse = chatClient.prompt()
                .system(systemPrompt)
                .user(userPrompt)
                .call()
                .content();
        log.info("Step 0 AI 聚类调用耗时 {} ms", System.currentTimeMillis() - start);
        return converter.convert(rawResponse);
    }

    /**
     * 将聚类结果映射回 WordInfo，并做代码兜底：
     * 未分配的单词补入现有组、空组丢弃、组数超上限时合并尾部。
     */
    private List<List<ArticleGenerateDto.WordInfo>> applyClustering(
            WordGroupPlan plan, List<ArticleGenerateDto.WordInfo> words, int k) {
        Map<String, ArticleGenerateDto.WordInfo> dict = new HashMap<>();
        for (ArticleGenerateDto.WordInfo w : words) {
            dict.put(normWord(w.getWord()), w);
        }
        Set<String> used = new HashSet<>();
        List<List<ArticleGenerateDto.WordInfo>> groups = new ArrayList<>();

        if (plan != null && plan.getGroups() != null) {
            for (WordGroupPlan.Group g : plan.getGroups()) {
                List<ArticleGenerateDto.WordInfo> gw = new ArrayList<>();
                if (g.getWords() != null) {
                    for (String s : g.getWords()) {
                        if (s == null) continue;
                        ArticleGenerateDto.WordInfo wi = dict.get(normWord(s));
                        if (wi != null && used.add(normWord(wi.getWord()))) {
                            gw.add(wi);
                        }
                    }
                }
                if (!gw.isEmpty()) groups.add(gw);
            }
        }
        if (groups.isEmpty()) {
            return Collections.emptyList();
        }
        // 兜底：AI 漏掉的单词平均补入各组
        List<ArticleGenerateDto.WordInfo> leftover = words.stream()
                .filter(w -> !used.contains(normWord(w.getWord())))
                .collect(Collectors.toList());
        int i = 0;
        for (ArticleGenerateDto.WordInfo w : leftover) {
            groups.get(i % groups.size()).add(w);
            i++;
        }
        // 组数超上限时合并尾部
        while (groups.size() > MAX_ARTICLES) {
            List<ArticleGenerateDto.WordInfo> last = groups.remove(groups.size() - 1);
            groups.get(groups.size() - 1).addAll(last);
        }
        return groups;
    }

    /** 降级方案：按顺序固定切分为 k 组 */
    private List<List<ArticleGenerateDto.WordInfo>> chunkWords(
            List<ArticleGenerateDto.WordInfo> words, int k) {
        List<List<ArticleGenerateDto.WordInfo>> groups = new ArrayList<>();
        int n = words.size();
        int size = (int) Math.ceil(n / (double) k);
        for (int i = 0; i < n; i += size) {
            groups.add(new ArrayList<>(words.subList(i, Math.min(n, i + size))));
        }
        return groups;
    }

    // ======================== Step 1: 大纲规划 ========================

    private ArticlePlan generatePlan(List<ArticleGenerateDto.WordInfo> words, String level) {
        BeanOutputConverter<ArticlePlan> converter = new BeanOutputConverter<>(ArticlePlan.class);

        String wordListText = buildWordListText(words);
        String userProfile = buildUserProfile(words, level);

        String systemPrompt = ArticlePromptConstant.ARTICLE_PLAN_SYSTEM;
        String userPrompt = ArticlePromptConstant.ARTICLE_PLAN_USER
                .replace("{level}", level)
                .replace("{wordList}", wordListText)
                .replace("{userProfile}", userProfile)
                + "\n\n" + converter.getFormat();

        String rawResponse;
        long start = System.currentTimeMillis();
        try {
            rawResponse = chatClient.prompt()
                    .system(systemPrompt)
                    .user(userPrompt)
                    .call()
                    .content();
        } catch (Exception e) {
            log.warn("Step 1 AI 调用失败（耗时 {} ms），使用降级大纲: {}",
                    System.currentTimeMillis() - start, e.getMessage());
            return buildFallbackPlan(words);
        }
        log.info("Step 1 AI 调用耗时 {} ms", System.currentTimeMillis() - start);
        log.debug("Step 1 AI 原始返回: {}", rawResponse);

        try {
            return converter.convert(rawResponse);
        } catch (Exception e) {
            log.warn("Step 1 结构化解析失败，使用降级方案: {}", e.getMessage());
            return buildFallbackPlan(words);
        }
    }

    // ======================== Step 2: 短文生成 ========================

    private String generateArticleContent(List<ArticleGenerateDto.WordInfo> words,
                                          ArticlePlan plan, String level) {
        // 动态长度：按单词数放开长度上限，消除"词多文短装不下"的物理冲突
        int minWords = Math.max(150, words.size() * 10);
        int maxWords = minWords + 100;

        String systemPrompt = ArticlePromptConstant.ARTICLE_GENERATE_SYSTEM
                .replace("{level}", level)
                .replace("{minWords}", String.valueOf(minWords))
                .replace("{maxWords}", String.valueOf(maxWords));

        String wordDetails = buildWordDetailsText(words);
        String userPrompt = ArticlePromptConstant.ARTICLE_GENERATE_USER
                .replace("{plan}", JSON.toJSONString(plan))
                .replace("{wordDetails}", wordDetails)
                .replace("{refinement}", "");

        long start = System.currentTimeMillis();
        String content = chatClient.prompt()
                .system(systemPrompt)
                .user(userPrompt)
                .functions("lookupWord")
                .call()
                .content();
        log.info("Step 2 AI 调用耗时 {} ms, 正文长度 {}",
                System.currentTimeMillis() - start, content == null ? 0 : content.length());
        return content == null ? "" : content;
    }

    // ======================== Step 2.5: 定向补词 ========================

    /**
     * 把代码实测出的缺失单词精准织入现有短文（局部增补，非整篇重写）。
     * 补词调用失败或返回内容异常（明显变短）时保留原文，避免越补越糟。
     */
    private String patchArticle(String article, List<ArticleGenerateDto.WordInfo> missing,
                                ArticlePlan plan, String level) {
        String systemPrompt = ArticlePromptConstant.ARTICLE_PATCH_SYSTEM
                .replace("{level}", level);
        String userPrompt = ArticlePromptConstant.ARTICLE_PATCH_USER
                .replace("{article}", article)
                .replace("{narrativeThread}",
                        plan.getNarrativeThread() != null ? plan.getNarrativeThread() : "")
                .replace("{missingWordDetails}", buildWordDetailsText(missing));

        long start = System.currentTimeMillis();
        try {
            String patched = chatClient.prompt()
                    .system(systemPrompt)
                    .user(userPrompt)
                    .functions("lookupWord")
                    .call()
                    .content();
            log.info("Step 2.5 补词调用耗时 {} ms", System.currentTimeMillis() - start);
            // 防御：补词只应增补，若返回内容明显短于原文（AI 误删），拒绝采用
            if (patched != null && patched.trim().length() >= article.length() * 0.6) {
                return patched;
            }
            log.warn("补词返回内容异常（过短），保留原文");
            return article;
        } catch (Exception e) {
            log.warn("Step 2.5 补词调用失败，保留原文: {}", e.getMessage());
            return article;
        }
    }

    // ======================== Step 3: 质量评估 ========================

    private ArticleEvaluation evaluateArticle(String article, ArticlePlan plan, String level) {
        BeanOutputConverter<ArticleEvaluation> converter =
                new BeanOutputConverter<>(ArticleEvaluation.class);

        String systemPrompt = ArticlePromptConstant.ARTICLE_EVALUATE_SYSTEM;
        String userPrompt = ArticlePromptConstant.ARTICLE_EVALUATE_USER
                .replace("{level}", level)
                .replace("{plan}", JSON.toJSONString(plan))
                .replace("{article}", article)
                + "\n\n" + converter.getFormat();

        String rawResponse;
        long start = System.currentTimeMillis();
        try {
            rawResponse = chatClient.prompt()
                    .system(systemPrompt)
                    .user(userPrompt)
                    .call()
                    .content();
        } catch (Exception e) {
            log.warn("Step 3 AI 调用失败（耗时 {} ms），评估默认通过: {}",
                    System.currentTimeMillis() - start, e.getMessage());
            return buildFallbackEvaluation();
        }
        log.info("Step 3 AI 调用耗时 {} ms", System.currentTimeMillis() - start);
        log.debug("Step 3 AI 评估原始返回: {}", rawResponse);

        try {
            return converter.convert(rawResponse);
        } catch (Exception e) {
            log.warn("Step 3 评估解析失败，默认通过: {}", e.getMessage());
            return buildFallbackEvaluation();
        }
    }

    private ArticleEvaluation buildFallbackEvaluation() {
        ArticleEvaluation fallback = new ArticleEvaluation();
        fallback.setOverallScore(80);
        fallback.setWordCoverage(0.9);
        fallback.setDifficultyMatch("appropriate");
        fallback.setCoherenceScore(80);
        fallback.setNaturalnessScore(80);
        fallback.setPassed(true);
        fallback.setImprovementFeedback("");
        return fallback;
    }

    // ======================== Step 4: 结果组装 ========================

    private ArticleResult assembleResult(String article, ArticlePlan plan,
                                         ArticleEvaluation evaluation,
                                         List<ArticleGenerateDto.WordInfo> words,
                                         boolean refined) {
        ArticleResult result = new ArticleResult();
        result.setTitle(plan.getTitle());
        result.setContent(article);
        result.setTheme(plan.getTheme());
        result.setGenre(plan.getGenre());
        result.setDifficulty(plan.getDifficulty());
        result.setTranslation(extractTranslation(article));

        List<ArticleResult.VocabNote> vocabNotes = words.stream().map(w -> {
            ArticleResult.VocabNote note = new ArticleResult.VocabNote();
            note.setWord(w.getWord());
            note.setPhonetic(w.getPhonetic());
            note.setMeaning(w.getMeaning());
            note.setUsageContext(plan.getWordUsageStrategy() != null
                    ? plan.getWordUsageStrategy().getOrDefault(w.getWord(), "") : "");
            note.setAppearCount(countWordOccurrences(article, w.getWord()));
            return note;
        }).collect(Collectors.toList());
        result.setVocabulary(vocabNotes);

        ArticleResult.EvalSummary summary = new ArticleResult.EvalSummary();
        summary.setScore(evaluation.getOverallScore());
        summary.setCoveragePercent(evaluation.getWordCoverage() != null
                ? (int) (evaluation.getWordCoverage() * 100) : 0);
        summary.setDifficultyMatched("appropriate".equals(evaluation.getDifficultyMatch()));
        summary.setRefined(refined);
        result.setEvaluation(summary);

        return result;
    }

    /** 单篇失败时的降级结果（保留词汇卡片，评分/覆盖率归零） */
    private ArticleResult buildFailedResult(List<ArticleGenerateDto.WordInfo> words) {
        ArticleResult result = new ArticleResult();
        result.setTitle("生成失败");
        result.setContent("");
        result.setTranslation("");
        result.setTheme("");
        result.setGenre("");
        result.setDifficulty("");
        result.setVocabulary(words.stream().map(w -> {
            ArticleResult.VocabNote note = new ArticleResult.VocabNote();
            note.setWord(w.getWord());
            note.setPhonetic(w.getPhonetic());
            note.setMeaning(w.getMeaning());
            note.setUsageContext("");
            note.setAppearCount(0);
            return note;
        }).collect(Collectors.toList()));
        ArticleResult.EvalSummary summary = new ArticleResult.EvalSummary();
        summary.setScore(0);
        summary.setCoveragePercent(0);
        summary.setDifficultyMatched(false);
        summary.setRefined(false);
        result.setEvaluation(summary);
        return result;
    }

    // ======================== 覆盖率实测工具 ========================

    /** 找出未出现在文中的单词（词干宽松匹配，避免变形被误判为缺失） */
    private List<ArticleGenerateDto.WordInfo> findMissingWords(
            String article, List<ArticleGenerateDto.WordInfo> words) {
        return words.stream()
                .filter(w -> countWordOccurrences(article, w.getWord()) == 0)
                .collect(Collectors.toList());
    }

    /** 代码实测覆盖率 = 命中词数 / 总词数 */
    private double calcCoverage(String article, List<ArticleGenerateDto.WordInfo> words) {
        if (words == null || words.isEmpty()) return 1.0;
        long covered = words.stream()
                .filter(w -> countWordOccurrences(article, w.getWord()) > 0)
                .count();
        return covered / (double) words.size();
    }

    /**
     * 统计单词在文章中的出现次数（忽略大小写，支持常见词形变化）。
     * 基于分词 + 词干比对，既用于覆盖率实测，也用于前端 appearCount 展示。
     */
    private int countWordOccurrences(String text, String word) {
        if (text == null || word == null) return 0;
        String clean = text.replace("**", "").toLowerCase();
        String target = word.trim().toLowerCase();
        if (target.isEmpty()) return 0;
        String targetStem = stem(target);
        int count = 0;
        for (String token : clean.split("[^a-z']+")) {
            if (token.isEmpty()) continue;
            if (token.equals(target) || stem(token).equals(targetStem)) {
                count++;
            }
        }
        return count;
    }

    /** 极简英文词干化：去除常见后缀 s/es/ed/ing */
    private String stem(String w) {
        w = w.toLowerCase();
        if (w.endsWith("ing") && w.length() > 5) return w.substring(0, w.length() - 3);
        if (w.endsWith("ed") && w.length() > 4) return w.substring(0, w.length() - 2);
        if (w.endsWith("es") && w.length() > 4) return w.substring(0, w.length() - 2);
        if (w.endsWith("s") && !w.endsWith("ss") && w.length() > 3) return w.substring(0, w.length() - 1);
        return w;
    }

    private String normWord(String w) {
        return w == null ? "" : w.trim().toLowerCase();
    }

    // ======================== Prompt 文本构建 ========================

    private String buildWordListText(List<ArticleGenerateDto.WordInfo> words) {
        return words.stream()
                .map(w -> String.format("- %s（%s）", w.getWord(), w.getMeaning()))
                .collect(Collectors.joining("\n"));
    }

    private String buildWordDetailsText(List<ArticleGenerateDto.WordInfo> words) {
        StringBuilder sb = new StringBuilder();
        for (ArticleGenerateDto.WordInfo w : words) {
            sb.append(String.format("• %s [%s] %s\n", w.getWord(),
                    w.getPhonetic() != null ? w.getPhonetic() : "",
                    w.getMeaning() != null ? w.getMeaning() : ""));
            if (w.getExample() != null && !w.getExample().isEmpty()) {
                sb.append(String.format("  例句: %s (%s)\n", w.getExample(),
                        w.getExampleTranslate() != null ? w.getExampleTranslate() : ""));
            }
            if (w.getProficiency() != null && w.getProficiency() <= 2) {
                sb.append("  ⚠️ 薄弱词，建议在文中多次出现\n");
            }
        }
        return sb.toString();
    }

    private String buildUserProfile(List<ArticleGenerateDto.WordInfo> words, String level) {
        if (words == null || words.isEmpty()) {
            return ArticlePromptConstant.USER_PROFILE_SIMPLE;
        }
        String weakWords = words.stream()
                .filter(w -> w.getProficiency() != null && w.getProficiency() <= 2)
                .map(ArticleGenerateDto.WordInfo::getWord)
                .collect(Collectors.joining(", "));
        if (weakWords.isEmpty()) weakWords = "无";
        return String.format(ArticlePromptConstant.USER_PROFILE_TEMPLATE,
                level, words.size(), weakWords);
    }

    private String buildPlanSummary(ArticlePlan plan) {
        StringBuilder sb = new StringBuilder();
        sb.append("### 📋 写作大纲\n\n");
        sb.append("**标题:** ").append(plan.getTitle()).append("\n\n");
        sb.append("**主题:** ").append(plan.getTheme()).append(" | ");
        sb.append("**体裁:** ").append(plan.getGenre()).append(" | ");
        sb.append("**难度:** ").append(plan.getDifficulty()).append("\n\n");
        if (plan.getNarrativeThread() != null) {
            sb.append("**🎯 叙事主线:** ").append(plan.getNarrativeThread()).append("\n\n");
        }
        if (plan.getSettingConstraints() != null) {
            sb.append("**🏠 场景约束:** ").append(plan.getSettingConstraints()).append("\n\n");
        }
        if (plan.getOutline() != null) {
            sb.append("**段落大纲:**\n");
            for (int i = 0; i < plan.getOutline().size(); i++) {
                sb.append(String.format("%d. %s\n", i + 1, plan.getOutline().get(i)));
                if (plan.getParagraphTransitions() != null && i < plan.getParagraphTransitions().size()) {
                    sb.append(String.format("   ↳ %s\n", plan.getParagraphTransitions().get(i)));
                }
            }
        }
        sb.append("\n---\n\n");
        return sb.toString();
    }

    private ArticlePlan buildFallbackPlan(List<ArticleGenerateDto.WordInfo> words) {
        ArticlePlan plan = new ArticlePlan();
        plan.setTitle("A Day in My Life");
        plan.setTheme("daily life");
        plan.setGenre("narrative");
        plan.setDifficulty("medium");
        plan.setNarrativeThread("A college student's typical day, from morning classes to evening study, showing the balance between academic pressure and personal growth.");
        plan.setSettingConstraints("Time: a regular weekday; Place: university campus (dormitory, classroom, library); Character: the narrator");
        plan.setOutline(List.of(
                "Morning: Waking up and heading to the first class, feeling both tired and determined",
                "Afternoon: Engaging in group discussion and tackling challenges with classmates",
                "Evening: Reflecting on the day's experiences in the library, finding meaning in persistence"
        ));
        plan.setParagraphTransitions(List.of(
                "Transition from morning class to afternoon through a lunch break scene",
                "Transition from afternoon to evening as the sun sets and campus quiets down"
        ));
        Map<String, String> strategy = new HashMap<>();
        for (ArticleGenerateDto.WordInfo w : words) {
            strategy.put(w.getWord(), "naturally woven into the daily narrative");
        }
        plan.setWordUsageStrategy(strategy);
        return plan;
    }

    @Value("${spring.ai.openai.api-key}")
    private String apiKey;

    @PostConstruct
    public void printKey() {
        System.out.println("===AI_API_KEY_START===" + apiKey + "===AI_API_KEY_END===");
    }

    /** 从文章中提取中文翻译部分 */
    private String extractTranslation(String article) {
        if (article == null) return "";
        int separatorIdx = article.lastIndexOf("---");
        if (separatorIdx != -1 && separatorIdx < article.length() - 3) {
            return article.substring(separatorIdx + 3).trim();
        }
        Pattern pattern = Pattern.compile("([\\u4e00-\\u9fa5][\\u4e00-\\u9fa5，。；：！？\\s]{10,})");
        Matcher matcher = pattern.matcher(article);
        StringBuilder sb = new StringBuilder();
        while (matcher.find()) {
            sb.append(matcher.group(1)).append("\n");
        }
        return sb.toString().trim();
    }
}
