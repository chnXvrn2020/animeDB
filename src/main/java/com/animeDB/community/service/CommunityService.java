package com.animeDB.community.service;

import com.animeDB.common.vo.CommunityCommentVO;
import com.animeDB.common.vo.CommunityPostVO;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

public interface CommunityService {
    HashMap<String, Object> selectCommunity4main(CommunityPostVO postVO);
    HashMap<String, Object> selectCommunityPost(CommunityPostVO postVO);
    void insertCommunityPost(CommunityPostVO postVO);
    HashMap<String, Object> selectOneCommunityPostNComment(CommunityPostVO postVO, CommunityCommentVO commentVO, HttpServletRequest request, HttpServletResponse response);
    HashMap<String, Object> updateVoteNReturn(HashMap<String, Object> map);
    void deleteCommunityPost(CommunityPostVO postVO);
    CommunityPostVO selectCommunityPost2Update(CommunityPostVO postVO);
    void updateCommunityPost(CommunityPostVO postVO);
}
