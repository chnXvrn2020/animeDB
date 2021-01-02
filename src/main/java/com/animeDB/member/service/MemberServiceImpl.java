package com.animeDB.member.service;

import com.animeDB.common.vo.MemberAttachmentVO;
import com.animeDB.member.dao.MemberDao;
import com.animeDB.common.vo.MemberVO;
import com.animeDB.util.FileUtil;
import com.animeDB.util.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;

@Service
public class MemberServiceImpl implements MemberService {
    @Value("${memberImage.uploadDir}")
    private String uploadDir;
    @Value("${forLinux.serverDir}")
    private String serverDir;

    @Autowired
    MemberDao memberDao;

    @Override
    public MemberVO selectMemberInfo(String userId) {
        return memberDao.selectMemberInfo(userId);
    }

    @Override
    public MemberAttachmentVO selectMemberAttachment(int userIdx) {
        return memberDao.selectMemberAttachment(userIdx);
    }

    @Override
    public void keepAutoLogin(int userIdx, String sessionKey, String browser) {
        int amount = 60 * 60 * 24 * 7; //7 DAY
        Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));

        HashMap<String, Object> map = new HashMap<>();
        map.put("userIdx", userIdx);
        map.put("sessionKey", sessionKey);
        map.put("sessionLimit", sessionLimit);
        map.put("browser", browser);
        memberDao.keepAutoLogin(map);
    }

    @Override
    public MemberVO checkUserWithSessionKey(String sessionKey, String browser) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("sessionKey", sessionKey);
        map.put("browser", browser);
        return memberDao.checkUserWithSessionKey(map);
    }

    @Override
    public void renewalLimit(int userIdx, String sessionKey, Date sessionLimit) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("userIdx", userIdx);
        map.put("sessionKey", sessionKey);
        map.put("sessionLimit", sessionLimit);
        memberDao.updateSessionLimit(map);
    }

    @Override
    public void logout(HttpSession session, HttpServletRequest request, HttpServletResponse response, int userIdx) {
        session.removeAttribute("member");
        Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
        if (loginCookie != null) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("userIdx", userIdx);
            map.put("browser", Utils.checkBrowser(request));
            map.put("sessionKey", loginCookie.getValue());

            loginCookie.setPath("/");
            loginCookie.setMaxAge(0);
            response.addCookie(loginCookie);

            memberDao.deleteSession(map);
        }
    }

    @Override
    public String selectMemberPwd(String userId) {
        return memberDao.selectMemberPwd(userId);
    }

    @Override
    public void deleteMember(String userId) {
        memberDao.deleteMember(userId);
    }

    @Override
    public void updateMember(MemberVO mvo, MemberAttachmentVO mavo, MultipartFile memberImageFile) {
        mvo.setPhone(Utils.phoneNumberWithHyphen(mvo.getPhone()));
        mavo.setUserIdx(mvo.getIdx());

        if (mavo.getAttachment() != null) {
            memberDao.updateMemberAttachment(mavo.getUserIdx());
        }
        else if (!memberImageFile.isEmpty()) {
            String attachment = FileUtil.imageFileUpload(memberImageFile, serverDir, uploadDir);
            String attachmentOrg = memberImageFile.getOriginalFilename();
            mavo.setAttachment(attachment);
            mavo.setAttachmentOrg(attachmentOrg);
            memberDao.updateMemberAttachment(mavo.getUserIdx());
            memberDao.insertMemberAttachment(mavo);
        }
        memberDao.updateMember(mvo);
    }
}
