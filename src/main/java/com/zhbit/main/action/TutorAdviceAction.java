package com.zhbit.main.action;

import javax.annotation.Resource;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.opensymphony.xwork2.ActionContext;
import com.zhbit.core.action.ActivitiBaseAction;
import com.zhbit.core.dao.GenericDao;
import com.zhbit.core.utils.EnumStatus.*;
import com.zhbit.main.dao.TutorAdviceDao;
import com.zhbit.main.entity.Topic;
import com.zhbit.main.entity.TutorAdvice;
import com.zhbit.main.service.TutorAdviceServiceI;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@SuppressWarnings("serial")
@Controller("tutorAdviceAction")
@Scope("prototype")
public class TutorAdviceAction extends ActivitiBaseAction<TutorAdvice> {
	
	private String studentUuid;
	
	private TutorAdviceServiceI tutorAdviceService;
	@Resource
	public void setTutorAdviceService(TutorAdviceServiceI tutorAdviceService) {
		this.tutorAdviceService = tutorAdviceService;
	}
	
	private TutorAdviceDao tutorAdviceDao;
	@Resource
	public void setTutorAdviceDao(TutorAdviceDao tutorAdviceDao) {
		this.tutorAdviceDao = tutorAdviceDao;
	}

	@Override
	public GenericDao<TutorAdvice> getDao() {
		return tutorAdviceDao;
	}
	
	@Override
	public void beforeSave(TutorAdvice model) {
		User user = getCurrentUser();
		if (model.getUser() == null) {
			model.setUser(user);
		}
		if (model.getStatus() == null) {
			model.setStatus(StatusEnum.unstart.getValue());
		}
		Student student = (Student) tutorAdviceDao.findByUuid(Student.class, studentUuid);
		Teacher teacher = student.getTeacher();
		Topic topic = student.getTopic();
		model.setStudent(student);
		model.setTopic(topic);
		model.setTeacher(teacher);
		model.setStatus(StatusEnum.unstart.getValue());
		model.setUuid(student.getUuid());
	}
	
	@Override
	public void afterSave(TutorAdvice model) {
		tutorAdviceService.saveTutorAdviceToStudentAndTeacher(model);
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getStartDate()) {
			criteria.add(Restrictions.ge("startDate", model.getStartDate()));
		}
		if (null != model.getEndDate()) {
			criteria.add(Restrictions.le("endDate", model.getEndDate()));
		}
		if (null != model.getStatus()) {
			if (StatusEnum.finished.getValue().equals(model.getStatus())) {
				Criterion c1 = Restrictions.eq("status", StatusEnum.success.getValue());
				Criterion c2 = Restrictions.eq("status", StatusEnum.fail.getValue());
				criteria.add(Restrictions.or(c1, c2));
			} else {
				criteria.add(Restrictions.eq("status", model.getStatus()));
			}
		}
		if (model.getQueryByAllUser() == null || "".equals(model.getQueryByAllUser())) {
			criteria.createAlias("user", "u");
			criteria.add(Restrictions.eq("u.id", getCurrentUser().getId()));
		}
	}
	
    public String findMyStudents(){
    	Teacher teacher = (Teacher) tutorAdviceDao.findByUuid(Teacher.class, getCurrentUser().getUuid());
    	ActionContext.getContext().put("students", teacher.getStudents());
    	ActionContext.getContext().put("teacher", teacher);
    	return "toMyStudent";
    }
    
    public String forwardTutorAdvice(){
    	tutorAdviceService.doForwardTutorAdvice(getCurrentUser());
    	return LIST_ACTION;
    }

	public String getStudentUuid() {
		return studentUuid;
	}

	public void setStudentUuid(String studentUuid) {
		this.studentUuid = studentUuid;
	}
}
