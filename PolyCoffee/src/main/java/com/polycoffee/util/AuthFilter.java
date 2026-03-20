package com.polycoffee.util;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter({ "/manager/*", "/employee/*" })
public class AuthFilter implements Filter {
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		String uriString = req.getRequestURI();
		String queryString = req.getQueryString();
		String error = "";
		if (!AuthUtil.isAuthenticated(req)) {
			error = "401";
		} else if (!AuthUtil.isManager(req) && uriString.contains("/manager")) {
			error = "403";
		}
		if (!error.isEmpty()) {
			String redirectUrl = uriString;
			if (queryString != null && !queryString.isBlank()) {
				redirectUrl += "?" + queryString;
			}
			req.getSession().setAttribute("REDIRECT_URL", redirectUrl);
			res.sendRedirect(req.getContextPath() + "/dang-nhap");
		} else {
			chain.doFilter(req, res);
		}
	}
}
