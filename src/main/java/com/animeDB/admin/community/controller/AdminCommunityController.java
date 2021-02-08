package com.animeDB.admin.community.controller;

import com.animeDB.admin.community.service.AdminCommunityService;
import com.animeDB.common.vo.CommunityKindVO;
import com.animeDB.common.vo.CommunityListVO;
import com.animeDB.common.vo.CommunityPostVO;
import com.animeDB.common.vo.MemberVO;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping(value = "/admin/community")
public class AdminCommunityController {
    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
    private final int rows = 10;

    @Autowired
    AdminCommunityService adminCommunityService;

    @Autowired
    MessageSource messageSource;

    @Autowired
    BCryptPasswordEncoder pwdEncoder;

    //Output community administration viewing
    @RequestMapping(value = {"/", ""})
    public String adminCommunity(Model m, Locale locale) {
        try {
            List<HashMap<String, Object>> cnt = adminCommunityService.selectCommunityStatusCnt();
            m.addAttribute("statusCnt", cnt);
        } catch (Exception e) {
            logger.info("admin - community : " + e.getMessage());
            m.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }
        return "admin/community/community";
    }

    //Output kind list
    @RequestMapping(value = "/kind", method = RequestMethod.GET)
    public String communityKind(Model m, Locale locale, CommunityKindVO kindVO) {
        try {
            int page = kindVO.getPage();
            int offset = (page - 1) * rows;
            kindVO.setOffset(offset);
            kindVO.setRows(rows);
            HashMap<String, Object> kind = adminCommunityService.selectCommunityKindList(kindVO);
            Pager pager = new Pager((int) kind.get("totalCount"), page, rows);
            m.addAttribute("kindVO", kindVO);
            m.addAttribute("kind", kind);
            m.addAttribute("pager", pager);
        } catch (Exception e) {
            logger.info("admin - communityKind : " + e.getMessage());
            m.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }
        return "admin/community/kindList";
    }

    //Output add kind viewing
    @RequestMapping("/addKind")
    public String addKind(Model model, HttpServletRequest request, Locale locale) {
        try {
            if (!Utils.checkReferer(request)) {
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", messageSource.getMessage("/", null, locale));
                return "common/alert";
            }
            model.addAttribute("kindVO", new CommunityKindVO());
            model.addAttribute("division", "add");
        } catch (Exception e) {
            logger.info("admin - addKind : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }

        return "admin/community/addKind";
    }

    //Insert kind
    @RequestMapping(value = "/addKind", method = RequestMethod.POST)
    public String addKind(@ModelAttribute CommunityKindVO kindVO, Locale locale, HttpSession session, Model model) {
        try {
            MemberVO sessionMemberVO = (MemberVO) session.getAttribute("member");
            kindVO.setInsertAdmin(sessionMemberVO.getUserId());
            if (adminCommunityService.insertKind(kindVO)) {
                model.addAttribute("msg", messageSource.getMessage("admin.kindAdded", null, locale));
                model.addAttribute("returnUrl", "/admin/community/kind");
            } else {
                model.addAttribute("msg", messageSource.getMessage("admin.duplicatedKind", null, locale));
            }
        } catch (Exception e) {
            logger.info("admin - addKind : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
        }

        return "common/alert";
    }

    //Output viewing kind
    @RequestMapping(value = "/viewKind", method = RequestMethod.GET)
    public String viewKind(CommunityKindVO kindVO, Model model, Locale locale, HttpSession session) {
        try {
            MemberVO sessionMemberVO = (MemberVO)session.getAttribute("member");
            HashMap<String, Object> map = adminCommunityService.selectOneKind(kindVO);
            kindVO = (CommunityKindVO) map.get("one");
            if (kindVO.getInsertAdmin().equals(sessionMemberVO.getUserId()))
                session.setAttribute("CSRF_TOKEN", pwdEncoder.encode("vrn!" + kindVO.getIdx() + "chn!-kind-"));
            model.addAttribute("one", map.get("one"));
            model.addAttribute("list", map.get("list"));
        } catch (Exception e) {
            logger.info("admin - viewKind : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }
        return "admin/community/kindView";
    }

    //Output modify kind viewing
    @RequestMapping(value = "/modifyKind", method = RequestMethod.GET)
    public String modifyKind(CommunityKindVO kindVO, HttpSession session, Model model, Locale locale, HttpServletRequest request) {
        try {
            if (!Utils.checkReferer(request)) {
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", messageSource.getMessage("/", null, locale));
                return "common/alert";
            }
            if (session.getAttribute("CSRF_TOKEN") == null || !pwdEncoder.matches("vrn!" + kindVO.getIdx() + "chn!-kind-", session.getAttribute("CSRF_TOKEN").toString())){
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", "/");
                return "common/alert";
            } else if (pwdEncoder.matches("vrn!" + kindVO.getIdx() + "chn!-kind-", session.getAttribute("CSRF_TOKEN").toString())) {
                session.removeAttribute("CSRF_TOKEN");
                model.addAttribute("kindVO", adminCommunityService.selectOneKind2Update(kindVO));
                model.addAttribute("division", "modify");
            }

        } catch (Exception e) {
            logger.info("admin - modifyKind : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }
        return "admin/community/addKind";
    }

    //Update Kind
    @RequestMapping(value = "/modifyKind", method = RequestMethod.POST)
    public String modifyKind(@ModelAttribute CommunityKindVO kindVO, Locale locale, Model model, HttpSession session) {
        try {
            if (adminCommunityService.updateKind(kindVO)) {
                adminCommunityService.updateKind(kindVO);
                model.addAttribute("msg", messageSource.getMessage("admin.kindUpdated", null, locale));
                model.addAttribute("returnUrl", "/admin/community/kind");
            } else {
                model.addAttribute("msg", messageSource.getMessage("admin.duplicatedKind", null, locale));
                model.addAttribute("returnUrl", "/admin/community/kind");
            }
            session.removeAttribute("CSRF_TOKEN");
        } catch (Exception e) {
            logger.info("admin - modifyKind : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
        }
        return "common/alert";
    }

    //Delete kind
    @RequestMapping(value = "/deleteKind", method = RequestMethod.GET)
    public String deleteKind(CommunityKindVO kindVO, Locale locale, HttpSession session, Model model, HttpServletRequest request) {
        try {
            if (!Utils.checkReferer(request)) {
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", messageSource.getMessage("/", null, locale));
                return "common/alert";
            }
            if (session.getAttribute("CSRF_TOKEN") == null || !pwdEncoder.matches("vrn!" + kindVO.getIdx() + "chn!-kind-", session.getAttribute("CSRF_TOKEN").toString())){
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", "/");
            }else if (pwdEncoder.matches("vrn!" + kindVO.getIdx() + "chn!-kind-", session.getAttribute("CSRF_TOKEN").toString())) {
                if (adminCommunityService.deleteKind(kindVO)) {
                    model.addAttribute("msg", messageSource.getMessage("admin.deletedKind", null, locale));
                    model.addAttribute("returnUrl", "/admin/community/kind");
                } else {
                    model.addAttribute("msg", messageSource.getMessage("admin.yetCommunityList", null, locale));
                }
                session.removeAttribute("CSRF_TOKEN");
            }
        } catch (Exception e) {
            logger.info("admin - deleteKind : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
        }
        return "common/alert";
    }

    //Output community list viewing
    @RequestMapping(value = "/communityList", method = RequestMethod.GET)
    public String communityList(Model model, Locale locale, CommunityListVO listVO) {
        try {
            int page = listVO.getPage();
            int offset = (page - 1) * rows;
            listVO.setOffset(offset);
            listVO.setRows(rows);
            HashMap<String, Object> list = adminCommunityService.selectCommunityList(listVO);
            Pager pager = new Pager((int) list.get("totalCount"), page, rows);
            model.addAttribute("listVO", listVO);
            model.addAttribute("list", list);
            model.addAttribute("pager", pager);
        } catch (Exception e) {
            logger.info("admin - communityList : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }
        return "admin/community/communityList";
    }

    //Output add community viewing
    @RequestMapping(value = "/addCommunity", method = RequestMethod.GET)
    public String addCommunity(Model model, Locale locale, HttpServletRequest request) {
        try {
            if (!Utils.checkReferer(request)) {
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", messageSource.getMessage("/", null, locale));
                return "common/alert";
            }
            model.addAttribute("kind", adminCommunityService.selectCommunityKind());
            model.addAttribute("listVO", new CommunityListVO());
            model.addAttribute("division", "add");
        } catch (Exception e) {
            logger.info("admin - addCommunity : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }
        return "admin/community/addCommunity";
    }

    //Insert community list
    @RequestMapping(value = "/addCommunity", method = RequestMethod.POST)
    public String addCommunity(@ModelAttribute CommunityListVO listVO, HttpSession session, Model model, Locale locale) {
        try {
            MemberVO sessionMemberVO = (MemberVO) session.getAttribute("member");
            listVO.setInsertAdmin(sessionMemberVO.getUserId());
            if (adminCommunityService.insertCommunity(listVO)) {
                model.addAttribute("msg", messageSource.getMessage("admin.communityAdded", null, locale));
                model.addAttribute("returnUrl", "/admin/community/communityList");
            } else {
                model.addAttribute("msg", messageSource.getMessage("admin.duplicatedCommunity", null, locale));
            }
        } catch (Exception e) {
            logger.info("admin - addCommunity : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
        }

        return "common/alert";
    }

    //Output viewing Community
    @RequestMapping(value = "/viewCommunity", method = RequestMethod.GET)
    public String viewCommunity(CommunityListVO listVO, Model model, HttpSession session, Locale locale) {
        try {
            MemberVO sessionMemberVO = (MemberVO) session.getAttribute("member");
            listVO = adminCommunityService.selectOneCommunity(listVO);
            if (listVO.getInsertAdmin().equals(sessionMemberVO.getUserId()))
                session.setAttribute("CSRF_TOKEN", pwdEncoder.encode("vrn!" + listVO.getIdx() + "chn!-community-"));
            model.addAttribute("one", listVO);
        } catch (Exception e) {
            logger.info("admin - viewCommunity : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }
        return "admin/community/communityView";
    }

    //Output modify Community viewing
    @RequestMapping(value = "/modifyCommunity", method = RequestMethod.GET)
    public String modifyCommunity(CommunityListVO listVO, Model model, HttpSession session, Locale locale, HttpServletRequest request) {
        try {
            if (!Utils.checkReferer(request)) {
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", messageSource.getMessage("/", null, locale));
                return "common/alert";
            }
            if (session.getAttribute("CSRF_TOKEN") == null || !pwdEncoder.matches("vrn!" + listVO.getIdx() + "chn!-community-", session.getAttribute("CSRF_TOKEN").toString())){
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", "/");
                return "common/alert";
            } else if (pwdEncoder.matches("vrn!" + listVO.getIdx() + "chn!-community-", session.getAttribute("CSRF_TOKEN").toString())) {
                HashMap<String, Object> map = adminCommunityService.selectOneCommunity2Update(listVO);
                model.addAttribute("listVO", map.get("listVO"));
                model.addAttribute("kind", map.get("kind"));
                model.addAttribute("division", "modify");
            }
        } catch (Exception e) {
            logger.info("admin - modifyCommunity : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }

        return "admin/community/addCommunity";
    }

    //Update Community
    @RequestMapping(value = "/modifyCommunity", method = RequestMethod.POST)
    public String modifyCommunity(@ModelAttribute CommunityListVO listVO, Model model, Locale locale, HttpSession session) {
        try {
            if (adminCommunityService.updateCommunity(listVO)) {
                model.addAttribute("msg", messageSource.getMessage("admin.communityUpdated", null, locale));
                model.addAttribute("returnUrl", "/admin/community/communityList");
            } else {
                model.addAttribute("msg", messageSource.getMessage("admin.duplicatedCommunity", null, locale));
                model.addAttribute("returnUrl", "/admin/community/communityList");
            }
            session.removeAttribute("CSRF_TOKEN");
        } catch (Exception e) {
            logger.info("admin - modifyCommunity : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
        }
        return "common/alert";
    }

    //Delete Community
    @RequestMapping(value = "/deleteCommunity", method = RequestMethod.GET)
    public String deleteCommunity(CommunityListVO listVO, Locale locale, HttpSession session, Model model, HttpServletRequest request) {
        try {
            if (!Utils.checkReferer(request)) {
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", messageSource.getMessage("/", null, locale));
                return "common/alert";
            }
            if (session.getAttribute("CSRF_TOKEN") == null || !pwdEncoder.matches("vrn!" + listVO.getIdx() + "chn!-community-", session.getAttribute("CSRF_TOKEN").toString())){
                model.addAttribute("msg", messageSource.getMessage("alert.unauthorized", null, locale));
                model.addAttribute("returnUrl", "/");
            }else if (pwdEncoder.matches("vrn!" + listVO.getIdx() + "chn!-community-", session.getAttribute("CSRF_TOKEN").toString())) {
                adminCommunityService.deleteCommunity(listVO);
                model.addAttribute("msg", messageSource.getMessage("admin.deletedCommunity", null, locale));
                model.addAttribute("returnUrl", "/admin/community/communityList");
                session.removeAttribute("CSRF_TOKEN");
            }
        } catch (Exception e) {
            logger.info("admin - deleteKind : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
        }
        return "common/alert";
    }

    //Output community posts
    @RequestMapping(value = "/communityPost", method = RequestMethod.GET)
    public String communityPost(@RequestParam int idx, Model model, Locale locale, CommunityPostVO postVO) {
        try {
            int page = postVO.getPage();
            int offset = (page - 1) * 30;
            postVO.setOffset(offset);
            postVO.setRows(30);
            postVO.setListIdx(idx);
            HashMap<String, Object> list = adminCommunityService.selectCommunityPost4Admin(postVO);
            Pager pager = new Pager((int) list.get("totalCount"), page, 30);
            model.addAttribute("postVO", postVO);
            model.addAttribute("post", list);
            model.addAttribute("pager", pager);
        } catch (Exception e) {
            logger.info("admin - communityPost : " + e.getMessage());
            model.addAttribute("msg", messageSource.getMessage("alert.serverError", null, locale));
            return "common/alert";
        }

        return "admin/community/communityPostList";
    }
}
