package com.animeDB.join.controller;

import com.animeDB.join.service.JoinService;
import com.animeDB.join.vo.JoinVO;
import com.animeDB.mailSender.MailSendService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;

@Controller
public class JoinController {

    private static final Logger logger = LoggerFactory.getLogger(JoinController.class);

    @Autowired
    JoinService joinService;

    @Autowired
    MailSendService mailSendService;

    //Output checking agree display before output inputting new member information to join
    @RequestMapping(value = "/join/new_join")
    public String newJoin() {
        return "join/agree";
    }

    //Output display that inputting new member information
    @RequestMapping(value = "join/confirm")
    public String inputNewMember() {
        return "join/confirm";
    }

    //Checking userId if it's duplicated
    @RequestMapping(value = "join/check_id", method = RequestMethod.GET)
    @ResponseBody
    public HashMap<String, Object> checkId(String userId) {
        HashMap<String, Object> response = new HashMap<>();
        try {
            if (joinService.checkId(userId) <= 0) {
                response.put("result", "pass");
                response.put("msg", "ご利用できるIDです。");
            } else {
                response.put("result", "duple");
                response.put("msg", "既に使用中のIDです。");
            }
        } catch (Exception e) {
            logger.error("join - checkId : " + e.getMessage());
            response.put("result", "error");
            response.put("msg", "サーバーエラーが発生しました。");
        }
        return response;
    }

    //Checking email if it's duplicated
    @RequestMapping(value = "join/check_email", method = RequestMethod.GET)
    @ResponseBody
    public HashMap<String, Object> checkEmail(String email) {
        HashMap<String, Object> response = new HashMap<>();
        try {
            if (joinService.checkEmail(email) <= 0) {
                response.put("result", "pass");
            } else {
                response.put("result", "duple");
                response.put("msg", "既に使用中のメールアドレスです。");
            }
        } catch (Exception e) {
            logger.error("join - checkEmail : " + e.getMessage());
            response.put("result", "error");
            response.put("msg", "サーバーエラーが発生しました。");
        }
        return response;
    }

    //Inserting new member to DB and return join complete display
    @RequestMapping(value = "join/confirm", method = RequestMethod.POST)
    public String insertNewMember(JoinVO jvo, Model m, HttpServletRequest request) {
        String redirectPage = "";
        try {
            joinService.insertNewMember(jvo);
            mailSendService.mailSendWithUserKey(jvo.getEmail(), jvo.getUserId(), jvo.getNickname(),jvo.getUserKey(), request);
            redirectPage = "join/complete";
        } catch (Exception e) {
            logger.error("join - insertNewMember : " + e.getMessage());
            m.addAttribute("msg", "サーバーエラーが発生しました。");
            redirectPage = "common/alert";
        }

        return redirectPage;
    }

    //Complete to authenticate new member with email
    @RequestMapping(value = "/join/key_alter", method = RequestMethod.GET)
    public String keyAlterConfirm(@RequestParam String userid, @RequestParam String key, Model m) throws IOException {
        try {
            HashMap<String, Object> map = new HashMap<>();

            map.put("userId", userid);
            map.put("userKey", key);

            if (joinService.AlterUserKey(map) >= 1) {
                m.addAttribute("msg", "認証が完了されました。これからログインができます。");
            } else {
                m.addAttribute("msg", "既に認証しました。");
            }

        } catch (Exception e) {
            logger.error("join - keyAlterConfirm : " + e.getMessage());
            m.addAttribute("msg", "サーバーエラーが発生しました。");
        }
        m.addAttribute("returnUrl", "/");

        return "common/alert";
    }
}
