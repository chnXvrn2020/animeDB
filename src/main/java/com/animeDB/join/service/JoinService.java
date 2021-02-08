package com.animeDB.join.service;

import com.animeDB.common.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.util.HashMap;

public interface JoinService {
    int checkId(String userId);
    int checkEmail(String email);
    void insertNewMember(MemberVO mvo, String birthday);
    int AlterUserKey(HashMap<String, Object> map);
}
