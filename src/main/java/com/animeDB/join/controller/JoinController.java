package com.animeDB.join.controller;

import com.animeDB.common.vo.MemberVO;
import com.animeDB.join.service.JoinService;
import com.animeDB.common.service.MailService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Locale;
import java.util.UUID;

@Controller
@RequestMapping(value = "/signup")
public class JoinController {

    private static final Logger logger = LoggerFactory.getLogger(JoinController.class);

    @Autowired
    JoinService joinService;

    @Autowired
    MailService mailSendService;

    @Autowired
    MessageSource messageSource;

    //Output checking agree display before output inputting new member information to join
    @RequestMapping(value = "/newSign")
    public String newJoin() {
        return "join/agree";
    }

    //Output display that inputting new member information
    @RequestMapping(value = "/confirm")
    public String insertNewMember() {
        return "join/confirm";
    }

    //Checking userId if it's duplicated
    @RequestMapping(value = "/check_id", method = RequestMethod.GET)
    @ResponseBody
    public HashMap<String, Object> checkId(String userId, Locale locale) {
        HashMap<String, Object> response = new HashMap<>();
        try {
            if (joinService.checkId(userId) <= 0) {
                response.put("result", "pass");
                response.put("msg", messageSource.getMessage("signup.checkUnusedId", null, locale));
            } else {
                response.put("result", "used");
                response.put("msg", messageSource.getMessage("alert.redundantId", null, locale));
            }
        } catch (Exception e) {
            logger.error("join - checkId : " + e.getMessage());
            response.put("result", "error");
            response.put("msg", messageSource.getMessage("alert.serverError", null, locale));
        }
        return response;
    }

    //Checking email if it's duplicated
    @RequestMapping(value = "/check_email", method = RequestMethod.GET)
    @ResponseBody
    public HashMap<String, Object> checkEmail(String email, Locale locale) {
        HashMap<String, Object> response = new HashMap<>();
        try {
            if (joinService.checkEmail(email) <= 0) {
                response.put("result", "pass");
            } else {
                response.put("result", "used");
                response.put("msg", messageSource.getMessage("alert.redundantEmail", null, locale));
            }
        } catch (Exception e) {
            logger.error("join - checkEmail : " + e.getMessage());
            response.put("result", "error");
            response.put("msg", messageSource.getMessage("alert.serverError", null, locale));
        }
        return response;
    }

    //Inserting new member to DB and return join complete display
    @RequestMapping(value = "/confirm", method = RequestMethod.POST)
    public String insertNewMember(MemberVO mvo, Model m, HttpServletRequest request, Locale locale) {
        String redirectPage = "";
        String[] birthday = new String[]
                {request.getParameter("birthYear"), request.getParameter("birthMonth"), request.getParameter("birthDay")};
        try {
            joinService.insertNewMember(mvo, birthday);
            mailSendService.mailSendWithUserKey(mvo.getEmail(), mvo.getUserId(), mvo.getNickname(),mvo.getUserKey(), request, locale);
            redirectPage = "join/complete";
        } catch (Exception e) {
            logger.error("join - insertNewMember : " + e.getMessage());
            m.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            redirectPage = "common/alert";
        }

        return redirectPage;
    }

    //Complete to authenticate new member with email
    @RequestMapping(value = "/key_alter", method = RequestMethod.GET)
    public String keyAlterConfirm(@RequestParam String userid, @RequestParam String key, Model m, Locale locale) throws IOException {
        try {
            HashMap<String, Object> map = new HashMap<>();

            map.put("userId", userid);
            map.put("userKey", key);

            if (joinService.AlterUserKey(map) >= 1) {
                m.addAttribute("msg", messageSource.getMessage("alert.mailAuthen", null, locale));
            } else {
                m.addAttribute("msg", messageSource.getMessage("alert.alreadyMailAuthen", null, locale));
            }

        } catch (Exception e) {
            logger.error("join - keyAlterConfirm : " + e.getMessage());
            m.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
        }
        m.addAttribute("returnUrl", "/");
        return "common/alert";
    }
}
