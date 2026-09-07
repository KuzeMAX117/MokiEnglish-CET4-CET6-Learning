package com.hao.topic.api.utils.enums;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
public enum StatusEnums {
    NORMAL(0, "正常"),
    STOP(1, "停用"),
    AUDITING(2, "待审核"),
    AUDIT_FAIL(3, "审核失败");

    private Integer code;
    private String message;

    public Integer getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    
    public static String getMessageByCode(Integer code) {
        for (StatusEnums statusEnums : StatusEnums.values()) {
            if (statusEnums.getCode().equals(code)) {
                return statusEnums.getMessage();
            }
        }
        return null;
    }
}
