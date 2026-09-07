package com.hao.topic.topic.service;

import com.hao.topic.model.dto.topic.PaperAnswerDto;
import com.hao.topic.model.vo.topic.PaperAnswerVo;
import com.hao.topic.model.vo.topic.PaperDetailVo;
import com.hao.topic.model.vo.topic.PaperProgressVo;
import com.hao.topic.model.vo.topic.PaperVo;

import java.util.List;

public interface PaperService {

    

    List<PaperVo> paperList(Integer level);

    

    PaperDetailVo paperDetail(Long id);

    

    PaperAnswerVo answer(PaperAnswerDto paperAnswerDto);

    

    List<PaperProgressVo> progress(Long paperId);
}
