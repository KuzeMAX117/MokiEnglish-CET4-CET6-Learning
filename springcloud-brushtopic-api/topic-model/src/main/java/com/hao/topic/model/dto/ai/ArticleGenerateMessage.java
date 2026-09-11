package com.hao.topic.model.dto.ai;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

/**
 * AI 短文异步生成 MQ 消息体
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ArticleGenerateMessage implements Serializable {

    /** 用户 ID */
    private Long userId;

    /** 日期（yyyy-MM-dd），用于 Redis 缓存 key */
    private String date;

    /** 目标单词列表 */
    private List<ArticleGenerateDto.WordInfo> words;

    /** 难度等级: CET-4 / CET-6 */
    private String level;

    /** 用户昵称 */
    private String nickname;
}
