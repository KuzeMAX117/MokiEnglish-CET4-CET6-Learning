package com.hao.topic.ai.service;

import com.hao.topic.model.dto.ai.ArticleGenerateDto;
import reactor.core.publisher.Flux;

/**
 * AI 短文生成服务接口
 * <p>
 * 实现多阶段 AI Pipeline：单词聚类分组 → 逐篇（大纲规划 → 短文生成(+Function Calling)
 * → 定向补词循环 → 质量评估 → 结果组装）。
 * </p>
 */
public interface ArticleService {

    /**
     * 多阶段流式生成短文（支持多篇）
     * <p>
     * Pipeline 流程：
     * <ol>
     *   <li>Step 0 - 单词语义聚类：词多时拆成 K 组，每组独立成文</li>
     *   <li>Step 1 - 大纲规划：Structured Output 生成 ArticlePlan</li>
     *   <li>Step 2 - 短文生成：基于大纲 + Function Calling + 动态长度</li>
     *   <li>Step 2.5 - 定向补词循环：代码实测缺失词 → AI 精准织入（≤ 3 轮）</li>
     *   <li>Step 3 - 质量评估：覆盖率改用代码实测值</li>
     *   <li>Step 4 - 结果组装：逐篇推送 JSON 元数据</li>
     * </ol>
     * </p>
     *
     * @param dto 请求参数（单词列表、难度等级）
     * @return SSE 流，按 GROUP/PLAN/ARTICLE/META/ALL_DONE 标记逐篇推送
     */
    Flux<String> generateArticle(ArticleGenerateDto dto);
}
