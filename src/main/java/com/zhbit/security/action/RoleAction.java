package com.zhbit.security.action;

import java.util.List;
import java.util.Set;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.zhbit.core.action.BaseAction;
import com.zhbit.core.dao.GenericDao;
import com.zhbit.security.dao.RoleDao;
import com.zhbit.security.entity.Resource;
import com.zhbit.security.entity.Role;
import com.zhbit.security.entity.User;

@SuppressWarnings("serial")
@Controller("roleAction")
@Scope("prototype")
public class RoleAction extends BaseAction<Role> {


	private RoleDao roleDao;
	
	private Long userId;
	private Long resourceId;

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public void setResourceId(Long resourceId) {
		this.resourceId = resourceId;
	}

	@javax.annotation.Resource
	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}

	@Override
	public GenericDao<Role> getDao() {
		return roleDao;
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getRoleName() && !"".equals(model.getRoleName())) {
			criteria.add(Restrictions.like("roleName", model.getRoleName(),
					MatchMode.ANYWHERE));
		}
	}
	
	@Override
	public void afterToUpdate(Role role) {
		List<User> users = roleDao.find(DetachedCriteria.forClass(User.class));
		List<Resource> resources = roleDao.find(DetachedCriteria.forClass(Resource.class));
		Set<User> roleUsers = role.getUsers();
		Set<Resource> roleResources = role.getResources();
		
		for (User user : roleUsers) {
			users.remove(user);
		}
		for (Resource resource : roleResources) {
			resources.remove(resource);
		}
		
		ActionContext.getContext().put("userList", users);
		ActionContext.getContext().put("resourceList", resources);
	}
	
	/**
	 * 为角色添加用户
	 * @return
	 */
	public String addUser() {
		Role role = roleDao.get(model.getId());
		User user = roleDao.get(User.class, userId);
		
		role.getUsers().add(user);
		roleDao.save(role);
		
		return UPDATE_ACTION;
	}
	
	/**
	 * 为角色删除用户
	 * @return
	 */
	public String deleteUser() {
		Role role = roleDao.get(model.getId());
		User user = roleDao.get(User.class, userId);
		
		role.getUsers().remove(user);
		roleDao.save(role);
		
		return UPDATE_ACTION;
	}
	
	/**
	 * 为角色添加资源
	 * @return
	 */
	public String addResource() {
		Role role = roleDao.get(model.getId());
		Resource resource = roleDao.get(Resource.class, resourceId);
		
		role.getResources().add(resource);
		roleDao.save(role);
		
		return UPDATE_ACTION;
	}
	
	/**
	 * 为角色删除资源
	 * @return
	 */
	public String deleteResource() {
		Role role = roleDao.get(model.getId());
		Resource resource = roleDao.get(Resource.class, resourceId);
		
		role.getResources().remove(resource);
		roleDao.save(role);
		
		return UPDATE_ACTION;
	}		
	
}
