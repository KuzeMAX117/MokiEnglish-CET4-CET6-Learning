package com.hao.topic.model.entity.topic;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class Topic extends BaseEntity {
    private String topicName;
    private String answer;
    private String aiAnswer;
    

    private String options;
    

    private String correctOption;
    

    private String questionType;
    

    private String analysis;
    private Integer sorted;
    private Integer isEveryday;
    private Integer isMember;
    private Long viewCount;
    private Integer status;
    private String createBy;
    private String failMsg;
}
