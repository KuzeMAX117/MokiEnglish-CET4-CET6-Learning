package com.hao.topic.system.content.service.impl;

import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.content.WordBookDto;
import com.hao.topic.model.dto.content.WordBookListDto;
import com.hao.topic.model.entity.word.WordBook;
import com.hao.topic.model.entity.word.WordItem;
import com.hao.topic.model.excel.word.WordItemExcel;
import com.hao.topic.system.word.mapper.WordBookMapper;
import com.hao.topic.system.word.mapper.WordItemMapper;
import com.hao.topic.system.content.service.WordBookManageService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
@AllArgsConstructor
@Slf4j
public class WordBookManageServiceImpl implements WordBookManageService {

    private final WordBookMapper wordBookMapper;
    private final WordItemMapper wordItemMapper;

    @Override
    public Map<String, Object> wordBookList(WordBookListDto dto) {
        LambdaQueryWrapper<WordBook> wrapper = new LambdaQueryWrapper<>();

        if (!StringUtils.isEmpty(dto.getName())) {
            wrapper.like(WordBook::getName, dto.getName());
        }
        if (dto.getType() != null) {
            wrapper.eq(WordBook::getType, dto.getType());
        }
        wrapper.orderByDesc(WordBook::getCreateTime);

        if (dto.getPageNum() == null || dto.getPageSize() == null) {
            List<WordBook> list = wordBookMapper.selectList(wrapper);
            return Map.of("total", list.size(), "rows", list);
        } else {
            Page<WordBook> page = new Page<>(dto.getPageNum(), dto.getPageSize());
            Page<WordBook> result = wordBookMapper.selectPage(page, wrapper);
            return Map.of("total", result.getTotal(), "rows", result.getRecords());
        }
    }

    @Override
    public void add(WordBookDto dto) {
        if (StringUtils.isEmpty(dto.getName())) {
            throw new TopicException("词书名称不能为空");
        }
        LambdaQueryWrapper<WordBook> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WordBook::getName, dto.getName());
        WordBook exist = wordBookMapper.selectOne(wrapper);
        if (exist != null) {
            throw new TopicException("词书名称已存在");
        }
        WordBook wordBook = new WordBook();
        BeanUtils.copyProperties(dto, wordBook);
        wordBook.setTotalCount(0);
        wordBookMapper.insert(wordBook);
    }

    @Override
    public void update(WordBookDto dto) {
        if (dto.getId() == null) {
            throw new TopicException("词书ID不能为空");
        }
        WordBook wordBook = wordBookMapper.selectById(dto.getId());
        if (wordBook == null) {
            throw new TopicException("词书不存在");
        }
        BeanUtils.copyProperties(dto, wordBook);
        wordBookMapper.updateById(wordBook);
    }

    @Override
    public void delete(Long[] ids) {
        if (ids == null || ids.length == 0) {
            throw new TopicException("请选择要删除的词书");
        }
        for (Long id : ids) {
            wordBookMapper.deleteById(id);
        }
    }

    @Override
    public String importExcel(Long bookId, MultipartFile multipartFile) throws IOException {
        if (bookId == null) {
            throw new TopicException("词书ID不能为空");
        }
        WordBook wordBook = wordBookMapper.selectById(bookId);
        if (wordBook == null) {
            throw new TopicException("词书不存在");
        }

        List<WordItemExcel> excelVoList = EasyExcel.read(multipartFile.getInputStream())
                .head(WordItemExcel.class)
                .sheet()
                .doReadSync();

        if (CollectionUtils.isEmpty(excelVoList)) {
            throw new TopicException("Excel文件为空");
        }

        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();

        for (WordItemExcel wordItemExcel : excelVoList) {
            try {
                if (StringUtils.isEmpty(wordItemExcel.getWord()) || StringUtils.isEmpty(wordItemExcel.getMeaning())) {
                    failureNum++;
                    failureMsg.append("第").append(successNum + failureNum).append("行：单词或释义为空<br/>");
                    continue;
                }

                LambdaQueryWrapper<WordItem> wrapper = new LambdaQueryWrapper<>();
                wrapper.eq(WordItem::getBookId, bookId);
                wrapper.eq(WordItem::getWord, wordItemExcel.getWord());
                WordItem existWord = wordItemMapper.selectOne(wrapper);

                if (existWord == null) {
                    WordItem wordItem = new WordItem();
                    wordItem.setBookId(bookId);
                    wordItem.setWord(wordItemExcel.getWord());
                    wordItem.setPhonetic(wordItemExcel.getPhonetic());
                    wordItem.setMeaning(wordItemExcel.getMeaning());
                    wordItem.setExample(wordItemExcel.getExample());
                    wordItem.setExampleTranslate(wordItemExcel.getExampleTranslate());
                    wordItemMapper.insert(wordItem);
                    successNum++;
                } else {
                    existWord.setPhonetic(wordItemExcel.getPhonetic());
                    existWord.setMeaning(wordItemExcel.getMeaning());
                    existWord.setExample(wordItemExcel.getExample());
                    existWord.setExampleTranslate(wordItemExcel.getExampleTranslate());
                    wordItemMapper.updateById(existWord);
                    successNum++;
                }
            } catch (Exception e) {
                failureNum++;
                failureMsg.append("第").append(successNum + failureNum).append("行：导入失败<br/>");
                log.error("导入单词失败", e);
            }
        }

        // 更新词书单词总数
        LambdaQueryWrapper<WordItem> countWrapper = new LambdaQueryWrapper<>();
        countWrapper.eq(WordItem::getBookId, bookId);
        long totalCount = wordItemMapper.selectCount(countWrapper);
        wordBook.setTotalCount((int) totalCount);
        wordBookMapper.updateById(wordBook);

        if (failureNum > 0) {
            failureMsg.insert(0, "很抱歉，导入失败！<br/>");
            failureMsg.append("成功导入").append(successNum).append("条，失败").append(failureNum).append("条");
            throw new TopicException(failureMsg.toString());
        } else {
            successMsg.insert(0, "恭喜你，导入成功！<br/>");
            successMsg.append("共导入").append(successNum).append("条数据");
        }
        return successMsg.toString();
    }
}
