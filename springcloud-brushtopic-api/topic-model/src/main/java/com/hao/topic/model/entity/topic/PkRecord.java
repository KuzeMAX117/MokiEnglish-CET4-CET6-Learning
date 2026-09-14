package com.hao.topic.model.entity.topic;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class PkRecord {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String roomId;
    private Long userAId;
    private Long userBId;
    private Integer userAScore;
    private Integer userBScore;
    private Long winnerId;
    private Integer totalQuestions;
    private String questionIds;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime endTime;
}
