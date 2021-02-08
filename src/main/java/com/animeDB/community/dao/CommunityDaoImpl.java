package com.animeDB.community.dao;

import com.animeDB.common.vo.CommunityCommentVO;
import com.animeDB.common.vo.CommunityKindVO;
import com.animeDB.common.vo.CommunityListVO;
import com.animeDB.common.vo.CommunityPostVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class CommunityDaoImpl implements CommunityDao{

    @Autowired
    SqlSessionTemplate sqlSession;

    private final String COMMUNITY = "com.animeDB.community.";

    @Override
    public List<CommunityKindVO> selectCommunityKind() {
        return sqlSession.selectList(COMMUNITY + "selectCommunityKind");
    }

    @Override
    public List<CommunityListVO> selectCommunityList() {
        return sqlSession.selectList(COMMUNITY + "selectCommunityList");
    }

    @Override
    public List<CommunityPostVO> selectNewPosts(CommunityPostVO postVO) {
        return sqlSession.selectList(COMMUNITY + "selectNewPosts", postVO);
    }

    @Override
    public List<CommunityPostVO> selectPopularPosts(CommunityPostVO postVO) {
        return sqlSession.selectList(COMMUNITY + "selectPopularPosts", postVO);
    }

    @Override
    public List<CommunityPostVO> selectCommunityPost(CommunityPostVO postVO) {
        return sqlSession.selectList(COMMUNITY + "selectCommunityPost", postVO);
    }

    @Override
    public int selectCommunityPostCnt(CommunityPostVO postVO) {
        return sqlSession.selectOne(COMMUNITY + "selectCommunityPostCnt", postVO);
    }

    @Override
    public CommunityPostVO selectCommunityListName(CommunityPostVO postVO) {
        return sqlSession.selectOne(COMMUNITY + "selectCommunityListName", postVO);
    }

    @Override
    public void insertCommunityPost(CommunityPostVO postVO) {
        sqlSession.insert(COMMUNITY + "insertCommunityPost", postVO);
    }

    @Override
    public CommunityPostVO selectOneCommunityPost(CommunityPostVO postVO) {
        return sqlSession.selectOne(COMMUNITY + "selectOneCommunityPost", postVO);
    }

    @Override
    public List<CommunityCommentVO> selectCommunityComment(CommunityCommentVO commentVO) {
        return sqlSession.selectList(COMMUNITY + "selectCommunityComment", commentVO);
    }

    @Override
    public int selectCommunityCommentCnt(CommunityCommentVO commentVO) {
        return sqlSession.selectOne(COMMUNITY + "selectCommunityCnt", commentVO);
    }

    @Override
    public void updateCommunityPostHit(CommunityPostVO postVO) {
        sqlSession.update(COMMUNITY + "updateCommunityPostHit", postVO);
    }

    @Override
    public void updateVote(HashMap<String, Object> map) {
        sqlSession.update(COMMUNITY + "updateCommunityPostVote", map);
    }

    @Override
    public HashMap<String, Object> selectOnePostVoteCnt(HashMap<String, Object> map) {
        return sqlSession.selectOne(COMMUNITY + "selectOnePostVoteCnt", map);
    }

    @Override
    public void deleteCommunityPost(CommunityPostVO postVO) {
        sqlSession.update(COMMUNITY + "deleteCommunityPost", postVO);
    }

    @Override
    public CommunityPostVO selectCommunityPost2Update(CommunityPostVO postVO) {
        return sqlSession.selectOne(COMMUNITY + "selectCommunityPost2Update", postVO);
    }

    @Override
    public void updateCommunityPost(CommunityPostVO postVO) {
        sqlSession.update(COMMUNITY + "updateCommunityPost", postVO);
    }
}
