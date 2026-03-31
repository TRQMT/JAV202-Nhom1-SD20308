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
    private MailUtil() {
    }

    public static boolean sendOtp(String toEmail, String otpCode, String purpose) {
        String host = getConfig("MAIL_HOST", "smtp.gmail.com");
        String port = getConfig("MAIL_PORT", "587");
        String username = getConfig("MAIL_USERNAME", null);
        String password = getConfig("MAIL_PASSWORD", null);
        String from = getConfig("MAIL_FROM", username != null ? username : "noreply@polycoffee.local");

        if (username == null || username.isBlank() || password == null || password.isBlank()) {
            return false;
        }

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("[MyCafe] Mã OTP xác thực");
            message.setContent(buildContent(otpCode, purpose), "text/plain; charset=UTF-8");
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static String buildContent(String otpCode, String purpose) {
        return "Xin chào,\n\n"
            + "Bạn vừa thực hiện thao tác: " + purpose + ".\n"
            + "Mã OTP của bạn là: " + otpCode + "\n"
            + "Mã có hiệu lực trong 5 phút.\n\n"
            + "Nếu bạn không thực hiện thao tác này, vui lòng bỏ qua email.\n\n"
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
