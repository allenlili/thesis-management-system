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
import com.zhbit.main.dao.TaskBookDao;
import com.zhbit.main.entity.TaskBook;
import com.zhbit.main.service.TaskBookServiceI;
import com.zhbit.security.entity.User;

@SuppressWarnings("serial")
@Controller
@Scope("prototype")
public class TaskBookAction extends ActivitiBaseAction<TaskBook> {
	
	private String topicNameFind;
	
	private TaskBookServiceI taskBookService;
	@Resource
	public void setTaskBookService(TaskBookServiceI taskBookService) {
		this.taskBookService = taskBookService;
	}
	
	private TaskBookDao taskBookDao;
	@Resource
	public void setTaskBookDao(TaskBookDao taskBookDao) {
		this.taskBookDao = taskBookDao;
	}

	@Override
	public GenericDao<TaskBook> getDao() {
		return taskBookDao;
	}
	
	@Override
	public void beforeSave(TaskBook model) {
		User user = getCurrentUser();
		if (model.getUser() == null) {
			model.setUser(user);
		}
		if (model.getStatus() == null) {
			model.setStatus(StatusEnum.unstart.getValue());
		}
		if(model.getTeacher() == null){
			model.setTeacher(taskBookService.getTeacher(user));
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
		if(topicNameFind != null && !"".equals(topicNameFind)){
			criteria.createAlias("topic", "t");
			criteria.add(Restrictions.like("t.topicName", "%"+topicNameFind+"%"));
		}
	}
	
    public String selectMyTaskBook(){
    	TaskBook taskBook = taskBookService.doFindMyTaskBook(getCurrentUser());
    	ActionContext.getContext().put("taskBook", taskBook);
    	return "myTaskBook";
    }

	public String getTopicNameFind() {
		return topicNameFind;
	}

	public void setTopicNameFind(String topicNameFind) {
		this.topicNameFind = topicNameFind;
	}

    
}
