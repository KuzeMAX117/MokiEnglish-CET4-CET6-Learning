package com.hao.topic.topic.controller;

import com.hao.topic.api.utils.helper.MinioHelper;
import com.hao.topic.api.utils.utils.ExcelUtil;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.result.Result;
import com.hao.topic.model.dto.topic.TopicCategoryDto;
import com.hao.topic.model.dto.topic.TopicCategoryListDto;
import com.hao.topic.model.dto.topic.TopicSubjectDto;
import com.hao.topic.model.dto.topic.TopicSubjectListDto;
import com.hao.topic.model.entity.topic.TopicCategory;
import com.hao.topic.model.entity.topic.TopicSubject;
import com.hao.topic.model.excel.topic.TopicCategoryExcel;
import com.hao.topic.model.excel.topic.TopicCategoryExcelExport;
import com.hao.topic.model.excel.topic.TopicSubjectExcel;
import com.hao.topic.model.excel.topic.TopicSubjectExcelExport;
import com.hao.topic.model.vo.system.TopicSubjectWebVo;
import com.hao.topic.model.vo.topic.TopicNameVo;
import com.hao.topic.model.vo.topic.TopicSubjectDetailAndTopicVo;
import com.hao.topic.model.vo.topic.TopicSubjectVo;
import com.hao.topic.topic.service.TopicSubjectService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/topic/subject")
@AllArgsConstructor
public class TopicSubjectController {

    private final TopicSubjectService topicSubjectService;

    private final MinioHelper minioHelper;

    

    @GetMapping("/list")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result<Map<String, Object>> list(TopicSubjectListDto topicSubjectListDto) {
        Map<String, Object> map = topicSubjectService.subjectList(topicSubjectListDto);
        return Result.success(map);
    }

    

    @PostMapping("/add")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result add(@RequestBody TopicSubjectDto topicCategoryDto) {
        topicSubjectService.add(topicCategoryDto);
        return Result.success();
    }

    

    @PostMapping("/img")
    @PreAuthorize("hasAuthority('admin')  || hasAuthority('member')")
    public Result upload(@RequestParam("avatar") MultipartFile file) {
        
        String url = minioHelper.uploadFile(file, "subject");
        return Result.success(url);
    }

    

    @PutMapping("/update")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result update(@RequestBody TopicSubjectDto topicSubjectDto) {
        topicSubjectService.update(topicSubjectDto);
        return Result.success();
    }

    

    @PutMapping("/audit")
    public void auditSubject(@RequestBody TopicSubject topicSubject) {
        topicSubjectService.auditSubject(topicSubject);
    }

    

    @DeleteMapping("/delete/{ids}")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result delete(@PathVariable Long[] ids) {
        topicSubjectService.delete(ids);
        return Result.success();
    }

    

    @GetMapping("/export/{ids}")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public void exportExcel(HttpServletResponse response, TopicSubjectListDto topicSubjectListDto, @PathVariable(required = false) Long[] ids) {
        List<TopicSubjectExcelExport> topicSubjectExcelExports = topicSubjectService.getExcelVo(topicSubjectListDto, ids);
        if (CollectionUtils.isEmpty(topicSubjectExcelExports)) {
            throw new TopicException(ResultCodeEnum.EXPORT_ERROR);
        }
        
        try {
            ExcelUtil.download(response, topicSubjectExcelExports, TopicSubjectExcelExport.class);
        } catch (IOException e) {
            throw new TopicException(ResultCodeEnum.EXPORT_ERROR);
        }
    }

    

    @PostMapping("/import")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result<String> importExcel(@RequestParam("file") MultipartFile multipartFile, @RequestParam("updateSupport") Boolean updateSupport) {
        try {
            
            String s = topicSubjectService.importExcel(multipartFile, updateSupport);
            return Result.success(s);
        } catch (Exception e) {
            return Result.fail(e.getMessage(), ResultCodeEnum.IMPORT_ERROR);
        }
    }

    

    @GetMapping("/template")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public void getExcelTemplate(HttpServletResponse response) {
        
        List<TopicSubjectExcel> excelVoList = new ArrayList<>();
        
        TopicSubjectExcel excelVo = new TopicSubjectExcel();
        
        excelVoList.add(excelVo);
        try {
            
            ExcelUtil.download(response, excelVoList, TopicSubjectExcel.class);
        } catch (IOException e) {
            throw new TopicException(ResultCodeEnum.DOWNLOAD_ERROR);
        }

    }

    

    @GetMapping("/getSubject")
    public Result<List<TopicSubjectVo>> getSubject() {
        List<TopicSubjectVo> list = topicSubjectService.list();
        return Result.success(list);
    }

    

    @GetMapping("/subject/{categoryId}")
    public Result<List<TopicSubjectWebVo>> subject(@PathVariable Long categoryId) {
        List<TopicSubjectWebVo> list = topicSubjectService.subject(categoryId);
        return Result.success(list);
    }

    

    @GetMapping("/subjectDetail/{id}")
    public Result<TopicSubjectDetailAndTopicVo> subjectDetail(@PathVariable Long id) {
        TopicSubjectDetailAndTopicVo topicSubjectDetailAndTopicVo = topicSubjectService.subjectDetail(id);
        return Result.success(topicSubjectDetailAndTopicVo);
    }

}
