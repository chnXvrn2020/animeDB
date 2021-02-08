package com.animeDB.community.dao;

import com.animeDB.common.vo.CommunityCommentVO;
import com.animeDB.common.vo.CommunityKindVO;
import com.animeDB.common.vo.CommunityListVO;
import com.animeDB.common.vo.CommunityPostVO;

import java.util.HashMap;
import java.util.List;

public interface CommunityDao {
    List<CommunityKindVO> selectCommunityKind();
    List<CommunityListVO> selectCommunityList();
    List<CommunityPostVO> selectNewPosts(CommunityPostVO postVO);
    List<CommunityPostVO> selectPopularPosts(CommunityPostVO postVO);
    List<CommunityPostVO> selectCommunityPost(CommunityPostVO postVO);
    int selectCommunityPostCnt(CommunityPostVO postVO);
    CommunityPostVO selectCommunityListName(CommunityPostVO postVO);
    void insertCommunityPost(CommunityPostVO postVO);
    CommunityPostVO selectOneCommunityPost(CommunityPostVO postVO);
    List<CommunityCommentVO> selectCommunityComment(CommunityCommentVO commentVO);
    int selectCommunityCommentCnt(CommunityCommentVO commentVO);
    void updateCommunityPostHit(CommunityPostVO postVO);
    void updateVote(HashMap<String, Object> map);
    HashMap<String, Object> selectOnePostVoteCnt(HashMap<String, Object> map);
    void deleteCommunityPost(CommunityPostVO postVO);
    CommunityPostVO selectCommunityPost2Update(CommunityPostVO postVO);
    void updateCommunityPost(CommunityPostVO postVO);
}
