package com.zhbit.security.action;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.SessionAware;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.zhbit.core.action.BaseAction;
import com.zhbit.core.dao.GenericDao;
import com.zhbit.core.utils.MD5Util;
import com.zhbit.core.utils.Constant.SystemConstant;
import com.zhbit.security.dao.UserDao;
import com.zhbit.security.entity.Role;
import com.zhbit.security.entity.User;

/**
 * UserAction：负责控制User实体类相关活动的页面调度和业务分配
 * @author AllenLi
 *
 */
@SuppressWarnings("serial")
@Controller("userAction")
@Scope("prototype")
public class UserAction extends BaseAction<User> implements SessionAware{
	
	private static Logger logger = Logger.getLogger(UserAction.class); 
	
	private UserDao userDao;
	@Resource
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	private Long roleId;
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	
	/**验证码*/
	private String securityCode;
	
	/**错误信息提示*/
	private String error;
	
	/**注入session*/
	@SuppressWarnings("unused")
	private Map<String, Object> session;
	
	@Override
	public GenericDao<User> getDao() {
		return userDao;
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getUserName() && !"".equals(model.getUserName())) {
			criteria.add(Restrictions.like("userName", model.getUserName(),
					MatchMode.ANYWHERE));
		}
	}
	
	@Override
	public void beforeSave(User model) {
		if(model.getPassword()!=null){
			model.setPassword(MD5Util.getMD5(model.getPassword()));
		}
	}
	
	@Override
	public void afterToUpdate(User user) {
		List<Role> roles = userDao.find(DetachedCriteria.forClass(Role.class));
		Set<Role> userRoles = user.getRoles();
		for (Role role : userRoles) {
			roles.remove(role);
		}
		ActionContext.getContext().put("roleList", roles);
	}
	
	public String addRole() {
		User user = userDao.get(model.getId());
		Role role = userDao.get(Role.class, roleId);
		role.getUsers().add(user);
		userDao.save(role);
		return UPDATE_ACTION;
	}
	
	public String deleteRole() {
		User user = userDao.get(model.getId());
		Role role = userDao.get(Role.class, roleId);
		role.getUsers().remove(user);
		userDao.save(role);
		return UPDATE_ACTION;
	}

	/**
	 * 用户登陆
	 * @return
	 */
	public String login() {
//		String serverCode = (String)session.get("SESSION_SECURITY_CODE");
//        if(!serverCode.equals(securityCode)){
//        	error = "验证码输入有误！";
//            return LOGIN;
//        }		
		logger.info(model.getUserName()+" "+ model.getPassword()+" "+model.getUserType());
		User user = userDao.login(model.getUserName(), model.getPassword(),model.getUserType());
		if (null != user && user.getUserType().equals(SystemConstant.STUDENT)) {
			ActionContext.getContext().getSession().put(SystemConstant.CURRENT_USER, user);
			return STUDENT_INDEX;
		}else if(null != user && user.getUserType().equals(SystemConstant.TEACHER)){
			ActionContext.getContext().getSession().put(SystemConstant.CURRENT_USER, user);
			return TEACHER_INDEX;			
		}else {
			error = "用户名或密码输入有误！";
			return LOGIN;
		}
	}
	
	/** 
	 * 用户注销
	 * @return
	 */
	public String logout() {
		ActionContext.getContext().getSession().remove(SystemConstant.CURRENT_USER);
		return LOGIN;
	}

	public String getSecurityCode() {
		return securityCode;
	}

	public void setSecurityCode(String securityCode) {
		this.securityCode = securityCode;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}
}
