package com.animeDB.join.service;

import com.animeDB.join.vo.JoinVO;

import java.util.HashMap;

public interface JoinService {
    int checkId(String userId);
    int checkEmail(String email);
    void insertNewMember(JoinVO jvo);
    int AlterUserKey(HashMap<String, Object> map);
}
