package com.animeDB.mailSender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

@Service
public class MailSendServiceImpl implements MailSendService {

    @Autowired
    private JavaMailSender mailSender;

    @Override
    public void mailSendWithUserKey(String email, String userId, String nickname, String userKey, HttpServletRequest request) {
        MimeMessage mail = mailSender.createMimeMessage();

        String htmlStr = "<h2>会員登録になられた" + nickname + "(" + userId + ")様、アニメDBです。</h2><br><br>"
                + "<p>アニメDBの会員になられた事にご歓迎いたします。<br>"
                + "<p>認証するボタンをクリックすると、以降ログインができます。<br>"
                + "<a href='http://localhost:8080/join/key_alter?userid=" + userId + "&key=" + userKey + "'>"
                + "認証する</a></p><br>"
                + "<p>(アニメDBに会員登録したことがない場合、このメールを無視してください。)</p>";

        try {
            mail.setSubject("[アニメDB] 会員登録認証メール");
            mail.setText(htmlStr, "utf-8", "html");
            mail.addRecipient(MimeMessage.RecipientType.TO, new InternetAddress(email));
            mailSender.send(mail);
        } catch (MessagingException ignored) {
        }
    }
}
