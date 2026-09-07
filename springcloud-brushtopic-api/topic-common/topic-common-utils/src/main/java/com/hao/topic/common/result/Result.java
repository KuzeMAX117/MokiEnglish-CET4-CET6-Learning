package com.hao.topic.common.result;

import com.hao.topic.common.enums.ResultCodeEnum;
import lombok.Data;

import java.io.Serializable;

@Data
public class Result<T> implements Serializable {
    private Integer code; 
    private String message; 
    private T data; 

    

    public static <T> Result<T> build(T data, ResultCodeEnum resultCodeEnum) {
        
        Result<T> result = new Result<>();
        if (data != null) {
            result.setData(data);
        }
        result.setCode(resultCodeEnum.getCode());
        result.setMessage(resultCodeEnum.getMessage());
        return result;
    }

    

    public static <T> Result<T> success() {
        return build(null, ResultCodeEnum.SUCCESS);
    }

    

    public static <T> Result<T> success(T object) {
        return build(object, ResultCodeEnum.SUCCESS);
    }

    

    public static <T> Result<T> fail(T object, ResultCodeEnum resultCodeEnum) {
        return build(object, resultCodeEnum);
    }

    

    public static <T> Result<T> fail() {
        return build(null, ResultCodeEnum.FAIL);
    }

    

    public static <T> Result<T> fail(ResultCodeEnum resultCodeEnum) {
        return build(null, resultCodeEnum);
    }

    

    public static <T> Result<T> fail(String message) {
        
        Result<T> result = new Result<>();
        result.setCode(ResultCodeEnum.FAIL.getCode());
        result.setData(null);
        result.setMessage(message);
        return result;
    }

    

    public static <T> Result<T> fail(String message, Integer code) {
        
        Result<T> result = new Result<>();
        result.setCode(code);
        result.setData(null);
        result.setMessage(message);
        return result;
    }
}
