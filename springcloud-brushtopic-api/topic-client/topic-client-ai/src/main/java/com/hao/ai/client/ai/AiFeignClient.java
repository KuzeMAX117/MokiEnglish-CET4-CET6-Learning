package com.hao.ai.client.ai;

import com.hao.topic.common.auth.TokenInterceptor;
import com.hao.topic.common.result.Result;
import com.hao.topic.model.vo.topic.TopicDataVo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.Map;

@FeignClient(name = "service-ai", configuration = TokenInterceptor.class)
public interface AiFeignClient {

    

    @GetMapping("/ai/model/count/{date}")
    Long countDate(@PathVariable String date);

    

    @GetMapping("/ai/model/count")
    Long count();

    @GetMapping("/ai/model/countAiDay7")
    List<TopicDataVo> countAiDay7();

    @GetMapping("/ai/model/countAi/{currentId}")
    Long countAi(@PathVariable Long currentId);

    @PostMapping("/ai/model/translate")
    Result<String> translateText(@RequestBody Map<String, String> body);
    
    @GetMapping("/ai/module/count/{moduleType}/{date}")
    Result<Long> countModuleByDate(@PathVariable String moduleType, @PathVariable String date);
    
    @GetMapping("/ai/module/count/{moduleType}")
    Result<Long> countModuleTotal(@PathVariable String moduleType);
    
    @GetMapping("/ai/module/count/all/{date}")
    Result<List<Map<String, Object>>> countAllModulesByDate(@PathVariable String date);
    
    @GetMapping("/ai/module/trend/all")
    Result<List<Map<String, Object>>> countAllModulesTrend();

}
