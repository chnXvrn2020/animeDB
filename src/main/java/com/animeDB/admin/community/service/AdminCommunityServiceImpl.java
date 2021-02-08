package com.animeDB.admin.community.service;

import com.animeDB.admin.community.dao.AdminCommunityDao;
import com.animeDB.common.vo.CommunityKindVO;
import com.animeDB.common.vo.CommunityListVO;
import com.animeDB.common.vo.CommunityPostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class AdminCommunityServiceImpl implements AdminCommunityService {

    @Autowired
    AdminCommunityDao adminCommunityDao;

    @Override
    public List<HashMap<String, Object>> selectCommunityStatusCnt() {
        return adminCommunityDao.selectCommunityStatusCnt();
    }

    @Override
    public HashMap<String, Object> selectCommunityKindList(CommunityKindVO kindVO) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("totalCount", adminCommunityDao.selectCommunityKindCnt(kindVO));
        map.put("list", adminCommunityDao.selectCommunityKindList(kindVO));
        return map;
    }

    @Override
    public boolean insertKind(CommunityKindVO kindVO) {
        if (adminCommunityDao.selectDuplicateKind(kindVO)) return false;
        else adminCommunityDao.insertKind(kindVO);
        return true;
    }

    @Override
    public HashMap<String, Object> selectOneKind(CommunityKindVO kindVO) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("one", adminCommunityDao.selectOneKind(kindVO));
        map.put("list", adminCommunityDao.selectListBelongKind(kindVO));
        return map;
    }

    @Override
    public CommunityKindVO selectOneKind2Update(CommunityKindVO kindVO) {
        return adminCommunityDao.selectOneKind(kindVO);
    }

    @Override
    public boolean updateKind(CommunityKindVO kindVO) {
        if (adminCommunityDao.selectDuplicateKind(kindVO)) return false;
        else adminCommunityDao.updateKind(kindVO);
        return true;
    }

    @Override
    public boolean deleteKind(CommunityKindVO kindVO) {
        if (adminCommunityDao.selectCommunityListBeforeDelete(kindVO)) return false;
        else adminCommunityDao.deleteKind(kindVO);
        return true;
    }

    @Override
    public HashMap<String, Object> selectCommunityList(CommunityListVO listVO) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("totalCount", adminCommunityDao.selectCommunityListCnt(listVO));
        map.put("list", adminCommunityDao.selectCommunityList(listVO));
        map.put("kind", adminCommunityDao.selectCommunityKind());
        return map;
    }

    @Override
    public List<CommunityKindVO> selectCommunityKind() {
        return adminCommunityDao.selectCommunityKind();
    }

    @Override
    public boolean insertCommunity(CommunityListVO listVO) {
        if (adminCommunityDao.selectDuplicateCommunity(listVO)) return false;
        else adminCommunityDao.insertCommunityList(listVO);
        return true;
    }

    @Override
    public CommunityListVO selectOneCommunity(CommunityListVO listVO) {
        return adminCommunityDao.selectOneCommunity(listVO);
    }

    @Override
    public HashMap<String, Object> selectOneCommunity2Update(CommunityListVO listVO) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("listVO", adminCommunityDao.selectOneCommunity2Update(listVO));
        map.put("kind", adminCommunityDao.selectCommunityKind());
        return map;
    }

    @Override
    public boolean updateCommunity(CommunityListVO listVO) {
        if (adminCommunityDao.selectDuplicateCommunity(listVO)) return false;
        else adminCommunityDao.updateCommunity(listVO);
        return true;
    }

    @Override
    public void deleteCommunity(CommunityListVO listVO) {
        adminCommunityDao.deleteCommunity(listVO);
    }

    @Override
    public HashMap<String, Object> selectCommunityPost4Admin(CommunityPostVO postVO) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("totalCount", adminCommunityDao.selectCommunityPostCnt(postVO));
        map.put("list", adminCommunityDao.selectCommunityPost(postVO));
        map.put("listName", adminCommunityDao.selectCommunityListName(postVO));
        return map;
    }
}
