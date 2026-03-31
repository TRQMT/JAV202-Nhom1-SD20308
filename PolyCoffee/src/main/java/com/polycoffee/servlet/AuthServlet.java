package com.polycoffee.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.polycoffee.dao.UserSecurityDAO;
import com.polycoffee.dao.UserDAO;
import com.polycoffee.entity.User;
import com.polycoffee.util.AuthUtil;
import com.polycoffee.util.MailUtil;
import com.polycoffee.util.OtpUtil;
import com.polycoffee.util.ParamUtil;

/**
 * Servlet implementation class AuthServlet
 */
@WebServlet({ "/dang-nhap", "/xac-thuc-2fa" })
public class AuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String OTP_PURPOSE_LOGIN_2FA = "LOGIN_2FA";
	private static final String SESSION_PENDING_2FA_USER_ID = "PENDING_2FA_USER_ID";
	private static final String SESSION_AUTH_SUCCESS = "AUTH_SUCCESS";

	UserDAO userDAO = new UserDAO();   
	UserSecurityDAO securityDAO = new UserSecurityDAO();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthServlet() {
        super();
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response)
					throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String path = request.getServletPath();
		if ("/xac-thuc-2fa".equals(path)) {
			Integer pendingUserId = (Integer) request.getSession().getAttribute(SESSION_PENDING_2FA_USER_ID);
			if (pendingUserId == null) {
				response.sendRedirect(request.getContextPath() + "/dang-nhap");
				return;
			}
			request.getRequestDispatcher("/views/auth/otp-2fa.jsp").forward(request, response);
			return;
		}

		Object success = request.getSession().getAttribute(SESSION_AUTH_SUCCESS);
		if (success != null) {
			request.setAttribute("success", success.toString());
			request.getSession().removeAttribute(SESSION_AUTH_SUCCESS);
		}

		request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, 
						  HttpServletResponse response) 
						  throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		if ("/xac-thuc-2fa".equals(request.getServletPath())) {
			handle2FaVerification(request, response);
			return;
		}

		String email = ParamUtil.getString(request, "email");
		String password = ParamUtil.getString(request, "password");
		User user = userDAO.findByEmail(email);

		if (user == null) {
			request.setAttribute("error", "Tài khoản không đúng!");
		} else if (!user.getPassword().equals(password)) {
			request.setAttribute("error", "Tài khoản không đúng!");
		} else if (!user.isActive()) {
			request.setAttribute("error", "Tài khoản đã bị khóa!");
		} else if (securityDAO.isTwoFactorEnabled(user.getId())) {
			String otp = OtpUtil.issueOtp(request, OTP_PURPOSE_LOGIN_2FA, user.getEmail(), 5);
			boolean sent = MailUtil.sendOtp(user.getEmail(), otp, "Đăng nhập 2FA");
			request.getSession().setAttribute(SESSION_PENDING_2FA_USER_ID, user.getId());
			if (!sent) {
				request.getSession().setAttribute("otpNotice",
						"Không gửi được email OTP. Kiểm tra cấu hình MAIL_USERNAME/MAIL_PASSWORD.");
			}
			response.sendRedirect(request.getContextPath() + "/xac-thuc-2fa");
			return;
		} else {
			AuthUtil.setUser(request, user);
			String redirectUrl = request.getContextPath() + "/trang-chu";
			if (request.getSession().getAttribute("REDIRECT_URL") != null) {
				redirectUrl = (String) request.getSession().getAttribute("REDIRECT_URL");
				request.getSession().removeAttribute("REDIRECT_URL");
			}
			response.sendRedirect(redirectUrl);
			return;
		}
		request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
	}

	private void handle2FaVerification(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer pendingUserId = (Integer) request.getSession().getAttribute(SESSION_PENDING_2FA_USER_ID);
		if (pendingUserId == null) {
			response.sendRedirect(request.getContextPath() + "/dang-nhap");
			return;
		}

		User pendingUser = userDAO.findById(pendingUserId);
		if (pendingUser == null) {
			request.getSession().removeAttribute(SESSION_PENDING_2FA_USER_ID);
			response.sendRedirect(request.getContextPath() + "/dang-nhap");
			return;
		}

		String action = ParamUtil.getString(request, "action");
		if ("resend".equals(action)) {
			String otp = OtpUtil.issueOtp(request, OTP_PURPOSE_LOGIN_2FA, pendingUser.getEmail(), 5);
			boolean sent = MailUtil.sendOtp(pendingUser.getEmail(), otp, "Đăng nhập 2FA");
			if (sent) {
				request.setAttribute("success", "Đã gửi lại OTP. Vui lòng kiểm tra email.");
			} else {
				request.setAttribute("error", "Không gửi được email OTP. Kiểm tra cấu hình mail.");
			}
			request.getRequestDispatcher("/views/auth/otp-2fa.jsp").forward(request, response);
			return;
		}

		if ("cancel".equals(action)) {
			request.getSession().removeAttribute(SESSION_PENDING_2FA_USER_ID);
			OtpUtil.clearOtp(request, OTP_PURPOSE_LOGIN_2FA);
			response.sendRedirect(request.getContextPath() + "/dang-nhap");
			return;
		}

		String otp = ParamUtil.getString(request, "otp");
		boolean valid = OtpUtil.verifyOtp(request, OTP_PURPOSE_LOGIN_2FA, pendingUser.getEmail(), otp);
		if (!valid) {
			request.setAttribute("error", "OTP không đúng hoặc đã hết hạn.");
			request.getRequestDispatcher("/views/auth/otp-2fa.jsp").forward(request, response);
			return;
		}

		request.getSession().removeAttribute(SESSION_PENDING_2FA_USER_ID);
		AuthUtil.setUser(request, pendingUser);

		String redirectUrl = request.getContextPath() + "/trang-chu";
		if (request.getSession().getAttribute("REDIRECT_URL") != null) {
			redirectUrl = (String) request.getSession().getAttribute("REDIRECT_URL");
			request.getSession().removeAttribute("REDIRECT_URL");
		}
		response.sendRedirect(redirectUrl);
	}
}
