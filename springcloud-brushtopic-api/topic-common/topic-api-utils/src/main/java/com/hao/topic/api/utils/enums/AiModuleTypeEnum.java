package com.hao.topic.api.utils.enums;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
public enum AiModuleTypeEnum {
    WORD("word", "背单词"),
    ESSAY("essay", "作文"),
    TRANSLATION("translation", "翻译");

    private String code;
    private String message;

    public String getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public static String getMessageByCode(String code) {
        for (AiModuleTypeEnum moduleType : AiModuleTypeEnum.values()) {
            if (moduleType.getCode().equals(code)) {
                return moduleType.getMessage();
            }
        }
        return null;
    }
}