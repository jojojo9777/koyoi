package com.koyoi.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HabitC {
    @GetMapping("/habit")
    public String habit() {
        return "habit/habit";
    }

}

