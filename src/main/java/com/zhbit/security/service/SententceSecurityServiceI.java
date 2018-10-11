package com.zhbit.security.service;

import org.hibernate.criterion.DetachedCriteria;

import com.zhbit.security.entity.User;

public interface SententceSecurityServiceI {
	public void getFindSecurityByRole(User user,DetachedCriteria criteria);
}
