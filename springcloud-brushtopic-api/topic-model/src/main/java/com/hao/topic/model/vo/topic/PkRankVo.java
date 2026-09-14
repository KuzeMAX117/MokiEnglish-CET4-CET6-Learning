package com.hao.topic.model.vo.topic;

import lombok.Data;

@Data
public class PkRankVo {
    private Long userId;
    private String nickname;
    private String avatar;
    private Integer score;
    private Long rank;
}
