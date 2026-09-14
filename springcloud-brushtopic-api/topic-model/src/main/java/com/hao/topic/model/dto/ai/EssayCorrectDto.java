package com.hao.topic.model.dto.ai;

import lombok.Data;

/**
 * 作文批改请求 DTO
 */
@Data
public class EssayCorrectDto {

    /** 作文内容 */
    private String essay;

    /** 作文题目 */
    private String topic;

    /** 难度等级：4（四级）/ 6（六级） */
    private Integer level;
}
