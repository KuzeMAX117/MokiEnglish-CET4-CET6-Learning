package com.hao.topic.system.word.config;

import com.hao.topic.system.word.service.WordRankRedisService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

/**
 * 应用启动时同步打卡数据到Redis
 */
@Component
@RequiredArgsConstructor
@Slf4j
@Order(1)
public class WordRankSyncRunner implements CommandLineRunner {

    private final WordRankRedisService wordRankRedisService;

    @Override
    public void run(String... args) throws Exception {
        log.info("========== 开始同步打卡数据到Redis ==========");
        try {
            wordRankRedisService.syncFromMySQL();
            log.info("========== 打卡数据同步完成 ==========");
        } catch (Exception e) {
            log.error("同步打卡数据到Redis失败", e);
        }
    }
}
