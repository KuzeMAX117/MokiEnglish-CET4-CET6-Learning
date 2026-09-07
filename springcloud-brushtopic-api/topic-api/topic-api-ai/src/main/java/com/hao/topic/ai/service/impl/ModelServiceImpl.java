package com.hao.topic.ai.service.impl;

import com.alibaba.dashscope.audio.tts.SpeechSynthesisAudioFormat;
import com.alibaba.dashscope.audio.tts.SpeechSynthesisParam;
import com.alibaba.dashscope.audio.tts.SpeechSynthesizer;
import com.alibaba.excel.util.StringUtils;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.alibaba.fastjson2.util.DateUtils;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hao.topic.ai.constant.AiConstant;
import com.hao.topic.ai.constant.PromptConstant;
import com.hao.topic.ai.constant.ResultConstant;
import com.hao.topic.ai.enums.AiStatusEnums;
import com.hao.topic.ai.mapper.AiAuditLogMapper;
import com.hao.topic.ai.mapper.AiHistoryMapper;
import com.hao.topic.ai.mapper.AiRecordMapper;
import com.hao.topic.ai.mapper.AiUserMapper;
import com.hao.topic.ai.properties.TtsProperties;
import com.hao.topic.ai.service.ModelService;
import com.hao.topic.api.utils.enums.StatusEnums;
import com.hao.topic.client.system.SystemFeignClient;
import com.hao.topic.client.topic.TopicFeignClient;
import com.hao.topic.common.constant.RedisConstant;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.security.utils.SecurityUtils;
import com.hao.topic.model.dto.ai.AiHistoryDto;
import com.hao.topic.model.dto.ai.ChatDto;
import com.hao.topic.model.dto.ai.TtsDto;
import com.hao.topic.model.dto.audit.TopicAudit;
import com.hao.topic.model.dto.audit.TopicAuditCategory;
import com.hao.topic.model.dto.audit.TopicAuditLabel;
import com.hao.topic.model.dto.audit.TopicAuditSubject;
import com.hao.topic.model.entity.ai.AiLog;
import com.hao.topic.model.entity.ai.AiHistory;
import com.hao.topic.model.entity.ai.AiRecord;
import com.hao.topic.model.entity.ai.AiUser;
import com.hao.topic.model.entity.system.SysRole;
import com.hao.topic.model.entity.topic.Topic;
import com.hao.topic.model.entity.topic.TopicCategory;
import com.hao.topic.model.entity.topic.TopicLabel;
import com.hao.topic.model.entity.topic.TopicSubject;
import com.hao.topic.model.vo.ai.AiHistoryContent;
import com.hao.topic.model.vo.ai.AiHistoryListVo;
import com.hao.topic.model.vo.ai.AiHistoryVo;
import com.hao.topic.model.vo.topic.TopicDataVo;
import com.hao.topic.model.vo.topic.TopicSubjectVo;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import reactor.core.publisher.Flux;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
public class ModelServiceImpl implements ModelService {
    private final ChatClient chatClient;
    @Autowired
    private AiHistoryMapper aiHistoryMapper;

    @Autowired
    private AiUserMapper aiUserMapper;

    @Autowired
    private TtsProperties ttsProperties;

    @Autowired
    private SystemFeignClient systemFeignClient;

    @Autowired
    private TopicFeignClient topicFeignClient;

    @Autowired
    private AiAuditLogMapper aiAuditLogMapper;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private AiRecordMapper aiRecordMapper;

    

    private static final String[] ENCOURAGEMENTS = {
            "💪 加油！你能行的！",
            "✨ 你可以的，相信自己！",
            "🔥 别放弃，再想想看～",
            "🌟 你已经很棒了，继续加油！",
            "🧠 慢慢来，答案就在前方～",
            "🚀 再试一次，你离成功不远了！",
            "💡 这道题对你来说不是问题！",
            "🎯 坚持到底就是胜利！",
            "🌈 每一次尝试都让你更接近成功！",
            "🌻 你的努力正在开花结果！",
            "⚡ 让智慧之光指引你前进！",
            "🦸 你就是自己的超级英雄！",
            "🌊 像海浪一样永不言弃！",
            "🎯 专注目标，你一定能做到！",
            "🚴 保持平衡，稳步前进！",
            "🧩 每个难题都是成长的拼图！",
            "🏆 冠军的潜力就在你心中！",
            "🌠 梦想就在不远处等着你！",
            "🦉 智慧正在你的脑中闪耀！",
            "⏳ 时间会证明你的坚持！"
    };

    

    private static String getRandomEncouragement() {
        int index = (int) (Math.random() * ENCOURAGEMENTS.length);
        return ENCOURAGEMENTS[index];
    }

    public ModelServiceImpl(ChatClient chatClient) {
        this.chatClient = chatClient;
    }

    

    public Flux<String> chat(ChatDto chatDto) {
        
        recordAi(chatDto.getNickname());
        
        recordAiUser();
        
        if (chatDto.getModel().equals(AiConstant.SYSTEM_MODEL)) {
            
            return systemModel(chatDto);
        } else if (chatDto.getModel().equals(AiConstant.AI_MODEL)) {
            
            return aiModel(chatDto);
        }
        
        return mixModel(chatDto);
    }
    

    private Flux<String> mixModel(ChatDto chatDto) {
        

        
        Long currentId = SecurityUtils.getCurrentId();
        
        String currentName = SecurityUtils.getCurrentName();
        
        AiHistory aiHistory = getCurrentHistory(chatDto);
        
        String prompt = null;
        
        if (aiHistory == null) {
            
            
            Long subjectId = disposeSystemModel(chatDto);
            
            if (subjectId == null) {
                log.info("Hao-发ai题目");
                return verifyPrompt(chatDto, null);
            }
            log.info("Hao-发系统题目");
            
            return sendRandomTopicToUser(chatDto);
        } else {
            
            
            
            Integer status = aiHistory.getStatus();

            
            if (AiStatusEnums.SEND_TOPIC.getCode().equals(status)) {
                
                prompt = "你提出面试题：" + aiHistory.getContent()
                        + "用户回答：" + chatDto.getPrompt() + "  " + PromptConstant.EVALUATE
                        + "结尾最后一定要一定要返回下面这句话\n" +
                        " > 请输入'**继续**'或者输入新的**题目类型**'";
                
                return startChat(prompt, aiHistory, AiStatusEnums.EVALUATE_ANSWER.getCode(), chatDto, currentName, currentId);
            }
            
            if (AiStatusEnums.EVALUATE_ANSWER.getCode().equals(status)) {
                
                if ("继续".equals(chatDto.getPrompt())) {
                    
                    List<AiHistory> aiHistoryList = aiHistoryMapper.selectList(new QueryWrapper<AiHistory>()
                            .eq("user_id", currentId)
                            .eq("status", AiStatusEnums.SEND_TOPIC.getCode())
                            .eq("chat_id", chatDto.getChatId())
                            .orderByDesc("create_time")
                            .last("limit 1"));
                    log.info("aiHistoryList: {}", aiHistoryList);
                    
                    chatDto.setPrompt(aiHistoryList.get(0).getTitle());
                    
                    Long subjectId = disposeSystemModel(chatDto);
                    
                    if (subjectId != null) {
                        log.info("Hao-发系统题目");
                        
                        return sendRandomTopicToUser(chatDto);
                    }
                    log.info("Hao-发ai题目");
                    
                    
                    return verifyPrompt(chatDto, aiHistoryList.get(0).getContent());
                } else {
                    
                    Long subjectId = disposeSystemModel(chatDto);
                    
                    if (subjectId != null) {
                        log.info("Hao-发系统题目");
                        
                        return sendRandomTopicToUser(chatDto);
                    }
                    log.info("Hao-发ai题目");
                    
                    return verifyPrompt(chatDto, aiHistory.getContent());
                }
            }
        }
        return null;
    }

    

    
    private Flux<String> aiModel(ChatDto chatDto) {
        

        
        Long currentId = SecurityUtils.getCurrentId();
        
        String currentName = SecurityUtils.getCurrentName();

        
        String prompt = null;
        
        AiHistory aiHistory = getCurrentHistory(chatDto);
        
        if (aiHistory == null) {
            
            return verifyPrompt(chatDto, null);
        } else {
            
            
            Integer status = aiHistory.getStatus();

            
            if (AiStatusEnums.SEND_TOPIC.getCode().equals(status)) {
                
                prompt = "你提出面试题：" + aiHistory.getContent()
                        + "用户回答：" + chatDto.getPrompt() + "  " + PromptConstant.EVALUATE
                        + "结尾最后一定要一定要返回下面这句话\n" +
                        " > 请输入'**继续**'或者输入新的**题目类型**'";
                
                return startChat(prompt, aiHistory, AiStatusEnums.EVALUATE_ANSWER.getCode(), chatDto, currentName, currentId);
            }
            
            if (AiStatusEnums.EVALUATE_ANSWER.getCode().equals(status)) {
                
                if ("继续".equals(chatDto.getPrompt())) {
                    
                    List<AiHistory> aiHistoryList = aiHistoryMapper.selectList(new QueryWrapper<AiHistory>()
                            .eq("user_id", currentId)
                            .eq("status", AiStatusEnums.SEND_TOPIC.getCode())
                            .eq("chat_id", chatDto.getChatId())
                            .orderByDesc("create_time")
                            .last("limit 1"));
                    log.info("aiHistoryList: {}", aiHistoryList);
                    
                    chatDto.setPrompt(aiHistoryList.get(0).getTitle());
                    
                    return verifyPrompt(chatDto, aiHistoryList.get(0).getContent());
                } else {
                    
                    return verifyPrompt(chatDto, aiHistory.getContent());
                }
            }
        }
        return null;
    }

    

    private Flux<String> verifyPrompt(ChatDto chatDto, String topic) {
        String prompt = null;
        if (topic != null) {
            String promptBuffer;
            
            LambdaQueryWrapper<AiHistory> aiHistoryLambdaQueryWrapper = new LambdaQueryWrapper<>();
            aiHistoryLambdaQueryWrapper.eq(AiHistory::getUserId, SecurityUtils.getCurrentId());
            aiHistoryLambdaQueryWrapper.eq(AiHistory::getStatus, AiStatusEnums.SEND_TOPIC.getCode());
            aiHistoryLambdaQueryWrapper.eq(AiHistory::getChatId, chatDto.getChatId());
            List<AiHistory> aiHistoryList = aiHistoryMapper.selectList(aiHistoryLambdaQueryWrapper);
            if (!CollectionUtils.isEmpty(aiHistoryList)) {
                
                promptBuffer = aiHistoryList.stream()
                        .map(AiHistory::getOriginalTitle) 
                        .filter(title -> title != null && !title.trim().isEmpty()) 
                        .collect(Collectors.joining("\n")); 
                prompt = PromptConstant.CHECK_TOPIC_TYPE + "当前对话记录已经出过的面试题\n【：" + promptBuffer + "】" + "就不可以在出了\n用户输入的面试题类型：【" + chatDto.getPrompt() + "】";

            }
            log.info("verifyPrompt================>?: {}", prompt);
        } else {
            prompt = PromptConstant.CHECK_TOPIC_TYPE + "\n用户输入的面试题类型：【" + chatDto.getPrompt() + "】";
        }
        
        String content = this.chatClient.prompt()
                .user(prompt)
                .call()
                .content();
        log.info("verifyPrompt================>?: {}", content);
        
        if (content != null && content.equalsIgnoreCase("false")) {
            
            return Flux.just("❌请输入正确的题目类型\uD83D\uDE0A");
        }
        
        
        prompt = "### 【" + chatDto.getPrompt() + "】类型 💡\n\n" +
                "## 面试题目：\n" +
                "**" + content + "**\n\n" +
                "> " + getRandomEncouragement();

        
        saveHistory(chatDto, prompt, content);
        
        return Flux.just(prompt);
    }

    

    

    

    private Flux<String> systemModel(ChatDto chatDto) {
        

        
        Long currentId = SecurityUtils.getCurrentId();
        
        String currentName = SecurityUtils.getCurrentName();

        
        String prompt = null;

        AiHistory aiHistory = getCurrentHistory(chatDto);

        
        if (aiHistory == null) {
            
            return sendRandomTopicToUser(chatDto);
        } else {
            
            

            
            Integer status = aiHistory.getStatus();
            
            if (AiStatusEnums.SEND_TOPIC.getCode().equals(status)) {
                
                prompt = "你提出面试题：" + aiHistory.getContent()
                        + "用户回答：" + chatDto.getPrompt() + "  " + PromptConstant.EVALUATE
                        + "结尾最后一定要一定要返回下面这句话\n" +
                        " > 请输入'**继续**'或者输入新的**题目类型**'";
                
                return startChat(prompt, aiHistory, AiStatusEnums.EVALUATE_ANSWER.getCode(), chatDto, currentName, currentId);
            }
            
            if (AiStatusEnums.EVALUATE_ANSWER.getCode().equals(status)) {
                
                if ("继续".equals(chatDto.getPrompt())) {
                    
                    List<AiHistory> aiHistoryList = aiHistoryMapper.selectList(new QueryWrapper<AiHistory>()
                            .eq("user_id", currentId)
                            .eq("status", AiStatusEnums.SEND_TOPIC.getCode())
                            .eq("chat_id", chatDto.getChatId())
                            .orderByDesc("create_time")
                            .last("limit 1"));
                    log.info("aiHistoryList: {}", aiHistoryList);
                    
                    chatDto.setPrompt(aiHistoryList.get(0).getTitle());
                    
                    return sendRandomTopicToUser(chatDto);
                } else {
                    
                    return sendRandomTopicToUser(chatDto);
                }
            }
        }
        return Flux.just(ResultConstant.SYSTEM_ERROR);
    }

    

    private Long disposeSystemModel(ChatDto chatDto) {
        
        String currentName = SecurityUtils.getCurrentName();
        
        String role = SecurityUtils.getCurrentRole();
        
        List<TopicSubjectVo> subject = topicFeignClient.getSubject(role, currentName);
        log.info("subject:" + JSON.toJSONString(subject));
        
        if (CollectionUtils.isNotEmpty(subject)) {
            List<TopicSubjectVo> list = subject.stream()
                    .filter(topicSubjectVo ->
                            topicSubjectVo.getSubjectName().equals(chatDto.getPrompt()))
                    .toList();
            if (CollectionUtils.isEmpty(list)) {
                
                return null;
            } else {
                return list.get(0).getId();
            }
        } else {
            return null;
        }
    }

    

    private Flux<String> sendRandomTopicToUser(ChatDto chatDto) {
        
        String role = SecurityUtils.getCurrentRole();
        
        Long subjectId = disposeSystemModel(chatDto);
        if (subjectId == null) {
            
            if (role.equals("member")) {
                
                return Flux.just(ResultConstant.PLEASE_INPUT_TOPIC_SUBJECT_OR_CUSTOM_TOPIC_SUBJECT);
            } else {
                return Flux.just(ResultConstant.PLEASE_INPUT_TOPIC_SUBJECT);
            }
        }
        
        Topic randomTopic = getSubjectTopicList(subjectId);
        if (randomTopic == null) {
            return Flux.just(ResultConstant.SYSTEM_IS_COMPLETING_TOPIC);
        }
        
        String prompt = "### 【" + chatDto.getPrompt() + "】专题 💡\n\n" +
                "## 面试题目：\n" +
                "**" + randomTopic.getTopicName() + "**\n\n" +
                "> " + getRandomEncouragement();

        saveHistory(chatDto, prompt, null);
        return Flux.just(prompt);
    }

    

    private Topic getSubjectTopicList(Long subjectId) {
        List<Topic> topicList = topicFeignClient.getSubjectTopicList(subjectId);
        if (CollectionUtils.isEmpty(topicList)) {
            return null;
        }

        
        int randomIndex = (int) (Math.random() * topicList.size());
        Topic selectedTopic = topicList.get(randomIndex);

        log.info("随机抽取到题目：{}", selectedTopic.getTopicName());
        return selectedTopic;
    }

    

    

    public Flux<String> startChat(String prompt, AiHistory aiHistory, Integer status, ChatDto chatDto, String currentName, Long currentId) {
        
        StringBuffer fullReply = new StringBuffer();

        Flux<String> content = this.chatClient.prompt()
                .user(prompt)
                .stream()
                .content();
        Flux<String> stringFlux = content.flatMap(response -> {
            fullReply.append(response);
            return Flux.just(response);
        }).doOnComplete(() -> {
            log.info("执行完成保存历史记录");
            
            String chatId = chatDto.getChatId();
            aiHistory.setChatId(chatId);
            aiHistory.setAccount(currentName);
            aiHistory.setUserId(currentId);
            aiHistory.setContent(fullReply.toString());
            aiHistory.setTitle(chatDto.getPrompt());
            aiHistory.setStatus(status);
            aiHistory.setMode(chatDto.getModel());
            aiHistory.setId(null);
            aiHistoryMapper.insert(aiHistory);
        });
        return stringFlux;
    }

    

    private AiHistory getCurrentHistory(ChatDto chatDto) {
        
        Long currentId = SecurityUtils.getCurrentId();
        
        String currentName = SecurityUtils.getCurrentName();

        
        AiHistory aiHistory = null;
        Page<AiHistory> aiHistoryPage = new Page<>(1, 1);
        LambdaQueryWrapper<AiHistory> aiHistoryLambdaQueryWrapper = new LambdaQueryWrapper<>();
        aiHistoryLambdaQueryWrapper.eq(AiHistory::getChatId, chatDto.getChatId());
        aiHistoryLambdaQueryWrapper.orderByDesc(AiHistory::getCreateTime);
        aiHistoryLambdaQueryWrapper.eq(AiHistory::getUserId, currentId);
        aiHistoryLambdaQueryWrapper.eq(AiHistory::getAccount, currentName);
        Page<AiHistory> aiHistoryPageDb = aiHistoryMapper.selectPage(aiHistoryPage, aiHistoryLambdaQueryWrapper);
        if (aiHistoryPageDb.getRecords().size() > 0) {
            aiHistory = aiHistoryPageDb.getRecords().get(0);
        }

        
        LambdaQueryWrapper<AiHistory> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(AiHistory::getChatId, chatDto.getChatId());
        lambdaQueryWrapper.eq(AiHistory::getParent, 1);
        lambdaQueryWrapper.orderByAsc(AiHistory::getCreateTime);
        List<AiHistory> aiHistories = aiHistoryMapper.selectList(lambdaQueryWrapper);
        if (CollectionUtils.isEmpty(aiHistories)) {
            if (aiHistory != null) {
                aiHistory.setParent(1);
            }
        }
        if (aiHistories.size() > 1) {
            
            aiHistories.remove(0);
            
            aiHistories.forEach(aiHistory1 -> {
                aiHistory1.setParent(0);
                aiHistoryMapper.updateById(aiHistory1);
            });
        }
        return aiHistory;
    }

    
    private void saveHistory(ChatDto chatDto, String prompt, String originalTitle) {
        String currentName = SecurityUtils.getCurrentName();
        Long currentId = SecurityUtils.getCurrentId();
        
        String chatId = chatDto.getChatId();
        
        AiHistory aiHistory = new AiHistory();
        aiHistory.setChatId(chatId);
        aiHistory.setAccount(currentName);
        aiHistory.setUserId(currentId);
        aiHistory.setContent(prompt);
        
        LambdaQueryWrapper<AiHistory> aiHistoryLambdaQueryWrapper = new LambdaQueryWrapper<>();
        aiHistoryLambdaQueryWrapper.eq(AiHistory::getChatId, chatId);
        aiHistoryLambdaQueryWrapper.eq(AiHistory::getParent, 1);
        aiHistoryLambdaQueryWrapper.orderByAsc(AiHistory::getCreateTime);
        List<AiHistory> aiHistories = aiHistoryMapper.selectList(aiHistoryLambdaQueryWrapper);
        if (CollectionUtils.isEmpty(aiHistories)) {
            aiHistory.setParent(1);
        }
        if (aiHistories.size() > 1) {
            
            aiHistories.remove(0);
            
            aiHistories.forEach(aiHistory1 -> {
                aiHistory1.setParent(0);
                aiHistoryMapper.updateById(aiHistory1);
            });
        }
        if (chatDto.getMemoryId() == 1) {
            aiHistory.setParent(1);
        }
        aiHistory.setTitle(chatDto.getPrompt());
        aiHistory.setStatus(AiStatusEnums.SEND_TOPIC.getCode());
        aiHistory.setMode(chatDto.getModel());
        aiHistory.setOriginalTitle(originalTitle);
        aiHistoryMapper.insert(aiHistory);
    }

    

    private void recordAiUser() {
        
        Long currentId = SecurityUtils.getCurrentId();
        
        String currentName = SecurityUtils.getCurrentName();
        
        String role = SecurityUtils.getCurrentRole();
        
        LambdaQueryWrapper<AiUser> aiUserLambdaQueryWrapper = new LambdaQueryWrapper<>();
        aiUserLambdaQueryWrapper.eq(AiUser::getUserId, currentId);
        aiUserLambdaQueryWrapper.eq(AiUser::getAccount, currentName);
        AiUser aiUser = aiUserMapper.selectOne(aiUserLambdaQueryWrapper);
        if (aiUser == null) {
            
            aiUser = new AiUser();
            aiUser.setUserId(currentId);
            aiUser.setAccount(currentName);
            aiUser.setAiCount(1L);
            
            SysRole byRoleKey = systemFeignClient.getByRoleKey(role);
            if (byRoleKey == null) {
                throw new TopicException(ResultCodeEnum.ROLE_NO_EXIST);
            }
            aiUser.setRoleName(byRoleKey.getName());
            
            aiUser.setRecentlyUsedTime(DateUtils.parseLocalDateTime(DateUtils.format(new Date())));
            aiUserMapper.insert(aiUser);
        } else {
            if (!aiUser.getRoleName().equals("管理员") && !aiUser.getRoleName().equals("会员")) {
                
                if (aiUser.getAiCount() >= aiUser.getCount()) {
                    throw new TopicException(ResultCodeEnum.AI_COUNT_ERROR);
                }
            }
            
            if (aiUser.getStatus() == 1) {
                throw new TopicException(ResultCodeEnum.AI_ERROR);
            }
            
            
            aiUser.setAiCount(aiUser.getAiCount() + 1);
            
            aiUser.setRecentlyUsedTime(DateUtils.parseLocalDateTime(DateUtils.format(new Date())));
            aiUserMapper.updateById(aiUser);
        }
    }

    

    private void recordAi(String nickname) {
        if (StringUtils.isEmpty(nickname)) {
            
            nickname = SecurityUtils.getCurrentName();
        }
        
        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        
        LambdaQueryWrapper<AiRecord> aiRecordLambdaQueryWrapper = new LambdaQueryWrapper<>();
        aiRecordLambdaQueryWrapper.eq(AiRecord::getAiTime, date);
        aiRecordLambdaQueryWrapper.eq(AiRecord::getUserId, SecurityUtils.getCurrentId());
        AiRecord aiRecord = aiRecordMapper.selectOne(aiRecordLambdaQueryWrapper);
        if (aiRecord == null) {
            
            aiRecord = new AiRecord();
            aiRecord.setUserId(SecurityUtils.getCurrentId());
            aiRecord.setCount(1L);
            aiRecord.setNickname(nickname);
            aiRecord.setAiTime(new Date());
            aiRecordMapper.insert(aiRecord);
        } else {
            
            aiRecord.setCount(aiRecord.getCount() + 1);
            aiRecord.setAiTime(new Date());
            aiRecordMapper.updateById(aiRecord);
        }
    }

    

    @Transactional
    public List<AiHistoryListVo> getHistory(AiHistoryDto aiHistoryDto) {
        
        Long currentId = SecurityUtils.getCurrentId();
        
        Page<AiHistory> aiHistoryPage = new Page<>(aiHistoryDto.getPageNum(), aiHistoryDto.getPageSize());
        
        LambdaQueryWrapper<AiHistory> aiHistoryLambdaQueryWrapper = new LambdaQueryWrapper<>();
        aiHistoryLambdaQueryWrapper.eq(AiHistory::getUserId, currentId); 
        aiHistoryLambdaQueryWrapper.eq(AiHistory::getParent, 1); 
        aiHistoryLambdaQueryWrapper.orderByDesc(AiHistory::getCreateTime);
        
        if (!StringUtils.isEmpty(aiHistoryDto.getTitle())) {
            aiHistoryLambdaQueryWrapper.like(AiHistory::getTitle, aiHistoryDto.getTitle());
        }
        
        aiHistoryMapper.selectPage(aiHistoryPage, aiHistoryLambdaQueryWrapper);
        
        List<AiHistory> records = aiHistoryPage.getRecords();

        
        List<AiHistoryListVo> aiHistoryListVos = new ArrayList<>();
        
        List<String> dates = records.stream().map(aiHistory -> {
            
            return DateUtils.format(aiHistory.getCreateTime(), "yyyy-MM-dd");
        }).distinct().toList();

        
        for (String date : dates) {
            AiHistoryListVo aiHistoryListVoResult = new AiHistoryListVo();
            aiHistoryListVoResult.setDate(date);
            
            List<AiHistory> aiHistories = records.stream().filter(aiHistory -> {
                
                String createTime = DateUtils.format(aiHistory.getCreateTime(), "yyyy-MM-dd");
                return createTime.equals(date);
            }).toList();
            
            List<AiHistoryVo> aiHistoryVos = aiHistories.stream().map(aiHistory -> {
                AiHistoryVo aiHistoryVo = new AiHistoryVo();
                BeanUtils.copyProperties(aiHistory, aiHistoryVo);
                return aiHistoryVo;
            }).toList();
            
            aiHistoryListVoResult.setAiHistoryVos(aiHistoryVos);
            aiHistoryListVos.add(aiHistoryListVoResult);
        }

        return aiHistoryListVos;
    }

    

    public List<AiHistoryContent> getHistoryById(Long id) {
        
        if (id == null) {
            throw new TopicException(ResultCodeEnum.AI_HISTORY_ERROR);
        }
        
        AiHistory aiHistory = aiHistoryMapper.selectById(id);
        
        String chatId = aiHistory.getChatId();
        
        LambdaQueryWrapper<AiHistory> aiHistoryLambdaQueryWrapper = new LambdaQueryWrapper<>();
        aiHistoryLambdaQueryWrapper.eq(AiHistory::getChatId, chatId);
        aiHistoryLambdaQueryWrapper.eq(AiHistory::getUserId, SecurityUtils.getCurrentId());
        aiHistoryLambdaQueryWrapper.orderByDesc(AiHistory::getParent);
        aiHistoryLambdaQueryWrapper.orderByAsc(AiHistory::getCreateTime);
        List<AiHistory> aiHistories = aiHistoryMapper.selectList(aiHistoryLambdaQueryWrapper);
        
        return aiHistories.stream().map(history -> {
            AiHistoryContent aiHistoryContent = new AiHistoryContent();
            BeanUtils.copyProperties(history, aiHistoryContent);
            return aiHistoryContent;
        }).toList();
    }

    

    public ResponseEntity<byte[]> tts(TtsDto text) {
        recordAiUser();
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        com.alibaba.dashscope.audio.tts.SpeechSynthesizer synthesizer = new SpeechSynthesizer();
        com.alibaba.dashscope.audio.tts.SpeechSynthesisParam param = SpeechSynthesisParam.builder()
                
                .apiKey(ttsProperties.getApiKey())
                .model(ttsProperties.getModel())
                .text(text.getText())
                .sampleRate(48000)
                .format(SpeechSynthesisAudioFormat.WAV)
                .build();

        
        ByteBuffer audio = synthesizer.call(param);

        
        byte[] audioBytes = audio.array();

        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("file", "output.wav");  

        
        return ResponseEntity.ok()
                .headers(headers)
                .body(audioBytes);
    }

    

    public void deleteHistory(Long id) {
        
        if (id == null) {
            throw new TopicException(ResultCodeEnum.AI_HISTORY_DELETE_ERROR);
        }
        
        AiHistory aiHistory = aiHistoryMapper.selectById(id);
        if (aiHistory == null) {
            throw new TopicException(ResultCodeEnum.AI_HISTORY_DELETE_ERROR);
        }
        
        LambdaQueryWrapper<AiHistory> aiHistoryLambdaQueryWrapper = new LambdaQueryWrapper<>();
        aiHistoryLambdaQueryWrapper.eq(AiHistory::getChatId, aiHistory.getChatId());
        
        aiHistoryMapper.delete(aiHistoryLambdaQueryWrapper);
    }

    

    @Override
    public void updateHistoryById(AiHistoryDto aiHistoryDto) {
        if (aiHistoryDto == null) {
            throw new TopicException(ResultCodeEnum.AI_HISTORY_UPDATE_ERROR);
        }
        
        if (aiHistoryDto.getId() == null || aiHistoryDto.getTitle() == null) {
            throw new TopicException(ResultCodeEnum.AI_HISTORY_UPDATE_ERROR);
        }
        AiHistory aiHistory = aiHistoryMapper.selectById(aiHistoryDto.getId());
        if (aiHistory == null) {
            throw new TopicException(ResultCodeEnum.AI_HISTORY_UPDATE_ERROR);
        }
        
        aiHistory.setTitle(aiHistoryDto.getTitle());
        aiHistoryMapper.updateById(aiHistory);
    }

    

    public void auditSubject(TopicAuditSubject topicAuditSubject) {
        
        String categoryName = topicAuditSubject.getCategoryName();
        
        String subjectName = topicAuditSubject.getSubjectName();
        
        String subjectDesc = topicAuditSubject.getSubjectDesc();
        
        String prompt = PromptConstant.AUDIT_SUBJECT + "\n" +
                "专题内容: 【" + subjectName + "】\n" +
                "专题描述: 【" + subjectDesc + "】\n" +
                "分类名称: 【" + categoryName + "】";
        
        String content = getAiContent(prompt, topicAuditSubject.getAccount(), topicAuditSubject.getUserId());
        
        log.info("AI返回结果: {}", content);
        TopicSubject topicSubject = new TopicSubject();
        String reason = null;
        try {
            
            JSONObject jsonObject = JSON.parseObject(content);
            boolean result = false;
            if (jsonObject != null) {
                result = jsonObject.getBooleanValue("result");
            }
            if (jsonObject != null) {
                reason = jsonObject.getString("reason");
            }
            topicSubject.setId(topicAuditSubject.getId());
            if (result) {
                log.info("审核通过: {}", reason);
                
                topicSubject.setStatus(StatusEnums.NORMAL.getCode());
            } else {
                log.warn("审核未通过: {}", reason);
                
                
                topicSubject.setFailMsg(reason);
                topicSubject.setStatus(StatusEnums.AUDIT_FAIL.getCode());
            }
        } catch (Exception e) {
            log.error("解析AI返回结果失败: {}", content, e);
            
            topicSubject.setStatus(StatusEnums.AUDIT_FAIL.getCode());
            topicSubject.setFailMsg("解析AI返回结果失败");
            reason = "解析AI返回结果失败";
        }
        
        topicFeignClient.auditSubject(topicSubject);
        
        recordAuditLog(reason, topicAuditSubject.getAccount(), topicAuditSubject.getUserId());
    }

    

    public void auditCategory(TopicAuditCategory topicAuditCategory) {
        
        String lockKey = RedisConstant.CATEGORY_AUDIT_KEY_PREFIX + topicAuditCategory.getId();
        
        String categoryName = topicAuditCategory.getCategoryName();
        
        String prompt = PromptConstant.AUDIT_CATEGORY + "\n" +
                "分类名称: 【" + categoryName + "】";
        
        String content = getAiContent(prompt, topicAuditCategory.getAccount(), topicAuditCategory.getUserId());
        
        log.info("AI返回结果: {}", content);
        TopicCategory topicCategory = new TopicCategory();
        String reason = null;
        try {
            
            JSONObject jsonObject = JSON.parseObject(content);
            boolean result = false;
            if (jsonObject != null) {
                result = jsonObject.getBooleanValue("result");
            }
            if (jsonObject != null) {
                reason = jsonObject.getString("reason");
            }
            topicCategory.setId(topicAuditCategory.getId());
            if (result) {
                log.info("审核通过: {}", reason);
                
                topicCategory.setStatus(StatusEnums.NORMAL.getCode());

            } else {
                log.warn("审核未通过: {}", reason);
                
                
                topicCategory.setFailMsg(reason);
                topicCategory.setStatus(StatusEnums.AUDIT_FAIL.getCode());

            }
        } catch (Exception e) {
            log.error("解析AI返回结果失败: {}", content, e);
            
            topicCategory.setStatus(StatusEnums.AUDIT_FAIL.getCode());
            topicCategory.setFailMsg("解析AI返回结果失败");
            reason = "解析AI返回结果失败";
            
            stringRedisTemplate.delete(lockKey);
        }
        
        topicFeignClient.auditCategory(topicCategory);
        
        recordAuditLog(reason, topicAuditCategory.getAccount(), topicAuditCategory.getUserId());

    }

    

    public void auditLabel(TopicAuditLabel topicAuditLabel) {
        
        String labelName = topicAuditLabel.getLabelName();
        
        String prompt = PromptConstant.AUDIT_LABEL + "\n" +
                "标签名称: 【" + labelName + "】";
        
        String content = getAiContent(prompt, topicAuditLabel.getAccount(), topicAuditLabel.getUserId());
        
        log.info("AI返回结果: {}", content);
        TopicLabel topicLabel = new TopicLabel();
        String reason = null;
        try {
            
            JSONObject jsonObject = JSON.parseObject(content);
            boolean result = false;
            if (jsonObject != null) {
                result = jsonObject.getBooleanValue("result");
            }
            if (jsonObject != null) {
                reason = jsonObject.getString("reason");
            }
            topicLabel.setId(topicAuditLabel.getId());
            if (result) {
                log.info("审核通过: {}", reason);
                
                topicLabel.setStatus(StatusEnums.NORMAL.getCode());
            } else {
                log.warn("审核未通过: {}", reason);
                
                
                topicLabel.setFailMsg(reason);
                topicLabel.setStatus(StatusEnums.AUDIT_FAIL.getCode());
            }
        } catch (Exception e) {
            log.error("解析AI返回结果失败: {}", content, e);
            
            topicLabel.setStatus(StatusEnums.AUDIT_FAIL.getCode());
            topicLabel.setFailMsg("解析AI返回结果失败");
            reason = "解析AI返回结果失败";
        }
        
        topicFeignClient.auditLabel(topicLabel);
        
        recordAuditLog(reason, topicAuditLabel.getAccount(), topicAuditLabel.getUserId());
    }

    

    public void auditTopic(TopicAudit topicAudit) {
        
        String topicName = topicAudit.getTopicName();
        
        String subjectName = topicAudit.getTopicSubjectName();
        
        String labelName = topicAudit.getTopicLabelName();
        
        String answer = topicAudit.getAnswer();
        
        String prompt = PromptConstant.AUDIT_TOPIC + "\n" +
                "面试题名称: 【" + topicName + "】\n" +
                "用户输入的面试题答案: 【" + answer + "】\n" +
                "关联标签可以有多个他们是通过':'分割的: 【" + labelName + "】\n" +
                "所属专题: 【" + subjectName + "】\n";
        
        String content = getAiContent(prompt, topicAudit.getAccount(), topicAudit.getUserId());
        
        log.info("AI返回结果: {}", content);
        Topic topic = new Topic();
        String reason = null;
        try {
            
            JSONObject jsonObject = JSON.parseObject(content);
            boolean result = false;
            if (jsonObject != null) {
                result = jsonObject.getBooleanValue("result");
            }
            if (jsonObject != null) {
                reason = jsonObject.getString("reason");
            }
            topic.setId(topicAudit.getId());
            if (result) {
                log.info("审核通过: {}", reason);
                
                topic.setStatus(StatusEnums.NORMAL.getCode());
            } else {
                log.warn("审核未通过: {}", reason);
                
                topic.setAiAnswer("");
                
                topic.setFailMsg(reason);
                topic.setStatus(StatusEnums.AUDIT_FAIL.getCode());
            }
        } catch (Exception e) {
            log.error("解析AI返回结果失败: {}", content, e);
            
            topic.setStatus(StatusEnums.AUDIT_FAIL.getCode());
            topic.setFailMsg("解析AI返回结果失败");
            reason = "解析AI返回结果失败";
        }
        
        topicFeignClient.auditTopic(topic);
        
        recordAuditLog(reason, topicAudit.getAccount(), topicAudit.getUserId());
    }

    

    public void generateAnswer(TopicAudit topicAudit) {
        
        String prompt = PromptConstant.GENERATE_ANSWER + "\n" +
                "面试题: 【" + topicAudit.getTopicName() + "】";
        
        String aiContent = getAiContent(prompt, topicAudit.getAccount(), topicAudit.getUserId());
        Topic topic = new Topic();
        topic.setAiAnswer(aiContent);
        topic.setId(topicAudit.getId());
        
        topicFeignClient.updateAiAnswer(topic);
        
        recordAuditLog("生成AI答案成功啦！", topicAudit.getAccount(), topicAudit.getUserId());
    }

    

    public String getAiContent(String prompt, String account, Long userId) {
        try {
            
            return this.chatClient.prompt()
                    .user(prompt)
                    .call()
                    .content();
        } catch (Exception e) {
            
            AiLog aiLog = new AiLog();
            aiLog.setAccount(account);
            aiLog.setContent("AI回复异常");
            aiLog.setUserId(userId);
            aiAuditLogMapper.insert(aiLog);
            throw new TopicException(ResultCodeEnum.FAIL);
        }
    }

    

    public void recordAuditLog(String content, String account, Long userId) {
        AiLog aiLog = new AiLog();
        aiLog.setAccount(account);
        aiLog.setContent(content);
        aiLog.setUserId(userId);
        aiAuditLogMapper.insert(aiLog);
    }

    

    public Long count(String date) {
        Long count = aiRecordMapper.countAiFrequency(date);
        if (count == null) {
            count = 0L;
        }
        return count;
    }

    

    public List<TopicDataVo> countAiDay7() {
        List<TopicDataVo> topicDataVoList = aiRecordMapper.countAiDay7();
        return topicDataVoList;
    }

    

    public Long countAi(Long currentId) {
        Long count = aiRecordMapper.countAi(currentId);
        if (count == null) {
            count = 0L;
        }
        return count;
    }
}
