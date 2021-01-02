package com.animeDB.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.util.Locale;

@Service
public class MailServiceImpl implements MailService {

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    MessageSource messageSource;

    @Override
    public void mailSendWithUserKey(String email, String userId, String nickname, String userKey, HttpServletRequest request, Locale locale) {
        MimeMessage mail = mailSender.createMimeMessage();
        String authenticateUrl = "https://www.animedb.site/signup/key_alter?userid=" + userId + "&key=" + userKey;
        String[] variables = {nickname, userId, authenticateUrl};

        try {
            mail.setSubject(messageSource.getMessage("mail.subject", null, locale));
            mail.setText(messageSource.getMessage("mail.authenticate", variables, locale), "utf-8", "html");
            mail.addRecipient(MimeMessage.RecipientType.TO, new InternetAddress(email));
            mailSender.send(mail);
        } catch (MessagingException ignored) {
        }
    }
}
