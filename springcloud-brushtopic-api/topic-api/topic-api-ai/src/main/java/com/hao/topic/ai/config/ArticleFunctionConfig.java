package com.hao.topic.ai.config;

import com.hao.topic.model.dto.ai.ArticleGenerateDto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Description;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;

/**
 * AI Function Calling 函数注册配置
 * <p>
 * 在 Spring AI 中，通过 @Bean + @Description 注册函数，
 * AI 在生成过程中可以主动调用这些函数获取精准数据，避免幻觉。
 * </p>
 * <p>
 * 设计思路：前端传入的单词数据在请求时存入 ThreadLocal 级别的上下文，
 * Function Calling 函数从上下文中读取数据，实现"AI 主动查词"的效果。
 * </p>
 */
@Configuration
@Slf4j
public class ArticleFunctionConfig {

    /**
     * 线程安全的单词上下文存储
     * <p>
     * key = userId（线程级别隔离），value = 当前请求的单词列表
     * 注意：生产环境建议使用 Redis 或请求级别的 Scope Bean 替代
     * </p>
     */
    private static final ConcurrentHashMap<String, List<ArticleGenerateDto.WordInfo>> WORD_CONTEXT = new ConcurrentHashMap<>();

    /**
     * 设置当前请求的单词上下文
     */
    public static void setWordContext(String requestId, List<ArticleGenerateDto.WordInfo> words) {
        WORD_CONTEXT.put(requestId, words);
    }

    /**
     * 清理单词上下文
     */
    public static void clearWordContext(String requestId) {
        WORD_CONTEXT.remove(requestId);
    }

    // ======================== Function Calling 请求/响应 ========================

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class WordLookupRequest {
        /** 要查询的单词 */
        private String word;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class WordLookupResponse {
        private String word;
        private String phonetic;
        private String meaning;
        private String example;
        private String exampleTranslate;
        private boolean found;

        public static WordLookupResponse notFound(String word) {
            WordLookupResponse resp = new WordLookupResponse();
            resp.setWord(word);
            resp.setFound(false);
            resp.setMeaning("未找到释义");
            return resp;
        }
    }

    // ======================== 注册 Function Bean ========================

    /**
     * 单词查询函数 —— AI 可在生成短文时主动调用此函数查询单词释义
     * <p>
     * 体现点：Function Calling 让 AI 在生成过程中"主动查资料"，
     * 而非让 AI 自己编造释义，解决大模型幻觉问题。
     * </p>
     */
    @Bean
    @Description("查询英语单词的准确释义、音标和例句。当你在写短文时不确定某个单词的用法，可以调用此函数获取精准信息。")
    public Function<WordLookupRequest, WordLookupResponse> lookupWord() {
        return request -> {
            String targetWord = request.getWord().trim().toLowerCase();
            log.info("🔍 Function Calling: AI 主动查询单词 [{}]", targetWord);

            // 从所有上下文中搜索匹配的单词
            for (Map.Entry<String, List<ArticleGenerateDto.WordInfo>> entry : WORD_CONTEXT.entrySet()) {
                for (ArticleGenerateDto.WordInfo wordInfo : entry.getValue()) {
                    if (wordInfo.getWord().trim().toLowerCase().equals(targetWord)) {
                        log.info("✅ Function Calling: 找到单词 [{}] 释义: {}", targetWord, wordInfo.getMeaning());
                        WordLookupResponse resp = new WordLookupResponse();
                        resp.setWord(wordInfo.getWord());
                        resp.setPhonetic(wordInfo.getPhonetic());
                        resp.setMeaning(wordInfo.getMeaning());
                        resp.setExample(wordInfo.getExample());
                        resp.setExampleTranslate(wordInfo.getExampleTranslate());
                        resp.setFound(true);
                        return resp;
                    }
                }
            }

            log.warn("⚠️ Function Calling: 未找到单词 [{}] 的信息", targetWord);
            return WordLookupResponse.notFound(targetWord);
        };
    }
}
