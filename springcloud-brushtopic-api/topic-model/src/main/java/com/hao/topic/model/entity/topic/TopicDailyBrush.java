package com.hao.topic.model.entity.topic;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class TopicDailyBrush {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long userId;
    private Long dailyId;
}
