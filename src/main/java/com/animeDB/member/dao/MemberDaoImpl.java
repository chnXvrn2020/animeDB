package com.animeDB.member.dao;

import com.animeDB.member.vo.MemberVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.HashMap;

@Repository
public class MemberDaoImpl implements MemberDao {

    @Autowired
    SqlSessionTemplate sqlSession;

    private static String MEMBER = "com.animeDB.member.";

    @Override
    public MemberVO login(String userId) {
        return sqlSession.selectOne(MEMBER + "login", userId);
    }

    @Override
    public MemberVO checkUserWithSessionKey(String value) {
        return sqlSession.selectOne(MEMBER + "checkUserWithSessionKey", value);
    }

    @Override
    public void renewalLimit(HashMap<String, Object> map) {
        sqlSession.update(MEMBER + "renewalLimit", map);
    }

    @Override
    public void keepAutoLogin(HashMap<String, Object> map) {
        sqlSession.update(MEMBER + "keepAutoLogin", map);
    }

    @Override
    public String selectMember(String userId) {
        return sqlSession.selectOne(MEMBER + "selectMember", userId);
    }

    @Override
    public void deleteMember(String userId) {
        sqlSession.update(MEMBER + "deleteMember", userId);
    }
}
