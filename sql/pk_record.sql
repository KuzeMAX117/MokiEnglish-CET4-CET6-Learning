-- PK 对战记录表
CREATE TABLE IF NOT EXISTS `pk_record` (
    `id`              BIGINT PRIMARY KEY AUTO_INCREMENT,
    `room_id`         VARCHAR(32) NOT NULL COMMENT '房间ID',
    `user_a_id`       BIGINT NOT NULL COMMENT '玩家A ID',
    `user_b_id`       BIGINT NOT NULL COMMENT '玩家B ID',
    `user_a_score`    INT DEFAULT 0 COMMENT '玩家A得分',
    `user_b_score`    INT DEFAULT 0 COMMENT '玩家B得分',
    `winner_id`       BIGINT DEFAULT NULL COMMENT '赢家ID，平局为NULL',
    `total_questions` INT DEFAULT 10 COMMENT '每人题数',
    `question_ids`    VARCHAR(500) DEFAULT NULL COMMENT '本场题目ID列表',
    `create_time`     DATETIME DEFAULT CURRENT_TIMESTAMP,
    `end_time`        DATETIME DEFAULT NULL COMMENT '结束时间',
    UNIQUE KEY `uk_room` (`room_id`),
    KEY `idx_user_a` (`user_a_id`),
    KEY `idx_user_b` (`user_b_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='PK对战记录';
