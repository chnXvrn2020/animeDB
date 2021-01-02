package com.animeDB.member.dao;

import com.animeDB.common.vo.MemberAttachmentVO;
import com.animeDB.common.vo.MemberVO;
import java.util.HashMap;

public interface MemberDao {
    MemberVO selectMemberInfo(String userId);
    MemberAttachmentVO selectMemberAttachment(int userIdx);
    MemberVO checkUserWithSessionKey(HashMap<String, Object> map);
    void updateSessionLimit(HashMap<String, Object> map);
    void keepAutoLogin(HashMap<String, Object> map);
    void deleteSession(HashMap<String, Object> map);
    String selectMemberPwd(String userId);
    void deleteMember(String userId);
    void updateMember(MemberVO mvo);
    void insertMemberAttachment(MemberAttachmentVO mavo);
    void updateMemberAttachment(int userIdx);
}
