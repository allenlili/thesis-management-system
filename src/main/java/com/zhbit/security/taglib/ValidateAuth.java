package com.zhbit.security.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zhbit.core.utils.Constant.SystemConstant;
import com.zhbit.security.dao.UserDao;
import com.zhbit.security.entity.User;

/**
 * 自定义标签：根据当前用户的权限隐藏元素
 * @author AllenLi
 *
 */
@SuppressWarnings("serial")
public class ValidateAuth extends TagSupport {
	
	private UserDao userDao;
	
	private String path;
	
	/** 
	 * EVAL_BODY_INCLUDE：显示标签中间内容
	 * SKIP_BODY：隐藏标签中间内容
	 * 
	 */
	@Override
	public int doStartTag() throws JspException {
		ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(this.pageContext.getServletContext());
		userDao = ac.getBean(UserDao.class);		
		User currentUser = (User) this.pageContext.getSession().getAttribute(SystemConstant.CURRENT_USER);
		if (userDao.validateAuth(currentUser.getId(), path)) {
			return EVAL_BODY_INCLUDE;
		} else {
			return SKIP_BODY;
		}
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

}
