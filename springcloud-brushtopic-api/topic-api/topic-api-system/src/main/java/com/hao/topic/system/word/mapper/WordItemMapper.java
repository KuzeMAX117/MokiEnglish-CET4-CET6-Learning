package com.hao.topic.system.word.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hao.topic.model.entity.word.WordItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface WordItemMapper extends BaseMapper<WordItem> {

    @Select("SELECT id FROM word_item WHERE book_id = #{bookId} AND is_deleted = 0")
    List<Long> selectIdsByBookId(@Param("bookId") Long bookId);
}
