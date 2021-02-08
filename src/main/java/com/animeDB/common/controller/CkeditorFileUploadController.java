package com.animeDB.common.controller;

import com.animeDB.member.controller.MemberController;
import com.animeDB.util.FileUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Locale;

@Controller
public class CkeditorFileUploadController {

    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

    @Autowired
    MessageSource messageSource;

    @Value("${communityImage.uploadDir}")
    private String uploadDir;
    @Value("${forLinux.serverDir}")
    private String serverDir;

    @RequestMapping(value = "uploadImg", method = RequestMethod.POST)
    public void ckeditorUploadFile(@RequestParam("upload") MultipartFile file, HttpServletResponse response, Locale locale) {
        HashMap<String, Object> map = new HashMap<>();
        response.setContentType("application/json");
        try {
            String fileTemp = FileUtil.imageFileUpload(file, serverDir, uploadDir);
            map.put("uploaded", 1);
            map.put("filename", fileTemp);
            map.put("url", "https://www.animedb.site/community_img/" + fileTemp);

            ObjectMapper mapper = new ObjectMapper();

            mapper.writeValue(response.getWriter(), map);
        } catch (Exception e) {
            logger.info("ckeditor - upload : " + e.getMessage());
            map.put("uploaded", 0);
            map.put("error", messageSource.getMessage("file.2mbLimit", null, locale));
        }
    }
}
