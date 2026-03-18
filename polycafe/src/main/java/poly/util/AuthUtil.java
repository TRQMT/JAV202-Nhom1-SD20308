package com.polycoffee.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.polycoffee.entity.User;

public class AuthUtil {
	public static final String SESSION_USER = "user";
	//Lưu thông tin user đăng nhập
	public static void setUser(HttpServletRequest request, User user) {
		HttpSession session = request.getSession();
		session.setAttribute(SESSION_USER, user);
	}
	// Lấy thông tin user đăng nhập
    public static User getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        return (User) session.getAttribute(SESSION_USER);
    }
    // Đã login chưa?
    public static boolean isAuthenticated(HttpServletRequest request) {
        return getUser(request) != null;
    }
    // Kiểm tra quyền
    public static boolean isManager(HttpServletRequest request) {
        User u = getUser(request);
        return u!=null? u.isRole():false;
    }
    //Xóa thông tin đăng nhập
    public static void clear(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute(SESSION_USER);
	}
}


