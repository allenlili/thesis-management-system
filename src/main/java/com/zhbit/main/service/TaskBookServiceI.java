package com.zhbit.main.service;

import com.zhbit.main.entity.TaskBook;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

public interface TaskBookServiceI {
	public Student getStudent(String uuid);
	public Teacher getTeacher(User user);
	public TaskBook doFindMyTaskBook(User currentUser);
}
