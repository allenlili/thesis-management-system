package com.zhbit.main.service;


import com.zhbit.main.entity.TutorAdvice;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.User;

public interface TutorAdviceServiceI {
	public Student getStudent(String uuid);
	public void saveTutorAdviceToStudentAndTeacher(TutorAdvice model);
	public void doForwardTutorAdvice(User currentUser);
}
