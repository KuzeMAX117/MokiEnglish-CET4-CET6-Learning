package com.hao.topic.topic.service;

import com.hao.topic.model.entity.topic.Topic;
import com.hao.topic.model.vo.topic.TopicSubjectVo;

import java.util.List;

public interface TopicAiService {
    List<Topic> getSubjectIdByTopicList(Long subjectId);

    List<TopicSubjectVo> getSubject(String role, String createBy);
}
