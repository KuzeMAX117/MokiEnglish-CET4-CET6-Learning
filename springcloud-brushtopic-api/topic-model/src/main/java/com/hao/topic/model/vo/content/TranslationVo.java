package com.hao.topic.model.vo.content;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class TranslationVo {
    private Long id;
    private String title;
    private String sourceLang;
    private String targetLang;
    private String sourceText;
    private String referenceAnswer;
    private String analysis;
    private Integer difficulty;
    private String category;
    private Long viewCount;
    private Integer isMember;
    private Integer status;
    private String createBy;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;
}
