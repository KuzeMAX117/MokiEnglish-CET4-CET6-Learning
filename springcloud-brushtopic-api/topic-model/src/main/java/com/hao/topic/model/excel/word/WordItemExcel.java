package com.hao.topic.model.excel.word;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentRowHeight;
import com.alibaba.excel.annotation.write.style.ContentStyle;
import com.alibaba.excel.annotation.write.style.HeadRowHeight;
import com.alibaba.excel.enums.poi.HorizontalAlignmentEnum;
import com.alibaba.excel.enums.poi.VerticalAlignmentEnum;
import lombok.Data;

@ContentRowHeight(30)
@HeadRowHeight(20)
@ColumnWidth(25)
@ContentStyle(horizontalAlignment = HorizontalAlignmentEnum.CENTER, verticalAlignment = VerticalAlignmentEnum.CENTER)
@Data
public class WordItemExcel {
    @ExcelProperty(value = "单词/词组")
    private String word;

    @ExcelProperty(value = "音标")
    private String phonetic;

    @ColumnWidth(40)
    @ExcelProperty(value = "释义")
    private String meaning;

    @ColumnWidth(50)
    @ExcelProperty(value = "例句")
    private String example;

    @ColumnWidth(50)
    @ExcelProperty(value = "例句翻译")
    private String exampleTranslate;
}