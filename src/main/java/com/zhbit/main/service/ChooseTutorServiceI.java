package com.zhbit.main.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.zhbit.main.entity.Wish;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

public interface ChooseTutorServiceI {

	public List<Teacher> findPossibleTeachers(User user);
	public Wish findMyWish(User user);
	public void doWish(User user, List<String> list);
	public Map<String,Teacher> getTeachersFromWish(Wish wish);
	public Teacher getMyTutor(User user);
	public Teacher findMyselfTeacher(User user);
	public Map<String, Object> findUnselectedStudentsEachRun(Teacher teacher);
	public String notifyWhichRun(Teacher teacher);
	public boolean doWishStudent(User user,String[] ids);
	boolean doUnWishStudent(User user, String[] ids);
	public void doChangeTeacherChooseSutdentRunNum(User user);
	public List<Student> doVerifyMySelectedStudent(Teacher myselfTeacher);
	public Set<Student> getMyStudents(Teacher myselfTeacher);
}
