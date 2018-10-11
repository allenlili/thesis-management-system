package com.zhbit.security.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.zhbit.core.dao.GenericDao;
import com.zhbit.core.utils.MD5Util;
import com.zhbit.security.entity.Resource;
import com.zhbit.security.entity.Role;
import com.zhbit.security.entity.User;

@Repository
public class UserDao extends GenericDao<User> {
	
	/**
	 * 登陆
	 * @param userName
	 * @param password
	 * @return
	 */
	public User login(String userName, String password,String userType) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(User.class);
		criteria.add(Restrictions.eq("userName", userName));
		System.out.println(MD5Util.getMD5(password));
		criteria.add(Restrictions.eq("password", MD5Util.getMD5(password)));
		criteria.add(Restrictions.eq("userType", userType));
		User user = (User) criteria.uniqueResult();
		return user;
	}
	
	/**
	 * 判断当前用户，有没有访问当前地址的权限
	 * @param userId 当前用户主键
	 * @param path 当前访问地址
	 * @return
	 */
	public boolean validateAuth(Long userId, String path) {
		Resource resource = getResourceForPath(path);
		
		return doValidate(userId, resource);
	}

	private boolean doValidate(Long userId, Resource resource) {
		//判断用户的角色是否属于资源的某一个角色,属于：有权限,不属于：没权限
		User currentUser = this.get(userId);
		if (resource != null) {
			for (Role resourceRole : resource.getRoles()) {
				for (Role userRole : currentUser.getRoles()) {
					if (resourceRole.getId().equals(userRole.getId())) {
						return true;
					}
				}
			}
			return false;
		} else {
			return true;
		}
	}

	private Resource getResourceForPath(String path) {
		List<Resource> resources = super.find(DetachedCriteria.forClass(Resource.class));
		Resource resource = null;
		for (Resource r : resources) {
			//找到跟访问地址"path"匹配的resource
			if (path.matches(r.getUrl())) {
				if (resource == null) {
					resource = r;
				} else {
					//url长度长的优先级高
					if (resource.getUrl().length() < r.getUrl().length()) {
						resource = r;
					}				
				}
			}
		}
		return resource;
	}
	
	public void savePersonalUserInfo(User user){
		User user2 = (User) findByUuid(User.class, user.getUuid());
		user2.setPassword(MD5Util.getMD5(user.getPassword()));
		sessionFactory.getCurrentSession().save(user2);
	}
}
