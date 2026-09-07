package com.hao.topic.security.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hao.topic.common.constant.ExceptionConstant;
import com.hao.topic.common.result.Result;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.system.SysUserDto;
import com.hao.topic.model.dto.system.SysUserListDto;
import com.hao.topic.model.entity.system.SysUser;
import com.hao.topic.model.excel.sytem.SysUserExcel;
import com.hao.topic.model.excel.sytem.SysUserExcelExport;
import com.hao.topic.model.vo.system.UserInfoVo;
import com.hao.topic.model.vo.topic.TopicDataVo;
import com.hao.topic.security.dto.*;
import com.hao.topic.security.handle.AuthenticationSuccessHandler;
import com.hao.topic.security.service.SysUserService;
import com.hao.topic.security.utils.DateUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.ReactiveAuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.web.server.WebFilterExchange;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.server.WebFilter;
import org.springframework.web.server.handler.DefaultWebFilterChain;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/security/user")
@Slf4j
public class SecurityController {

    @Autowired
    private ReactiveAuthenticationManager authenticationManager;

    @Autowired
    private AuthenticationSuccessHandler authenticationSuccessHandler;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    private SysUserService sysUserService;

    

    @PostMapping(value = "/login", consumes = MediaType.APPLICATION_JSON_VALUE)
    public Mono<Void> login(ServerWebExchange exchange, @Validated @RequestBody LoginRequestDto loginRequest) {
        
        String s = stringRedisTemplate.opsForValue().get(loginRequest.getCode());
        if (s == null || !s.equals(loginRequest.getCode())) {
            log.error("验证码错误");
            return Mono.error(new RuntimeException(ExceptionConstant.CODE_ERROR));
        }

        exchange.getAttributes().put("remember", loginRequest.getRemember());

        return authenticationManager
                .authenticate(new UsernamePasswordAuthenticationToken(
                        loginRequest.getUsername(),
                        loginRequest.getPassword()
                ))
                .flatMap(authentication -> {
                    List<WebFilter> filters = new ArrayList<>();
                    DefaultWebFilterChain filterChain = new DefaultWebFilterChain(exchange1 -> Mono.empty(), filters);
                    WebFilterExchange webFilterExchange = new WebFilterExchange(exchange, filterChain);

                    
                    return authenticationSuccessHandler.onAuthenticationSuccess(webFilterExchange, authentication);
                })
                .onErrorResume(e -> {
                    log.error("认证失败", e);
                    return Mono.error(e);
                });
    }

    

    @GetMapping("/userInfo")
    public Result<UserInfoVo> getUserInfo(String token) {
        UserInfoVo userInfoVo = sysUserService.getUserInfo(token);
        return Result.success(userInfoVo);
    }

    

    @RequestMapping("/list")
    public Map<String, Object> list(SysUserListDto sysUserListDto) {
        return sysUserService.userList(sysUserListDto);
    }

    

    @PostMapping("/add")
    void add(@RequestBody SysUserDto sysUserDto) {
        sysUserService.add(sysUserDto);
    }

    

    @PostMapping("/update")
    void update(@RequestBody SysUserDto sysUserDto) {
        sysUserService.update(sysUserDto);
    }

    

    @DeleteMapping("/delete/{ids}")
    void delete(@PathVariable Long[] ids) {
        sysUserService.delete(ids);
    }

    

    @GetMapping("/getByRoleId/{roleId}")
    Boolean getByRoleId(@PathVariable Long roleId) {
        return sysUserService.getByRoleId(roleId);
    }

    

    @RequestMapping("/export/{ids}")
    List<SysUserExcelExport> getExcelVo(SysUserListDto sysUserListDto, @PathVariable Long[] ids) {
        return sysUserService.getExcelVo(sysUserListDto, ids);
    }

    

    @PostMapping("/import")
    String importExcel(@RequestBody List<SysUserExcel> excelVoList, @RequestParam("updateSupport") Boolean updateSupport) {
        return sysUserService.importExcel(excelVoList, updateSupport);
    }

    

    @GetMapping("/info/{id}")
    public SysUser getUserInfo(@PathVariable Long id) {
        return sysUserService.getById(id);
    }

    

    @PutMapping("/avatar")
    public Result saveAvatar(@RequestBody UserDto userDto) {
        
        sysUserService.saveAvatar(userDto);
        return Result.success();
    }

    

    @PutMapping("/updateNicknameAndEmail")
    public Result updateNicknameAndEmail(@RequestBody UserDto userDto) {
        
        sysUserService.updateNicknameAndEmail(userDto);
        return Result.success();
    }

    

    @PutMapping("/updatePassword")
    public Result updatePassword(@RequestBody UserDto userDto) {
        
        sysUserService.updatePassword(userDto);
        return Result.success();
    }

    

    @PostMapping("loginType")
    public Mono<Result<Map<String, Object>>> loginType(@RequestBody @Validated LoginTypeDto loginTypeDto) {
        return sysUserService.loginType(loginTypeDto)
                .map(Result::success)
                .defaultIfEmpty(Result.fail("登录失败"));
    }

    

    @GetMapping("/sendEmail")
    public Result sendEmail(String email) {
        
        sysUserService.sendVerificationEmail(email);
        return Result.success();
    }

    

    @PutMapping("/resetPassword")
    public Result resetPassword(@RequestBody @Validated ResetPasswordDto resetPasswordDto) {
        sysUserService.resetPassword(resetPasswordDto);
        return Result.success();
    }

    

    @PostMapping("/register")
    public Result register(@RequestBody @Validated RegisterDto registerDto) {
        sysUserService.register(registerDto);
        return Result.success();
    }

    

    @GetMapping("/count/{date}")
    public Long countDate(@PathVariable String date) {
        
        LocalDateTime start = DateUtils.parseStartOfDay(date);
        LocalDateTime end = DateUtils.parseEndOfDay(date);

        
        LambdaQueryWrapper<SysUser> wrapper = new LambdaQueryWrapper<>();
        wrapper.between(SysUser::getCreateTime, start, end);

        return sysUserService.count(wrapper);
    }

    

    @GetMapping("/count")
    public Long count() {
        return sysUserService.count();
    }

    

    @GetMapping("/countUserDay7")
    public List<TopicDataVo> countUserDay7() {
        return sysUserService.countUserDay7();
    }

    

    @GetMapping("/getAllUser")
    public List<SysUser> getAllUser() {
        return sysUserService.list();
    }
}