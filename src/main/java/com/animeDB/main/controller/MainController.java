package com.animeDB.main.controller;

import com.animeDB.member.controller.MemberController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import javax.servlet.http.HttpServletRequest;
import java.util.Locale;

@Controller
public class MainController {
    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

    @Autowired
    SessionLocaleResolver localeResolver;

    @Autowired
    MessageSource messageSource;

    //Output main
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String main() {
        return "main/main";
    }

}
