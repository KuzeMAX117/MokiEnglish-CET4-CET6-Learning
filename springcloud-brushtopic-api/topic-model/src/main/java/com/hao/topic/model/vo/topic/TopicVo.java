package com.hao.topic.model.vo.topic;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

import java.util.List;

@Data
public class TopicVo extends BaseEntity {

    private String topicName;
    private String answer;
    private String aiAnswer;
    private String createBy;
    private Integer sorted;
    private Integer isEveryday;
    private Integer status;
    private Integer isMember;
    private Long viewCount;
    
    private String subject;
    
    private List<String> labels;
    private String failMsg;
}
