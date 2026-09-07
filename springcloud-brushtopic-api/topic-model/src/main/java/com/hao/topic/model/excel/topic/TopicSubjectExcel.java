package com.hao.topic.model.excel.topic;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentRowHeight;
import com.alibaba.excel.annotation.write.style.ContentStyle;
import com.alibaba.excel.annotation.write.style.HeadRowHeight;
import com.alibaba.excel.enums.poi.HorizontalAlignmentEnum;
import com.alibaba.excel.enums.poi.VerticalAlignmentEnum;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@ContentRowHeight(30)

@HeadRowHeight(20)

@ColumnWidth(25)

@ContentStyle(horizontalAlignment = HorizontalAlignmentEnum.CENTER, verticalAlignment = VerticalAlignmentEnum.CENTER)
@Data
public class TopicSubjectExcel {
    @ExcelProperty(value = "题目专题名称")
    private String subjectName;
    @ExcelProperty(value = "题目专题描述")
    private String subjectDesc;
    @ExcelProperty(value = "图片url")
    private String imageUrl;
    @ExcelProperty(value = "题目专题分类")
    private String categoryName;
}
