package com.hao.topic.ai.service;

import com.hao.topic.model.vo.topic.TopicDataVo;

import java.util.List;
import java.util.Map;

public interface AiModuleRecordService {
    
    void recordModuleUsage(Long userId, String nickname, String moduleType);
    
    void recordModuleUsage(Long userId, String nickname, String moduleType, Long businessId, String businessType);
    
    Long countModuleUsage(String moduleType, String date);
    
    List<TopicDataVo> countModuleTrend7Days(String moduleType);
    
    Long countModuleUsageByUser(Long userId, String moduleType);
    
    List<Map<String, Object>> countAllModulesByDate(String date);
    
    List<Map<String, Object>> countAllModulesTrend(Integer days);
    
    Long countBusinessUsage(Long businessId, String businessType);
}