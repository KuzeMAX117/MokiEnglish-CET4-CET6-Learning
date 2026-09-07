package com.hao.ai.client.ai;

import com.hao.topic.common.auth.TokenInterceptor;
import com.hao.topic.model.vo.topic.TopicDataVo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

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

}
