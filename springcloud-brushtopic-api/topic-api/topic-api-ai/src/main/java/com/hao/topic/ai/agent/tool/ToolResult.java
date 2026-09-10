package com.hao.topic.ai.agent.tool;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ToolResult {
    private String toolName;
    private boolean success;
    private Object data;
    private String errorMessage;

    public static ToolResult success(String toolName, Object data) {
        return new ToolResult(toolName, true, data, null);
    }

    public static ToolResult fail(String toolName, String errorMessage) {
        return new ToolResult(toolName, false, null, errorMessage);
    }
}
