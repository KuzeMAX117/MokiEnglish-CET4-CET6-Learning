package com.hao.topic.model.entity.word;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 英语词典（兜底查询用，不参与背诵模块）
 */
@Data
@TableName("word_dictionary")
public class WordDictionary {

    @TableId(type = IdType.AUTO)
    private Long id;

    private String word;

    private String translation;

    private LocalDateTime createTime;
}
