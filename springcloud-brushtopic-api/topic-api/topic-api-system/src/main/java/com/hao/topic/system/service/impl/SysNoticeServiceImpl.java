package com.hao.topic.system.service.impl;

import com.alibaba.fastjson2.util.DateUtils;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.hao.topic.api.utils.constant.TimeUtils;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.model.dto.system.SysNoticeDto;
import com.hao.topic.model.dto.system.SysNoticeReadDto;
import com.hao.topic.model.entity.system.SysNotice;
import com.hao.topic.model.vo.system.SysNoticeVo;
import com.hao.topic.system.constant.NoticeConstant;
import com.hao.topic.system.enums.NoticeEnums;
import com.hao.topic.system.mapper.SysNoticeMapper;
import com.hao.topic.system.service.SysNoticeService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Objects;

@Service
@AllArgsConstructor
@Slf4j
public class SysNoticeServiceImpl implements SysNoticeService {
    private final SysNoticeMapper sysNoticeMapper;

    

    public void recordNotice(SysNoticeDto sysNoticeDto) {
        if (sysNoticeDto.getStatus() == null) {
            throw new TopicException(ResultCodeEnum.FAIL);
        }
        
        Long currentId = SecurityUtils.getCurrentId();
        
        String message = NoticeEnums.getMessageByCode(sysNoticeDto.getStatus());
        
        SysNotice sysNoticeDb = new SysNotice();
        sysNoticeDb.setAccount(SecurityUtils.getCurrentName());
        sysNoticeDb.setUserId(currentId);
        sysNoticeDb.setStatus(sysNoticeDto.getStatus());
        
        if (Objects.equals(sysNoticeDto.getStatus(), NoticeEnums.MEMBER_PAY.getCode())) {
            
            LambdaQueryWrapper<SysNotice> sysNoticeLambdaQueryWrapper = new LambdaQueryWrapper<>();
            sysNoticeLambdaQueryWrapper.eq(SysNotice::getStatus, NoticeEnums.MEMBER_PAY.getCode());
            sysNoticeLambdaQueryWrapper.eq(SysNotice::getUserId, currentId);
            SysNotice sysNotice = sysNoticeMapper.selectOne(sysNoticeLambdaQueryWrapper);
            if (sysNotice != null) {
                
                return;
            }
            
            sysNoticeDb.setContent(NoticeConstant.RECHARGE_MEMBER);
        } else {
            
            sysNoticeDb.setContent(message);
        }
        sysNoticeMapper.insert(sysNoticeDb);
    }

    

    public List<SysNoticeVo> list() {
        
        Long currentId = SecurityUtils.getCurrentId();
        
        String role = SecurityUtils.getCurrentRole();
        List<SysNotice> sysNoticeList = null;
        if (role.equals("admin")) {
            
            LambdaQueryWrapper<SysNotice> sysNoticeLambdaQueryWrapper = new LambdaQueryWrapper<>();
            sysNoticeLambdaQueryWrapper.orderByDesc(SysNotice::getCreateTime);
            sysNoticeLambdaQueryWrapper.eq(SysNotice::getIsRead, 0);
            sysNoticeList = sysNoticeMapper.selectList(sysNoticeLambdaQueryWrapper);
        } else {
            
            LambdaQueryWrapper<SysNotice> sysNoticeLambdaQueryWrapper = new LambdaQueryWrapper<>();
            sysNoticeLambdaQueryWrapper.eq(SysNotice::getRecipientsId, currentId);
            sysNoticeLambdaQueryWrapper.eq(SysNotice::getIsRead, 0);
            sysNoticeLambdaQueryWrapper.orderByDesc(SysNotice::getCreateTime);
            
            sysNoticeLambdaQueryWrapper.eq(SysNotice::getStatus, NoticeEnums.REPLY.getCode());
            sysNoticeList = sysNoticeMapper.selectList(sysNoticeLambdaQueryWrapper);
        }
        return sysNoticeList.stream().map(item -> {
            SysNoticeVo sysNoticeVo = new SysNoticeVo();
            BeanUtils.copyProperties(item, sysNoticeVo);
            
            String today = DateUtils.format(item.getCreateTime(), "yyyy-MM-dd");
            if (today.equals(DateUtils.format(new Date(), "yyyy-MM-dd"))) {
                sysNoticeVo.setTimeDesc(TimeUtils.formatTimeAgo(item.getCreateTime()));
            } else {
                
                sysNoticeVo.setTimeDesc(DateUtils.format(item.getCreateTime(), "yyyy-MM-dd HH:mm:ss"));
            }
            return sysNoticeVo;
        }).toList();
    }

    

    public Boolean has() {
        
        Long currentId = SecurityUtils.getCurrentId();
        
        String role = SecurityUtils.getCurrentRole();
        if (role.equals("admin")) {
            
            LambdaQueryWrapper<SysNotice> sysNoticeLambdaQueryWrapper = new LambdaQueryWrapper<>();
            sysNoticeLambdaQueryWrapper.orderByDesc(SysNotice::getCreateTime);
            sysNoticeLambdaQueryWrapper.eq(SysNotice::getIsRead, 0);
            Long count = sysNoticeMapper.selectCount(sysNoticeLambdaQueryWrapper);
            return count > 0;
        } else {
            
            LambdaQueryWrapper<SysNotice> sysNoticeLambdaQueryWrapper = new LambdaQueryWrapper<>();
            sysNoticeLambdaQueryWrapper.eq(SysNotice::getRecipientsId, currentId);
            sysNoticeLambdaQueryWrapper.eq(SysNotice::getIsRead, 0);
            sysNoticeLambdaQueryWrapper.orderByDesc(SysNotice::getCreateTime);
            
            sysNoticeLambdaQueryWrapper.eq(SysNotice::getStatus, NoticeEnums.REPLY.getCode());
            Long count = sysNoticeMapper.selectCount(sysNoticeLambdaQueryWrapper);
            return count > 0;
        }
    }

    

    public void read(SysNoticeReadDto sysNoticeReadDto) {
        if (CollectionUtils.isEmpty(sysNoticeReadDto.getIdsList())) {
            throw new TopicException(ResultCodeEnum.FAIL);
        }
        sysNoticeReadDto.getIdsList().forEach(item -> {
            SysNotice sysNotice = new SysNotice();
            sysNotice.setId(item);
            sysNotice.setIsRead(1);
            sysNoticeMapper.updateById(sysNotice);
        });
    }

    

    public void clearNotice() {
        
        Long currentId = SecurityUtils.getCurrentId();
        
        
        LambdaQueryWrapper<SysNotice> sysNoticeLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysNoticeLambdaQueryWrapper.eq(SysNotice::getIsRead, 0);
        sysNoticeLambdaQueryWrapper.eq(SysNotice::getRecipientsId, currentId);
        List<SysNotice> sysNotices = sysNoticeMapper.selectList(sysNoticeLambdaQueryWrapper);
        if (CollectionUtils.isEmpty(sysNotices)) {
            return;
        }
        sysNotices.forEach(item -> {
            item.setIsRead(1);
            sysNoticeMapper.updateById(item);
        });
    }
}
