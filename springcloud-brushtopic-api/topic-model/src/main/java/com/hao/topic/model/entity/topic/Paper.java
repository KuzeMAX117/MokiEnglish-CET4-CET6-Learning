package com.hao.topic.model.entity.topic;

import com.baomidou.mybatisplus.annotation.TableName;
import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
@TableName("paper")
public class Paper extends BaseEntity {
    

    private Integer level;
    

    private Integer examYear;
    

    private Integer examHalf;
    private String title;
    private Long totalScore;
    private Integer status;
}
