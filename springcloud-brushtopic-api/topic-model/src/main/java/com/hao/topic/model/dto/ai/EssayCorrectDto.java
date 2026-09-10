package com.hao.topic.model.dto.ai;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EssayCorrectDto {
    private String essay;
    private String topic;
    private Integer level;
}
