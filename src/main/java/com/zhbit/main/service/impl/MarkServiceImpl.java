package com.zhbit.main.service.impl;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.zhbit.core.utils.EnumStatus.StatusEnum;
import com.zhbit.main.dao.MarkDao;
import com.zhbit.main.dao.TopicDao;
import com.zhbit.main.entity.Mark;
import com.zhbit.main.service.MarkServiceI;
import com.zhbit.security.dao.StudentDao;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@Service("markService")
public class MarkServiceImpl implements MarkServiceI {

	private static Logger logger = Logger.getLogger(MarkServiceImpl.class);
	
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
	
	private MarkDao markDao;
	@Resource
	public void setMarkDao(MarkDao markDao) {
		this.markDao = markDao;
	}
	
	@SuppressWarnings("unused")
	private TopicDao topicDao;
	@Resource
	public void setTopicDao(TopicDao topicDao) {
		this.topicDao = topicDao;
	}
	
	@Override
	public Student getStudent(String uuid) {
		logger.info("getStudent(String uuid)");
		Student student = (Student) studentDao.findByUuid(Student.class, uuid);
		return student;
	}

	@Override
	public Mark findMyMark(User user) {
		Student student = (Student) studentDao.findByUuid(Student.class, user.getUuid());
		return student.getMark();
	}

	@Override
	public boolean doForwardGrade(String[] uuids, String[] lectureGrades,User user) {
		Teacher teacher = (Teacher) teacherDao.findByUuid(Teacher.class, user.getUuid());
		teacher.setForwardLectureGradeStatus(StatusEnum.success.getValue());
		teacherDao.save(teacher);
		List<String> strings1 = Arrays.asList(uuids);
		logger.info(strings1);
		List<String> strings2 = Arrays.asList(lectureGrades);
		logger.info(strings2);
		Mark mark = null;
		Student student = null;
		for(int i=0; i<strings1.size(); i++){
			student = (Student) studentDao.findByUuid(Student.class, strings1.get(i));
			logger.info(student);
			mark = student.getMark();
			mark.setLectureGrade(Integer.parseInt(strings2.get(i)));
			mark.setStatus(StatusEnum.success.getValue());
			mark.setStartDate(new Date());
			logger.info(mark.calculate());
			mark.setTotalGrade(mark.calculate());
			markDao.save(mark);
		}
		return true;
	}
	
}
