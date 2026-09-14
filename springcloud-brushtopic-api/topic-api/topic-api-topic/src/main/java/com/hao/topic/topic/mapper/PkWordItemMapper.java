package com.hao.topic.topic.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hao.topic.model.entity.word.WordItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface PkWordItemMapper extends BaseMapper<WordItem> {

    @Select("SELECT id FROM word_item WHERE book_id = #{bookId} AND is_deleted = 0 ORDER BY RAND() LIMIT #{limit}")
    List<Long> selectRandomIdsByBookId(@Param("bookId") Long bookId, @Param("limit") int limit);

    @Select("SELECT id, word, meaning FROM word_item WHERE book_id = #{bookId} AND is_deleted = 0 ORDER BY RAND() LIMIT #{limit}")
    List<WordItem> selectRandomWordsByBookId(@Param("bookId") Long bookId, @Param("limit") int limit);

    @Select("SELECT id, word, meaning FROM word_item WHERE book_id IN (3, 4, 5) AND is_deleted = 0 ORDER BY RAND() LIMIT #{limit}")
    List<WordItem> selectRandomWordsFromAllLevels(@Param("limit") int limit);
}
