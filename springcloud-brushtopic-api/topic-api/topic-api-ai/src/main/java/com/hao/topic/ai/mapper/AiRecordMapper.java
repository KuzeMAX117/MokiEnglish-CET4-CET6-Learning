package com.hao.topic.ai.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hao.topic.model.entity.ai.AiRecord;
import com.hao.topic.model.vo.topic.TopicDataVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AiRecordMapper extends BaseMapper<AiRecord> {
    Long countAiFrequency(String date);

    List<TopicDataVo> countAiDay7();

    Long countAi(Long currentId);
}
