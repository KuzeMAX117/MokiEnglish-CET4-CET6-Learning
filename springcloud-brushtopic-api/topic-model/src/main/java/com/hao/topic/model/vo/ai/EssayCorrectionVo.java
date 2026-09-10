package com.hao.topic.model.vo.ai;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EssayCorrectionVo {
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
}
