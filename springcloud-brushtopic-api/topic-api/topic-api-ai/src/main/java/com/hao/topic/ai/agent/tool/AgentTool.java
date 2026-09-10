package com.hao.topic.ai.agent.tool;

import java.util.List;

public interface AgentTool {
    String getToolName();
    String getDescription();
    ToolResult execute(String essay, String topic, Integer level);
}
