package com.hao.topic.model.entity.topic;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class TopicLabel  extends BaseEntity {
    private String labelName;
    private Integer status;
    private String createBy;
    private Long useCount;
    private String failMsg;
}
