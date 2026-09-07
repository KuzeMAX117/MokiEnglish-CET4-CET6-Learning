package com.hao.topic.ai.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hao.topic.ai.mapper.AiUserMapper;
import com.hao.topic.ai.service.ManageService;
import com.hao.topic.client.security.SecurityFeignClient;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.ai.AiUserDto;
import com.hao.topic.model.entity.ai.AiUser;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
public class ManageServiceImpl implements ManageService {
    private AiUserMapper aiUserMapper;

    

    public Map<String, Object> list(AiUserDto aiUserDto) {
        
        Page<AiUser> aiUserPage = new Page<>(aiUserDto.getPageNum(), aiUserDto.getPageSize());
        
        LambdaQueryWrapper<AiUser> aiUserLambdaQueryWrapper = new LambdaQueryWrapper<>();
        if (!StringUtils.isEmpty(aiUserDto.getAccount())) {
            aiUserLambdaQueryWrapper.like(AiUser::getAccount, aiUserDto.getAccount());
        }
        aiUserLambdaQueryWrapper.orderByDesc(AiUser::getRecentlyUsedTime);
        
        Page<AiUser> aiUserPageDb = aiUserMapper.selectPage(aiUserPage, aiUserLambdaQueryWrapper);

        return Map.of(
                "total", aiUserPageDb.getTotal(),
                "rows", aiUserPageDb.getRecords()
        );
    }

    

    public void update(AiUser aiUser) {
        aiUserMapper.updateById(aiUser);
    }
}
