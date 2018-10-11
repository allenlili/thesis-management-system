package com.zhbit.main.service.impl;


import java.util.Date;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.zhbit.core.utils.EnumStatus.StatusEnum;
import com.zhbit.main.dao.MarkDao;
import com.zhbit.main.dao.ThesisScriptDao;
import com.zhbit.main.dao.ViewerAdviceDao;
import com.zhbit.main.entity.Mark;
import com.zhbit.main.entity.ThesisScript;
import com.zhbit.main.entity.ViewerAdvice;
import com.zhbit.main.service.ViewerAdviceServiceI;
import com.zhbit.security.dao.StudentDao;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@Service("viewerAdviceService")
public class ViewerAdviceServiceImpl implements ViewerAdviceServiceI {

	private static Logger logger = Logger.getLogger(ViewerAdviceServiceImpl.class);
	
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
	
	private ViewerAdviceDao viewerAdviceDao;
	@Resource
	public void setViewerAdviceDao(ViewerAdviceDao viewerAdviceDao) {
		this.viewerAdviceDao = viewerAdviceDao;
	}
	
	private MarkDao markDao;
	@Resource
	public void setMarkDao(MarkDao markDao) {
		this.markDao = markDao;
	}
	
	private ThesisScriptDao thesisScriptDao;
	@Resource
	public void setThesisScriptDao(ThesisScriptDao thesisScriptDao) {
		this.thesisScriptDao = thesisScriptDao;
	}
	
	@Override
	public Student getStudent(String uuid) {
		Student student = (Student) studentDao.findByUuid(Student.class, uuid);
		return student;
	}

	@Override
	public void saveViewerAdviceToStudentAndTeacher(ViewerAdvice model) {
		logger.info("saveViewerAdviceToStudent(ViewerAdvice model)");
		ViewerAdvice viewerAdvice = (ViewerAdvice) viewerAdviceDao.findByUuid(ViewerAdvice.class, model.getUuid());
		Student student = model.getStudent();
		ThesisScript lastThesisScript = student.getLastThesisScript();
		Teacher viewer = model.getTeacher();
		lastThesisScript.setViewer(viewer);
		thesisScriptDao.save(lastThesisScript);
		student.setViewerAdvice(viewerAdvice);
		viewer.getViewerAdvices().add(viewerAdvice);
		Mark mark = student.getMark();
		if(mark==null){
			mark = new Mark();
			mark.setStudent(student);
			mark.setViewer(viewer);
			mark.setUuid(student.getUuid());
			mark.setViewerGrade(model.getViewerGrade());
			mark.setStatus(StatusEnum.unstart.getValue());
			markDao.save(mark);
			mark = (Mark) markDao.findByUuid(Mark.class, student.getUuid());
			student.setMark(mark);
		}else{
			mark.setViewer(viewer);
			mark.setViewerGrade(model.getViewerGrade());
			markDao.save(mark);
		}
		studentDao.save(student);
		teacherDao.save(viewer);
	}

	@Override
	public void doForwardViewerAdvice(User currentUser) {
		Teacher teacher = (Teacher) teacherDao.findByUuid(Teacher.class, currentUser.getUuid());
		Set<ViewerAdvice> viewerAdvices = teacher.getViewerAdvices();
		for (ViewerAdvice viewerAdvice : viewerAdvices) {
			viewerAdvice.setStatus(StatusEnum.success.getValue());
			viewerAdvice.setStartDate(new Date());
			viewerAdviceDao.save(viewerAdvice);
		}
		teacher.setForwardViewerGradeStatus(StatusEnum.success.getValue());
		teacherDao.save(teacher);
	}
}
