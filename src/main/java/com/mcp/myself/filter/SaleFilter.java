package com.mcp.myself.filter;

import com.mcp.myself.constant.SystemConstant;
import com.mongodb.DBObject;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 
 * 管理员过滤器
 * 
 * @author w44
 * 
 */
public class SaleFilter implements Filter {


	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest servletRequest,
			ServletResponse servletResponse, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		String admin = (String) request.getSession().getAttribute(
				SystemConstant.SESSION_SALE);
		if (admin == null) {
			response.sendRedirect("/laundry/student/login.html");
		} else {
			chain.doFilter(request, response);
		}
	}

	public void destroy() {
		// TODO Auto-generated method stub

	}

}
