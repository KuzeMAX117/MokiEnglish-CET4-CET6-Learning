package com.hao.topic.model.vo.topic;

import lombok.Data;

@Data
public class TopicUserRankVo {
    private String avatar;
    private String nickname;
    private Long scope;
    private Long userId;
    private Long rank;
    private String role;
    private String topicTime;
}
