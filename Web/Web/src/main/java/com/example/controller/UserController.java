package com.example.controller;

import com.example.common.Result;

import com.example.entity.Smart;
import com.example.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/smart")
public class UserController {

    @Resource
    private UserService userService;

    // 新增用户
    @PostMapping
    public Result add(@RequestBody Smart smart) {
        userService.save(smart);
        return Result.success();
    }

    // 修改用户
    @PutMapping
    public Result update(@RequestBody Smart smart) {
        userService.save(smart);
        return Result.success();
    }

    // 删除用户
    @DeleteMapping("/{id}")
    public void delete(@PathVariable("id") Long id) {
        userService.delete(id);
    }

    // 根据id查询用户
    @GetMapping("/{id}")
    public Result<Smart> findById(@PathVariable Long id) {
        return Result.success(userService.findById(id));
    }

    // 查询所有用户
    @GetMapping
    public Result<List<Smart>> findAll() {
        return Result.success(userService.findAll());
    }

    // 分页查询用户
    @GetMapping("/page")
    public Result<Page<Smart>> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                                       @RequestParam(defaultValue = "10") Integer pageSize,
                                       @RequestParam(required = false) String name) {
        return Result.success(userService.findPage(pageNum, pageSize, name));
    }

}
