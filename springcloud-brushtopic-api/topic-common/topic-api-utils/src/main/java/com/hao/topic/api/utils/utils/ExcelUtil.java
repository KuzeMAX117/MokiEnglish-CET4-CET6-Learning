package com.hao.topic.api.utils.utils;

import com.alibaba.excel.EasyExcel;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class ExcelUtil {

    

    public static <T> void download(HttpServletResponse response, List<T> list, Class<T> clazz) throws IOException {
        
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        
        String fileName = URLEncoder.encode("导出", StandardCharsets.UTF_8).replaceAll("\\+", "%20");
        
        response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");
        
        EasyExcel
                
                .write(response.getOutputStream(), clazz)
                
                .sheet()
                
                .doWrite(list);

    }
}