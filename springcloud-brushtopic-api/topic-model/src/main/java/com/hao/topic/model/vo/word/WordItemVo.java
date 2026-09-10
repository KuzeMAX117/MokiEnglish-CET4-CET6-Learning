package com.hao.topic.model.vo.word;

import lombok.Data;

@Data
public class WordItemVo {
    private Long id;
    private Long bookId;
    private String word;
    private String phonetic;
    private String meaning;
    private String phrase;
    private String syllableWord;
    private String example;
    private String exampleTranslate;
    /** 熟练度 0-5，0=未学 */
    private Integer proficiency;
    /** 状态 0=未学 1=学习中 2=已掌握 */
    private Integer status;
}
