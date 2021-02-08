package com.animeDB.admin.community.dao;

import com.animeDB.common.vo.CommunityKindVO;
import com.animeDB.common.vo.CommunityListVO;
import com.animeDB.common.vo.CommunityPostVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class AdminCommunityDaoImpl implements AdminCommunityDao {

    @Autowired
    SqlSessionTemplate sqlSession;

    private final String ADMIN_COMMUNITY = "com.animeDB.adminCommunity.";

    @Override
    public List<HashMap<String, Object>> selectCommunityStatusCnt() {
        return sqlSession.selectList(ADMIN_COMMUNITY + "selectCommunityStatusCnt");
    }

    @Override
    public List<CommunityKindVO> selectCommunityKind() {
        return sqlSession.selectList(ADMIN_COMMUNITY + "selectCommunityKind");
    }

    @Override
    public List<CommunityKindVO> selectCommunityKindList(CommunityKindVO kindVO) {
        return sqlSession.selectList(ADMIN_COMMUNITY + "selectKindList", kindVO);
    }

    @Override
    public int selectCommunityKindCnt(CommunityKindVO kindVO) {
        return sqlSession.selectOne(ADMIN_COMMUNITY + "selectKindCnt", kindVO);
    }

    @Override
    public void insertKind(CommunityKindVO kindVO) {
        sqlSession.insert(ADMIN_COMMUNITY + "insertKind", kindVO);
    }

    @Override
    public boolean selectDuplicateKind(CommunityKindVO kindVO) {
        return sqlSession.selectOne(ADMIN_COMMUNITY + "selectDuplicateKind", kindVO);
    }

    @Override
    public CommunityKindVO selectOneKind(CommunityKindVO kindVO) {
        return sqlSession.selectOne(ADMIN_COMMUNITY + "selectOneKind", kindVO);
    }

    @Override
    public List<CommunityListVO> selectListBelongKind(CommunityKindVO kindVO) {
        return sqlSession.selectList(ADMIN_COMMUNITY + "selectListBelongKind", kindVO);
    }

    @Override
    public boolean selectCommunityListBeforeDelete(CommunityKindVO kindVO) {
        return sqlSession.selectOne(ADMIN_COMMUNITY + "selectCommunityListBeforeDelete", kindVO);
    }

    @Override
    public void deleteKind(CommunityKindVO kindVO) {
        sqlSession.update(ADMIN_COMMUNITY + "deleteKind", kindVO);
    }

    @Override
    public void updateKind(CommunityKindVO kindVO) {
        sqlSession.update(ADMIN_COMMUNITY + "updateKind", kindVO);
    }

    @Override
    public int selectCommunityListCnt(CommunityListVO listVO) {
        return sqlSession.selectOne(ADMIN_COMMUNITY + "selectCommunityListCnt", listVO);
    }

    @Override
    public List<CommunityListVO> selectCommunityList(CommunityListVO listVO) {
        return sqlSession.selectList(ADMIN_COMMUNITY + "selectCommunityList", listVO);
    }

    @Override
    public boolean selectDuplicateCommunity(CommunityListVO listVO) {
        return sqlSession.selectOne(ADMIN_COMMUNITY + "selectDuplicateCommunity", listVO);
    }

    @Override
    public void insertCommunityList(CommunityListVO listVO) {
        sqlSession.insert(ADMIN_COMMUNITY + "insertCommunityList", listVO);
    }

    @Override
    public CommunityListVO selectOneCommunity(CommunityListVO listVO) {
        return sqlSession.selectOne(ADMIN_COMMUNITY + "selectOneCommunity", listVO);
    }

    @Override
    public CommunityListVO selectOneCommunity2Update(CommunityListVO listVO) {
        return sqlSession.selectOne(ADMIN_COMMUNITY + "selectCommunity2Update", listVO);
    }

    @Override
    public void updateCommunity(CommunityListVO listVO) {
        sqlSession.update(ADMIN_COMMUNITY + "updateCommunity", listVO);
    }

    @Override
    public void deleteCommunity(CommunityListVO listVO) {
        sqlSession.update(ADMIN_COMMUNITY + "deleteCommunity", listVO);
    }

    @Override
    public int selectCommunityPostCnt(CommunityPostVO postVO) {
        return sqlSession.selectOne(ADMIN_COMMUNITY + "selectCommunityPostCnt", postVO);
    }

    @Override
    public List<CommunityPostVO> selectCommunityPost(CommunityPostVO postVO) {
        return sqlSession.selectList(ADMIN_COMMUNITY + "selectCommunityPost4Admin", postVO);
    }

    @Override
    public CommunityPostVO selectCommunityListName(CommunityPostVO postVO) {
        return sqlSession.selectOne(ADMIN_COMMUNITY + "selectCommunityListName", postVO);
    }
}
