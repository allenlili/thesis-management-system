package com.zhbit.security.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.zhbit.core.dao.GenericDao;
import com.zhbit.security.entity.Role;
import com.zhbit.security.entity.User;

@Repository
public class RoleDao extends GenericDao<Role> {

	public List<Role> findRolesByUser(User user) {
		DetachedCriteria criteria = DetachedCriteria.forClass(Role.class);
		criteria.createAlias("users", "us").add(Restrictions.eq("us.uuid", user.getUuid()));
		List<Role> roles = find(criteria);
		return roles;
	}
	
	public Role fineByRoleName(String roleName){
		DetachedCriteria criteria = DetachedCriteria.forClass(Role.class);
		criteria.add(Restrictions.eq("roleName", roleName));
		List<Role> roles = find(criteria);
		return roles.isEmpty()?null:roles.get(0);
	}

}
