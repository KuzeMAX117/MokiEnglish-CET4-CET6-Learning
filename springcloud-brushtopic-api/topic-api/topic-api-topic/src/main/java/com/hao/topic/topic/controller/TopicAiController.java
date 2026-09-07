package com.hao.topic.topic.controller;

import com.hao.topic.model.entity.topic.Topic;
import com.hao.topic.model.vo.topic.TopicSubjectVo;
import com.hao.topic.topic.service.TopicAiService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/topic/ai")
@AllArgsConstructor
public class TopicAiController {
    private TopicAiService topicAiService;

    

    @GetMapping("/topicList/{subjectId}")
    List<Topic> getSubjectTopicList(@PathVariable Long subjectId) {
        return topicAiService.getSubjectIdByTopicList(subjectId);
    }

    

    @GetMapping("/subject/{role}/{createBy}")
    public List<TopicSubjectVo> aiSubject(@PathVariable String role, @PathVariable String createBy) {
        return topicAiService.getSubject(role, createBy);
    }
}
