package com.hao.topic.ai.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hao.topic.model.dto.ai.AiUserDto;
import com.hao.topic.model.entity.ai.AiUser;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AiUserMapper extends BaseMapper<AiUser> {

}
