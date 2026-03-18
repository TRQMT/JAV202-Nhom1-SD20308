package com.polycoffee.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter({ "/manager/*", "/employee/*" })
public class AuthFilter implements Filter {
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		String uriString = req.getRequestURI();
		String error = "";
		if (!AuthUtil.isAuthenticated(req)) {
			error = "401";
		} else if (!AuthUtil.isManager(req) && uriString.contains("/manager")) {
			error = "403";
		}
		if (!error.isEmpty()) {
			req.getSession().setAttribute("REDIRECT_URL", uriString);
			res.sendRedirect(req.getContextPath() + "/dang-nhap");
		} else {
			chain.doFilter(req, res);
		}

		chain.doFilter(req, res);
	}
}
