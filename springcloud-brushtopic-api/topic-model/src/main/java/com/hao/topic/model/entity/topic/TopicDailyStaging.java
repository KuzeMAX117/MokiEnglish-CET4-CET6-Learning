package com.hao.topic.model.entity.topic;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class TopicDailyStaging {
    @TableId(type = IdType.AUTO)
    private Long id;

    private Long userId;
    private Long topicId;
    private Long subjectId;
    private Integer isPublic;
}
