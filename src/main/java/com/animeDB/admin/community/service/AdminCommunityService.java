package com.animeDB.admin.community.service;

import com.animeDB.common.vo.CommunityKindVO;
import com.animeDB.common.vo.CommunityListVO;
import com.animeDB.common.vo.CommunityPostVO;

import java.util.HashMap;
import java.util.List;

public interface AdminCommunityService {
    List<HashMap<String, Object>> selectCommunityStatusCnt();
    HashMap<String, Object> selectCommunityKindList(CommunityKindVO kindVO);
    boolean insertKind(CommunityKindVO kindVO);
    HashMap<String, Object> selectOneKind(CommunityKindVO kindVO);
    CommunityKindVO selectOneKind2Update(CommunityKindVO kindVO);
    boolean updateKind(CommunityKindVO kindVO);
    boolean deleteKind(CommunityKindVO kindVO);
    HashMap<String, Object> selectCommunityList(CommunityListVO listVO);
    List<CommunityKindVO> selectCommunityKind();
    boolean insertCommunity(CommunityListVO listVO);
    CommunityListVO selectOneCommunity(CommunityListVO listVO);
    HashMap<String, Object> selectOneCommunity2Update(CommunityListVO listVO);
    boolean updateCommunity(CommunityListVO listVO);
    void deleteCommunity(CommunityListVO listVO);
    HashMap<String, Object> selectCommunityPost4Admin(CommunityPostVO postVO);
}
