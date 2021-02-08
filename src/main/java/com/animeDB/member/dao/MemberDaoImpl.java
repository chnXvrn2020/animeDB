package com.animeDB.member.dao;

import com.animeDB.common.vo.MemberAttachmentVO;
import com.animeDB.common.vo.MemberVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;

@Repository
public class MemberDaoImpl implements MemberDao {

    @Autowired
    SqlSessionTemplate sqlSession;

    private final String MEMBER = "com.animeDB.member.";

    @Override
    public MemberVO selectMemberInfo(String userId) {
        return sqlSession.selectOne(MEMBER + "selectMemberInfo", userId);
    }

    @Override
    public MemberAttachmentVO selectMemberAttachment(int userIdx) {
        return sqlSession.selectOne(MEMBER + "selectMemberAttachment", userIdx);
    }

    @Override
    public MemberVO checkUserWithSessionKey(HashMap<String, Object> map) {
        return sqlSession.selectOne(MEMBER + "checkUserWithSessionKey", map);
    }

    @Override
    public void updateSessionLimit(HashMap<String, Object> map) {
        sqlSession.update(MEMBER + "updateSessionLimit", map);
    }

    @Override
    public void keepAutoLogin(HashMap<String, Object> map) {
        sqlSession.insert(MEMBER + "keepAutoLogin", map);
    }

    @Override
    public void deleteSession(HashMap<String, Object> map) {
        sqlSession.delete(MEMBER + "deleteSession", map);
    }

    @Override
    public String selectMemberPwd(String userId) {
        return sqlSession.selectOne(MEMBER + "selectMemberPwd", userId);
    }

    @Override
    public void deleteMember(int idx) {
        sqlSession.update(MEMBER + "deleteMember", idx);
    }

    @Override
    public void updateMember(MemberVO mvo) {
        sqlSession.update(MEMBER + "updateMember", mvo);
    }

    @Override
    public void insertMemberAttachment(MemberAttachmentVO mavo) {
        sqlSession.insert(MEMBER + "insertMemberAttachment", mavo);
    }

    @Override
    public void updateMemberAttachment(int userIdx) {
        sqlSession.update(MEMBER + "updateMemberAttachment", userIdx);
    }

    @Override
    public void deleteAllSession(int idx) {
        sqlSession.delete(MEMBER + "deleteAllSession", idx);
    }
}
