package com.hao.topic.model.vo.topic;

import lombok.Data;

import java.util.List;

@Data
public class TopicTrendVo {
    private List<String> dateList;
    private List<Integer> countUserList;
    private List<Integer> countTopicList;

}
