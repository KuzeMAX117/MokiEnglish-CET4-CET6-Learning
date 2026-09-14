package com.hao.topic.ai.controller;

import com.alibaba.dashscope.audio.ttsv2.SpeechSynthesisParam;
import com.alibaba.dashscope.audio.ttsv2.SpeechSynthesizer;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hao.topic.ai.properties.TtsProperties;
import com.hao.topic.ai.service.ModelService;
import com.hao.topic.common.result.Result;
import com.hao.topic.model.dto.ai.AiHistoryDto;
import com.hao.topic.model.dto.ai.ChatDto;
import com.hao.topic.model.dto.ai.EssayCorrectDto;
import com.hao.topic.model.dto.ai.TranslationCorrectDto;
import com.hao.topic.model.dto.ai.TtsDto;
import com.hao.topic.model.entity.system.SysUser;
import com.hao.topic.model.vo.ai.AiHistoryContent;
import com.hao.topic.model.vo.ai.AiHistoryListVo;
import com.hao.topic.model.vo.ai.EssayCorrectionVo;
import com.hao.topic.model.vo.ai.TranslationCorrectionVo;
import com.hao.topic.model.vo.topic.TopicDataVo;
import com.hao.topic.security.utils.DateUtils;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("ai/model")
@AllArgsConstructor
public class ModelController {
    private final ModelService modelService;

    

    @PostMapping("/chat")
    public Flux<String> chat(@RequestBody ChatDto chatDto) {
        return modelService.chat(chatDto);
    }

    

    @GetMapping("/history")
    public Result getHistory(AiHistoryDto aiHistoryDto) {
        List<AiHistoryListVo> historyListVoList = modelService.getHistory(aiHistoryDto);
        return Result.success(historyListVoList);
    }

    

    @GetMapping("/history/{id}")
    public Result getHistoryById(@PathVariable Long id) {
        List<AiHistoryContent> aiHistoryContentList = modelService.getHistoryById(id);
        return Result.success(aiHistoryContentList);
    }

    

    @PostMapping("tts")
    public ResponseEntity<byte[]> tts(@RequestBody TtsDto ttsDto) {
        return modelService.tts(ttsDto);
    }

    

    @DeleteMapping("/history/{id}")
    public Result deleteHistory(@PathVariable Long id) {
        modelService.deleteHistory(id);
        return Result.success();
    }

    

    @PutMapping("/history")
    public Result updateHistory(@RequestBody AiHistoryDto aiHistoryDto) {
        modelService.updateHistoryById(aiHistoryDto);
        return Result.success();
    }

    

    @GetMapping("/count/{date}")
    public Long countDate(@PathVariable String date) {
        return modelService.count(date);
    }

    

    @GetMapping("/count")
    public Long count() {
        return modelService.count(null);
    }

    

    @GetMapping("/countAiDay7")
    List<TopicDataVo> countAiDay7() {
        return modelService.countAiDay7();
    }

    

    @GetMapping("/countAi/{currentId}")
    Long countAi(@PathVariable Long currentId) {
        return modelService.countAi(currentId);
    }

    

    @PostMapping("/translate")
    public Result<String> translateText(@RequestBody java.util.Map<String, String> body) {
        String text = body.get("text");
        return Result.success(modelService.translateText(text));
    }

    

    @PostMapping("/translate/correct")
    public Result<TranslationCorrectionVo> correctTranslation(@RequestBody TranslationCorrectDto dto) {
        return Result.success(modelService.correctTranslation(dto));
    }

    @PostMapping("/essay/correct")
    public Result<EssayCorrectionVo> correctEssay(@RequestBody EssayCorrectDto dto) {
        return Result.success(modelService.correctEssay(dto));
    }
}
