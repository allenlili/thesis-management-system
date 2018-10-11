package com.zhbit.main.action;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.zhbit.core.action.BaseAction;
import com.zhbit.core.dao.GenericDao;
import com.zhbit.security.dao.StudentDao;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.service.StudentServiceI;

@SuppressWarnings("serial")
@Controller("tutorRecorderAction")
@Scope("prototype")
public class TutorRecorderAction extends BaseAction<Student> {
	
	private static Logger logger = Logger.getLogger(TutorRecorderAction.class); 
	
	private StudentDao studentDao;
	@Resource
	public void setStudentDao(StudentDao studentDao) {
		this.studentDao = studentDao;
	}
	
	private StudentServiceI studentService;
	@Resource
	public void setStudentService(StudentServiceI studentService) {
		this.studentService = studentService;
	}
		
	@Override
	public GenericDao<Student> getDao() {
		return studentDao;
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (model.getName() != null && !"".equals(model.getName())) {
			criteria.add(Restrictions.like("name", model.getName(),MatchMode.ANYWHERE));
		}
		if (model.getStudentId() != null && !"".equals(model.getStudentId())) {
			criteria.add(Restrictions.like("studentId", model.getStudentId(),MatchMode.ANYWHERE));
		}
		if(model.getTeacher() == null){
			Teacher teacher = (Teacher) studentDao.findByUuid(Teacher.class, getCurrentUser().getUuid());
			criteria.createAlias("teacher", "t")
			.add(Restrictions.eq("t.id", teacher.getId()));
		}
	}
	
	public String watch(){
		logger.info("watch()");
		Map<String, Object> map = studentService.watchTutorRecorder(model);
		ActionContext.getContext().put("result", map);
		return "toTutorRecorder";
	}
}
