package com.hao.topic.ai.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hao.topic.model.entity.ai.AiLog;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AiAuditLogMapper extends BaseMapper<AiLog> {
}
