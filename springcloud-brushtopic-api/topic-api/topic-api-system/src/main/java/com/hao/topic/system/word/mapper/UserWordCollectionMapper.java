package com.hao.topic.system.word.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hao.topic.model.entity.word.UserWordCollection;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface UserWordCollectionMapper extends BaseMapper<UserWordCollection> {

    /** 查询用户全部收藏（按收藏时间倒序） */
    @Select("SELECT * FROM user_word_collection WHERE user_id = #{userId} AND is_deleted = 0 ORDER BY create_time DESC, id DESC")
    List<UserWordCollection> selectByUser(@Param("userId") Long userId);

    /** 按用户+单词查询（含已软删除记录，便于复活），绕过逻辑删除自动过滤 */
    @Select("SELECT * FROM user_word_collection WHERE user_id = #{userId} AND word = #{word} LIMIT 1")
    UserWordCollection selectByUserAndWord(@Param("userId") Long userId, @Param("word") String word);

    /** 复活一条已软删除的收藏并刷新释义快照 */
    @Update("UPDATE user_word_collection SET is_deleted = 0, phonetic = #{phonetic}, meaning = #{meaning}, " +
            "example = #{example}, example_translate = #{exampleTranslate}, update_time = NOW() WHERE id = #{id}")
    int revive(@Param("id") Long id, @Param("phonetic") String phonetic, @Param("meaning") String meaning,
               @Param("example") String example, @Param("exampleTranslate") String exampleTranslate);

    /** 软删除用户的一个收藏单词 */
    @Update("UPDATE user_word_collection SET is_deleted = 1, update_time = NOW() " +
            "WHERE user_id = #{userId} AND word = #{word} AND is_deleted = 0")
    int softDeleteByUserAndWord(@Param("userId") Long userId, @Param("word") String word);
}
