package com.polycoffee.util;

import java.io.Serializable;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.concurrent.ThreadLocalRandom;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class OtpUtil {
    private static final String OTP_PREFIX = "OTP_";

    private OtpUtil() {
    }

    public static String issueOtp(HttpServletRequest request, String purpose, String email, int ttlMinutes) {
        String code = String.format("%06d", ThreadLocalRandom.current().nextInt(0, 1_000_000));
        Instant expiresAt = Instant.now().plus(ttlMinutes, ChronoUnit.MINUTES);
        OtpTicket ticket = new OtpTicket(purpose, email, code, expiresAt);
        request.getSession().setAttribute(getKey(purpose), ticket);
        return code;
    }

    public static boolean verifyOtp(HttpServletRequest request, String purpose, String email, String inputCode) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }

        Object value = session.getAttribute(getKey(purpose));
        if (!(value instanceof OtpTicket ticket)) {
            return false;
        }

        if (ticket.expiresAt().isBefore(Instant.now())) {
            session.removeAttribute(getKey(purpose));
            return false;
        }

        if (!ticket.email().equalsIgnoreCase(email)) {
            return false;
        }

        boolean ok = ticket.code().equals(inputCode != null ? inputCode.trim() : "");
        if (ok) {
            session.removeAttribute(getKey(purpose));
        }
        return ok;
    }

    public static void clearOtp(HttpServletRequest request, String purpose) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(getKey(purpose));
        }
    }

    private static String getKey(String purpose) {
        return OTP_PREFIX + purpose;
    }

    public record OtpTicket(String purpose, String email, String code, Instant expiresAt) implements Serializable {
        private static final long serialVersionUID = 1L;
    }
}
