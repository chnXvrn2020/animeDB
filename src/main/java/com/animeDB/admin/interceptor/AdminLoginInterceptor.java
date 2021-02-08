package com.animeDB.admin.interceptor;

import com.animeDB.common.vo.MemberVO;
import com.animeDB.util.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.Locale;

public class AdminLoginInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    MessageSource messageSource;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        SessionLocaleResolver sessionLocale = new SessionLocaleResolver();
        Locale locale = sessionLocale.resolveLocale(request);
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("member");
        PrintWriter out = response.getWriter();

        if (!Utils.checkPc(request)) {
            response.setContentType("text/html; charset=UTF-8");
            out.println("<script>alert('" + messageSource.getMessage("alert.adminOnMobile", null, locale) + "');history.go(-1);</script>");
            out.flush();
            return false;
        }

        if (mvo == null || !mvo.getRole().equals("admin")) {
            response.setContentType("text/html; charset=UTF-8");
            out.println("<script>alert('" + messageSource.getMessage("alert.noAuthority", null, locale) + "');history.go(-1);</script>");
            out.flush();
            return false;
        }
        return true;
    }
}
