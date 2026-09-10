package com.hao.topic.model.vo.word;

import lombok.Data;

@Data
public class WordStatsVo {
    private Long learned;
    private Long mastered;
    private Long reviewDue;
    private Long toLearn;
    private Long todayLearned;
    private Long cet4Learned;
    private Long cet4Total;
    private Long cet6Learned;
    private Long cet6Total;
}
