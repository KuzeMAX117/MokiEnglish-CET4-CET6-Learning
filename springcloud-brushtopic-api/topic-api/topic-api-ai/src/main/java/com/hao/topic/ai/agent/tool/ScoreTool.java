package com.hao.topic.ai.agent.tool;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.hao.topic.common.exception.TopicException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
@RequiredArgsConstructor
@Slf4j
public class ScoreTool implements AgentTool {

    private final ChatClient chatClient;

    @Override
    public String getToolName() {
        return "essay_score";
    }

    @Override
    public String getDescription() {
        return "按四六级作文评分标准对作文进行综合评分";
    }

    @Override
    public ToolResult execute(String essay, String topic, Integer level) {
        try {
            String levelName = level == 4 ? "四级" : "六级";
            String systemPrompt = String.format("""
                You are a strict CET-%s essay grader. Grade the essay based on error count.
                
                First, count all errors in the essay:
                - Grammar errors (subject-verb agreement, tense, articles, prepositions)
                - Spelling errors
                - Incomplete sentences
                - Logic issues
                
                Then assign score based on error count:
                - 0 errors: 14-15 points
                - 1-2 minor errors: 13 points
                - 3-4 errors or 1 serious error: 10-12 points
                - 5-7 errors or 2-3 serious errors: 7-9 points
                - 8-10 errors or 4+ serious errors: 4-6 points
                - 11+ errors: 1-3 points
                - Blank or off-topic: 0 points
                
                CET-6 is stricter than CET-4 for same quality.
                
                Return JSON:
                {
                    "score": number,
                    "band": 14/11/8/5/2/0,
                    "bandDescription": "description",
                    "overall": "evaluation",
                    "dimensions": {"content": 0-5, "language": 0-5, "vocabulary": 0-5, "structure": 0-5},
                    "strengths": ["strength1"],
                    "weaknesses": ["weakness1"],
                    "errorCount": number,
                    "seriousErrorCount": number
                }
                """, levelName);

            String userPrompt = String.format("""
                Topic: %s
                Level: CET-%s
                
                Essay:
                %s
                
                Count errors strictly and grade accordingly.""", topic, level, essay);

            String content = chatClient.prompt()
                    .system(systemPrompt)
                    .user(userPrompt)
                    .call()
                    .content();

            JSONObject result = parseJson(content);

            // 二次校验：根据错误数量强制限制分数
            int errorCount = result.getIntValue("errorCount", 0);
            int seriousErrorCount = result.getIntValue("seriousErrorCount", 0);
            int score = result.getIntValue("score", 0);
            int maxScore;

            if (errorCount == 0) {
                maxScore = 15;
            } else if (errorCount <= 2 && seriousErrorCount == 0) {
                maxScore = 13;
            } else if (errorCount <= 4 || seriousErrorCount <= 1) {
                maxScore = 12;
            } else if (errorCount <= 7 || seriousErrorCount <= 3) {
                maxScore = 9;
            } else if (errorCount <= 10 || seriousErrorCount <= 5) {
                maxScore = 6;
            } else {
                maxScore = 3;
            }

            if (score > maxScore) {
                log.warn("Score {} exceeds max {} based on errors (total:{}, serious:{}), adjusting",
                        score, maxScore, errorCount, seriousErrorCount);
                score = maxScore;
            }

            return ToolResult.success(getToolName(), Map.of(
                    "score", score,
                    "band", result.getIntValue("band"),
                    "bandDescription", result.getString("bandDescription"),
                    "overall", result.getString("overall"),
                    "dimensions", result.getJSONObject("dimensions"),
                    "strengths", result.getJSONArray("strengths"),
                    "weaknesses", result.getJSONArray("weaknesses"),
                    "errorCount", errorCount,
                    "seriousErrorCount", seriousErrorCount
            ));
        } catch (Exception e) {
            log.error("评分失败", e);
            return ToolResult.fail(getToolName(), "评分服务异常");
        }
    }

    private JSONObject parseJson(String content) {
        String json = content.trim();
        if (json.startsWith("```")) {
            int firstBreak = json.indexOf('\n');
            if (firstBreak > 0) json = json.substring(firstBreak + 1);
            int fenceEnd = json.lastIndexOf("```");
            if (fenceEnd >= 0) json = json.substring(0, fenceEnd);
            json = json.trim();
        }
        int start = json.indexOf('{');
        int end = json.lastIndexOf('}');
        if (start < 0 || end <= start) {
            throw new TopicException("AI 返回格式异常");
        }
        return JSON.parseObject(json.substring(start, end + 1));
    }
}
