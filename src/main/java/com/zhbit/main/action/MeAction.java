package com.zhbit.main.action;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.zhbit.core.action.AbstractAction;
import com.zhbit.security.action.UserAction;
import com.zhbit.security.dao.StudentDao;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.dao.UserDao;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@SuppressWarnings("serial")
@Controller("meAction")
@Scope("prototype")
public class MeAction extends AbstractAction{

	private static Logger logger = Logger.getLogger(UserAction.class); 
	private Student student;
	private Teacher teacher;
	private User user;
	
	private StudentDao studentDao;
	@Resource
	public void setStudentDao(StudentDao studentDao) {
		this.studentDao = studentDao;
	}
	
	private TeacherDao teacherDao;
	@Resource
	public void setTeacherDao(TeacherDao teacherDao) {
		this.teacherDao = teacherDao;
	}
	
	private UserDao userDao;
	@Resource
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}	
	
	/**
	 * 跳到学生个人信息
	 * @return
	 */
	public String toUpdateStuInfo(){
		logger.info("toUpdateStuInfo()");
		DetachedCriteria criteria = DetachedCriteria.forClass(Student.class);
		criteria.add(Restrictions.eq("studentId", getCurrentUser().getUserName()));
		List<Student> students = studentDao.find(criteria);
		if(!students.isEmpty()){
			student = students.get(0);
		}
		return "toStuInfoUpdate";
	}
	
	/**
	 * 跳到学生用户信息修改页面
	 * @return
	 */
	public String toModifyStuUserInfo(){
		DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
		criteria.add(Restrictions.eq("userName", getCurrentUser().getUserName()));		
		List<User> users = userDao.find(criteria);
		if(!users.isEmpty()){
			user = users.get(0);
		}
		return "toStuUserUpdate";
	}
	
	public String saveStuInfo(){
		studentDao.saveStuInfo(student);
		return "toStuInfoUpdatePage";
	}
	
	public String saveStuUserInfo(){
		userDao.savePersonalUserInfo(user);
		return "toStuUserUpdatePage";
	}
	
	/**
	 * 跳到学生老师个人信息
	 * @return
	 */	
	public String toUpdateTeaInfo(){
		DetachedCriteria criteria = DetachedCriteria.forClass(Teacher.class);
		criteria.add(Restrictions.eq("teacherId", getCurrentUser().getUserName()));
		List<Teacher> teachers = teacherDao.find(criteria);
		if(!teachers.isEmpty()){
			teacher = teachers.get(0);
		}
		return "toTeaInfoUpdate";
	}	

	/**
	 * 跳到老师用户信息修改页面
	 * @return
	 */
	public String toModifyTeaUserInfo(){
		DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
		criteria.add(Restrictions.eq("userName", getCurrentUser().getUserName()));		
		List<User> users = userDao.find(criteria);
		if(!users.isEmpty()){
			user = users.get(0);
		}		
		return "toTeaUserUpdate";
	}
	
	public String saveTeaInfo(){
		teacherDao.saveTeaInfo(teacher);;
		return "toTeaInfoUpdatePage";
	}
	
	public String saveTeaUserInfo(){
		userDao.savePersonalUserInfo(user);
		return "toTeaUserUpdatePage";
	}

	
	
	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	public Teacher getTeacher() {
		return teacher;
	}

	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
}
