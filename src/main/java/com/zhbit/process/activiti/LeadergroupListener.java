package com.zhbit.process.activiti;

import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.springframework.stereotype.Component;

import com.zhbit.core.entity.ActivitiBaseEntity;
import com.zhbit.core.utils.EnumStatus.ProcessVariableEnum;
import com.zhbit.process.dao.ActivitiDao;
import com.zhbit.security.entity.User;

@SuppressWarnings("serial")
@Component
public class LeadergroupListener implements TaskListener {

	private ActivitiDao activitiDao;

	@Resource
	public void setActivitiDao(ActivitiDao activitiDao) {
		this.activitiDao = activitiDao;
	}

	@Override
	public void notify(DelegateTask task) {
		ActivitiBaseEntity model = (ActivitiBaseEntity) task.getVariable(ProcessVariableEnum.model.toString());
		User requestUser = model.getUser();
		List<User> users = activitiDao.findLeadergroupForUser(requestUser);
		for (User u : users) {
			task.addCandidateUser(u.getUserName());
		}
	}

}
