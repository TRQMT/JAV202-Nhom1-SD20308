package com.polycoffee.util;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class MailUtil {
    // Dien dung thong tin Gmail/App Password cua ban tai day.
    private static final String GMAIL_USERNAME = "tungttts01665@gmail.com";
    private static final String GMAIL_APP_PASSWORD = "pqou yoah xjmr bxvw";

    private MailUtil() {
    }

    public static boolean sendOtp(String toEmail, String otpCode, String purpose) {
        String subject = "[MyCafe] Ma OTP xac thuc";
        String body = buildContent(otpCode, purpose);
        String from = getConfig("MAIL_FROM", getConfig("MAIL_USERNAME", GMAIL_USERNAME));
        return send(from, toEmail, subject, body) == 1;
    }

    public static int send(String from, String to, String subject, String body) {
        String host = getConfig("MAIL_HOST", "smtp.gmail.com");
        String port = getConfig("MAIL_PORT", "587");
        String username = getConfig("MAIL_USERNAME", GMAIL_USERNAME);
        String password = getConfig("MAIL_PASSWORD", GMAIL_APP_PASSWORD);

        if (username == null || username.isBlank() || password == null || password.isBlank()) {
            return -1;
        }

        Properties props = new Properties();
        props.setProperty("mail.smtp.auth", "true");
        props.setProperty("mail.smtp.starttls.enable", "true");
        props.setProperty("mail.smtp.host", host);
        props.setProperty("mail.smtp.port", port);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            MimeMessage mail = new MimeMessage(session);
            mail.setFrom(new InternetAddress(from));
            mail.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            mail.setSubject(subject, "utf-8");
            mail.setText(body, "utf-8", "html");
            mail.setReplyTo(mail.getFrom());
            Transport.send(mail);
            return 1;
        } catch (MessagingException e) {
            e.printStackTrace();
            return -1;
        }
    }

    private static String buildContent(String otpCode, String purpose) {
        return "Xin chao,<br><br>"
            + "Ban vua thuc hien thao tac: " + purpose + ".<br>"
            + "Ma OTP cua ban la: <b>" + otpCode + "</b><br>"
            + "Ma co hieu luc trong 5 phut.<br><br>"
            + "Neu ban khong thuc hien thao tac nay, vui long bo qua email.<br><br>"
            + "MyCafe";
    }

    private static String getConfig(String key, String defaultValue) {
        String fromProperty = System.getProperty(key);
        if (fromProperty != null && !fromProperty.isBlank()) {
            return fromProperty;
        }

        String fromEnv = System.getenv(key);
        if (fromEnv != null && !fromEnv.isBlank()) {
            return fromEnv;
        }

        return defaultValue;
    }
}
