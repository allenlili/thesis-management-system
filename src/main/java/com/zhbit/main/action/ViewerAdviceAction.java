package com.zhbit.main.action;

import java.util.HashSet;
import java.util.Set;

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
import com.zhbit.main.dao.ViewerAdviceDao;
import com.zhbit.main.entity.Topic;
import com.zhbit.main.entity.ViewerAdvice;
import com.zhbit.main.service.ViewerAdviceServiceI;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@SuppressWarnings("serial")
@Controller("viewerAdviceAction")
@Scope("prototype")
public class ViewerAdviceAction extends ActivitiBaseAction<ViewerAdvice> {
	
	private String studentUuid;
	
	private ViewerAdviceServiceI viewerAdviceService;
	@Resource
	public void setViewerAdviceService(ViewerAdviceServiceI viewerAdviceService) {
		this.viewerAdviceService = viewerAdviceService;
	}
	
	private ViewerAdviceDao viewerAdviceDao;
	@Resource
	public void setViewerAdviceDao(ViewerAdviceDao viewerAdviceDao) {
		this.viewerAdviceDao = viewerAdviceDao;
	}

	@Override
	public GenericDao<ViewerAdvice> getDao() {
		return viewerAdviceDao;
	}
	
	@Override
	public void beforeSave(ViewerAdvice model) {
		User user = getCurrentUser();
		if (model.getUser() == null) {
			model.setUser(user);
		}
		if (model.getStatus() == null) {
			model.setStatus(StatusEnum.unstart.getValue());
		}
		Student student = (Student) viewerAdviceDao.findByUuid(Student.class, studentUuid);
		Teacher viewer = student.getTeacher().getViewer();
		Topic topic = student.getTopic();
		model.setStudent(student);
		model.setTopic(topic);
		model.setTeacher(viewer);
		model.setStatus(StatusEnum.unstart.getValue());
		model.setUuid(student.getUuid());
	}
	
	@Override
	public void afterSave(ViewerAdvice model) {
		viewerAdviceService.saveViewerAdviceToStudentAndTeacher(model);
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
    	Teacher teacher = (Teacher) viewerAdviceDao.findByUuid(Teacher.class, getCurrentUser().getUuid());
    	Set<Student> students = new HashSet<Student>();
    	Set<Teacher> teachers = teacher.getTeachers();
    	for (Teacher teacher2 : teachers) {
    		students.addAll(teacher2.getStudents());
		}
    	ActionContext.getContext().put("students",students);
    	ActionContext.getContext().put("teacher", teacher);
    	return "toMyStudent";
    }
    
    public String forwardViewerAdvice(){
    	viewerAdviceService.doForwardViewerAdvice(getCurrentUser());
    	return LIST_ACTION;
    }

	public String getStudentUuid() {
		return studentUuid;
	}

	public void setStudentUuid(String studentUuid) {
		this.studentUuid = studentUuid;
	}
    
}
