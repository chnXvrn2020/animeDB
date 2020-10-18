package com.animeDB.interceptor;

import com.animeDB.member.service.MemberService;
import com.animeDB.member.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.Date;

public class MemberLoginInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    MemberService memberService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        HttpSession session = request.getSession();
        Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
        if (loginCookie != null) {
            MemberVO mvo = memberService.checkUserWithSessionKey(loginCookie.getValue());
            if (mvo != null) {
                Date date = new Date();
                Timestamp timestamp = new Timestamp(date.getTime());
                if (mvo.getSessionLimit().after(timestamp)) {
                    int amount = 60 * 60 * 24 * 7; //7 DAY
                    Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));
                    memberService.renewalLimit(mvo.getUserId(), loginCookie.getValue(), sessionLimit);
                    mvo.setPasswd("");
                    session.setAttribute("member", mvo);
                } else {
                    memberService.logout(session, request, response);
                }
            }
        }
        return true;
    }
}
