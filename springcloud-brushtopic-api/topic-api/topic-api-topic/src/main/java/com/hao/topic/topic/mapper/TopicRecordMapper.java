package com.hao.topic.topic.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hao.topic.model.entity.topic.TopicRecord;
import com.hao.topic.model.vo.topic.TopicDataVo;
import com.hao.topic.model.vo.topic.TopicUserRankVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TopicRecordMapper extends BaseMapper<TopicRecord> {

    Long countTopicFrequency(String date);

    List<TopicDataVo> countTopicDay15();

    List<TopicDataVo> countUserDay15();

    Long countTopicUserRecord(Long currentId);

    Long selectMaximumCount(Long currentId);

    Long selectRecentConsecutiveCount(Long currentId);

    List<TopicDataVo> userTopicDateCount(String date, Long currentId);

    Long selectMaxSubject(Long id);
}
