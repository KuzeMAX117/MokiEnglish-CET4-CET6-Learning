package com.hao.topic.system.word.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hao.topic.model.entity.word.UserWordRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserWordRecordMapper extends BaseMapper<UserWordRecord> {

    @Select("SELECT COUNT(*) FROM user_word_record WHERE user_id = #{userId} AND book_id = #{bookId} AND is_deleted = 0")
    Long countByUserAndBook(@Param("userId") Long userId, @Param("bookId") Long bookId);

    @Select("SELECT * FROM user_word_record " +
            "WHERE user_id = #{userId} AND book_id = #{bookId} AND is_deleted = 0 " +
            "AND (status = 0 OR (status != 2 AND next_review_time <= NOW())) " +
            "ORDER BY CASE WHEN status = 0 THEN 1 ELSE 0 END, next_review_time ASC " +
            "LIMIT #{limit}")
    List<UserWordRecord> selectTodayWords(@Param("userId") Long userId, @Param("bookId") Long bookId, @Param("limit") Integer limit);

    @Select("SELECT * FROM user_word_record " +
            "WHERE user_id = #{userId} AND book_id = #{bookId} AND is_deleted = 0 " +
            "AND DATE(last_study_time) = CURDATE() " +
            "ORDER BY last_study_time DESC")
    List<UserWordRecord> selectTodayLearnedWords(@Param("userId") Long userId, @Param("bookId") Long bookId);

    @Select("SELECT COUNT(*) FROM user_word_record WHERE user_id = #{userId} AND is_deleted = 0 AND status != 0")
    Long countLearned(@Param("userId") Long userId);

    @Select("SELECT COUNT(*) FROM user_word_record WHERE user_id = #{userId} AND is_deleted = 0 AND status = 2")
    Long countMastered(@Param("userId") Long userId);

    @Select("SELECT COUNT(*) FROM user_word_record WHERE user_id = #{userId} AND is_deleted = 0 AND status = 0")
    Long countToLearn(@Param("userId") Long userId);

    @Select("SELECT COUNT(*) FROM user_word_record WHERE user_id = #{userId} AND is_deleted = 0 AND next_review_time <= NOW() AND status != 2")
    Long countReviewDue(@Param("userId") Long userId);

    @Select("SELECT COUNT(*) FROM user_word_record WHERE user_id = #{userId} AND is_deleted = 0 AND DATE(last_study_time) = CURDATE()")
    Long countTodayLearned(@Param("userId") Long userId);

    @Select("SELECT COUNT(*) FROM user_word_record r JOIN word_item w ON r.word_id = w.id WHERE r.user_id = #{userId} AND r.is_deleted = 0 AND w.book_id = #{bookId} AND r.status != 0")
    Long countLearnedByBook(@Param("userId") Long userId, @Param("bookId") Long bookId);

    @Select("SELECT DATE(last_study_time) AS study_date, COUNT(*) AS study_count " +
            "FROM user_word_record " +
            "WHERE user_id = #{userId} AND is_deleted = 0 AND status != 0 " +
            "AND last_study_time >= #{startDate} " +
            "GROUP BY DATE(last_study_time)")
    List<Map<String, Object>> selectDailyCounts(@Param("userId") Long userId, @Param("startDate") String startDate);

    @Select("SELECT ranked.`rank`, ranked.user_id AS userId, ranked.streak AS scope, " +
            "COALESCE(NULLIF(u.nickname, ''), u.account) AS nickname, u.avatar, " +
            "r.role_key AS role FROM " +
            "(SELECT user_id, COUNT(DISTINCT DATE(last_study_time)) AS streak, " +
            "RANK() OVER (ORDER BY COUNT(DISTINCT DATE(last_study_time)) DESC) AS `rank` " +
            "FROM user_word_record WHERE is_deleted = 0 AND status != 0 " +
            "AND last_study_time IS NOT NULL " +
            "GROUP BY user_id) AS ranked " +
            "JOIN sys_user AS u ON ranked.user_id = u.id " +
            "JOIN (SELECT user_id, MIN(role_id) AS role_id FROM sys_user_role GROUP BY user_id) AS ur ON u.id = ur.user_id " +
            "JOIN sys_role AS r ON ur.role_id = r.id " +
            "ORDER BY ranked.`rank` LIMIT 100")
    List<Map<String, Object>> getWordCountRank();

    @Select("SELECT ranked.`rank`, ranked.user_id AS userId, ranked.streak AS scope, " +
            "COALESCE(NULLIF(u.nickname, ''), u.account) AS nickname, u.avatar, " +
            "r.role_key AS role FROM " +
            "(SELECT user_id, COUNT(DISTINCT DATE(last_study_time)) AS streak, " +
            "RANK() OVER (ORDER BY COUNT(DISTINCT DATE(last_study_time)) DESC) AS `rank` " +
            "FROM user_word_record WHERE is_deleted = 0 AND status != 0 " +
            "AND last_study_time IS NOT NULL " +
            "GROUP BY user_id) AS ranked " +
            "JOIN sys_user AS u ON ranked.user_id = u.id " +
            "JOIN (SELECT user_id, MIN(role_id) AS role_id FROM sys_user_role GROUP BY user_id) AS ur ON u.id = ur.user_id " +
            "JOIN sys_role AS r ON ur.role_id = r.id " +
            "WHERE ranked.user_id = #{userId}")
    Map<String, Object> getWordUserRank(@Param("userId") Long userId);

    @Select("SELECT `rank` FROM (SELECT user_id, COUNT(DISTINCT DATE(last_study_time)) AS streak, " +
            "RANK() OVER (ORDER BY COUNT(DISTINCT DATE(last_study_time)) DESC) AS `rank` " +
            "FROM user_word_record WHERE is_deleted = 0 AND status != 0 " +
            "AND last_study_time IS NOT NULL " +
            "GROUP BY user_id) AS ranked WHERE user_id = #{userId}")
    Long getWordRank(@Param("userId") Long userId);

    @Select("SELECT u.id AS userId, COALESCE(NULLIF(u.nickname, ''), u.account) AS nickname, " +
            "u.avatar, r.role_key AS role FROM sys_user u " +
            "JOIN (SELECT user_id, MIN(role_id) AS role_id FROM sys_user_role GROUP BY user_id) AS ur ON u.id = ur.user_id " +
            "JOIN sys_role AS r ON ur.role_id = r.id " +
            "WHERE u.id = #{userId}")
    Map<String, Object> getUserInfo(@Param("userId") Long userId);

    @Select("SELECT COUNT(DISTINCT DATE(last_study_time)) AS streak FROM user_word_record " +
            "WHERE user_id = #{userId} AND is_deleted = 0 AND status != 0 AND last_study_time IS NOT NULL")
    Long countStreakDays(@Param("userId") Long userId);
}
