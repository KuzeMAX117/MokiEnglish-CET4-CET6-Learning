package com.hao.topic.topic.service.impl;

import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.topic.PaperParseDto;
import com.hao.topic.model.vo.topic.PaperParseResultVo;
import com.hao.topic.topic.service.PaperParseService;
import com.hao.topic.topic.service.parser.CETPaperParser;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.xwpf.usermodel.IBodyElement;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * 试卷解析编排：文本切行 / docx 读段落+表格，统一交给 CETPaperParser
 */
@Service
@Slf4j
public class PaperParseServiceImpl implements PaperParseService {

    /**
     * docx 上传大小上限（字节）
     */
    private static final long MAX_DOCX_SIZE = 10 * 1024 * 1024L;

    private static final Set<String> VALID_SECTIONS = Set.of("writing", "listening", "reading", "translation");

    @Override
    public PaperParseResultVo parseText(PaperParseDto dto) {
        if (dto == null || StringUtils.isEmpty(dto.getText())) {
            throw new TopicException("解析文本不能为空");
        }
        String section = normalizeSection(dto.getSection());
        String subSection = normalizeSubSection(dto.getSubSection());
        List<String> lines = splitLines(dto.getText());
        PaperParseResultVo result = new CETPaperParser().parse(lines, section, subSection);
        log.info("粘贴文本解析完成：section={}, subSection={}, 子板块数={}, 题数={}",
                section, subSection, result.getSubSections().size(),
                result.getSubSections().stream().mapToInt(s -> s.getTopics().size()).sum());
        return result;
    }

    @Override
    public PaperParseResultVo parseDocx(MultipartFile file, String section, Long paperId) {
        if (file == null || file.isEmpty()) {
            throw new TopicException("请上传 docx 文件");
        }
        String filename = file.getOriginalFilename();
        if (filename == null || !filename.toLowerCase().endsWith(".docx")) {
            throw new TopicException("仅支持 .docx 格式（老版 .doc 请另存为 .docx 后上传）");
        }
        if (file.getSize() > MAX_DOCX_SIZE) {
            throw new TopicException("文件过大（超过 10MB），请移除 docx 内嵌图片后重试");
        }
        String rawText = readDocx(file);
        String normalizedSection = normalizeSection(section);
        PaperParseResultVo result = new CETPaperParser().parse(splitLines(rawText), normalizedSection, null);
        result.setRawText(rawText);
        log.info("docx 解析完成：file={}, paperId={}, 子板块数={}, 题数={}", filename, paperId,
                result.getSubSections().size(),
                result.getSubSections().stream().mapToInt(s -> s.getTopics().size()).sum());
        return result;
    }

    /**
     * 读取 docx：按文档顺序提取段落与表格单元格文本（表格内的词库不丢失）
     */
    private String readDocx(MultipartFile file) {
        StringBuilder sb = new StringBuilder();
        try (InputStream in = file.getInputStream(); XWPFDocument doc = new XWPFDocument(in)) {
            for (IBodyElement element : doc.getBodyElements()) {
                if (element instanceof XWPFParagraph paragraph) {
                    sb.append(paragraph.getText() == null ? "" : paragraph.getText()).append("\n");
                } else if (element instanceof XWPFTable table) {
                    for (XWPFTableRow row : table.getRows()) {
                        for (XWPFTableCell cell : row.getTableCells()) {
                            String cellText = cell.getText();
                            if (cellText != null && !cellText.trim().isEmpty()) {
                                sb.append(cellText).append("\n");
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            log.error("docx 读取失败", e);
            throw new TopicException("docx 读取失败：" + e.getMessage());
        }
        return sb.toString();
    }

    private List<String> splitLines(String text) {
        List<String> lines = new ArrayList<>();
        for (String line : text.split("\n")) {
            lines.add(line);
        }
        return lines;
    }

    private String normalizeSection(String section) {
        if (StringUtils.isEmpty(section)) {
            return null;
        }
        String s = section.trim().toLowerCase();
        return VALID_SECTIONS.contains(s) ? s : null;
    }

    private String normalizeSubSection(String subSection) {
        if (StringUtils.isEmpty(subSection)) {
            return null;
        }
        return subSection.trim().toLowerCase();
    }
}
