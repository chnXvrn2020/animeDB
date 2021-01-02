package com.animeDB.join.dao;

import com.animeDB.common.vo.MemberVO;

import java.util.HashMap;

public interface JoinDao {
    int selectUserId(String userId);
    int selectEmail(String email);
    void insertNewMember(MemberVO mvo);
    int updateUserKey(HashMap<String, Object> map);
}
