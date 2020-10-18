package com.animeDB.member.controller;

import com.animeDB.member.service.MemberService;
import com.animeDB.member.vo.MemberVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.WebUtils;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

@Controller
public class MemberController {

    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

    @Autowired
    MemberService memberService;
    @Autowired
    BCryptPasswordEncoder pwdEncoder;

    //Login member with their own ID and PW
    @RequestMapping(value = "login", method = RequestMethod.POST)
    public String login(Model m, @RequestParam("id") String userId, @RequestParam("pw") String passwd, @RequestParam(defaultValue = "false") String rememberMe, HttpSession session, HttpServletResponse response) {
        MemberVO mvo = new MemberVO();
        String redirectPage = "";
        String y = "Y";
        String n = "N";
        boolean pwdMatched = false;
        boolean mailAuth = false;
        boolean isMemberDeleted = false;

        try {
            mvo = memberService.login(userId);

            if (mvo != null) {
                pwdMatched = pwdEncoder.matches(passwd, mvo.getPasswd());
                mailAuth = mvo.getUserKey().equals(y);
                isMemberDeleted = mvo.getDeleteYn().equals(n);

                if (pwdMatched && mailAuth && isMemberDeleted) {
                    //Keeping auto login
                    if (rememberMe.equals("true")) {
                        Cookie loginCookie = new Cookie("loginCookie", session.getId());
                        int amount = 60 * 60 * 24 * 7; //7 DAY
                        Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));

                        memberService.keepAutoLogin(userId, session.getId(), sessionLimit);

                        loginCookie.setPath("/");
                        loginCookie.setMaxAge(60*60*24*7);
                        response.addCookie(loginCookie);
                    }
                    mvo.setPasswd("");
                    session.setAttribute("member", mvo);
                    redirectPage = "redirect:";
                } else if (!mailAuth) {
                    redirectPage = "common/alert";
                    m.addAttribute("msg", "メール認証がまだ行っておりません。");
                } else if (!pwdMatched) {
                    redirectPage = "common/alert";
                    m.addAttribute("msg", "該当の会員がございません。");
                } else if (!isMemberDeleted) {
                    redirectPage = "common/alert";
                    m.addAttribute("msg", "既に解除された会員です。");
                }
            } else {
                redirectPage = "common/alert";
                m.addAttribute("msg", "該当の会員がございません。");
            }

        } catch (Exception e) {
            redirectPage = "common/alert";
            logger.error("member - login : " + e.getMessage());
            m.addAttribute("msg", "サーバーエラーが発生しました。");
        }
        return redirectPage;
    }

    //Logout member
    @RequestMapping(value = "logout")
    @ResponseBody
    public HashMap<String, Object> logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        Object object = session.getAttribute("member");
        HashMap<String, Object> map = new HashMap<>();

        try {
            if (object != null) {
                MemberVO mvo = (MemberVO) object;
                session.removeAttribute("member");
                session.invalidate();
                Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
                if (loginCookie != null) {
                    loginCookie.setPath("/");
                    loginCookie.setMaxAge(0);
                    response.addCookie(loginCookie);
                    memberService.keepAutoLogin(mvo.getUserId(), "none", new Date());
                }
                map.put("msg", "ログアウトしました。");
                map.put("result", "Y");
            } else {
                map.put("msg", "サーバーエラーが発生しました。1");
                map.put("result", "N");
            }
        } catch (Exception e) {
            logger.error("member - logout : " + e.getMessage());
            map.put("msg", "サーバーエラーが発生しました。");
            map.put("result", "N");
        }

        return map;
    }

    //Output member profile
    @RequestMapping(value = "member/profile")
    public String memberProfile(HttpSession session, Model model) {
        String redirectPage = null;

        try {
            if (session.getAttribute("member") != null) {
                redirectPage = "member/profile";
            } else {
                model.addAttribute("msg", "不正なアクセスです。");
                model.addAttribute("returnUrl", "/");
                redirectPage = "common/alert";
            }
        } catch (Exception e) {
            logger.error("member - profile : " + e.getMessage());
            model.addAttribute("msg", "サーバーエラーが発生しました。");
        }

        return redirectPage;
    }

    //Output delete member confirm viewing
    @RequestMapping(value = "member/leaveId")
    public String deleteMemberConfirm(HttpSession session, Model model) {
        String redirectPage = null;

        try {
            if (session.getAttribute("member") != null) {
                session.setAttribute("CSRF_TOKEN", UUID.randomUUID().toString());
                redirectPage = "member/leaveId";
            } else {
                model.addAttribute("msg", "不正なアクセスです。");
                model.addAttribute("returnUrl", "/");
                redirectPage = "common/alert";
            }
        } catch (Exception e) {
            logger.error("member - deleteViewing : " + e.getMessage());
            model.addAttribute("msg", "サーバーエラーが発生しました。");
        }

        return redirectPage;

    }

    //Delete member
    @RequestMapping(value = "member/leaveId", method = RequestMethod.POST)
    public String deleteMember(HttpServletRequest request, Model model) {
        String userId = request.getParameter("userId");
        String passwd = request.getParameter("passwd");
        String csrf = request.getParameter("_csrf");

        try {
            if (request.getSession().getAttribute("CSRF_TOKEN").equals(csrf)) {
                if (pwdEncoder.matches(passwd, memberService.selectMember(userId))) {
                    memberService.deleteMember(userId);
                    request.getSession().invalidate();
                    model.addAttribute("msg", "正常に解除しました。\\n今までありがとうございました。");
                    model.addAttribute("returnUrl", "/");
                } else {
                    model.addAttribute("msg", "パスワードが正しくありません。\\nもう一度ご確認ください。");
                }
            } else {
                model.addAttribute("msg", "不正なアクセスです。");
                model.addAttribute("returnUrl", "/");
            }
        } catch (Exception e) {
            logger.error("member - delete : " + e.getMessage());
            model.addAttribute("msg", "サーバーエラーが発生しました。");
        }

        return "common/alert";
    }

    //Output modify member viewing
    @RequestMapping(value = "member/modify")
    public String modifyMember(HttpSession session, Model model) {
        String redirectPage = null;

        try {
            if (session.getAttribute("member") != null) {
                session.setAttribute("CSRF_TOKEN", UUID.randomUUID().toString());
                redirectPage = "member/modifyMember";
            } else {
                model.addAttribute("msg", "不正なアクセスです。");
                model.addAttribute("returnUrl", "/");
                redirectPage = "common/alert";
            }
        } catch (Exception e) {
            logger.error("member - modifyMember : " + e.getMessage());
            model.addAttribute("msg", "サーバーエラーが発生しました。");
        }

        return redirectPage;
    }
}
