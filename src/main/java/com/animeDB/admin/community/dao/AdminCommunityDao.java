package com.animeDB.admin.community.dao;

import com.animeDB.common.vo.CommunityKindVO;
import com.animeDB.common.vo.CommunityListVO;
import com.animeDB.common.vo.CommunityPostVO;

import java.util.HashMap;
import java.util.List;

public interface AdminCommunityDao {
    List<HashMap<String, Object>> selectCommunityStatusCnt();
    List<CommunityKindVO> selectCommunityKind();
    List<CommunityKindVO> selectCommunityKindList(CommunityKindVO kindVO);
    int selectCommunityKindCnt(CommunityKindVO kindVO);
    void insertKind(CommunityKindVO kindVO);
    boolean selectDuplicateKind(CommunityKindVO kindVO);
    CommunityKindVO selectOneKind(CommunityKindVO kindVO);
    List<CommunityListVO> selectListBelongKind(CommunityKindVO kindVO);
    boolean selectCommunityListBeforeDelete(CommunityKindVO kindVO);
    void deleteKind(CommunityKindVO kindVO);
    void updateKind(CommunityKindVO kindVO);
    int selectCommunityListCnt(CommunityListVO listVO);
    List<CommunityListVO> selectCommunityList(CommunityListVO listVO);
    boolean selectDuplicateCommunity(CommunityListVO listVO);
    void insertCommunityList(CommunityListVO listVO);
    CommunityListVO selectOneCommunity(CommunityListVO listVO);
    CommunityListVO selectOneCommunity2Update(CommunityListVO listVO);
    void updateCommunity(CommunityListVO listVO);
    void deleteCommunity(CommunityListVO listVO);
    int selectCommunityPostCnt(CommunityPostVO postVO);
    List<CommunityPostVO> selectCommunityPost(CommunityPostVO postVO);
    CommunityPostVO selectCommunityListName(CommunityPostVO postVO);
}
