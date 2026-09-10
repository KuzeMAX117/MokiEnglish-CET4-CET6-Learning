package com.hao.topic.ai.config;


import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.openai.OpenAiChatModel;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.JdkClientHttpRequestFactory;
import org.springframework.web.client.RestClient;

import java.net.http.HttpClient;
import java.time.Duration;

@Configuration
public class ChatConfiguration {

    /**
     * AI 调用读超时（秒），可通过配置项 ai.chat.read-timeout-seconds 覆盖。
     * <p>
     * 注意：JdkClientHttpRequestFactory 的 readTimeout 会被映射为
     * {@code java.net.http.HttpRequest#timeout()}，语义是「整个请求直到收到响应头」的总预算，
     * 而不是 socket 空闲超时。因此非流式（.call()）调用 qwen-max 生成大段结构化 JSON 时，
     * 必须覆盖最坏情况下的完整生成耗时，否则会抛 HttpTimeoutException: request timed out。
     * </p>
     * <p>
     * 流式（.stream()）走的是 WebClient，不受此参数影响，首字节返回很快，天然规避该问题。
     * </p>
     */
    @Value("${ai.chat.read-timeout-seconds:300}")
    private long readTimeoutSeconds;

    /** 建立 TCP/TLS 连接的超时（秒） */
    @Value("${ai.chat.connect-timeout-seconds:30}")
    private long connectTimeoutSeconds;

    @Bean
    public RestClient.Builder restClientBuilder() {
        HttpClient httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(connectTimeoutSeconds))
                .build();

        JdkClientHttpRequestFactory requestFactory = new JdkClientHttpRequestFactory(httpClient);
        requestFactory.setReadTimeout(Duration.ofSeconds(readTimeoutSeconds));

        return RestClient.builder().requestFactory(requestFactory);
    }

    @Bean
    public ChatClient chatClient(OpenAiChatModel openAiChatModel) {
        return ChatClient.builder(openAiChatModel)
                .build();
    }

}
