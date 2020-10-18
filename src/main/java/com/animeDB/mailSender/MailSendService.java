package com.animeDB.mailSender;

import javax.servlet.http.HttpServletRequest;

public interface MailSendService {
    void mailSendWithUserKey(String email, String userId, String nickname, String userKey, HttpServletRequest request);
}
