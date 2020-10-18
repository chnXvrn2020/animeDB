package com.animeDB.member.service;

import com.animeDB.member.dao.MemberDao;
import com.animeDB.member.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    MemberDao memberDao;

    @Override
    public MemberVO login(String userId) {
        return memberDao.login(userId);
    }

    @Override
    public void keepAutoLogin(String userId, String sessionKey, Date sessionLimit) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("userId", userId);
        map.put("sessionKey", sessionKey);
        map.put("sessionLimit", sessionLimit);
        memberDao.keepAutoLogin(map);
    }

    @Override
    public MemberVO checkUserWithSessionKey(String value) {
        return memberDao.checkUserWithSessionKey(value);
    }

    @Override
    public void renewalLimit(String userId, String sessionId, Date sessionLimit) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("userId", userId);
        map.put("value", sessionId);
        map.put("sessionLimit", sessionLimit);
        memberDao.renewalLimit(map);
    }

    @Override
    public void logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        session.removeAttribute("member");
    }

    @Override
    public String selectMember(String userId) {
        return memberDao.selectMember(userId);
    }

    @Override
    public void deleteMember(String userId) {
        memberDao.deleteMember(userId);
    }
}
