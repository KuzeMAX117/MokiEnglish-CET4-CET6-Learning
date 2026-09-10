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

    @Select("SELECT user_id AS userId, COUNT(*) AS scope " +
            "FROM user_word_record " +
            "WHERE is_deleted = 0 AND DATE(last_study_time) = CURDATE() " +
            "GROUP BY user_id " +
            "ORDER BY scope DESC " +
            "LIMIT 100")
    List<Map<String, Object>> getTodayWordRank();

    @Select("SELECT user_id AS userId, COUNT(*) AS scope " +
            "FROM user_word_record " +
            "WHERE is_deleted = 0 AND status != 0 " +
            "GROUP BY user_id " +
            "ORDER BY scope DESC " +
            "LIMIT 100")
    List<Map<String, Object>> getTotalWordRank();
}
