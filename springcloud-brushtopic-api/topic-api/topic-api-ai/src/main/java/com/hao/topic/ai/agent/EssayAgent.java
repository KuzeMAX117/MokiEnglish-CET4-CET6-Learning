package com.hao.topic.ai.agent;

import com.hao.topic.ai.agent.tool.AgentTool;
import com.hao.topic.ai.agent.tool.ToolResult;
import com.hao.topic.ai.service.AiModuleRecordService;
import com.hao.topic.common.security.utils.SecurityUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * 作文批改 Agent
 * 
 * 架构说明（面试用）：
 * 1. Agent 模式：采用 Planner-Executor 架构，Agent 作为调度器协调多个 Tool 完成任务
 * 2. Tool 编排：每个 Tool 是独立的能力单元，Agent 根据任务需求选择并编排 Tool
 * 3. 并行执行：无依赖的 Tool 可并行调用，提升响应速度
 * 4. 结果聚合：Agent 负责汇总各 Tool 结果，生成最终批改报告
 * 
 * 调用链路：
 * 用户提交 → EssayAgent.execute()
 *   ├→ GrammarCheckTool.execute()  (并行)
 *   ├→ VocabularyTool.execute()    (并行)
 *   └→ ScoreTool.execute()         (并行)
 *   ↓
 * EssayAgentResult.fromToolResults() 聚合
 *   ↓
 * 返回完整批改结果
 */
@Component
@Slf4j
public class EssayAgent {

    private final List<AgentTool> tools;
    private final ExecutorService executor = Executors.newFixedThreadPool(3);
    private final AiModuleRecordService aiModuleRecordService;

    @Autowired
    public EssayAgent(List<AgentTool> tools, AiModuleRecordService aiModuleRecordService) {
        this.tools = tools;
        this.aiModuleRecordService = aiModuleRecordService;
        log.info("EssayAgent 初始化完成，注册 Tool 数量: {}", tools.size());
        tools.forEach(t -> log.info("  - Tool: {} ({})", t.getToolName(), t.getDescription()));
    }

    /**
     * 执行作文批改全链路
     * 
     * @param essay 作文内容
     * @param topic 作文题目
     * @param level 四级=4，六级=6
     * @return 批改结果
     */
    public EssayAgentResult execute(String essay, String topic, Integer level) {
        return execute(essay, topic, level, null);
    }
    
    /**
     * 执行作文批改全链路（带业务关联）
     * 
     * @param essay 作文内容
     * @param topic 作文题目
     * @param level 四级=4，六级=6
     * @param essayId 作文ID（用于关联AI使用记录）
     * @return 批改结果
     */
    public EssayAgentResult execute(String essay, String topic, Integer level, Long essayId) {
        long startTime = System.currentTimeMillis();
        log.info("Agent 开始执行作文批改，题目: {}, 级别: CET-{}, essayId: {}", topic, level, essayId);
        
        // 记录作文模块使用
        try {
            Long userId = SecurityUtils.getCurrentId();
            String nickname = SecurityUtils.getCurrentName();
            aiModuleRecordService.recordModuleUsage(userId, nickname, "essay", essayId, "essay");
        } catch (Exception e) {
            log.warn("记录作文模块使用失败: {}", e.getMessage());
        }

        // 1. 编排 Tool 执行顺序（这里三个 Tool 无依赖，可以并行）
        List<CompletableFuture<ToolResult>> futures = new ArrayList<>();
        for (AgentTool tool : tools) {
            CompletableFuture<ToolResult> future = CompletableFuture.supplyAsync(() -> {
                log.info("Tool [{}] 开始执行...", tool.getToolName());
                long toolStart = System.currentTimeMillis();
                ToolResult result = tool.execute(essay, topic, level);
                long toolTime = System.currentTimeMillis() - toolStart;
                log.info("Tool [{}] 执行完成，耗时: {}ms, 成功: {}",
                        tool.getToolName(), toolTime, result.isSuccess());
                return result;
            }, executor);
            futures.add(future);
        }

        // 2. 等待所有 Tool 执行完成
        List<ToolResult> results = new ArrayList<>();
        for (CompletableFuture<ToolResult> future : futures) {
            try {
                results.add(future.get());
            } catch (Exception e) {
                log.error("Tool 执行异常", e);
                results.add(ToolResult.fail("unknown", e.getMessage()));
            }
        }

        // 3. Agent 聚合结果
        long totalTime = System.currentTimeMillis() - startTime;
        EssayAgentResult finalResult = EssayAgentResult.fromToolResults(results, totalTime);
        log.info("Agent 执行完成，总耗时: {}ms, 最终得分: {}", totalTime, finalResult.getScore());

        return finalResult;
    }

    /**
     * 获取已注册的 Tool 列表（用于调试/展示）
     */
    public List<Map<String, String>> listTools() {
        return tools.stream()
                .sorted(Comparator.comparing(AgentTool::getToolName))
                .map(t -> Map.of(
                        "name", t.getToolName(),
                        "description", t.getDescription()
                ))
                .toList();
    }
}
