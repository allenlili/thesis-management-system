package com.zhbit.main.service;

import com.zhbit.main.entity.Mark;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.User;

public interface MarkServiceI {
	public Student getStudent(String uuid);
	public Mark findMyMark(User user);
	public boolean doForwardGrade(String[] uuids, String[] lectureGrades,User user);
}
