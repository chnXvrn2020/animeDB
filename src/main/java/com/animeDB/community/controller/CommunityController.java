package com.animeDB.community.controller;

import com.animeDB.common.vo.CommunityCommentVO;
import com.animeDB.common.vo.CommunityPostVO;
import com.animeDB.common.vo.MemberVO;
import com.animeDB.community.service.CommunityService;
import com.animeDB.member.controller.MemberController;
import com.animeDB.util.Pager;
import com.animeDB.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Locale;

@Controller
@RequestMapping(value = "/community")
public class CommunityController {
    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

    @Autowired
    CommunityService communityService;

    @Autowired
    MessageSource messageSource;

    @Autowired
    BCryptPasswordEncoder pwdEncoder;

    //Output main community list
    @RequestMapping(value = {"/", ""})
    public String communityMain(Model model, Locale locale) {
        try {
            CommunityPostVO postVO = new CommunityPostVO();
            postVO.setLocale(locale.getLanguage() + "_" + locale.getCountry());
            HashMap<String, Object> map = communityService.selectCommunity4main(postVO);
            model.addAttribute("kind", map.get("kind"));
            model.addAttribute("list", map.get("list"));
            model.addAttribute("newPosts", map.get("newPosts"));
            model.addAttribute("popular", map.get("popular"));
        } catch (Exception e) {
            logger.info("community - main : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }

        return "community/main";
    }

    //Output community list
    @RequestMapping(value = "/list")
    public String communityList(@RequestParam int list_idx, Model model, Locale locale, CommunityPostVO postVO) {
        try {
            int page = postVO.getPage();
            int offset = (page - 1) * 30;
            postVO.setOffset(offset);
            postVO.setRows(30);
            postVO.setListIdx(list_idx);
            postVO.setLocale(locale.getLanguage() + "_" + locale.getCountry());
            HashMap<String, Object> list = communityService.selectCommunityPost(postVO);
            Pager pager = new Pager((int) list.get("totalCount"), page, 30);
            model.addAttribute("postVO", postVO);
            model.addAttribute("post", list);
            model.addAttribute("pager", pager);
        } catch (Exception e) {
            logger.info("community - list : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }
        return "community/list";
    }

    //Output community write view
    @RequestMapping(value = "/write")
    public String writeCommunity(@RequestParam int list_idx, Model model, Locale locale, HttpSession session, HttpServletRequest request) {
        try {
            if (!Utils.checkReferer(request)) {
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", messageSource.getMessage("/", null, locale));
                return "common/alert";
            }
            if (session.getAttribute("member") == null) {
                model.addAttribute("msg", messageSource.getMessage("alert.afterSignIn", null, locale));
                return "common/alert";
            }
            CommunityPostVO postVO = new CommunityPostVO(list_idx);
            model.addAttribute("postVO", postVO);
        } catch (Exception e) {
            logger.info("community - write : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }
        return "community/write";
    }

    //Insert post
    @RequestMapping(value = "/write", method = RequestMethod.POST)
    public String writeCommunity(@ModelAttribute CommunityPostVO postVO, Locale locale, HttpSession session, Model model) {
        try {
            MemberVO sessionMemberVO = (MemberVO) session.getAttribute("member");
            postVO.setMemberIdx(sessionMemberVO.getIdx());
            postVO.setLocale(locale.getLanguage() + "_" + locale.getCountry());
            communityService.insertCommunityPost(postVO);
            model.addAttribute("msg", messageSource.getMessage("alert.writeSuccess", null, locale));
            model.addAttribute("returnUrl", "/community/list?list_idx=" + postVO.getListIdx());
        } catch (Exception e){
            logger.info("community - write : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
        }
        return "common/alert";
    }

    //Output community view that first page
    @RequestMapping(value = "/view", method = RequestMethod.GET)
    public String viewCommunity(CommunityPostVO postVO, int list_idx, Model model, Locale locale, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        try {
            CommunityCommentVO commentVO = new CommunityCommentVO();
            commentVO.setPostIdx(postVO.getIdx());
            commentVO.setLocale(locale.getLanguage() + "_" + locale.getCountry());
            postVO.setListIdx(list_idx);
            HashMap<String, Object> map = communityService.selectOneCommunityPostNComment(postVO, commentVO, request, response);
            Pager pager = new Pager((int) map.get("totalCount"), (int) map.get("page"), 30);
            MemberVO sessionMemberVO = (MemberVO)session.getAttribute("member");
            CommunityPostVO tempPostVO = (CommunityPostVO) map.get("postVO");
            try {
                if (tempPostVO.getMemberIdx() == sessionMemberVO.getIdx())
                    session.setAttribute("CSRF_TOKEN", pwdEncoder.encode("vrn?!" + postVO.getIdx() + "chn?!-comm"));
            } catch (Exception ignored) {}
            model.addAttribute("postVO", tempPostVO);
            model.addAttribute("comment", map.get("comment"));
            model.addAttribute("totalCommentCtn", map.get("totalCount"));
            model.addAttribute("commentVO", commentVO);
            model.addAttribute("pager", pager);
        } catch (Exception e) {
            logger.info("community - view : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }
        return "community/view";
    }

    @RequestMapping(value = "vote", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public HashMap<String, Object> votePost(int idx, String uid, String mode, Locale locale, HttpSession session) {
        HashMap<String, Object> response = new HashMap<>();
        try {
            MemberVO sessionMember = (MemberVO) session.getAttribute("member");
            if (sessionMember != null) {
                if (!sessionMember.getUserId().equals(uid)) {
                    HashMap<String, Object> map = new HashMap<>();
                    map.put("idx", idx);
                    map.put("memberIdx", sessionMember.getIdx());
                    map.put("mode", mode);
                    response.put("result", "voted");
                    response.put("vote", communityService.updateVoteNReturn(map));
                } else {
                    response.put("result", "notAllowed");
                    response.put("msg", messageSource.getMessage("alert.voteMine", null, locale));
                }
            } else {
                response.put("result", "noSignIn");
                response.put("msg", messageSource.getMessage("alert.afterSignIn", null, locale));
            }
        } catch (Exception e) {
            logger.info("community - vote : " + e.getMessage());
            response.put("result", "error");
            response.put("msg", messageSource.getMessage("alert.serverError", null, locale));
        }
        return response;
    }

    //Delete community view
    @RequestMapping(value = "/view/delete", method = RequestMethod.GET)
    public String deleteCommunityView(CommunityPostVO postVO, @RequestParam int list_idx, Locale locale, HttpSession session, Model model, HttpServletRequest request) {
        try {
            if (!Utils.checkReferer(request)) {
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", messageSource.getMessage("/", null, locale));
                return "common/alert";
            }
            if (pwdEncoder.matches("vrn?!" + postVO.getIdx() + "chn?!-comm", session.getAttribute("CSRF_TOKEN").toString())) {
                communityService.deleteCommunityPost(postVO);
                model.addAttribute("msg", messageSource.getMessage("community.deletedPost", null, locale));
                model.addAttribute("returnUrl", "/community/list?list_idx=" + list_idx);
                session.removeAttribute("CSRF_TOKEN");
            } else if (session.getAttribute("CSRF_TOKEN") == null || !pwdEncoder.matches("vrn?!" + postVO.getIdx() + "chn?!-comm", session.getAttribute("CSRF_TOKEN").toString())) {
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", "/");
            }
        } catch (Exception e) {
            logger.info("community - deleteView : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
        }

        return "common/alert";
    }

    //Output modify community post
    @RequestMapping(value = "/modify", method = RequestMethod.GET)
    public String modifyCommunityPost(CommunityPostVO postVO, Model model, HttpSession session, Locale locale, HttpServletRequest request) {
        try {
            if (!Utils.checkReferer(request)) {
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", messageSource.getMessage("/", null, locale));
                return "common/alert";
            }
            if (session.getAttribute("CSRF_TOKEN") == null || !pwdEncoder.matches("vrn?!" + postVO.getIdx() + "chn?!-comm", session.getAttribute("CSRF_TOKEN").toString())) {
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", "/");
            }else if (pwdEncoder.matches("vrn?!" + postVO.getIdx() + "chn?!-comm", session.getAttribute("CSRF_TOKEN").toString())) {
                model.addAttribute("postVO", communityService.selectCommunityPost2Update(postVO));
            }

        } catch (Exception e) {
            logger.info("community - modifyCommunityPost : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }
        return "community/write";
    }

    //Update community post
    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String modifyCommunityPost(@ModelAttribute CommunityPostVO postVO, int list_idx, Model model, HttpSession session, Locale locale) {
        try {
            communityService.updateCommunityPost(postVO);
            model.addAttribute("msg", messageSource.getMessage("alert.modifySuccess", null, locale));
            model.addAttribute("returnUrl", "/community/view?list_idx=" + list_idx + "&idx=" + postVO.getIdx());
            session.removeAttribute("CSRF_TOKEN");
        } catch (Exception e) {
            logger.info("community - modifyCommunityPost : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
        }
        return "common/alert";

    }

}
