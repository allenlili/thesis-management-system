package com.zhbit.main.service;


import com.zhbit.main.entity.ViewerAdvice;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.User;

public interface ViewerAdviceServiceI {
	public Student getStudent(String uuid);
	public void saveViewerAdviceToStudentAndTeacher(ViewerAdvice model);
	public void doForwardViewerAdvice(User currentUser);
}
