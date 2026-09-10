package com.hao.topic.ai.agent.tool;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.hao.topic.common.exception.TopicException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Component
@RequiredArgsConstructor
@Slf4j
public class VocabularyTool implements AgentTool {

    private final ChatClient chatClient;

    @Override
    public String getToolName() {
        return "vocabulary_optimize";
    }

    @Override
    public String getDescription() {
        return "分析作文词汇使用，推荐更高级的词汇替换建议";
    }

    @Override
    public ToolResult execute(String essay, String topic, Integer level) {
        try {
            String systemPrompt = """
                You are an English vocabulary expert. Analyze the vocabulary in the following essay.
                Suggest more advanced or varied word replacements where appropriate.
                Return a JSON object with the format:
                {
                    "suggestions": [
                        {
                            "original": "basic word/phrase",
                            "suggestion": "advanced replacement",
                            "reason": "why this is better"
                        }
                    ],
                    "vocabularyScore": 7
                }
                vocabularyScore is from 1-10, evaluating vocabulary richness and appropriateness.
                Only return the JSON, no other text.
                """;

            String userPrompt = String.format("""
                Level: CET-%s
                Topic: %s
                
                Essay:
                %s
                
                Please analyze the vocabulary and provide suggestions in JSON format.
                """, level, topic, essay);

            String content = chatClient.prompt()
                    .system(systemPrompt)
                    .user(userPrompt)
                    .call()
                    .content();

            JSONObject result = parseJson(content);
            JSONArray suggestions = result.getJSONArray("suggestions");
            List<Map<String, String>> suggestionList = new ArrayList<>();
            if (suggestions != null) {
                for (int i = 0; i < suggestions.size(); i++) {
                    JSONObject s = suggestions.getJSONObject(i);
                    suggestionList.add(Map.of(
                            "original", s.getString("original"),
                            "suggestion", s.getString("suggestion"),
                            "reason", s.getString("reason")
                    ));
                }
            }

            return ToolResult.success(getToolName(), Map.of(
                    "suggestions", suggestionList,
                    "vocabularyScore", result.getIntValue("vocabularyScore")
            ));
        } catch (Exception e) {
            log.error("词汇分析失败", e);
            return ToolResult.fail(getToolName(), "词汇分析服务异常");
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
