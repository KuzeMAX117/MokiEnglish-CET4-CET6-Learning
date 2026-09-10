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
public class GrammarCheckTool implements AgentTool {

    private final ChatClient chatClient;

    @Override
    public String getToolName() {
        return "grammar_check";
    }

    @Override
    public String getDescription() {
        return "检查英语作文中的语法错误，返回错误列表及修正建议";
    }

    @Override
    public ToolResult execute(String essay, String topic, Integer level) {
        try {
            String systemPrompt = """
                You are an English grammar expert. Check the following English essay for grammar errors.
                Return a JSON object with the format:
                {
                    "errors": [
                        {
                            "original": "the sentence with error",
                            "correction": "corrected sentence",
                            "explanation": "grammar rule explanation"
                        }
                    ],
                    "errorCount": 3
                }
                Only return the JSON, no other text.
                """;

            String userPrompt = String.format("""
                Level: %s (CET-%s)
                Topic: %s
                
                Essay:
                %s
                
                Please check for grammar errors and return the result in JSON format.
                """, level == 4 ? "四级" : "六级", level, topic, essay);

            String content = chatClient.prompt()
                    .system(systemPrompt)
                    .user(userPrompt)
                    .call()
                    .content();

            JSONObject result = parseJson(content);
            JSONArray errors = result.getJSONArray("errors");
            List<Map<String, String>> errorList = new ArrayList<>();
            if (errors != null) {
                for (int i = 0; i < errors.size(); i++) {
                    JSONObject err = errors.getJSONObject(i);
                    errorList.add(Map.of(
                            "original", err.getString("original"),
                            "correction", err.getString("correction"),
                            "explanation", err.getString("explanation")
                    ));
                }
            }

            return ToolResult.success(getToolName(), Map.of(
                    "errors", errorList,
                    "errorCount", errorList.size()
            ));
        } catch (Exception e) {
            log.error("语法检查失败", e);
            return ToolResult.fail(getToolName(), "语法检查服务异常");
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
