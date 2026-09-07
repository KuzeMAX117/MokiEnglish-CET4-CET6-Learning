package com.hao.topic.common.exception;

import com.hao.topic.common.enums.ResultCodeEnum;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TopicException extends RuntimeException {
    
    private Integer code;

    
    public TopicException(ResultCodeEnum resultCodeEnum) {
        
        super(resultCodeEnum.getMessage());
        this.code = resultCodeEnum.getCode();
    }

    public TopicException(String message) {
        super(message);
        this.code = 400;
    }
}
