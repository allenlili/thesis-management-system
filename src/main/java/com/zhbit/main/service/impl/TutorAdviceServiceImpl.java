package com.zhbit.main.service.impl;


import java.util.Date;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.zhbit.core.utils.EnumStatus.StatusEnum;
import com.zhbit.main.dao.MarkDao;
import com.zhbit.main.dao.TutorAdviceDao;
import com.zhbit.main.dao.TopicDao;
import com.zhbit.main.entity.Mark;
import com.zhbit.main.entity.TutorAdvice;
import com.zhbit.main.service.TutorAdviceServiceI;
import com.zhbit.security.dao.StudentDao;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@Service("tutorAdviceService")
public class TutorAdviceServiceImpl implements TutorAdviceServiceI {

	private static Logger logger = Logger.getLogger(TutorAdviceServiceImpl.class);
	
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
	
	private TutorAdviceDao tutorAdviceDao;
	@Resource
	public void setTutorAdviceDao(TutorAdviceDao tutorAdviceDao) {
		this.tutorAdviceDao = tutorAdviceDao;
	}
	
	@SuppressWarnings("unused")
	private TopicDao topicDao;
	@Resource
	public void setTopicDao(TopicDao topicDao) {
		this.topicDao = topicDao;
	}
	
	private MarkDao markDao;
	@Resource
	public void setMarkDao(MarkDao markDao) {
		this.markDao = markDao;
	}	
	
	@Override
	public Student getStudent(String uuid) {
		Student student = (Student) studentDao.findByUuid(Student.class, uuid);
		return student;
	}

	@Override
	public void saveTutorAdviceToStudentAndTeacher(TutorAdvice model) {
		logger.info("saveTutorAdviceToStudent(TutorAdvice model)");
		TutorAdvice tutorAdvice = (TutorAdvice) tutorAdviceDao.findByUuid(TutorAdvice.class, model.getUuid());
		Student student = model.getStudent();
		Teacher tutor = model.getTeacher();
		student.setTutorAdvice(tutorAdvice);
		tutor.getTutorAdvices().add(tutorAdvice);
		Mark mark = student.getMark();
		if(mark==null){
			mark = new Mark();
			mark.setStudent(student);
			mark.setTutor(tutor);
			mark.setUuid(student.getUuid());
			mark.setTutorGrade(model.getTutorGrade());
			mark.setStatus(StatusEnum.unstart.getValue());
			markDao.save(mark);
			mark = (Mark) markDao.findByUuid(Mark.class, student.getUuid());
			student.setMark(mark);
		}else{
			mark.setTutor(tutor);
			mark.setTutorGrade(model.getTutorGrade());
			markDao.save(mark);
		}		
		studentDao.save(student);
		teacherDao.save(tutor);
	}

	@Override
	public void doForwardTutorAdvice(User currentUser) {
		Teacher teacher = (Teacher) teacherDao.findByUuid(Teacher.class, currentUser.getUuid());
		Set<TutorAdvice> tutorAdvices = teacher.getTutorAdvices();
		for (TutorAdvice tutorAdvice : tutorAdvices) {
			tutorAdvice.setStatus(StatusEnum.success.getValue());
			tutorAdvice.setStartDate(new Date());
			tutorAdviceDao.save(tutorAdvice);
		}
		teacher.setForwardTutorGradeStatus(StatusEnum.success.getValue());
		teacherDao.save(teacher);
	}
}
