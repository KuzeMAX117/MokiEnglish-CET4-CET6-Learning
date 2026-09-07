package com.hao.topic.security.properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;

@Configuration
@ConfigurationProperties(prefix = "security.auth")
public class AuthProperties {

    

    private int timeout;

    

    private int rememberMe;

    

    private int h5Timeout;

    public int getTimeout() {
        return timeout;
    }

    public void setTimeout(int timeout) {
        this.timeout = timeout;
    }

    public int getRememberMe() {
        return rememberMe;
    }

    public void setRememberMe(int rememberMe) {
        this.rememberMe = rememberMe;
    }

    public int getH5Timeout() {
        return h5Timeout;
    }

    public void setH5Timeout(int h5Timeout) {
        this.h5Timeout = h5Timeout;
    }
}
