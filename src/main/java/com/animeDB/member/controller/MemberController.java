package com.animeDB.member.controller;

import com.animeDB.common.vo.MemberAttachmentVO;
import com.animeDB.member.service.MemberService;
import com.animeDB.common.vo.MemberVO;
import com.animeDB.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Locale;
import java.util.UUID;

@Controller
public class MemberController {

    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

    @Autowired
    MemberService memberService;

    @Autowired
    BCryptPasswordEncoder pwdEncoder;

    @Autowired
    MessageSource messageSource;

    //Login member with their own ID and PW
    @RequestMapping(value = "login", method = RequestMethod.POST)
    public String login(Model m, @RequestParam("id") String userId, @RequestParam("pw") String passwd, @RequestParam(defaultValue = "false") String rememberMe, HttpSession session, HttpServletResponse response, HttpServletRequest request, Locale locale) {
        String redirectPage = "redirect:" + request.getHeader("Referer");
        try {
            MemberVO mvo = memberService.selectMemberInfo(userId);

            if (mvo != null) {
                boolean pwdMatched = pwdEncoder.matches(passwd, mvo.getPasswd());
                boolean mailAuth = mvo.getUserKey().equals("Y");
                boolean isMemberDeleted = mvo.getDeleteYn().equals("N");

                if (pwdMatched && mailAuth && isMemberDeleted) {
                    MemberAttachmentVO mavo = memberService.selectMemberAttachment(mvo.getIdx());
                    //Keeping auto login
                    if (rememberMe.equals("true")) {
                        Cookie loginCookie = new Cookie("loginCookie", session.getId());

                        memberService.keepAutoLogin(mvo.getIdx(), session.getId(), Utils.checkBrowser(request));

                        loginCookie.setPath("/");
                        loginCookie.setMaxAge(60*60*24*7);
                        response.addCookie(loginCookie);
                    }
                    mvo.setPasswd("");
                    session.setAttribute("member", mvo);
                    session.setAttribute("memberAttachment", mavo);
                    if (session.getAttribute("prevPage") != null) {
                        redirectPage = "redirect:" + session.getAttribute("prevPage");
                        session.removeAttribute("prevPage");
                    }
                } else if (!mailAuth) {
                    m.addAttribute("msg", messageSource.getMessage("signin.notAuthenMail", null, locale));
                    return "common/alert";
                } else if (!pwdMatched) {
                    m.addAttribute("msg", messageSource.getMessage("signin.noMember", null, locale));
                    return "common/alert";
                } else if (!isMemberDeleted) {
                    m.addAttribute("msg", messageSource.getMessage("signin.deleted", null, locale));
                    return "common/alert";
                }
            } else {
                m.addAttribute("msg", messageSource.getMessage("signin.noMember", null, locale));
                return "common/alert";
            }
        } catch (Exception e) {
            logger.error("member - login : " + e.getMessage());
            m.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }
        return redirectPage;
    }

    //Logout member
    @RequestMapping(value = "logout")
    @ResponseBody
    public HashMap<String, Object> logout(HttpSession session, HttpServletRequest request, HttpServletResponse response, Locale locale) {
        MemberVO mvo = (MemberVO) session.getAttribute("member");
        HashMap<String, Object> map = new HashMap<>();

        try {
            if (mvo != null) {
                memberService.logout(session, request, response, mvo.getIdx());
                map.put("msg", messageSource.getMessage("alert.signOut", null, locale));
                map.put("result", "Y");
            } else {
                map.put("msg", messageSource.getMessage("alert.serverError", null, locale));
                map.put("result", "N");
            }
        } catch (Exception e) {
            logger.error("member - logout : " + e.getMessage());
            map.put("msg", messageSource.getMessage("alert.serverError", null, locale));
            map.put("result", "N");
        }

        return map;
    }

    //Output member profile
    @RequestMapping(value = "member/profile")
    public String memberProfile(HttpSession session, Model model, Locale locale) {
        try {
            if (session.getAttribute("member") == null) {
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", "/");
                return "common/alert";
            }
        } catch (Exception e) {
            logger.error("member - profile : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }

        return "member/profile";
    }

    //Output delete member confirm viewing
    @RequestMapping(value = "member/leaveId")
    public String deleteMember(HttpSession session, Model model, Locale locale) {
        try {
            if (session.getAttribute("member") != null) {
                session.setAttribute("CSRF_TOKEN", UUID.randomUUID().toString());
            } else {
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", "/");
                return "common/alert";
            }
        } catch (Exception e) {
            logger.error("member - deleteViewing : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }

        return "member/leaveId";

    }

    //Delete member
    @RequestMapping(value = "member/leaveId", method = RequestMethod.POST)
    public String deleteMember(HttpServletRequest request, Model model, Locale locale) {
        MemberVO sessionMember = (MemberVO)request.getSession().getAttribute("member");
        String passwd = request.getParameter("passwd");
        String csrf = request.getParameter("_csrf");

        try {
            if (request.getSession().getAttribute("CSRF_TOKEN").equals(csrf)) {
                if (pwdEncoder.matches(passwd, memberService.selectMemberPwd(sessionMember.getUserId()))) {
                    memberService.deleteMember(sessionMember.getIdx());
                    request.getSession().invalidate();
                    model.addAttribute("msg", messageSource.getMessage("alert.deleteSuccess", null, locale));
                    model.addAttribute("returnUrl", "/");
                } else {
                    model.addAttribute("msg", messageSource.getMessage("alert.deleteFail", null, locale));
                }
            } else if (request.getSession().getAttribute("CSRF_TOKEN") == null){
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", "/");
            }
        } catch (Exception e) {
            logger.info("member - delete : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
        }

        return "common/alert";
    }

    //Output modify member viewing
    @RequestMapping(value = "member/modify")
    public String modifyMember(HttpSession session, Model model, Locale locale) {
        try {
            if (session.getAttribute("member") != null) {
                session.setAttribute("CSRF_TOKEN", UUID.randomUUID().toString());
            } else {
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", "/");
                return "common/alert";
            }
        } catch (Exception e) {
            logger.info("member - modifyMember : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }

        return "member/modifyMember";
    }

    //Complete to modify member and update DB
    @RequestMapping(value = "member/modify", method = RequestMethod.POST)
    public String modifyMember(MemberVO mvo, HttpSession session, HttpServletRequest request, @RequestParam MultipartFile memberImageFile, Model model, Locale locale) {
        MemberAttachmentVO mavo = new MemberAttachmentVO();
        String csrf = request.getParameter("_csrf");
        String deleteImageYn = request.getParameter("deleteImageYn");

        if (!Utils.checkReferer(request)) return null;

        try {
            if (session.getAttribute("CSRF_TOKEN").equals(csrf)) {
                MemberVO sessionMember = (MemberVO) session.getAttribute("member");
                mvo.setIdx(sessionMember.getIdx());
                if (deleteImageYn.equals("Y")) {
                    mavo.setAttachment("delete");
                    mavo.setAttachmentOrg("delete");
                }
                memberService.updateMember(mvo, mavo, memberImageFile);
                session.setAttribute("member", memberService.selectMemberInfo(sessionMember.getUserId()));
                session.setAttribute("memberAttachment", memberService.selectMemberAttachment(sessionMember.getIdx()));
                session.removeAttribute("CSRF_TOKEN");
                model.addAttribute("msg", messageSource.getMessage("alert.memberChange", null, locale));
                model.addAttribute("returnUrl", "/member/profile");
            } else if (session.getAttribute("CSRF_TOKEN") == null){
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", "/");
            }
        } catch (Exception e) {
            logger.info("member - modifyMember : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
        }

        return "common/alert";
    }

    @RequestMapping(value = "member/signIn")
    public String signIn(HttpSession session, HttpServletRequest request) {
        session.setAttribute("prevPage", request.getHeader("Referer"));
        return "common/signIn";
    }
}
