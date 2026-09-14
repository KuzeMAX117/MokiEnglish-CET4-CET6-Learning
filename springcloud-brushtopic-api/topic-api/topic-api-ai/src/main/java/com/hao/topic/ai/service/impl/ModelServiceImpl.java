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
import com.hao.topic.ai.agent.EssayAgent;
import com.hao.topic.ai.agent.EssayAgentResult;
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
import com.hao.topic.model.dto.ai.EssayCorrectDto;
import com.hao.topic.model.dto.ai.TranslationCorrectDto;
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
import com.hao.topic.model.vo.ai.EssayCorrectionVo;
import com.hao.topic.model.vo.ai.TranslationCorrectionVo;
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

    @Autowired
    private EssayAgent essayAgent;

    

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

    

    @Override
    public String translateText(String text) {
        if (text == null || text.isBlank()) {
            return "";
        }
        String prompt = "请将以下英文文本翻译成中文，只返回翻译结果，不要任何解释或额外内容：\n" + text;
        return this.chatClient.prompt()
                .user(prompt)
                .call()
                .content();
    }

    

    @Override
    public TranslationCorrectionVo correctTranslation(TranslationCorrectDto dto) {
        if (dto == null || CollectionUtils.isEmpty(dto.getItems())) {
            throw new TopicException("批改内容不能为空");
        }

        // 人格设定已内置在 System Prompt 中（HaoTeacher 英语语法与翻译批改专家）
        String systemPrompt = PromptConstant.TRANSLATION_CORRECT_SYSTEM;

        // 逐句内容序列化为 JSON 数组，避免拼接歧义
        String itemsJson = JSON.toJSONString(dto.getItems());
        String userPrompt = PromptConstant.TRANSLATION_CORRECT_USER
                .replace("{direction}", "cn2en".equals(dto.getDirection()) ? "中文翻译成英文" : "英文翻译成中文")
                .replace("{level}", dto.getLevel() != null && dto.getLevel() == 6 ? "六级" : "四级")
                .replace("{topic}", dto.getTopic() == null ? "" : dto.getTopic())
                .replace("{items}", itemsJson);

        log.info("翻译批改请求：direction={}, level={}, 句数={}",
                dto.getDirection(), dto.getLevel(), dto.getItems().size());

        String content = this.chatClient.prompt()
                .system(systemPrompt)
                .user(userPrompt)
                .call()
                .content();

        log.debug("翻译批改 AI 原始返回: {}", content);

        TranslationCorrectionVo vo = parseTranslationCorrection(content);
        normalizeCorrection(vo, dto);
        return vo;
    }

    /**
     * 解析 AI 返回的批改 JSON，容错处理 markdown 代码块包裹等情况。
     */
    private TranslationCorrectionVo parseTranslationCorrection(String content) {
        if (content == null || content.isBlank()) {
            throw new TopicException("AI 批改服务暂无响应，请稍后重试");
        }
        String json = content.trim();
        // 去除可能的 ```json ... ``` 包裹
        if (json.startsWith("```")) {
            int firstBreak = json.indexOf('\n');
            if (firstBreak > 0) {
                json = json.substring(firstBreak + 1);
            }
            int fenceEnd = json.lastIndexOf("```");
            if (fenceEnd >= 0) {
                json = json.substring(0, fenceEnd);
            }
            json = json.trim();
        }
        // 截取最外层 JSON 对象，防止 AI 携带额外说明文字
        int start = json.indexOf('{');
        int end = json.lastIndexOf('}');
        if (start < 0 || end <= start) {
            throw new TopicException("AI 批改结果格式异常，请重试");
        }
        try {
            TranslationCorrectionVo vo = JSON.parseObject(json.substring(start, end + 1), TranslationCorrectionVo.class);
            if (vo == null) {
                throw new TopicException("AI 批改结果解析失败，请重试");
            }
            return vo;
        } catch (TopicException e) {
            throw e;
        } catch (Exception e) {
            log.error("翻译批改结果解析失败: {}", e.getMessage(), e);
            throw new TopicException("AI 批改结果解析失败，请重试");
        }
    }

    /**
     * 归一化批改结果：
     * 1. 以后端权威的档次原文映射强制校准 band/bandLabel/bandDescription，保证“档次原文严格原样引用”；
     * 2. score 钳制到所属档次区间，多维度分钳制 0-5；
     * 3. 漏译降档上限兜底 + 有效作答下限保护（语义相关的有效作答不得落 0 分档；整篇漏译/语义完全无关按大纲保留 0 分档）；
     * 4. 以提交内容为准回填原文/译文/参考翻译，补齐缺失字段，防止 AI 幻觉篡改。
     */
    private void normalizeCorrection(TranslationCorrectionVo vo, TranslationCorrectDto dto) {
        // 格式兜底：评分字段全缺失视为解析异常，提示重试，避免静默展示全 0 分
        if (vo.getBand() == null && vo.getScore() == null && vo.getAccuracy() == null
                && vo.getFluency() == null && vo.getGrammar() == null) {
            throw new TopicException("AI 批改结果格式异常，请重试");
        }
        vo.setAccuracy(clampScore(vo.getAccuracy(), 5));
        vo.setFluency(clampScore(vo.getFluency(), 5));
        vo.setGrammar(clampScore(vo.getGrammar(), 5));
        double rawScore = vo.getScore() == null ? 0D : Math.max(0, Math.min(vo.getScore(), 15));

        // 档次校准：band 非法时按 score 推断
        int band = normalizeBand(vo.getBand(), rawScore);
        // 漏译降档兜底：按有效作答覆盖率强制压低档次上限，防止只译部分句子却拿高分
        int total = dto.getItems().size();
        int effective = 0;
        for (TranslationCorrectDto.Item it : dto.getItems()) {
            if (isEffectiveAnswer(it.getUserTranslation())) {
                effective++;
            }
        }
        double coverage = total == 0 ? 0D : (double) effective / total;
        int coverageMaxBand = maxBandByCoverage(coverage);
        if (band > coverageMaxBand) {
            band = coverageMaxBand;
            vo.setBandReason((vo.getBandReason() == null ? "" : vo.getBandReason())
                    + String.format(" 【系统校准】有效作答 %d/%d 句（覆盖率 %.0f%%），按漏译降档规则档次上限为 %d 档，已下调。",
                    effective, total, coverage * 100, coverageMaxBand));
        }
        // 下限保护：大纲 0 分档仅限“未作答；仅有孤立单词；译文与原文语义完全无关”；
        // 部分作答且语义相关时不得被 AI 误判整体清零；coverage>0 时上限必 >=2，故直接提至 2 档
        if (effective > 0 && band == 0) {
            // 先用 AI 自己的逐句批改判断有效作答是否真的传达了原文语义：
            // 若每个有效句都被判 serious 级漏译且核心信息点无 ok，属官方 0 分档“语义完全无关”，保留 0 分档
            boolean conveysMeaning = false;
            List<TranslationCorrectionVo.Detail> dlist = vo.getDetails();
            for (int i = 0; i < dto.getItems().size() && !conveysMeaning; i++) {
                if (!isEffectiveAnswer(dto.getItems().get(i).getUserTranslation())) {
                    continue;
                }
                TranslationCorrectionVo.Detail d =
                        (dlist != null && i < dlist.size()) ? dlist.get(i) : null;
                if (d == null || d.getErrors() == null) {
                    // 无逐句数据可依时不作无关推定，保留下限保护
                    conveysMeaning = true;
                    break;
                }
                boolean seriousOmission = false;
                for (TranslationCorrectionVo.ErrorItem er : d.getErrors()) {
                    if ("serious".equals(er.getSeverity()) && "omission".equals(er.getType())) {
                        seriousOmission = true;
                        break;
                    }
                }
                if (!seriousOmission) {
                    conveysMeaning = true;
                }
            }
            if (!conveysMeaning && vo.getCoreInfoCheck() != null) {
                for (TranslationCorrectionVo.CoreInfoItem info : vo.getCoreInfoCheck()) {
                    if ("ok".equals(info.getStatus())) {
                        conveysMeaning = true;
                        break;
                    }
                }
            }
            if (!conveysMeaning) {
                vo.setBandReason((vo.getBandReason() == null ? "" : vo.getBandReason())
                        + String.format(" 【系统校准】有效作答 %d/%d 句经逐句批改均未传达原文核心信息（整篇漏译或语义完全无关），按大纲保留 0 分档。",
                        effective, total));
            } else {
                band = 2;
                // AI 的 0 分档判定连带其 0 分/0 维度分一并作废：分数与维度改由 AI 自己的逐句错误分级
                // 聚合已译部分质量重定，避免“译句干净却只拿区间下限 1 分、维度全 1”的误伤
                int clean = 0;
                int minorOnly = 0;
                for (int i = 0; i < dto.getItems().size(); i++) {
                    if (!isEffectiveAnswer(dto.getItems().get(i).getUserTranslation())) {
                        continue;
                    }
                    TranslationCorrectionVo.Detail d =
                            (dlist != null && i < dlist.size()) ? dlist.get(i) : null;
                    if (d == null || d.getErrors() == null) {
                        continue;
                    }
                    int serious = 0;
                    int minor = 0;
                    for (TranslationCorrectionVo.ErrorItem er : d.getErrors()) {
                        if ("serious".equals(er.getSeverity())) {
                            serious++;
                        } else {
                            minor++;
                        }
                    }
                    if (serious == 0 && minor == 0) {
                        clean++;
                    } else if (serious == 0) {
                        minorOnly++;
                    }
                }
                // 2 分档区间 [1,3] 内按已译部分质量取值：全部干净取上沿，仅轻微瑕取中，有严重错误取下沿
                int qualityScore;
                int langDim;
                if (clean == effective) {
                    qualityScore = 3;
                    langDim = 4;
                } else if (clean + minorOnly == effective) {
                    qualityScore = 2;
                    langDim = 3;
                } else {
                    qualityScore = 1;
                    langDim = 2;
                }
                rawScore = qualityScore;
                // 准确度按覆盖率折低（至少 1），流畅/语法如实反映已译句语言质量
                vo.setAccuracy(Math.max(vo.getAccuracy(), Math.max(1D, Math.round(coverage * 5))));
                vo.setFluency(Math.max(vo.getFluency(), (double) langDim));
                vo.setGrammar(Math.max(vo.getGrammar(), (double) langDim));
                vo.setBandReason((vo.getBandReason() == null ? "" : vo.getBandReason())
                        + String.format(" 【系统校准】有效作答 %d/%d 句且语义相关，不属于未作答或译文完全无关情形，0 分档不适用，已提至 2 档下限；"
                        + "分数与维度分按已译部分质量（%d 句无错误、%d 句仅轻微瑕）由逐句批改聚合重定。",
                        effective, total, clean, minorOnly));
            }
        }
        vo.setBand(band);
        vo.setBandLabel(BAND_LABELS.get(band));
        vo.setBandDescription(BAND_DESCRIPTIONS.get(band));
        // score 必须落在该档次区间内，超出则钳制到区间边界
        double[] range = BAND_RANGES.get(band);
        vo.setScore(Math.max(range[0], Math.min(rawScore, range[1])));
        // 维度分一致性兜底：档次非 0 却三维全 0 属自相矛盾（AI 误判 0 分档的连带产物），提至与档次相符的下限
        if (band > 0 && vo.getAccuracy() == 0D && vo.getFluency() == 0D && vo.getGrammar() == 0D) {
            vo.setAccuracy(1D);
            vo.setFluency(1D);
            vo.setGrammar(1D);
        }

        if (vo.getBandReason() == null) {
            vo.setBandReason("");
        }
        if (vo.getLevelScene() == null) {
            vo.setLevelScene("");
        }
        if (vo.getOverall() == null) {
            vo.setOverall("");
        }
        if (vo.getCoreInfoCheck() == null) {
            vo.setCoreInfoCheck(new ArrayList<>());
        }
        for (TranslationCorrectionVo.CoreInfoItem info : vo.getCoreInfoCheck()) {
            if (info.getPoint() == null) {
                info.setPoint("");
            }
            if (info.getNote() == null) {
                info.setNote("");
            }
            String status = info.getStatus();
            if (!"missing".equals(status) && !"wrong".equals(status)) {
                info.setStatus("ok");
            }
        }
        if (vo.getSelfCheckList() == null) {
            vo.setSelfCheckList(new ArrayList<>());
        }

        List<TranslationCorrectDto.Item> items = dto.getItems();
        List<TranslationCorrectionVo.Detail> details = vo.getDetails();
        if (details == null) {
            details = new ArrayList<>();
            vo.setDetails(details);
        }
        for (int i = 0; i < items.size(); i++) {
            TranslationCorrectDto.Item item = items.get(i);
            TranslationCorrectionVo.Detail detail;
            if (i < details.size() && details.get(i) != null) {
                detail = details.get(i);
            } else {
                detail = new TranslationCorrectionVo.Detail();
                details.add(detail);
            }
            // 原文类字段一律以提交内容为准
            detail.setSource(item.getSource());
            detail.setReference(item.getReference());
            detail.setUserTranslation(item.getUserTranslation() == null || item.getUserTranslation().isBlank()
                    ? "（未翻译）" : item.getUserTranslation());
            if (detail.getCompleteness() == null) {
                detail.setCompleteness("");
            }
            if (detail.getPolishedConservative() == null) {
                detail.setPolishedConservative("");
            }
            if (detail.getPolishedAdvanced() == null) {
                detail.setPolishedAdvanced("");
            }
            if (detail.getComment() == null) {
                detail.setComment("");
            }
            if (detail.getErrors() == null) {
                detail.setErrors(new ArrayList<>());
            }
            for (TranslationCorrectionVo.ErrorItem error : detail.getErrors()) {
                error.setType(normalizeErrType(error.getType()));
                // 分级：仅 serious/minor，非法值归为 minor
                boolean serious = "serious".equals(error.getSeverity());
                error.setSeverity(serious ? "serious" : "minor");
                if (error.getExplanation() == null) {
                    error.setExplanation("");
                }
                if (error.getSuggestion() == null) {
                    error.setSuggestion("");
                }
                // 影响分析兼底：为空时按分级默认
                if (error.getImpact() == null || error.getImpact().isBlank()) {
                    error.setImpact(serious ? "会降档" : "仅小幅扣分，不影响档次");
                }
                // 错误片段必须是用户译文的子串，否则清空 errorText，避免前端高亮错位
                if (error.getErrorText() != null && !error.getErrorText().isEmpty()
                        && !detail.getUserTranslation().contains(error.getErrorText())) {
                    error.setErrorText("");
                }
            }
        }
        // 多余的 details（AI 返回句数超出提交句数）直接丢弃
        while (details.size() > items.size()) {
            details.remove(details.size() - 1);
        }
    }

    private Double clampScore(Double value, double max) {
        if (value == null || value < 0) {
            return 0D;
        }
        return Math.min(value, max);
    }

    /** 官方档次标签（后端权威校准，防止 AI 引用偏差） */
    private static final Map<Integer, String> BAND_LABELS = Map.of(
            14, "14分档（13–15分）",
            11, "11分档（10–12分）",
            8, "8分档（7–9分）",
            5, "5分档（4–6分）",
            2, "2分档（1–3分）",
            0, "0分档（阅卷执行标准，非大纲正文）"
    );

    /** 官方档次描述原文（《考试大纲 2016 修订版》翻译评分标准） */
    private static final Map<Integer, String> BAND_DESCRIPTIONS = Map.of(
            14, "译文准确表达了原文的意思。译文流畅，结构清晰，用词贴切，基本无语言错误，仅有个别小错。",
            11, "译文基本表达了原文的意思。结构较清晰，语言通顺，但有少量语言错误。",
            8, "译文勉强表达了原文的意思。译文勉强连贯，语言错误相当多，其中有一些是严重错误。",
            5, "译文仅表达了一小部分原文的意思。连贯性差，有相当多的严重语言错误。",
            2, "译文支离破碎。除个别词语或句子，绝大部分文字没有表达原文意思。",
            0, "未作答；仅有孤立单词；译文与原文语义完全无关。"
    );

    /** 各档次分数区间 [min, max]，用于校验 score 与 band 一致 */
    private static final Map<Integer, double[]> BAND_RANGES = Map.of(
            14, new double[]{13, 15},
            11, new double[]{10, 12},
            8, new double[]{7, 9},
            5, new double[]{4, 6},
            2, new double[]{1, 3},
            0, new double[]{0, 0}
    );

    private static final Set<String> ERR_TYPES =
            Set.of("spelling", "grammar", "word_choice", "expression", "omission", "completeness");

    /**
     * 校准档次：band 合法则用之，否则按总分推断最接近的档次。
     */
    private int normalizeBand(Integer band, double score) {
        if (band != null && BAND_RANGES.containsKey(band)) {
            return band;
        }
        if (score >= 13) {
            return 14;
        }
        if (score >= 10) {
            return 11;
        }
        if (score >= 7) {
            return 8;
        }
        if (score >= 4) {
            return 5;
        }
        if (score >= 1) {
            return 2;
        }
        return 0;
    }

    private String normalizeErrType(String type) {
        return type != null && ERR_TYPES.contains(type) ? type : "expression";
    }

    /**
     * 判定是否为有效作答：排除空、单个字符、纯数字/符号等无意义输入（视为未作答）。
     */
    private boolean isEffectiveAnswer(String text) {
        if (text == null) {
            return false;
        }
        String t = text.trim();
        if (t.length() < 2) {
            return false;
        }
        return t.codePoints().anyMatch(Character::isLetter);
    }

    /**
     * 按有效作答覆盖率给出档次上限（漏译降档硬规则）。
     */
    private int maxBandByCoverage(double coverage) {
        if (coverage >= 0.99) {
            return 14;
        }
        if (coverage >= 0.8) {
            return 11;
        }
        if (coverage >= 0.6) {
            return 8;
        }
        if (coverage >= 0.4) {
            return 5;
        }
        if (coverage > 0) {
            return 2;
        }
        return 0;
    }

    @Override
    public EssayCorrectionVo correctEssay(EssayCorrectDto dto) {
        if (dto == null || dto.getEssay() == null || dto.getEssay().isBlank()) {
            throw new TopicException("作文内容不能为空");
        }

        String levelName = dto.getLevel() != null && dto.getLevel() == 6 ? "六级" : "四级";
        log.info("作文批改请求：level=CET-{}, 字数={}", dto.getLevel(), dto.getEssay().split("\\s+").length);

        // 使用 Agent 多Tool协作批改
        EssayAgentResult agentResult = essayAgent.execute(dto.getEssay(), dto.getTopic(), dto.getLevel());

        // 转换为前端需要的格式
        EssayCorrectionVo vo = convertToVo(agentResult, dto);

        log.info("作文批改完成：score={}, 语法错误数={}, 词汇建议数={}",
                vo.getScore(), vo.getGrammarErrors().size(), vo.getVocabularySuggestions().size());

        return vo;
    }

    /**
     * 将 Agent 结果转换为前端 VO
     */
    private EssayCorrectionVo convertToVo(EssayAgentResult agentResult, EssayCorrectDto dto) {
        EssayCorrectionVo vo = new EssayCorrectionVo();

        // 基础信息
        vo.setScore(agentResult.getScore() != null ? (double) agentResult.getScore() : 0.0);
        vo.setBand(agentResult.getBand());
        vo.setBandDescription(agentResult.getBandDescription());
        vo.setOverall(agentResult.getOverall());

        // 四维评分
        if (agentResult.getDimensions() != null) {
            vo.setContent(toDouble(agentResult.getDimensions().get("content")));
            vo.setLanguage(toDouble(agentResult.getDimensions().get("language")));
            vo.setVocabulary(toDouble(agentResult.getDimensions().get("vocabulary")));
            vo.setStructure(toDouble(agentResult.getDimensions().get("structure")));
        }

        // 语法错误
        if (agentResult.getGrammarErrors() != null) {
            List<EssayCorrectionVo.GrammarError> errors = agentResult.getGrammarErrors().stream()
                    .map(m -> {
                        EssayCorrectionVo.GrammarError e = new EssayCorrectionVo.GrammarError();
                        e.setType(m.get("type"));
                        e.setSeverity(m.get("severity"));
                        e.setOriginal(m.get("original"));
                        e.setCorrection(m.get("correction"));
                        e.setExplanation(m.get("explanation"));
                        return e;
                    }).toList();
            vo.setGrammarErrors(errors);
        } else {
            vo.setGrammarErrors(new ArrayList<>());
        }

        // 词汇建议
        if (agentResult.getVocabularySuggestions() != null) {
            List<EssayCorrectionVo.VocabularySuggestion> suggestions = agentResult.getVocabularySuggestions().stream()
                    .map(m -> {
                        EssayCorrectionVo.VocabularySuggestion s = new EssayCorrectionVo.VocabularySuggestion();
                        s.setOriginal(m.get("original"));
                        s.setSuggestion(m.get("suggestion"));
                        s.setReason(m.get("reason"));
                        return s;
                    }).toList();
            vo.setVocabularySuggestions(suggestions);
        } else {
            vo.setVocabularySuggestions(new ArrayList<>());
        }

        // bandLabel
        if (vo.getBand() != null) {
            vo.setBandLabel(getBandLabel(vo.getBand()));
        }

        // 六级降分
        if (dto.getLevel() != null && dto.getLevel() == 6 && vo.getScore() != null && vo.getScore() > 1) {
            vo.setScore(vo.getScore() - 1);
            vo.setBand(getBandFromScore(vo.getScore().intValue()));
            vo.setBandLabel(getBandLabel(vo.getBand()));
        }

        // selfCheckList
        vo.setSelfCheckList(new ArrayList<>());
        if (agentResult.getWeaknesses() != null) {
            vo.setSelfCheckList(agentResult.getWeaknesses());
        }

        return vo;
    }

    private Double toDouble(Object obj) {
        if (obj == null) return 0.0;
        if (obj instanceof Number) return ((Number) obj).doubleValue();
        try {
            return Double.parseDouble(obj.toString());
        } catch (Exception e) {
            return 0.0;
        }
    }

    private int getBandFromScore(int score) {
        if (score >= 13) return 14;
        if (score >= 10) return 11;
        if (score >= 7) return 8;
        if (score >= 4) return 5;
        if (score >= 1) return 2;
        return 0;
    }

    private String getBandLabel(int band) {
        return switch (band) {
            case 14 -> "14分档（13–15分）";
            case 11 -> "11分档（10–12分）";
            case 8 -> "8分档（7–9分）";
            case 5 -> "5分档（4–6分）";
            case 2 -> "2分档（1–3分）";
            case 0 -> "0分档";
            default -> "";
        };
    }
}
