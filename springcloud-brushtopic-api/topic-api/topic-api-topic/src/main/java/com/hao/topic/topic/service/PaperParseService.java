package com.hao.topic.topic.service;

import com.hao.topic.model.dto.topic.PaperParseDto;
import com.hao.topic.model.vo.topic.PaperParseResultVo;
import org.springframework.web.multipart.MultipartFile;

/**
 * 试卷管理：粘贴文本 / docx 解析编排（只解析不落库）
 */
public interface PaperParseService {

    /**
     * 粘贴文本解析
     */
    PaperParseResultVo parseText(PaperParseDto dto);

    /**
     * docx 上传解析
     */
    PaperParseResultVo parseDocx(MultipartFile file, String section, Long paperId);
}
