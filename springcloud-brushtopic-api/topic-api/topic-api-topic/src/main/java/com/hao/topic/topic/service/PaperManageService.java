package com.hao.topic.topic.service;

import com.hao.topic.model.dto.topic.PaperManageDto;
import com.hao.topic.model.dto.topic.PaperManageQueryDto;
import com.hao.topic.model.dto.topic.PaperSectionSaveDto;
import com.hao.topic.model.vo.topic.PaperManageDetailVo;

import java.util.Map;

public interface PaperManageService {

    /**
     * 试卷列表（分页 + 筛选，含各板块题数）
     */
    Map<String, Object> paperManageList(PaperManageQueryDto query);

    /**
     * 新建试卷（草稿状态）
     */
    Long add(PaperManageDto dto);

    /**
     * 修改试卷元信息
     */
    void update(PaperManageDto dto);

    /**
     * 删除试卷（关联删除，题目按作答记录情况删除或停用）
     */
    void delete(Long[] ids);

    /**
     * 编辑器详情（含草稿卷，题目过滤停用/删除）
     */
    PaperManageDetailVo detail(Long id);

    /**
     * 按板块分段保存（整段替换，事务）
     */
    Map<String, Object> saveSection(PaperSectionSaveDto dto);

    /**
     * 发布（校验后置为正常状态，返回警告清单）
     */
    Map<String, Object> publish(Long id);

    /**
     * 下架
     */
    void unpublish(Long id);
}
