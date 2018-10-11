package com.zhbit.main.service;

import com.zhbit.main.entity.MidCheck;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

public interface MidCheckServiceI {
	public Teacher getTeacher(User user);
	public MidCheck findMyMidCheck(User currentUser);
	public void doCreateMidCheck(User currentUser);
}
