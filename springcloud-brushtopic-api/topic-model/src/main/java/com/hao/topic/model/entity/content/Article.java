package com.hao.topic.model.entity.content;

import com.hao.topic.model.entity.BaseEntity;
import lombok.Data;

@Data
public class Article extends BaseEntity {
    private String title;
    private String content;
    private String summary;
    private String coverImage;
    private String category;
    private String source;
    private Long viewCount;
    private Integer isMember;
    private Integer status;
    private String createBy;
}
