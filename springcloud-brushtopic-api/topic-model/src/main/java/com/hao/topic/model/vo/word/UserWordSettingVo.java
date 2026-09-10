package com.hao.topic.model.vo.word;

import lombok.Data;

@Data
public class UserWordSettingVo {
    private Long id;
    private Long userId;
    private Long bookId;
    private Integer dailyCount;
}
