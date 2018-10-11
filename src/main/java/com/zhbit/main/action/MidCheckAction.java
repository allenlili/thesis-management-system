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
import com.zhbit.main.dao.MidCheckDao;
import com.zhbit.main.entity.MidCheck;
import com.zhbit.main.service.MidCheckServiceI;
import com.zhbit.security.entity.User;

@SuppressWarnings("serial")
@Controller("midCheckAction")
@Scope("prototype")
public class MidCheckAction extends ActivitiBaseAction<MidCheck> {
	
	
	private MidCheckServiceI midCheckService;
	@Resource
	public void setMidCheckService(MidCheckServiceI midCheckService) {
		this.midCheckService = midCheckService;
	}
	
	private MidCheckDao midCheckDao;
	@Resource
	public void setMidCheckDao(MidCheckDao midCheckDao) {
		this.midCheckDao = midCheckDao;
	}

	@Override
	public GenericDao<MidCheck> getDao() {
		return midCheckDao;
	}
	
	@Override
	public void beforeSave(MidCheck model) {
		User user = getCurrentUser();
		if (model.getUser() == null) {
			model.setUser(user);
		}
		if (model.getStatus() == null) {
			model.setStatus(StatusEnum.unstart.getValue());
		}
		if(model.getTeacher() == null){
			model.setTeacher(midCheckService.getTeacher(user));
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
	
    public String selectMyMidCheck(){
    	MidCheck midCheck = midCheckService.findMyMidCheck(getCurrentUser());
//    	if(midCheck == null){
//    		midCheckService.createMidCheck(getCurrentUser());
//    		return "myMidCheck";
//    	}
    	ActionContext.getContext().put("midCheck", midCheck);
    	return "myMidCheck";
    }
    
    /**
     * 中期检查创建一次机会，生成第一栏内容将不能修改
     * @return
     */
    public String createMidCheck(){
    	midCheckService.doCreateMidCheck(getCurrentUser());
    	return "listAction";
    }
}
