package com.hao.topic.ai.controller;

import com.hao.topic.ai.service.ArticleService;
import com.hao.topic.model.dto.ai.ArticleGenerateDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

/**
 * AI 短文生成控制器
 * <p>
 * 独立于通用 {@link ModelController} 的专用端点，
 * 体现不同业务场景需要不同的 AI 调用策略。
 * </p>
 */
@RestController
@RequestMapping("ai/article")
@RequiredArgsConstructor
public class ArticleController {

    private final ArticleService articleService;

    /**
     * 多阶段 Pipeline 流式生成短文
     * <p>
     * SSE 流式输出：
     * <ul>
     *   <li>阶段 1: 推送 "<!-- PHASE:PLAN -->" 标记 + 大纲摘要</li>
     *   <li>阶段 2: 推送 "<!-- PHASE:ARTICLE -->" 标记 + Markdown 正文流</li>
     *   <li>阶段 3: 推送 "<!-- PHASE:META -->" 标记 + JSON 元数据（词汇卡片+评估）</li>
     * </ul>
     * </p>
     */
    @PostMapping("/generate")
    public Flux<String> generateArticle(@RequestBody ArticleGenerateDto dto) {
        return articleService.generateArticle(dto);
    }
}
