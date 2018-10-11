package com.zhbit.main.action;


import java.util.Date;
import java.util.List;

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
import com.zhbit.main.dao.ThesisProposalDao;
import com.zhbit.main.entity.ThesisProposal;
import com.zhbit.main.entity.Topic;
import com.zhbit.main.service.ThesisProposalServiceI;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.User;

@SuppressWarnings("serial")
@Controller
@Scope("prototype")
public class ThesisProposalAction extends ActivitiBaseAction<ThesisProposal> {
	private Long id;
	
	private Long watchId;
	
	private ThesisProposalServiceI thesisProposalService;
	@Resource
	public void setThesisProposalService(ThesisProposalServiceI thesisProposalService) {
		this.thesisProposalService = thesisProposalService;
	}
	
	private ThesisProposalDao thesisProposalDao;
	@Resource
	public void setThesisProposalDao(ThesisProposalDao thesisProposalDao) {
		this.thesisProposalDao = thesisProposalDao;
	}

	@Override
	public GenericDao<ThesisProposal> getDao() {
		return thesisProposalDao;
	}
	
	@Override
	public void beforeSave(ThesisProposal model) {
		User user = getCurrentUser();
		if (model.getUser() == null) {
			model.setUser(user);
		}
		if (model.getStatus() == null) {
			model.setStatus(StatusEnum.unstart.getValue());
		}
		if(model.getStudent() == null){
			Student student = thesisProposalService.getStudent(user.getUuid());
			Topic topic = thesisProposalService.getTopic(student);
			model.setStudent(student);
			model.setTeacher(student.getTeacher());
			model.setTopic(topic);
			model.setStartDate(new Date());
		}
	}
	
	@Override
	public void afterSave(ThesisProposal model) {
		thesisProposalService.saveModelForStudent(model);
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
	
    public String selectMyThesisProposal(){
    	ThesisProposal thesisProposal = thesisProposalService.findMyThesisProposal(getCurrentUser());
    	Student student = thesisProposalService.getStudent(getCurrentUser().getUuid());
    	if(thesisProposal != null){
    		ActionContext.getContext().put("thesisProposal", thesisProposal);
    		return "myThesisProposal";
    	}
    	ActionContext.getContext().put("student", student);
    	return "toAddThesisProposal";
    }
    
    public String selectMyStudentProposal(){
    	List<ThesisProposal> thesisProposals = thesisProposalService.findStudentProposal(getCurrentUser());
    	ActionContext.getContext().put("thesisProposals", thesisProposals);
    	return "toMyStudentThesisProposal";
    }
    
    public String watchMyStudentProposal(){
    	ThesisProposal thesisProposal = thesisProposalDao.get(watchId);
    	ActionContext.getContext().getValueStack().push(thesisProposal);
    	return "watchMyStudent";
    }

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getWatchId() {
		return watchId;
	}

	public void setWatchId(Long watchId) {
		this.watchId = watchId;
	}

    
}
