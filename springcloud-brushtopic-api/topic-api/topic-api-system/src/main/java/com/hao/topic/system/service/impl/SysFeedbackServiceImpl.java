package com.hao.topic.system.service.impl;

import com.alibaba.nacos.common.utils.StringUtils;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hao.topic.api.utils.enums.StatusEnums;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.model.dto.system.SysFeedbackReplyDto;
import com.hao.topic.model.entity.system.SysFeedback;
import com.hao.topic.model.entity.system.SysNotice;
import com.hao.topic.model.vo.system.SysFeedbackUserVo;
import com.hao.topic.model.vo.system.SysFeedbackVo;
import com.hao.topic.system.enums.NoticeEnums;
import com.hao.topic.system.mapper.SysFeedbackMapper;
import com.hao.topic.system.mapper.SysNoticeMapper;
import com.hao.topic.system.service.SysFeedbackService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Service
@AllArgsConstructor
@Slf4j
public class SysFeedbackServiceImpl extends ServiceImpl<SysFeedbackMapper, SysFeedback> implements SysFeedbackService {
    private final SysFeedbackMapper sysFeedbackMapper;
    private final SysNoticeMapper sysNoticeMapper;

    

    @Transactional
    public void saveFeedback(SysFeedback sysFeedbackDto) {
        
        if (StringUtils.isEmpty(sysFeedbackDto.getFeedbackContent())) {
            throw new TopicException(ResultCodeEnum.PARAM_ACCOUNT_ERROR);
        }
        
        Long currentId = SecurityUtils.getCurrentId();
        String currentName = SecurityUtils.getCurrentName();
        SysFeedback sysFeedback = new SysFeedback();
        sysFeedback.setUserId(currentId);
        sysFeedback.setAccount(currentName);
        sysFeedback.setFeedbackContent(sysFeedbackDto.getFeedbackContent());
        sysFeedback.setStatus(0);
        sysFeedbackMapper.insert(sysFeedback);
        
        SysNotice sysNotice = new SysNotice();
        sysNotice.setAccount(currentName);
        sysNotice.setUserId(currentId);
        sysNotice.setContent(sysFeedbackDto.getFeedbackContent());
        sysNotice.setStatus(sysFeedbackDto.getStatus());
        sysNoticeMapper.insert(sysNotice);
    }

    

    public Map<String, Object> list(SysFeedback sysFeedback) {
        
        Page<SysFeedback> page = new Page<>(sysFeedback.getPageNum(), sysFeedback.getPageSize());
        
        LambdaQueryWrapper<SysFeedback> sysFeedbackLambdaQueryWrapper = new LambdaQueryWrapper<>();
        if (sysFeedback.getStatus() != null) {
            sysFeedbackLambdaQueryWrapper.eq(SysFeedback::getStatus, sysFeedback.getStatus());
        }
        if (!StringUtils.isEmpty(sysFeedback.getReplyAccount())) {
            sysFeedbackLambdaQueryWrapper.like(SysFeedback::getReplyAccount, sysFeedback.getReplyAccount());
        }
        if (!StringUtils.isEmpty(sysFeedback.getAccount())) {
            sysFeedbackLambdaQueryWrapper.like(SysFeedback::getAccount, sysFeedback.getAccount());
        }
        sysFeedbackLambdaQueryWrapper.orderByDesc(SysFeedback::getCreateTime);
        
        Page<SysFeedback> selectedPage = sysFeedbackMapper.selectPage(page, sysFeedbackLambdaQueryWrapper);
        
        return Map.of(
                "total", selectedPage.getTotal(),
                "rows", selectedPage.getRecords().stream().map(
                        sysFeedback1 -> {
                            SysFeedbackVo sysFeedbackVo = new SysFeedbackVo();
                            BeanUtils.copyProperties(sysFeedback1, sysFeedbackVo);
                            return sysFeedbackVo;
                        }
                )
        );
    }

    

    public List<SysFeedbackUserVo> feedback() {
        LambdaQueryWrapper<SysFeedback> sysFeedbackLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysFeedbackLambdaQueryWrapper.eq(SysFeedback::getUserId, SecurityUtils.getCurrentId());
        sysFeedbackLambdaQueryWrapper.orderByDesc(SysFeedback::getCreateTime);
        List<SysFeedback> sysFeedbacks = sysFeedbackMapper.selectList(sysFeedbackLambdaQueryWrapper);
        return sysFeedbacks.stream().map(sysFeedback -> {
            SysFeedbackUserVo sysFeedbackUserVo = new SysFeedbackUserVo();
            BeanUtils.copyProperties(sysFeedback, sysFeedbackUserVo);
            return sysFeedbackUserVo;
        }).toList();
    }

    

    @Transactional
    public void reply(SysFeedbackReplyDto sysFeedbackReplyDto) {
        
        if (sysFeedbackReplyDto.getId() == null || sysFeedbackReplyDto.getReplyContent() == null || sysFeedbackReplyDto.getReplyContent().isEmpty()) {
            throw new TopicException(ResultCodeEnum.FEEDBACK_CONTENT_IS_NULL);
        }
        
        SysFeedback sysFeedback = sysFeedbackMapper.selectById(sysFeedbackReplyDto.getId());
        if (sysFeedback == null) {
            throw new TopicException(ResultCodeEnum.FEEDBACK_NOT_EXIST);
        }
        
        sysFeedback.setReplyContent(sysFeedbackReplyDto.getReplyContent());
        sysFeedback.setReplyAccount(SecurityUtils.getCurrentName());
        sysFeedback.setReplyTime(LocalDateTime.now());
        sysFeedback.setReplyId(SecurityUtils.getCurrentId());
        
        sysFeedback.setStatus(1);
        
        sysFeedbackMapper.updateById(sysFeedback);

        
        SysNotice sysNotice = new SysNotice();
        
        sysNotice.setAccount(sysFeedback.getReplyAccount());
        sysNotice.setUserId(sysFeedback.getReplyId());
        
        sysNotice.setContent(sysFeedback.getReplyContent());
        sysNotice.setStatus(NoticeEnums.REPLY.getCode());
        
        sysNotice.setRecipientsId(sysFeedback.getUserId());
        
        sysNoticeMapper.insert(sysNotice);
    }
}
