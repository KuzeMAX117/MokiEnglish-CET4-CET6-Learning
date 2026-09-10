package com.hao.topic.ai.agent;

import com.hao.topic.ai.agent.tool.AgentTool;
import com.hao.topic.ai.agent.tool.ToolResult;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@Data
@NoArgsConstructor
public class EssayAgentResult {
    private Integer score;
    private Integer band;
    private String bandDescription;
    private String overall;
    private Map<String, Object> dimensions;
    private List<Map<String, String>> grammarErrors;
    private Integer grammarErrorCount;
    private List<Map<String, String>> vocabularySuggestions;
    private Integer vocabularyScore;
    private List<String> strengths;
    private List<String> weaknesses;
    private List<String> toolChain;
    private Long totalTimeMs;

    public static EssayAgentResult fromToolResults(List<ToolResult> results, long totalTimeMs) {
        EssayAgentResult finalResult = new EssayAgentResult();
        finalResult.setToolChain(results.stream().map(ToolResult::getToolName).toList());
        finalResult.setTotalTimeMs(totalTimeMs);

        for (ToolResult result : results) {
            if (!result.isSuccess()) continue;
            Map<String, Object> data = (Map<String, Object>) result.getData();

            switch (result.getToolName()) {
                case "grammar_check" -> {
                    finalResult.setGrammarErrors((List<Map<String, String>>) data.get("errors"));
                    finalResult.setGrammarErrorCount((Integer) data.get("errorCount"));
                }
                case "vocabulary_optimize" -> {
                    finalResult.setVocabularySuggestions((List<Map<String, String>>) data.get("suggestions"));
                    finalResult.setVocabularyScore((Integer) data.get("vocabularyScore"));
                }
                case "essay_score" -> {
                    finalResult.setScore((Integer) data.get("score"));
                    finalResult.setBand((Integer) data.get("band"));
                    finalResult.setBandDescription((String) data.get("bandDescription"));
                    finalResult.setOverall((String) data.get("overall"));
                    finalResult.setDimensions((Map<String, Object>) data.get("dimensions"));
                    finalResult.setStrengths((List<String>) data.get("strengths"));
                    finalResult.setWeaknesses((List<String>) data.get("weaknesses"));
                }
            }
        }
        return finalResult;
    }
}
