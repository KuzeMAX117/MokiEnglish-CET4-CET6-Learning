package com.hao.topic.model.excel.topic;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentRowHeight;
import com.alibaba.excel.annotation.write.style.ContentStyle;
import com.alibaba.excel.annotation.write.style.HeadRowHeight;
import com.alibaba.excel.enums.poi.HorizontalAlignmentEnum;
import com.alibaba.excel.enums.poi.VerticalAlignmentEnum;
import lombok.Data;

import java.time.LocalDateTime;

@ContentRowHeight(30)

@HeadRowHeight(20)

@ColumnWidth(25)

@ContentStyle(horizontalAlignment = HorizontalAlignmentEnum.CENTER, verticalAlignment = VerticalAlignmentEnum.CENTER)
@Data
public class TopicLabelExcelExport {

    @ExcelProperty(value = "ID")
    private Long id;

    @ExcelProperty(value = "题目标签名称")
    private String labelName;

    @ExcelProperty(value = "创建人")
    private String createBy;

    @ExcelProperty(value = "状态")
    private String status;

    @ExcelProperty(value = "题目数量")
    private Long useCount;

    @ExcelProperty(value = "创建时间")
    private LocalDateTime createTime;

    @ExcelProperty(value = "修改时间")
    private LocalDateTime updateTime;
}
