package com.hao.topic.system.controller;

import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.hao.topic.api.utils.utils.ExcelUtil;
import com.hao.topic.client.security.SecurityFeignClient;
import com.hao.topic.common.enums.ResultCodeEnum;
import com.hao.topic.common.exception.TopicException;
import com.hao.topic.common.result.Result;
import com.hao.topic.common.utils.StringUtils;
import com.hao.topic.model.dto.system.SysUserDto;
import com.hao.topic.model.dto.system.SysUserListDto;
import com.hao.topic.model.entity.system.SysRole;
import com.hao.topic.model.excel.sytem.SysUserExcel;
import com.hao.topic.model.excel.sytem.SysUserExcelExport;
import com.hao.topic.model.vo.system.SysRoleVo;
import com.hao.topic.system.mapper.SysRoleMapper;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@RestController
@RequestMapping("/system/user")
public class SysUserController {

    @Autowired
    private SecurityFeignClient securityFeignClient;

    @Autowired
    private SysRoleMapper sysRoleMapper;

    

    @GetMapping("/list")
    @PreAuthorize("hasAuthority('admin')")
    public Result<Map<String, Object>> list(SysUserListDto sysUserListDto) {
        Map<String, Object> map = securityFeignClient.list(sysUserListDto);
        return Result.success(map);
    }

    

    @GetMapping("/roleList")
    @PreAuthorize("hasAuthority('admin')")
    public Result<List<SysRoleVo>> roleList() {
        List<SysRole> sysRoles = sysRoleMapper.selectList(null);
        
        List<SysRoleVo> list = sysRoles.stream().map(sysRole -> {
            SysRoleVo sysRoleVo = new SysRoleVo();
            sysRoleVo.setRoleName(sysRole.getName());
            return sysRoleVo;
        }).toList();
        return Result.success(list);
    }

    

    @PostMapping("/add")
    @PreAuthorize("hasAuthority('admin')")
    public Result add(@RequestBody SysUserDto sysUserDto) {
        Boolean result = prepareSysUserDto(sysUserDto);
        if (!result) {
            return Result.fail(ResultCodeEnum.ROLE_NO_EXIST);
        }
        try {
            securityFeignClient.add(sysUserDto);
        } catch (Exception e) {
            throw new TopicException(ResultCodeEnum.ADD_USER_ERROR);

        }
        return Result.success();
    }

    

    @PutMapping("/update")
    @PreAuthorize("hasAuthority('admin')")
    public Result update(@RequestBody SysUserDto sysUserDto) {
        Boolean result = prepareSysUserDto(sysUserDto);
        if (!result) {
            return Result.fail(ResultCodeEnum.ROLE_NO_EXIST);
        }
        securityFeignClient.update(sysUserDto);
        return Result.success();
    }

    

    private Boolean prepareSysUserDto(SysUserDto sysUserDto) {
        
        LambdaQueryWrapper<SysRole> sysRoleLambdaQueryWrapper = new LambdaQueryWrapper<>();
        sysRoleLambdaQueryWrapper.eq(SysRole::getName, sysUserDto.getRoleName());
        SysRole sysRole = sysRoleMapper.selectOne(sysRoleLambdaQueryWrapper);
        if (StringUtils.isNull(sysRole)) {
            return false;
        }
        
        if (sysRole.getIdentify() == 1) {
            
            LocalDateTime now = LocalDateTime.now();
            sysUserDto.setMemberTime(now);  
        }
        
        sysUserDto.setRoleId(sysRole.getId());
        return true;
    }

    

    @DeleteMapping("/delete/{ids}")
    @PreAuthorize("hasAuthority('admin')")
    public Result delete(@PathVariable Long[] ids) {
        securityFeignClient.delete(ids);
        return Result.success();
    }

    

    @GetMapping("/export/{ids}")
    public void exportExcel(HttpServletResponse response, SysUserListDto sysUserListDto, @PathVariable Long[] ids) {
        List<SysUserExcelExport> sysUserExcelExports = securityFeignClient.getExcelVo(sysUserListDto, ids);
        if (CollectionUtils.isEmpty(sysUserExcelExports)) {
            throw new TopicException(ResultCodeEnum.EXPORT_ERROR);
        }
        
        try {
            ExcelUtil.download(response, sysUserExcelExports, SysUserExcelExport.class);
        } catch (IOException e) {
            throw new TopicException(ResultCodeEnum.EXPORT_ERROR);
        }
    }

    

    @PostMapping("/import")
    public Result<String> importExcel(@RequestParam("file") MultipartFile multipartFile, @RequestParam("updateSupport") Boolean updateSupport) {
        try {
            List<SysUserExcel> excelVoList = EasyExcel.read(multipartFile.getInputStream())
                    
                    .head(SysUserExcel.class)
                    
                    .sheet()
                    
                    .doReadSync();
            
            String s = securityFeignClient.importExcel(excelVoList, updateSupport);
            return Result.success(s);
        } catch (Exception e) {
            
            System.out.println("Exception message: " + e.getMessage());
            
            String regex = "\"message\":\"(.*?)\"";
            Pattern pattern = Pattern.compile(regex);
            Matcher matcher = pattern.matcher(e.getMessage());
            System.out.println(matcher);
            if (matcher.find()) {
                return Result.fail(matcher.group(1), ResultCodeEnum.IMPORT_ERROR);
            } else {
                
                return Result.fail(e.getMessage(), ResultCodeEnum.IMPORT_ERROR);
            }
        }
    }

    

    @GetMapping("/template")
    public void getExcelTemplate(HttpServletResponse response) {
        
        List<SysUserExcel> excelVoList = new ArrayList<>();
        
        SysUserExcel excelVo = new SysUserExcel();
        
        excelVoList.add(excelVo);
        try {
            
            ExcelUtil.download(response, excelVoList, SysUserExcel.class);
        } catch (IOException e) {
            throw new TopicException(ResultCodeEnum.DOWNLOAD_ERROR);
        }

    }

}
