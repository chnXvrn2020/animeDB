package com.animeDB.community.service;

import com.animeDB.common.vo.CommunityCommentVO;
import com.animeDB.common.vo.CommunityPostVO;
import com.animeDB.community.dao.CommunityDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

@Service
public class CommunityServiceImpl implements CommunityService{

    @Value("${communityImage.uploadDir}")
    private String uploadDir;
    @Value("${forLinux.serverDir}")
    private String serverDir;

    @Autowired
    CommunityDao communityDao;

    @Override
    public HashMap<String, Object> selectCommunity4main(CommunityPostVO postVO) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("kind", communityDao.selectCommunityKind());
        map.put("list", communityDao.selectCommunityList());
        map.put("newPosts", communityDao.selectNewPosts(postVO));
        map.put("popular", communityDao.selectPopularPosts(postVO));
        return map;
    }

    @Override
    public HashMap<String, Object> selectCommunityPost(CommunityPostVO postVO) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("totalCount", communityDao.selectCommunityPostCnt(postVO));
        map.put("list", communityDao.selectCommunityPost(postVO));
        map.put("listName", communityDao.selectCommunityListName(postVO));
        return map;
    }

    @Override
    public void insertCommunityPost(CommunityPostVO postVO) {
        communityDao.insertCommunityPost(postVO);
    }

    @Override
    public HashMap<String, Object> selectOneCommunityPostNComment(CommunityPostVO postVO, CommunityCommentVO commentVO, HttpServletRequest request, HttpServletResponse response) {
        HashMap<String, Object> map = new HashMap<>();
        Cookie[] cookies = request.getCookies();
        Cookie viewCookie = null;

        //Check cookie
        if (cookies != null && cookies.length > 0) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cookie" + postVO.getListIdx() + "&" + postVO.getIdx())) {
                    viewCookie = cookie;
                }
            }
        }

        //Update post's hit when no cookie belongs to it
        if (viewCookie == null) {
            Cookie newCookie = new Cookie("cookie" + postVO.getListIdx() + "&" + postVO.getIdx(), "|" + postVO.getListIdx() + "&" + postVO.getIdx() + "|");
            response.addCookie(newCookie);
            communityDao.updateCommunityPostHit(postVO);
        }

        map.put("postVO", communityDao.selectOneCommunityPost(postVO));
        int totalCommentCnt = communityDao.selectCommunityCommentCnt(commentVO);
        map.put("totalCount", totalCommentCnt);
        int page = ((totalCommentCnt == 0)) ? 1 : ((totalCommentCnt % 30) == 0)
                ? totalCommentCnt / 30 : totalCommentCnt / 30 + 1;
        int offset = (page - 1) * 30;
        commentVO.setOffset(offset);
        commentVO.setRows(30);
        map.put("page", page);
        map.put("comment", communityDao.selectCommunityComment(commentVO));
        return map;
    }

    @Override
    public HashMap<String, Object> updateVoteNReturn(HashMap<String, Object> map) {
        communityDao.updateVote(map);
        return communityDao.selectOnePostVoteCnt(map);
    }

    @Override
    public void deleteCommunityPost(CommunityPostVO postVO) {
        communityDao.deleteCommunityPost(postVO);
    }

    @Override
    public CommunityPostVO selectCommunityPost2Update(CommunityPostVO postVO) {
        return communityDao.selectCommunityPost2Update(postVO);
    }

    @Override
    public void updateCommunityPost(CommunityPostVO postVO) {
        communityDao.updateCommunityPost(postVO);
    }
}
