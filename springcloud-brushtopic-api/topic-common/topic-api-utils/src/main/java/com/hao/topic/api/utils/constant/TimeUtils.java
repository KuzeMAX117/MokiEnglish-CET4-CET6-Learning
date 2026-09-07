package com.hao.topic.api.utils.constant;

import com.alibaba.fastjson2.util.DateUtils;

import java.time.Duration;
import java.time.LocalDateTime;

public class TimeUtils {

    

    public static String formatTimeAgo(LocalDateTime time) {
        LocalDateTime now = LocalDateTime.now();
        long diffInMinutes = Duration.between(time, now).toMinutes();

        if (diffInMinutes < 1) {
            return "刚刚";
        } else if (diffInMinutes < 60) {
            return diffInMinutes + "分钟前";
        } else if (diffInMinutes < 24 * 60) {
            return diffInMinutes / 60 + "小时前";
        } else if (diffInMinutes < 30 * 24 * 60) {
            return diffInMinutes / (24 * 60) + "天前";
        } else {
            return DateUtils.format(time, "yyyy-MM-dd HH:mm:ss"); 
        }
    }
}
