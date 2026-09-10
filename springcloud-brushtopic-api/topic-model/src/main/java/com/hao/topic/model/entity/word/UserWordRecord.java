package com.hao.topic.model.entity.word;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UserWordRecord extends BaseEntity {
    private Long userId;
    private Long wordId;
    private Long bookId;
    private Integer status;
    private Integer proficiency;
    private LocalDateTime nextReviewTime;
    private Integer reviewCount;
    private LocalDateTime lastStudyTime;
}
