package com.animeDB.member.service;

import com.animeDB.member.vo.MemberVO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;

public interface MemberService {
    MemberVO login(String userId);
    void keepAutoLogin(String userId, String sessionKey, Date sessionLimit);
    MemberVO checkUserWithSessionKey(String value);
    void renewalLimit(String userId, String sessionId, Date sessionLimit);
    void logout(HttpSession session, HttpServletRequest request, HttpServletResponse response);
    String selectMember(String userId);
    void deleteMember(String userId);
}
