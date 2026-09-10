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
                You are a CET-%s essay grading expert following the official CET scoring rubric.
                Grade the essay based on: content, language accuracy, vocabulary, and structure.
                
                CET-%s Essay Scoring Bands (Total 15 points):
                - Band 5 (14-15): Excellent - well organized, clear arguments, varied vocabulary, minimal errors
                - Band 4 (11-13): Good - clear structure, good vocabulary, some errors
                - Band 3 (8-10): Adequate - basic structure, some errors, acceptable vocabulary
                - Band 2 (5-7): Poor - weak structure, many errors, limited vocabulary
                - Band 1 (1-4): Very poor - minimal content, severe errors
                - Band 0 (0): No relevant content or blank
                
                Return a JSON object with the format:
                {
                    "score": 12,
                    "band": 4,
                    "bandDescription": "Good",
                    "overall": "overall evaluation text",
                    "dimensions": {
                        "content": 4,
                        "language": 3,
                        "vocabulary": 3,
                        "structure": 3
                    },
                    "strengths": ["strength1", "strength2"],
                    "weaknesses": ["weakness1", "weakness2"]
                }
                Each dimension is from 1-5. Only return the JSON, no other text.
                """, levelName, levelName);

            String userPrompt = String.format("""
                Topic: %s
                
                Essay:
                %s
                
                Please grade this essay according to CET-%s standards and return the result in JSON format.
                """, topic, essay, levelName);

            String content = chatClient.prompt()
                    .system(systemPrompt)
                    .user(userPrompt)
                    .call()
                    .content();

            JSONObject result = parseJson(content);

            return ToolResult.success(getToolName(), Map.of(
                    "score", result.getIntValue("score"),
                    "band", result.getIntValue("band"),
                    "bandDescription", result.getString("bandDescription"),
                    "overall", result.getString("overall"),
                    "dimensions", result.getJSONObject("dimensions"),
                    "strengths", result.getJSONArray("strengths"),
                    "weaknesses", result.getJSONArray("weaknesses")
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
