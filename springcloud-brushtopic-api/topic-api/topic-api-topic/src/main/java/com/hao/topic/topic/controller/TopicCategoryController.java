package com.hao.topic.topic.controller;

import com.alibaba.excel.EasyExcel;
import com.hao.topic.api.utils.utils.ExcelUtil;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.result.Result;
import com.hao.topic.model.dto.topic.TopicCategoryDto;
import com.hao.topic.model.dto.topic.TopicCategoryListDto;
import com.hao.topic.model.entity.topic.TopicCategory;
import com.hao.topic.model.excel.sytem.SysUserExcel;
import com.hao.topic.model.excel.topic.TopicCategoryExcel;
import com.hao.topic.model.excel.topic.TopicCategoryExcelExport;
import com.hao.topic.model.vo.topic.TopicCategoryVo;
import com.hao.topic.topic.service.TopicCategoryService;
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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@RestController
@RequestMapping("/topic/category")
@AllArgsConstructor
public class TopicCategoryController {

    private final TopicCategoryService topicCategoryService;

    

    @GetMapping("/list")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result<Map<String, Object>> list(TopicCategoryListDto topicCategoryDto) {
        Map<String, Object> map = topicCategoryService.categoryList(topicCategoryDto);
        return Result.success(map);
    }

    

    @PostMapping("/add")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result add(@RequestBody TopicCategoryDto topicCategoryDto) {
        topicCategoryService.add(topicCategoryDto);
        return Result.success();
    }

    

    @PutMapping("/update")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result update(@RequestBody TopicCategoryDto topicCategoryDto) {
        topicCategoryService.update(topicCategoryDto);
        return Result.success();
    }

    

    @PutMapping("/audit")
    public void auditCategory(@RequestBody TopicCategory topicCategory) {
        topicCategoryService.auditCategory(topicCategory);
    }

    

    @DeleteMapping("/delete/{ids}")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result delete(@PathVariable Long[] ids) {
        topicCategoryService.delete(ids);
        return Result.success();
    }

    

    @GetMapping("/export/{ids}")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public void exportExcel(HttpServletResponse response, TopicCategoryListDto topicCategoryListDto, @PathVariable(required = false) Long[] ids) {
        List<TopicCategoryExcelExport> topicCategoryExcelExports = topicCategoryService.getExcelVo(topicCategoryListDto, ids);
        if (CollectionUtils.isEmpty(topicCategoryExcelExports)) {
            throw new TopicException(ResultCodeEnum.EXPORT_ERROR);
        }
        
        try {
            ExcelUtil.download(response, topicCategoryExcelExports, TopicCategoryExcelExport.class);
        } catch (IOException e) {
            throw new TopicException(ResultCodeEnum.EXPORT_ERROR);
        }
    }

    

    @PostMapping("/import")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public Result<String> importExcel(@RequestParam("file") MultipartFile multipartFile, @RequestParam("updateSupport") Boolean updateSupport) {
        try {
            
            String s = topicCategoryService.importExcel(multipartFile, updateSupport);
            return Result.success(s);
        } catch (Exception e) {
            return Result.fail(e.getMessage(), ResultCodeEnum.IMPORT_ERROR);
        }
    }

    

    @GetMapping("/template")
    @PreAuthorize("hasAuthority('admin') || hasAuthority('member')")
    public void getExcelTemplate(HttpServletResponse response) {
        
        List<TopicCategoryExcel> excelVoList = new ArrayList<>();
        
        TopicCategoryExcel excelVo = new TopicCategoryExcel();
        
        excelVoList.add(excelVo);
        try {
            
            ExcelUtil.download(response, excelVoList, TopicCategoryExcel.class);
        } catch (IOException e) {
            throw new TopicException(ResultCodeEnum.DOWNLOAD_ERROR);
        }
    }

    

    @GetMapping("/category/{isCustomQuestion}")
    public Result<List<TopicCategoryVo>> category(@PathVariable Boolean isCustomQuestion) {
        List<TopicCategoryVo> list = topicCategoryService.category(isCustomQuestion);
        return Result.success(list);
    }
}
