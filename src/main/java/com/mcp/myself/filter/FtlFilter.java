

package com.mcp.myself.filter;

import com.mcp.myself.util.HttpUtils;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * 
 * Ftl文件安全过滤器
 * 
 * @author w44
 * 
 */
public class FtlFilter implements Filter {


	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub

	}

	public void doFilter(ServletRequest servletRequest,
			ServletResponse servletResponse, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		response.sendRedirect(HttpUtils.getBasePath(request) + "/error/404.htm");
	}

	public void destroy() {
		// TODO Auto-generated method stub

	}

}
