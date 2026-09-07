package com.hao.topic.model.vo.topic;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.List;

@Data
public class TopicCollectionVo {
    private Long id;
    private Long subjectId;
    private String topicName;
    List<String> labelNames;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private String collectionTime;

}
