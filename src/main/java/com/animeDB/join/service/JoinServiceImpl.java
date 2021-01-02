package com.animeDB.join.service;

import com.animeDB.common.vo.MemberVO;
import com.animeDB.join.dao.JoinDao;
import com.animeDB.util.Utils;
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
    public void insertNewMember(MemberVO mvo, String[] birthday) {
        mvo.setPasswd(pwdEncoder.encode(mvo.getPasswd()));
        mvo.setPhone(Utils.phoneNumberWithHyphen(mvo.getPhone()));
        mvo.setBirthday(Utils.mergeBirthday(birthday[0], birthday[1], birthday[2]));
        mvo.setUserKey(Utils.randomUserKey(false,20));
        joinDao.insertNewMember(mvo);
    }

    @Override
    public int AlterUserKey(HashMap<String, Object> map) {
        return joinDao.updateUserKey(map);
    }
}
