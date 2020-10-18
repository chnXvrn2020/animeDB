package com.animeDB.join.dao;

import com.animeDB.join.vo.JoinVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;

@Repository
public class JoinDaoImpl implements JoinDao {

    @Autowired
    SqlSessionTemplate sqlSession;

    private static String JOIN_MEMBER = "com.animeDB.joinMember.";

    @Override
    public int selectUserId(String userId) {
        return sqlSession.selectOne(JOIN_MEMBER + "checkId", userId);
    }

    @Override
    public int selectEmail(String email) {
        return sqlSession.selectOne(JOIN_MEMBER + "checkEmail", email);
    }

    @Override
    public void insertNewMember(JoinVO jvo) {
        sqlSession.insert(JOIN_MEMBER + "insertNewMember", jvo);
    }

    @Override
    public int updateUserKey(HashMap<String, Object> map) {
        return sqlSession.update(JOIN_MEMBER + "updateUserKey", map);
    }
}
