package com.animeDB.member.service;

import com.animeDB.common.vo.MemberAttachmentVO;
import com.animeDB.common.vo.MemberVO;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;

public interface MemberService {
    MemberVO selectMemberInfo(String userId);
    MemberAttachmentVO selectMemberAttachment(int userIdx);
    void keepAutoLogin(int userIdx, String sessionKey, String browser);
    MemberVO checkUserWithSessionKey(String sessionKey, String browser);
    void renewalLimit(int userIdx, String sessionId, Date sessionLimit);
    void logout(HttpSession session, HttpServletRequest request, HttpServletResponse response, int userIdx);
    String selectMemberPwd(String userId);
    void deleteMember(String userId);
    void updateMember(MemberVO mvo, MemberAttachmentVO mavo, MultipartFile memberImageFile);
}
