package com.example.service;

import com.example.dao.UserRepository;
import com.example.entity.Smart;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class UserService {

    @Resource
    private UserRepository userRepository;

    public void save(Smart smart) {
        String now = new SimpleDateFormat("yyyy/MM/dd").format(new Date());
        smart.setCreateTime(now);
        userRepository.save(smart);
    }

    public void delete(Long id) {
        userRepository.deleteById(id);
    }

    public Smart findById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    public List<Smart> findAll() {
        return userRepository.findAll();
    }

    public Page<Smart> findPage(Integer pageNum, Integer pageSize, String name) {
         //构建分页查询条件
        Sort sort = Sort.by(Sort.Direction.DESC, "create_time");
        Pageable pageRequest = PageRequest.of(pageNum - 1, pageSize,sort);
        return userRepository.findByNameLike(name, pageRequest);
    }
}
