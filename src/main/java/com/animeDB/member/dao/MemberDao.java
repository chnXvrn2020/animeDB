package com.animeDB.member.dao;

import com.animeDB.member.vo.MemberVO;

import java.util.Date;
import java.util.HashMap;

public interface MemberDao {
    MemberVO login(String userId);
    MemberVO checkUserWithSessionKey(String value);
    void renewalLimit(HashMap<String, Object> map);
    void keepAutoLogin(HashMap<String, Object> map);
    String selectMember(String userId);
    void deleteMember(String userId);
}
