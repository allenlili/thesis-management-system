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
import com.zhbit.main.dao.MarkDao;
import com.zhbit.main.entity.Mark;
import com.zhbit.main.service.MarkServiceI;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@SuppressWarnings("serial")
@Controller("markAction")
@Scope("prototype")
public class MarkAction extends ActivitiBaseAction<Mark> {
	
	private String result;
	private String[] uuids;
	private String[]  lectureGrades;
	
	
	private MarkServiceI markService;
	@Resource
	public void setMarkService(MarkServiceI markService) {
		this.markService = markService;
	}
	
	private MarkDao markDao;
	@Resource
	public void setMarkDao(MarkDao markDao) {
		this.markDao = markDao;
	}

	@Override
	public GenericDao<Mark> getDao() {
		return markDao;
	}
	
	@Override
	public void beforeSave(Mark model) {
		User user = getCurrentUser();
		if (model.getUser() == null) {
			model.setUser(user);
		}
		if (model.getStatus() == null) {
			model.setStatus(StatusEnum.unstart.getValue());
		}
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
	
    public String findMyMark(){
    	Student student = markService.getStudent(getCurrentUser().getUuid());
    	ActionContext.getContext().put("student", student);
    	return "toMyMark";
    }
    
    public String findMyStudents(){
    	Teacher teacher = (Teacher) markDao.findByUuid(Teacher.class, getCurrentUser().getUuid());
    	ActionContext.getContext().put("students", teacher.getStudents());
    	ActionContext.getContext().put("teacher", teacher);
    	return "toMyStudent";
    }
    
	public String forwardGrade(){
		this.markService.doForwardGrade(uuids,lectureGrades,getCurrentUser());
		return LIST_ACTION;
	}

	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}

	public String[] getUuids() {
		return uuids;
	}
	public void setUuids(String[] uuids) {
		this.uuids = uuids;
	}

	public String[] getLectureGrades() {
		return lectureGrades;
	}
	public void setLectureGrades(String[] lectureGrades) {
		this.lectureGrades = lectureGrades;
	}

}
