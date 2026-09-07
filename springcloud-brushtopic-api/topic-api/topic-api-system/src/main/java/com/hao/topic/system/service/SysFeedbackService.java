package com.hao.topic.system.service;

import com.hao.topic.model.dto.system.SysFeedbackReplyDto;
import com.hao.topic.model.entity.system.SysFeedback;
import com.hao.topic.model.vo.system.SysFeedbackUserVo;

import java.util.List;
import java.util.Map;

public interface SysFeedbackService {
    void saveFeedback(SysFeedback sysFeedback);

    Map<String, Object> list(SysFeedback sysFeedback);

    List<SysFeedbackUserVo> feedback();

    void reply(SysFeedbackReplyDto content);
}
