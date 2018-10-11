package com.zhbit.main.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import com.zhbit.core.utils.EnumStatus.StatusEnum;
import com.zhbit.main.dao.TaskBookDao;
import com.zhbit.main.entity.TaskBook;
import com.zhbit.main.service.TaskBookServiceI;
import com.zhbit.security.dao.StudentDao;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@Service("taskBookService")
public class TaskBookServiceImpl implements TaskBookServiceI {

	private static Logger logger = Logger.getLogger(TaskBookServiceImpl.class);
	
	private TeacherDao teacherDao;
	@Resource
	public void setTeacherDao(TeacherDao teacherDao) {
		this.teacherDao = teacherDao;
	}
	
	private StudentDao studentDao;
	@Resource
	public void setStudentDao(StudentDao studentDao) {
		this.studentDao = studentDao;
	}
	
	private TaskBookDao taskBookDao;
	@Resource
	public void setTaskBookDao(TaskBookDao taskBookDao) {
		this.taskBookDao = taskBookDao;
	}
	
	@Override
	public Student getStudent(String uuid) {
		Student student = (Student) studentDao.findByUuid(Student.class, uuid);
		return student;
	}

	@Override
	public Teacher getTeacher(User user) {
		Teacher teacher = (Teacher) teacherDao.findByUuid(Teacher.class, user.getUuid());
		return teacher;
	}

	@Override
	public TaskBook doFindMyTaskBook(User currentUser) {
		logger.info("findMyTaskBook(User currentUser)");
		TaskBook taskBook = null;
		Student student = (Student) studentDao.findByUuid(Student.class, currentUser.getUuid());
		taskBook = student.getTaskBook();
		if(student.getTaskBook()!=null){
			return taskBook;
		}
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(TaskBook.class);
		detachedCriteria.createAlias("student", "s")
		.add(Restrictions.eq("s.id", student.getId()))
		.add(Restrictions.eq("status", StatusEnum.success.getValue()));
		List<TaskBook> taskBooks = taskBookDao.find(detachedCriteria);
		if(taskBooks != null && !taskBooks.isEmpty()){
			taskBook = taskBooks.get(0);
			student.setTaskBook(taskBook);
			studentDao.save(student);
			return taskBook;
		}
		return taskBook;
	}
}
