package com.hao.topic.client.security;

import com.hao.topic.common.auth.TokenInterceptor;
import com.hao.topic.model.dto.ai.AiUserDto;
import com.hao.topic.model.dto.system.SysUserDto;
import com.hao.topic.model.dto.system.SysUserListDto;
import com.hao.topic.model.entity.system.SysUser;
import com.hao.topic.model.excel.sytem.SysUserExcel;
import com.hao.topic.model.excel.sytem.SysUserExcelExport;
import com.hao.topic.model.vo.topic.TopicDataVo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.cloud.openfeign.SpringQueryMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@FeignClient(name = "topic-security", configuration = TokenInterceptor.class)
public interface SecurityFeignClient {

    

    @GetMapping("/security/user/list")
    Map<String, Object> list(@SpringQueryMap SysUserListDto sysUserListDto);

    

    @PostMapping("/security/user/add")
    void add(@RequestBody SysUserDto sysUserDto);

    

    @PostMapping("/security/user/update")
    void update(@RequestBody SysUserDto sysUserDto);

    

    @DeleteMapping("/security/user/delete/{ids}")
    void delete(@PathVariable Long[] ids);

    

    @GetMapping("/security/user/getByRoleId/{roleId}")
    Boolean getByRoleId(@PathVariable Long roleId);

    

    @GetMapping("/security/user/export/{ids}")
    List<SysUserExcelExport> getExcelVo(SysUserListDto sysUserListDto, @PathVariable Long[] ids);

    

    @PostMapping("/security/user/import")
    String importExcel(@RequestBody List<SysUserExcel> excelVoList, @RequestParam("updateSupport") Boolean updateSupport);

    @GetMapping("/security/user/count/{date}")
    public Long countDate(@PathVariable String date);

    @GetMapping("/security/user/count")
    public Long count();

    @GetMapping("/security/user/countUserDay7")
    List<TopicDataVo> countUserDay7();
    @GetMapping("/security/user/getAllUser")
    public List<SysUser> getAllUser();
}
