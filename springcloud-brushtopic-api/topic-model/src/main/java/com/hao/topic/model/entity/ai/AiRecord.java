package com.hao.topic.model.entity.ai;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
public class AiRecord {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long userId;
    private String nickname;
    private Long count;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date aiTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField(fill = FieldFill.UPDATE)
    private LocalDateTime updateTime;
}
