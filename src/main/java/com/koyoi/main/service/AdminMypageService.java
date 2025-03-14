package com.koyoi.main.service;

import com.koyoi.main.mapper.AdminMypageMapper;
import com.koyoi.main.vo.AdminMypageVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminMypageService {

    @Autowired
    private AdminMypageMapper adminMypageMapper;

    // 회원 목록 조회
    public List<AdminMypageVO> getAllUsers() {
        return adminMypageMapper.getAllUsers();
    }

    // 상담사 목록 조회
    public List<AdminMypageVO> getAllCounselors() {
        return adminMypageMapper.getAllCounselors();
    }

    public AdminMypageVO getUserById(String userId) {
        return adminMypageMapper.getUserById(userId);
    }

    public int updateUser(AdminMypageVO user) {
        return adminMypageMapper.updateUser(user);
    }
}
