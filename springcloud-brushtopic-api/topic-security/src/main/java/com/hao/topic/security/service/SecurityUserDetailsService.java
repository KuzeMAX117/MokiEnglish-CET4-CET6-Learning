package com.hao.topic.security.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hao.topic.client.system.SystemFeignClient;
import com.hao.topic.common.constant.ExceptionConstant;
import com.hao.topic.model.entity.system.SysRole;
import com.hao.topic.model.entity.system.SysUser;
import com.hao.topic.model.entity.system.SysUserRole;
import com.hao.topic.security.mapper.SysUserRoleMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.ReactiveUserDetailsService;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;

import java.util.ArrayList;
import java.util.Collection;

@Slf4j
@Service
public class SecurityUserDetailsService implements ReactiveUserDetailsService {

    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private SysUserRoleMapper sysUserRoleMapper;

    @Autowired
    private SystemFeignClient systemFeignClient;

    

    @Override
    public Mono<UserDetails> findByUsername(String account) {
        log.info(account);
        
        SysUser sysUser = sysUserService.findByUserName(account);

        
        if (sysUser == null) {
            
            return Mono.error(new UsernameNotFoundException(ExceptionConstant.USER_NOT_EXIST));
        }
        
        if (sysUser.getStatus() == 1) {
            return Mono.error(new UsernameNotFoundException(ExceptionConstant.USER_NOT_STOP));
        }
        log.info(sysUser.toString());
        return Mono.fromCallable(() -> {
                    
                    LambdaQueryWrapper<SysUserRole> wrapper = new LambdaQueryWrapper<>();
                    wrapper.eq(SysUserRole::getUserId, sysUser.getId());
                    return sysUserRoleMapper.selectOne(wrapper);
                })
                .subscribeOn(Schedulers.boundedElastic())
                .flatMap(userRole -> {
                    if (userRole == null) {
                        return Mono.error(new UsernameNotFoundException(ExceptionConstant.USER_NOT_ROLE));
                    }
                    return Mono.fromCallable(() -> systemFeignClient.getById(userRole.getRoleId()))
                            .subscribeOn(Schedulers.boundedElastic());
                })
                .flatMap(sysRole -> {
                    if (sysRole == null) {
                        return Mono.error(new UsernameNotFoundException(ExceptionConstant.USER_NOT_ROLE));
                    }

                    Collection<GrantedAuthority> authorities = new ArrayList<>();
                    authorities.add(new SimpleGrantedAuthority(sysRole.getRoleKey()));

                    return Mono.just(new SecurityUserDetails(
                            sysUser.getAccount(),
                            "{bcrypt}" + sysUser.getPassword(),
                            authorities,
                            sysUser.getId()
                    ));
                });
    }
}