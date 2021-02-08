package com.animeDB.admin.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Locale;

@Controller
@RequestMapping(value = "/admin")
public class AdminMainController {
    //Output main admin window
    @RequestMapping(value = {"/", ""})
    public String adminMain(HttpServletRequest request, Model m, Locale locale) {
        return "admin/main/main";
    }
}
