package com.hao.topic.security.utils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.LocalTime;
import java.util.List;

public class DateUtils {
    public static LocalDateTime parseStartOfDay(String dateStr) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date = LocalDate.parse(dateStr, formatter);
        return LocalDateTime.of(date, LocalTime.MIN); 
    }

    public static LocalDateTime parseEndOfDay(String dateStr) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date = LocalDate.parse(dateStr, formatter);
        return LocalDateTime.of(date, LocalTime.MAX); 
    }

}
