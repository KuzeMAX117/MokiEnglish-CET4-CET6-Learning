package com.hao.topic.model.vo.content;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class EssayVo {
    private Long id;
    private String title;
    private String content;
    private String referenceAnswer;
    private String analysis;
    private String category;
    private Integer difficulty;
    private Integer timeLimit;
    private String wordCount;
    private Long viewCount;
    private Integer isMember;
    private Integer status;
    private String createBy;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;
}
