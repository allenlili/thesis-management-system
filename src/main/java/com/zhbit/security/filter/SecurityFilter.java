package com.zhbit.security.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zhbit.core.utils.Constant.SystemConstant;
import com.zhbit.security.dao.UserDao;
import com.zhbit.security.entity.User;

/**
 * Servlet Filter implementation class SecurityFilter
 */
public class SecurityFilter implements Filter {
	
	/**
	 * 放过的地址列表,这些地址不进行登陆，权限判断	
	 */
	private String[] letPassUrls;
	/**
	 * 登陆页面 
	 */
	private String loginPage;
	
	private String noAuthPage;
	
	private UserDao userDao;

	@Override
	public void init(FilterConfig config) throws ServletException {
		String url = config.getInitParameter("letPassUrls");
		letPassUrls = url.split(",");
		loginPage = config.getInitParameter("loginPage");
		noAuthPage = config.getInitParameter("noAuthPage");
		
		//获取web.xml中ContextLoaderListener加载的spring容器
		ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(config.getServletContext());
		userDao = ac.getBean(UserDao.class);
	}
	
	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
		HttpSession session = request.getSession();
		//当前访问地址
		String path = request.getServletPath();
		
		//放过一些访问地址
		for (String regex : letPassUrls) {
			if (path.matches(regex)) {
				chain.doFilter(request, response);
				return;
			}
		}
		//登陆判断
		User currentUser = (User) session.getAttribute(SystemConstant.CURRENT_USER);
		if (null == currentUser) {
			response.sendRedirect(request.getContextPath() + loginPage);
			return;
		}
		
		//权限判断
		boolean b = userDao.validateAuth(currentUser.getId(), path);
		if (b) {
			chain.doFilter(request, response);
		} else {
			response.sendRedirect(request.getContextPath() + noAuthPage);
		}
	}

	@Override
	public void destroy() {
		
	}
	
}
