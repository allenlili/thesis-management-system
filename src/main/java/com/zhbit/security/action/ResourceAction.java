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
import com.zhbit.security.dao.ResourceDao;
import com.zhbit.security.entity.Resource;
import com.zhbit.security.entity.Role;

@SuppressWarnings("serial")
@Controller("resourceAction")
@Scope("prototype")
public class ResourceAction extends BaseAction<Resource> {

	private ResourceDao resourceDao;
	
	/**
	 * 为资源添加的角色的ID
	 */
	private Long roleId;
	
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	@javax.annotation.Resource
	public void setResourceDao(ResourceDao resourceDao) {
		this.resourceDao = resourceDao;
	}

	@Override
	public GenericDao<Resource> getDao() {
		return resourceDao;
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getUrl() && !"".equals(model.getUrl())) {
			criteria.add(Restrictions.like("url", model.getUrl(), MatchMode.ANYWHERE));
		}
	}
	
	@Override
	public void afterToUpdate(Resource resource) {
		//所有角色
		List<Role> roles = resourceDao.find(DetachedCriteria.forClass(Role.class));
		//资源已有的角色
		Set<Role> resourceRoles = resource.getRoles();
		//把所有的角色去掉以有的角色，得到资源没有的角色
		for (Role role : resourceRoles) {
			roles.remove(role);
		}
		ActionContext.getContext().put("roleList", roles);
	}
	
	/**
	 * 为资源添加角色
	 * @return
	 */
	public String addRole() {
		Resource resource = resourceDao.get(model.getId());
		Role role = resourceDao.get(Role.class, roleId);
		
		//JoinTable配置在哪一方，让哪一方管理关联关系
		role.getResources().add(resource);
		resourceDao.save(role);
		
		return UPDATE_ACTION;
	}
	
	/**
	 * 为资源删除角色
	 * @return
	 */
	public String deleteRole() {
		Resource resource = resourceDao.get(model.getId());
		Role role = resourceDao.get(Role.class, roleId);
		
		role.getResources().remove(resource);
		resourceDao.save(role);
		
		return UPDATE_ACTION;
	}	
	
}
