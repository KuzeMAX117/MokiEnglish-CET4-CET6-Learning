package com.hao.topic.security.service;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hao.topic.client.system.SystemFeignClient;
import com.hao.topic.common.auth.TokenInterceptor;
import com.hao.topic.common.constant.RedisConstant;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.utils.JWTUtils;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.system.SysUserDto;
import com.hao.topic.model.dto.system.SysUserListDto;
import com.hao.topic.model.entity.system.SysRole;
import com.hao.topic.model.entity.system.SysUser;
import com.hao.topic.model.entity.system.SysUserRole;
import com.hao.topic.model.excel.sytem.SysUserExcel;
import com.hao.topic.model.excel.sytem.SysUserExcelExport;
import com.hao.topic.model.vo.system.SysMenuVo;
import com.hao.topic.model.vo.system.SysUserListVo;
import com.hao.topic.model.vo.system.UserInfoVo;
import com.hao.topic.model.vo.topic.TopicDataVo;
import com.hao.topic.security.constant.EmailConstant;
import com.hao.topic.security.constant.JwtConstant;
import com.hao.topic.security.dto.RegisterDto;
import com.hao.topic.security.dto.ResetPasswordDto;
import com.hao.topic.security.dto.LoginTypeDto;
import com.hao.topic.security.dto.UserDto;
import com.hao.topic.security.mapper.SysUserMapper;
import com.hao.topic.security.mapper.SysUserRoleMapper;
import com.hao.topic.security.properties.AuthProperties;
import com.hao.topic.security.utils.EmailSendUtils;
import com.hao.topic.security.utils.PasswordUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;

import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.TimeUnit;

@Service
@Slf4j
public class SysUserService extends ServiceImpl<SysUserMapper, SysUser> {

    @Autowired
    private SysUserRoleMapper sysUserRoleMapper;

    @Autowired
    private SystemFeignClient systemFeignClient;

    @Autowired
    private SysUserMapper sysUserMapper;

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private AuthProperties ignoreWhiteProperties;

    @Autowired
    private EmailSendUtils emailSendUtils;

    

    public SysUser findByUserName(String username) {
        LambdaQueryWrapper<SysUser> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(SysUser::getAccount, username);
        return getOne(queryWrapper);
    }

    

    public UserInfoVo getUserInfo(String token) {
        if (token == null) {
            throw new TopicException(ResultCodeEnum.LOGIN_ERROR);
        }
        
        Map<String, Object> tokenInfo = JWTUtils.getTokenInfo(token);
        
        if (CollectionUtils.isEmpty(tokenInfo)) {
            throw new TopicException(ResultCodeEnum.LOGIN_ERROR);
        }
        
        String username = (String) tokenInfo.get("username");
        
        if (username == null) {
            throw new TopicException(ResultCodeEnum.LOGIN_ERROR);
        }
        
        SysUser sysUser = findByUserName(username);
        
        if (sysUser == null) {
            throw new TopicException(ResultCodeEnum.ACCOUNT_ERROR);
        }
        
        UserInfoVo userInfoVo = new UserInfoVo();
        userInfoVo.setAccount(sysUser.getAccount());
        userInfoVo.setAvatar(sysUser.getAvatar());
        userInfoVo.setNickname(sysUser.getNickname());
        userInfoVo.setId(sysUser.getId());

        
        SysUserRole sysUserRole = sysUserRoleMapper.selectOne(new LambdaQueryWrapper<SysUserRole>().eq(SysUserRole::getUserId, sysUser.getId()));
        
        if (sysUserRole == null) {
            throw new TopicException(ResultCodeEnum.ACCOUNT_ERROR);
        }
        
        SysRole sysRole = systemFeignClient.getById(sysUserRole.getRoleId());
        
        if (sysRole == null) {
            throw new TopicException(ResultCodeEnum.ACCOUNT_ERROR);
        }
        userInfoVo.setIdentity(sysRole.getIdentify());
        
        TokenInterceptor.setToken(token);
        
        List<SysMenuVo> sysMenus = systemFeignClient.userMenu(sysRole.getId());
        
        if (CollectionUtils.isEmpty(sysMenus)) {
            throw new TopicException(ResultCodeEnum.NO_MENU_FAIL);
        }
        userInfoVo.setMenuList(sysMenus);

        return userInfoVo;
    }

    

    public Map<String, Object> userList(SysUserListDto sysUserListDto) {
        if (sysUserListDto.getPageNum() != null) {
            sysUserListDto.setPageNum((sysUserListDto.getPageNum() - 1) * sysUserListDto.getPageSize());
        }
        
        List<SysUserListVo> sysUserListVos = sysUserMapper.selectUserListVo(sysUserListDto);
        
        int total = sysUserMapper.countUserList(sysUserListDto);
        log.info("查询结果：{}", sysUserListVos);
        return Map.of(
                "total", total,
                "rows", sysUserListVos
        );
    }

    

    @Transactional
    public void add(SysUserDto sysUserDto) {
        
        if (StringUtils.isEmpty(sysUserDto.getAccount())) {
            throw new TopicException(ResultCodeEnum.PARAM_ACCOUNT_ERROR);
        }
        
        if (StringUtils.isEmpty(sysUserDto.getRoleName())) {
            throw new TopicException(ResultCodeEnum.PARAM_ROLE_ERROR);
        }
        
        if (StringUtils.isEmpty(sysUserDto.getPassword())) {
            throw new TopicException(ResultCodeEnum.PARAM_PASSWORD_ERROR);
        }
        
        SysUser sysUser = new SysUser();
        BeanUtils.copyProperties(sysUserDto, sysUser);
        
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        String encode = bCryptPasswordEncoder.encode(sysUser.getPassword());
        sysUser.setPassword(encode);
        
        if (findByUserName(sysUser.getAccount()) != null) {
            throw new TopicException(ResultCodeEnum.ADD_USER_ERROR);
        }
        
        int insert = sysUserMapper.insert(sysUser);
        
        SysUserRole sysUserRole = new SysUserRole();
        sysUserRole.setUserId(sysUser.getId());
        sysUserRole.setRoleId(sysUserDto.getRoleId());
        sysUserRoleMapper.insert(sysUserRole);
    }

    

    @Transactional
    public void update(SysUserDto sysUserDto) {
        
        if (StringUtils.isEmpty(sysUserDto.getAccount())) {
            throw new TopicException(ResultCodeEnum.PARAM_ACCOUNT_ERROR);
        }
        
        if (StringUtils.isEmpty(sysUserDto.getRoleName())) {
            throw new TopicException(ResultCodeEnum.PARAM_ROLE_ERROR);
        }
        
        SysUser sysUser = new SysUser();
        BeanUtils.copyProperties(sysUserDto, sysUser);
        sysUserMapper.updateById(sysUser);
        
        LambdaQueryWrapper<SysUserRole> sysUserRoleLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysUserRoleLambdaQueryWrapper.eq(SysUserRole::getUserId, sysUserDto.getId());
        sysUserRoleMapper.delete(sysUserRoleLambdaQueryWrapper);
        
        SysUserRole sysUserRole = new SysUserRole();
        sysUserRole.setUserId(sysUser.getId());
        sysUserRole.setRoleId(sysUserDto.getRoleId());
        sysUserRoleMapper.insert(sysUserRole);
    }

    

    @Transactional
    public void delete(Long[] ids) {
        
        for (Long id : ids) {
            
            sysUserMapper.deleteById(id);
            
            LambdaQueryWrapper<SysUserRole> sysUserRoleLambdaQueryWrapper = new LambdaQueryWrapper<>();
            sysUserRoleLambdaQueryWrapper.eq(SysUserRole::getUserId, id);
            sysUserRoleMapper.delete(sysUserRoleLambdaQueryWrapper);
        }
    }

    

    public Boolean getByRoleId(Long roleId) {
        
        LambdaQueryWrapper<SysUserRole> sysRoleLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysRoleLambdaQueryWrapper.eq(SysUserRole::getRoleId, roleId);
        List<SysUserRole> sysUserRoles = sysUserRoleMapper.selectList(sysRoleLambdaQueryWrapper);
        if (!CollectionUtils.isEmpty(sysUserRoles)) {
            return false;
        }
        return true;
    }

    

    public List<SysUserExcelExport> getExcelVo(SysUserListDto sysUserListDto, Long[] ids) {
        if (ids[0] != 0) {
            
            List<SysUser> sysUsers = sysUserMapper.selectBatchIds(Arrays.asList(ids));
            if (!CollectionUtils.isEmpty(sysUsers)) {
                
                List<SysUserExcelExport> sysUserExcelExports = new ArrayList<>();
                for (SysUser sysUser : sysUsers) {
                    SysUserExcelExport sysUserExcelExport = new SysUserExcelExport();
                    BeanUtils.copyProperties(sysUser, sysUserExcelExport);
                    
                    LambdaQueryWrapper<SysUserRole> sysUserRoleLambdaQueryWrapper = new LambdaQueryWrapper<>();
                    sysUserRoleLambdaQueryWrapper.eq(SysUserRole::getUserId, sysUser.getId());
                    SysUserRole sysUserRole = sysUserRoleMapper.selectOne(sysUserRoleLambdaQueryWrapper);
                    if (sysUserRole != null) {
                        SysRole byId = systemFeignClient.getById(sysUserRole.getRoleId());
                        if (byId != null) {
                            sysUserExcelExport.setRoleName(byId.getName());
                        }
                    }
                    sysUserExcelExports.add(sysUserExcelExport);
                }
                
                sysUserExcelExports.sort(Comparator.comparing(SysUserExcelExport::getId).reversed());
                return sysUserExcelExports;
            }
        }
        
        
        List<SysUserListVo> sysUserListVos = sysUserMapper.selectUserListVo(sysUserListDto);
        
        if (!CollectionUtils.isEmpty(sysUserListVos)) {
            
            List<SysUserExcelExport> sysUserExcelExports = new ArrayList<>();
            for (SysUserListVo sysUserListVo : sysUserListVos) {
                SysUserExcelExport sysUserExcelExport = new SysUserExcelExport();
                BeanUtils.copyProperties(sysUserListVo, sysUserExcelExport);
                sysUserExcelExports.add(sysUserExcelExport);
            }
            return sysUserExcelExports;
        }
        return null;
    }

    

    @Transactional
    public String importExcel(List<SysUserExcel> excelVoList, Boolean updateSupport) {
        
        if (StringUtils.isNull(excelVoList) || excelVoList.size() == 0) {
            throw new TopicException(ResultCodeEnum.IMPORT_EXCEL_ERROR);
        }
        
        int successNum = 0;
        
        int failureNum = 0;
        
        StringBuilder successMsg = new StringBuilder();
        
        StringBuilder failureMsg = new StringBuilder();
        
        for (SysUserExcel sysUserExcelTemplate : excelVoList) {
            try {
                
                SysUser sysUser = findByUserName(sysUserExcelTemplate.getAccount());
                if (StringUtils.isNull(sysUser)) {
                    
                    
                    sysUserExcelTemplate.setPassword(PasswordUtils.encodePassword(sysUserExcelTemplate.getPassword()));
                    
                    SysRole sysRole = sysUserMapper.getByRoleName(sysUserExcelTemplate.getRoleName());
                    if (StringUtils.isNull(sysRole)) {
                        
                        failureNum++;
                        failureMsg.append("<br/>").append(failureNum).append("-用户：").append(sysUserExcelTemplate.getAccount()).append("-角色不存在");
                    } else {
                        
                        
                        SysUser user = new SysUser();
                        BeanUtils.copyProperties(sysUserExcelTemplate, user);
                        sysUserMapper.insert(user);
                        
                        SysUserRole sysUserRole = new SysUserRole();
                        sysUserRole.setUserId(user.getId());
                        sysUserRole.setRoleId(sysRole.getId());
                        sysUserRoleMapper.insert(sysUserRole);
                        successNum++;
                        successMsg.append("<br/>").append(successNum).append("-用户：").append(sysUserExcelTemplate.getAccount()).append("-导入成功");
                    }
                } else if (updateSupport) {
                    
                    
                    sysUserExcelTemplate.setPassword(PasswordUtils.encodePassword(sysUserExcelTemplate.getPassword()));
                    
                    SysRole sysRole = sysUserMapper.getByRoleName(sysUserExcelTemplate.getRoleName());
                    if (StringUtils.isNull(sysRole)) {
                        
                        failureNum++;
                        failureMsg.append("<br/>").append(failureNum).append("-用户：").append(sysUserExcelTemplate.getAccount()).append("-角色不存在");
                    } else {
                        
                        BeanUtils.copyProperties(sysUserExcelTemplate, sysUser);
                        sysUserMapper.updateById(sysUser);
                        
                        LambdaQueryWrapper<SysUserRole> sysUserRoleLambdaQueryWrapper = new LambdaQueryWrapper<>();
                        sysUserRoleLambdaQueryWrapper.eq(SysUserRole::getUserId, sysUser.getId());
                        sysUserRoleMapper.delete(sysUserRoleLambdaQueryWrapper);
                        
                        SysUserRole sysUserRole = new SysUserRole();
                        sysUserRole.setUserId(sysUser.getId());
                        sysUserRole.setRoleId(sysRole.getId());
                        sysUserRoleMapper.insert(sysUserRole);
                        successNum++;
                        successMsg.append("<br/>").append(successNum).append("-用户：").append(sysUserExcelTemplate.getAccount()).append("-更新成功");
                    }
                } else {
                    
                    failureNum++;
                    failureMsg.append("<br/>").append(failureNum).append("-用户：").append(sysUser.getAccount()).append("-已存在");
                }
            } catch (Exception e) {
                failureNum++;
                String msg = "<br/>" + failureNum + "-用户： " + sysUserExcelTemplate.getAccount() + " 导入失败：";
                failureMsg.append(msg).append(e.getMessage());
                log.error(msg, e);
            }
        }
        if (failureNum > 0) {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
            throw new TopicException(failureMsg.toString());
        } else {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
        }
        return successMsg.toString();
    }

    

    public void saveAvatar(UserDto userDto) {
        if (userDto.getId() == null) {
            throw new TopicException(ResultCodeEnum.USER_NOT_EXIST);
        }
        SysUser sysUserDb = sysUserMapper.selectById(userDto.getId());
        if (sysUserDb == null) {
            throw new TopicException(ResultCodeEnum.USER_NOT_EXIST);
        }
        sysUserDb.setAvatar(userDto.getAvatar());
        sysUserMapper.updateById(sysUserDb);
    }

    

    public void updateNicknameAndEmail(UserDto userDto) {
        
        if (userDto.getId() == null) {
            throw new TopicException(ResultCodeEnum.USER_NOT_EXIST);
        }
        SysUser sysUserDb = sysUserMapper.selectById(userDto.getId());
        if (sysUserDb == null) {
            throw new TopicException(ResultCodeEnum.USER_NOT_EXIST);
        }
        if (!userDto.getPassword().equals(sysUserDb.getPassword())) {
            if (!PasswordUtils.matches(userDto.getPassword(), sysUserDb.getPassword())) {
                throw new TopicException(ResultCodeEnum.USER_PASSWORD_ERROR);
            }
        }
        
        LambdaQueryWrapper<SysUser> eq = new LambdaQueryWrapper<SysUser>().eq(SysUser::getNickname, userDto.getNickname());
        if (sysUserMapper.selectCount(eq) > 0) {
            throw new TopicException(ResultCodeEnum.USER_NICKNAME_EXIST);
        }
        if (userDto.getEmail() != null && !userDto.getEmail().equals("")) {
            
            LambdaQueryWrapper<SysUser> emailEq = new LambdaQueryWrapper<SysUser>().eq(SysUser::getEmail, userDto.getEmail());
            if (sysUserMapper.selectCount(emailEq) > 0) {
                throw new TopicException(ResultCodeEnum.USER_EMAIL_EXIST);
            }
            
            
            Object o = redisTemplate.opsForValue().get(EmailConstant.EMAIL_CODE.getValue() + ":" + userDto.getEmail());
            if (o == null) {
                throw new TopicException(ResultCodeEnum.USER_EMAIL_CODE_ERROR);
            }
            String code = o.toString();
            if (!code.equals(userDto.getCode())) {
                throw new TopicException(ResultCodeEnum.USER_EMAIL_CODE_INPUT_ERROR);
            }
            sysUserDb.setEmail(userDto.getEmail());
        }
        sysUserDb.setNickname(userDto.getNickname());
        try {
            sysUserMapper.updateById(sysUserDb);
        } catch (Exception e) {
            throw new TopicException(ResultCodeEnum.USER_NICKNAME_EXIST);
        }
    }

    

    public void updatePassword(UserDto userDto) {
        
        if (userDto.getId() == null) {
            throw new TopicException(ResultCodeEnum.USER_NOT_EXIST);
        }
        SysUser sysUserDb = sysUserMapper.selectById(userDto.getId());
        if (sysUserDb == null) {
            throw new TopicException(ResultCodeEnum.USER_NOT_EXIST);
        }
        
        if (!PasswordUtils.matches(userDto.getPassword(), sysUserDb.getPassword())) {
            throw new TopicException(ResultCodeEnum.USER_PASSWORD_ERROR);
        }
        
        if (!userDto.getNewPassword().equals(userDto.getConfirmPassword())) {
            throw new TopicException(ResultCodeEnum.USER_PASSWORD_ERROR);
        }
        
        sysUserDb.setPassword(PasswordUtils.encodePassword(userDto.getNewPassword()));
        sysUserMapper.updateById(sysUserDb);
    }

    

    public Mono<Map<String, Object>> loginType(LoginTypeDto loginTypeDto) {
        Integer loginType = loginTypeDto.getLoginType();
        String account = loginTypeDto.getAccount();
        if (account == null) {
            throw new TopicException(ResultCodeEnum.FAIL);
        }
        String email = loginTypeDto.getEmail();
        if (email == null) {
            throw new TopicException(ResultCodeEnum.FAIL);
        }
        switch (loginType) {
            case 0:
                return accountLogin(loginTypeDto);
            case 1:
                return emailLogin(loginTypeDto);
            default:
                throw new TopicException(ResultCodeEnum.FAIL);
        }
    }

    

    private Mono<Map<String, Object>> emailLogin(LoginTypeDto loginTypeDto) {
        
        LambdaQueryWrapper<SysUser> sysUserLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysUserLambdaQueryWrapper.eq(SysUser::getEmail, loginTypeDto.getEmail());
        SysUser sysUser = sysUserMapper.selectOne(sysUserLambdaQueryWrapper);
        if (sysUser == null) {
            throw new TopicException(ResultCodeEnum.USER_NOT_EXIST);
        }
        
        if (!PasswordUtils.matches(loginTypeDto.getPassword(), sysUser.getPassword())) {
            throw new TopicException(ResultCodeEnum.USER_PASSWORD_ERROR);
        }
        
        if (sysUser.getStatus() == 1) {
            throw new TopicException(ResultCodeEnum.USER_ACCOUNT_STOP);
        }
        return getRoleIdentify(sysUser)
                .map(sysRole -> {
                    String token = createToken(sysUser, sysRole);
                    return Map.of(
                            "token", token,
                            "userInfo", JSON.toJSONString(sysUser),
                            "role", sysRole.getIdentify()
                    );
                });
    }

    

    private Mono<SysRole> getRoleIdentify(SysUser sysUser) {
        return Mono.fromCallable(() -> {
                    LambdaQueryWrapper<SysUserRole> sysUserRoleLambdaQueryWrapper = new LambdaQueryWrapper<>();
                    sysUserRoleLambdaQueryWrapper.eq(SysUserRole::getUserId, sysUser.getId());
                    return sysUserRoleMapper.selectOne(sysUserRoleLambdaQueryWrapper);
                })
                .publishOn(Schedulers.boundedElastic()) 
                .filter(Objects::nonNull)
                .switchIfEmpty(Mono.error(new TopicException(ResultCodeEnum.USER_NOT_EXIST)))
                .flatMap(sysUserRole ->
                        Mono.fromCallable(() -> systemFeignClient.getById(sysUserRole.getRoleId()))
                                .publishOn(Schedulers.boundedElastic())
                                .filter(Objects::nonNull)
                                .switchIfEmpty(Mono.error(new TopicException(ResultCodeEnum.USER_NOT_EXIST)))
                );
    }

    

    private Mono<Map<String, Object>> accountLogin(LoginTypeDto loginTypeDto) {
        
        SysUser sysUser = findByUserName(loginTypeDto.getAccount());
        if (sysUser == null) {
            throw new TopicException(ResultCodeEnum.USER_NOT_EXIST);
        }
        
        if (!PasswordUtils.matches(loginTypeDto.getPassword(), sysUser.getPassword())) {
            throw new TopicException(ResultCodeEnum.USER_PASSWORD_ERROR);
        }
        
        if (sysUser.getStatus() == 1) {
            throw new TopicException(ResultCodeEnum.USER_ACCOUNT_STOP);
        }
        return getRoleIdentify(sysUser)
                .map(sysRole -> {
                    String token = createToken(sysUser, sysRole);
                    return Map.of(
                            "token", token,
                            "userInfo", JSON.toJSONString(sysUser),
                            "role", sysRole.getIdentify()
                    );
                });
    }

    private String createToken(SysUser sysUser, SysRole sysRole) {
        
        Map<String, String> load = new HashMap<>();
        load.put("username", sysUser.getAccount());
        load.put("id", String.valueOf(sysUser.getId()));
        load.put("role", sysRole.getRoleKey());
        String token = JWTUtils.creatToken(load, JwtConstant.EXPIRE_TIME * ignoreWhiteProperties.getH5Timeout());
        
        redisTemplate.opsForValue().set(sysUser.getAccount(), token, ignoreWhiteProperties.getH5Timeout(), TimeUnit.DAYS);
        return token;
    }

    

    public void sendVerificationEmail(String email) {
        
        if (StringUtils.isEmpty(email)) {
            throw new TopicException(ResultCodeEnum.USER_EMAIL_NOT_EXIST);
        }
        
        if (redisTemplate.hasKey(EmailConstant.EMAIL_CODE.getValue() + ":" + email)) {
            throw new TopicException(ResultCodeEnum.USER_EMAIL_CODE_EXIST);
        }
        try {
            emailSendUtils.sendVerificationEmail(email);
        } catch (Exception e) {
            throw new TopicException(ResultCodeEnum.USER_EMAIL_SEND_ERROR);
        }
    }

    

    public void resetPassword(ResetPasswordDto resetPasswordDto) {
        
        LambdaQueryWrapper<SysUser> sysUserLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysUserLambdaQueryWrapper.eq(SysUser::getEmail, resetPasswordDto.getEmail());
        SysUser sysUser = sysUserMapper.selectOne(sysUserLambdaQueryWrapper);
        if (sysUser == null) {
            throw new TopicException(ResultCodeEnum.USER_NOT_EXIST);
        }
        
        Object o = redisTemplate.opsForValue().get(EmailConstant.EMAIL_CODE.getValue() + ":" + resetPasswordDto.getEmail());
        if (o == null) {
            throw new TopicException(ResultCodeEnum.USER_EMAIL_CODE_ERROR);
        }
        String code = o.toString();
        
        if (!code.equals(resetPasswordDto.getCode())) {
            throw new TopicException(ResultCodeEnum.USER_EMAIL_CODE_INPUT_ERROR);
        }
        
        if (!resetPasswordDto.getNewPassword().equals(resetPasswordDto.getPassword())) {
            throw new TopicException(ResultCodeEnum.USER_PASSWORD_ERROR);
        }
        sysUser.setPassword(PasswordUtils.encodePassword(resetPasswordDto.getNewPassword()));
        sysUserMapper.updateById(sysUser);
    }

    

    public void register(RegisterDto registerDto) {
        String email = registerDto.getEmail();
        
        LambdaQueryWrapper<SysUser> sysUserLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysUserLambdaQueryWrapper.eq(SysUser::getEmail, email);
        SysUser sysUser = sysUserMapper.selectOne(sysUserLambdaQueryWrapper);
        if (sysUser != null) {
            throw new TopicException(ResultCodeEnum.USER_EMAIL_EXIST);
        }
        String account = registerDto.getAccount();
        
        LambdaQueryWrapper<SysUser> userLambdaQueryWrapper = new LambdaQueryWrapper<>();
        userLambdaQueryWrapper.eq(SysUser::getAccount, account);
        SysUser sysUserAccount = sysUserMapper.selectOne(userLambdaQueryWrapper);
        if (sysUserAccount != null) {
            throw new TopicException(ResultCodeEnum.USER_ACCOUNT_EXIST);
        }
        
        if (!StringUtils.isEmpty(registerDto.getNickname())) {
            
            LambdaQueryWrapper<SysUser> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.eq(SysUser::getNickname, registerDto.getNickname());
            SysUser sysUserNickname = sysUserMapper.selectOne(queryWrapper);
            if (sysUserNickname != null) {
                throw new TopicException(ResultCodeEnum.USER_NICKNAME_EXIST);
            }
        }
        
        Object o = redisTemplate.opsForValue().get(EmailConstant.EMAIL_CODE.getValue() + ":" + email);
        if (o == null) {
            throw new TopicException(ResultCodeEnum.USER_EMAIL_CODE_ERROR);
        }
        String code = o.toString();
        if (!code.equals(registerDto.getCode())) {
            throw new TopicException(ResultCodeEnum.USER_EMAIL_CODE_INPUT_ERROR);
        }
        
        String password = PasswordUtils.encodePassword(registerDto.getPassword());
        
        SysUser sysUserDb = new SysUser();
        sysUserDb.setAccount(account);
        sysUserDb.setEmail(email);
        sysUserDb.setPassword(password);
        sysUserDb.setNickname(registerDto.getNickname());
        sysUserMapper.insert(sysUserDb);

        
        SysUserRole sysUserRole = new SysUserRole();
        sysUserRole.setUserId(sysUserDb.getId());
        sysUserRole.setRoleId(2L);
        sysUserRoleMapper.insert(sysUserRole);
    }

    

    public List<TopicDataVo> countUserDay7() {
        return sysUserMapper.countUserDay7();
    }
}
