package com.koyoi.main.controller;

import com.koyoi.main.mapper.AdminMypageMapper;
import com.koyoi.main.service.AdminMypageService;
import com.koyoi.main.vo.AdminMypageVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class AdminMypageC {

    @Autowired
    private AdminMypageService adminMypageService;

    @GetMapping("/admin")
    public String admin(Model model) {

        model.addAttribute("users", adminMypageService.getAllUsers());
        model.addAttribute("counselors", adminMypageService.getAllCounselors());
        return "adminmypage/adminmypage";

    }

    @GetMapping("/admin/userDetail")
    @ResponseBody
    public AdminMypageVO userDetail(String userId) {
        return adminMypageService.getUserById(userId);
    }

    @PostMapping("/admin/updateUser")
    @ResponseBody
    public boolean updateUser(AdminMypageVO user) {
        return adminMypageService.updateUser(user) > 0;
    }





}
