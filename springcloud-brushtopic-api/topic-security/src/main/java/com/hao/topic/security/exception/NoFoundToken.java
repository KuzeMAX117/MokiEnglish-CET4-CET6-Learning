package com.hao.topic.security.exception;

public class NoFoundToken extends RuntimeException {
    private static final long serialVersionUID = 1L;

    

    public NoFoundToken(String msg) {
        super(msg);
    }

    

    public String getMsg() {
        return getMessage();
    }
}
