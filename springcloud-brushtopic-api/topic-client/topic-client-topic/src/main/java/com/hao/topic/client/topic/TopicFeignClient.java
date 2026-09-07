package com.hao.topic.client.topic;

import com.hao.topic.common.auth.TokenInterceptor;
import com.hao.topic.common.result.Result;
import com.hao.topic.model.entity.topic.Topic;
import com.hao.topic.model.entity.topic.TopicCategory;
import com.hao.topic.model.entity.topic.TopicLabel;
import com.hao.topic.model.entity.topic.TopicSubject;
import com.hao.topic.model.vo.topic.TopicSubjectDetailAndTopicVo;
import com.hao.topic.model.vo.topic.TopicSubjectVo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@FeignClient(name = "service-topic", configuration = TokenInterceptor.class)
public interface TopicFeignClient {

    

    @PutMapping("/topic/category/audit")
    public void auditCategory(@RequestBody TopicCategory topicCategory);

    

    @PutMapping("/topic/subject/audit")
    public void auditSubject(@RequestBody TopicSubject topicSubject);

    

    @PutMapping("/topic/label/audit")
    void auditLabel(@RequestBody TopicLabel topicLabel);

    

    @PutMapping("/topic/topic/audit")
    void auditTopic(@RequestBody Topic topic);

    

    @PutMapping("/topic/topic/answer")
    void updateAiAnswer(@RequestBody Topic topic);

    

    @GetMapping("/topic/ai/subject/{role}/{createBy}")
    public List<TopicSubjectVo> getSubject(@PathVariable String role, @PathVariable String createBy);

    

    @GetMapping("/topic/ai/topicList/{subjectId}")
    List<Topic> getSubjectTopicList(@PathVariable Long subjectId);

}
