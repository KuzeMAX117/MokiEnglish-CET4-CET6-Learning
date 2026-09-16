package com.hao.topic.ai.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hao.topic.ai.mapper.AiModuleRecordMapper;
import com.hao.topic.ai.service.AiModuleRecordService;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.model.entity.ai.AiModuleRecord;
import com.hao.topic.model.vo.topic.TopicDataVo;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
@Slf4j
public class AiModuleRecordServiceImpl implements AiModuleRecordService {
    
    private final AiModuleRecordMapper aiModuleRecordMapper;
    
    @Override
    public void recordModuleUsage(Long userId, String nickname, String moduleType) {
        recordModuleUsage(userId, nickname, moduleType, null, null);
    }
    
    @Override
    public void recordModuleUsage(Long userId, String nickname, String moduleType, Long businessId, String businessType) {
        if (userId == null || moduleType == null || moduleType.isEmpty()) {
            log.warn("记录模块使用失败：参数无效 userId={}, moduleType={}", userId, moduleType);
            return;
        }
        
        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        
        if (businessId != null) {
            // 有业务ID时，每次创建独立记录（用于追踪具体作文/翻译的使用）
            AiModuleRecord record = new AiModuleRecord();
            record.setUserId(userId);
            record.setNickname(nickname);
            record.setModuleType(moduleType);
            record.setBusinessId(businessId);
            record.setBusinessType(businessType);
            record.setCount(1L);
            record.setRecordDate(new Date());
            aiModuleRecordMapper.insert(record);
            log.debug("记录模块使用（业务关联）：userId={}, moduleType={}, businessId={}, businessType={}",
                    userId, moduleType, businessId, businessType);
        } else {
            // 无业务ID时，按日聚合（用于模块维度统计）
            LambdaQueryWrapper<AiModuleRecord> wrapper = new LambdaQueryWrapper<>();
            wrapper.eq(AiModuleRecord::getUserId, userId);
            wrapper.eq(AiModuleRecord::getModuleType, moduleType);
            wrapper.eq(AiModuleRecord::getRecordDate, date);
            wrapper.isNull(AiModuleRecord::getBusinessId);
            
            AiModuleRecord existingRecord = aiModuleRecordMapper.selectOne(wrapper);
            
            if (existingRecord == null) {
                AiModuleRecord record = new AiModuleRecord();
                record.setUserId(userId);
                record.setNickname(nickname);
                record.setModuleType(moduleType);
                record.setCount(1L);
                record.setRecordDate(new Date());
                aiModuleRecordMapper.insert(record);
            } else {
                existingRecord.setCount(existingRecord.getCount() + 1);
                aiModuleRecordMapper.updateById(existingRecord);
            }
        }
        
        log.debug("记录模块使用：userId={}, moduleType={}, date={}", userId, moduleType, date);
    }
    
    @Override
    public Long countModuleUsage(String moduleType, String date) {
        Long count = aiModuleRecordMapper.countModuleFrequency(moduleType, date);
        return count == null ? 0L : count;
    }
    
    @Override
    public List<TopicDataVo> countModuleTrend7Days(String moduleType) {
        return aiModuleRecordMapper.countModuleDay7(moduleType);
    }
    
    @Override
    public Long countModuleUsageByUser(Long userId, String moduleType) {
        Long count = aiModuleRecordMapper.countModuleByUser(userId, moduleType);
        return count == null ? 0L : count;
    }
    
    @Override
    public List<Map<String, Object>> countAllModulesByDate(String date) {
        return aiModuleRecordMapper.countAllModulesByDate(date);
    }
    
    @Override
    public List<Map<String, Object>> countAllModulesTrend(Integer days) {
        if (days == null || days <= 0) {
            days = 7;
        }
        return aiModuleRecordMapper.countAllModulesTrend(days);
    }
    
    @Override
    public Long countBusinessUsage(Long businessId, String businessType) {
        if (businessId == null || businessType == null) {
            return 0L;
        }
        LambdaQueryWrapper<AiModuleRecord> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AiModuleRecord::getBusinessId, businessId);
        wrapper.eq(AiModuleRecord::getBusinessType, businessType);
        List<AiModuleRecord> records = aiModuleRecordMapper.selectList(wrapper);
        return records == null ? 0L : (long) records.size();
    }
}