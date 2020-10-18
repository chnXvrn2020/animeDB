package com.animeDB.join.dao;

import com.animeDB.join.vo.JoinVO;

import java.util.HashMap;

public interface JoinDao {
    int selectUserId(String userId);
    int selectEmail(String email);
    void insertNewMember(JoinVO jvo);
    int updateUserKey(HashMap<String, Object> map);
}
