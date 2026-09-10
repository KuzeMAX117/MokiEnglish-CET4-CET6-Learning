package com.hao.topic.model.entity.word;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class UserWordSetting extends BaseEntity {
    private Long userId;
    private Long bookId;
    private Integer dailyCount;
}
