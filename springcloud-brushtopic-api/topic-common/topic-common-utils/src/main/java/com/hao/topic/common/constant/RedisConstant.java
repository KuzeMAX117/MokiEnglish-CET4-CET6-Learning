package com.hao.topic.common.constant;

public class RedisConstant {
    
    public static final String USER_LOGIN_KEY_PREFIX = "user:login:";
    
    public static final String GENERATE_ANSWER_KEY_PREFIX = "generate:answer:";
    
    public static final String TOPIC_AUDIT_KEY_PREFIX = "topic:audit:";
    
    public static final String CATEGORY_AUDIT_KEY_PREFIX = "category:audit:";
    
    public static final String LABEL_AUDIT_KEY_PREFIX = "label:audit:";
    
    public static final String SUBJECT_AUDIT_KEY_PREFIX = "subject:audit:";
    
    public static final Long AUDIT_EXPIRE_TIME = 5L;

    
    public static final String USER_COLLECTIONS_PREFIX = "user:collections:";
    
    public static final String TOPIC_RANK_PREFIX = "topic:rank";
    
    public static final String TOPIC_RANK_TODAY_PREFIX = "topic:rank:today:";
    
    public static final String USER_RANK_PREFIX = "user:rank:";

    /* ============ PK 相关 ============ */
    public static final String PK_QUEUE = "pk:queue";
    public static final String PK_ROOM_PREFIX = "pk:room:";
    public static final String PK_USER_MATCHING_PREFIX = "pk:matching:";
    public static final String PK_USER_MATCHING_SUFFIX = ":matching";
    public static final int PK_QUESTIONS_PER_USER = 10;
    public static final String PK_ROOM_QUESTIONS_SUFFIX = ":questions";
    public static final String PK_RANK_DAILY_PREFIX = "pk:rank:daily:";
    public static final String PK_RANK_ALL = "pk:rank:all";
    public static final int PK_ROOM_TTL = 30;
    public static final int PK_TOTAL_QUESTIONS = PK_QUESTIONS_PER_USER * 3;
}
