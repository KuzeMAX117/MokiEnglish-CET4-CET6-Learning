package com.hao.topic.ai.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hao.topic.model.entity.ai.AiModuleRecord;
import com.hao.topic.model.vo.topic.TopicDataVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface AiModuleRecordMapper extends BaseMapper<AiModuleRecord> {
    
    Long countModuleFrequency(@Param("moduleType") String moduleType, @Param("date") String date);
    
    List<TopicDataVo> countModuleDay7(@Param("moduleType") String moduleType);
    
    Long countModuleByUser(@Param("userId") Long userId, @Param("moduleType") String moduleType);
    
    List<Map<String, Object>> countAllModulesByDate(@Param("date") String date);
    
    List<Map<String, Object>> countAllModulesTrend(@Param("days") Integer days);
}