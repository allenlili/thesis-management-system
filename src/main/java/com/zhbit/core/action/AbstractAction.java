package com.zhbit.core.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.zhbit.core.utils.Constant.SystemConstant;
import com.zhbit.security.entity.User;



@SuppressWarnings("serial")
public abstract class AbstractAction extends ActionSupport implements ServletRequestAware, ServletResponseAware{

	protected HttpServletRequest request;
	protected HttpServletResponse response;
	public static final String LIST  = "list";
	public static final String LIST_ACTION  = "listAction";
	public static final String ADD  = "add";
	public static final String UPDATE  = "update";
	public static final String UPDATE_ACTION = "updateAction";
	public static final String STUDENT_INDEX  = "student_index";
	public static final String TEACHER_INDEX  = "teacher_index";
	public static final String PAGE  = "page";
	
	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}
	
	protected User getCurrentUser() {
		return (User) ActionContext.getContext().getSession().get(SystemConstant.CURRENT_USER);
	}
	
}
