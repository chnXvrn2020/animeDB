package com.animeDB.join.service;

import com.animeDB.join.dao.JoinDao;
import com.animeDB.join.vo.JoinVO;
import com.animeDB.util.utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class JoinServiceImpl implements JoinService {

    @Autowired
    JoinDao joinDao;
    @Autowired
    BCryptPasswordEncoder pwdEncoder;

    @Override
    public int checkId(String userId) {
        return joinDao.selectUserId(userId);
    }

    @Override
    public int checkEmail(String email) {
        return joinDao.selectEmail(email);
    }

    @Override
    public void insertNewMember(JoinVO jvo) {
        jvo.setPasswd(pwdEncoder.encode(jvo.getPasswd()));
        jvo.setPhone(utils.phoneNumberWithHyphen(jvo.getPhone()));
        jvo.setAddr1(utils.postNumberWithHyphen(jvo.getAddr1()));
        jvo.setBirthday(utils.mergeBirthday(jvo.getBirthYear(), jvo.getBirthMonth(), jvo.getBirthday()));
        jvo.setUserKey(utils.randomUserKey(false,20));
        joinDao.insertNewMember(jvo);
    }

    @Override
    public int AlterUserKey(HashMap<String, Object> map) {
        return joinDao.updateUserKey(map);
    }
}
