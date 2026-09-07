package com.hao.topic.model.vo.ai;

import lombok.Data;

import java.util.List;

@Data
public class AiHistoryListVo {
    
    private String date;
    
    List<AiHistoryVo> aiHistoryVos;
}
