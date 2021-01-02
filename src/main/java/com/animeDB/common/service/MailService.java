package com.animeDB.common.service;

import javax.servlet.http.HttpServletRequest;
import java.util.Locale;

public interface MailService {
    void mailSendWithUserKey(String email, String userId, String nickname, String userKey, HttpServletRequest request, Locale locale);
}
