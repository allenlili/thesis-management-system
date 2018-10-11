package com.zhbit.process.activiti;

import javax.annotation.Resource;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.JavaDelegate;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Component;

import com.zhbit.core.entity.ActivitiBaseEntity;
import com.zhbit.core.utils.EnumStatus.ProcessVariableEnum;
import com.zhbit.core.utils.EnumStatus.StatusEnum;

@Component
public class UpdateSuccessStatusService implements JavaDelegate {
	
	private SessionFactory sessionFactory;

	@Resource
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public void execute(DelegateExecution execution) throws Exception {
		ActivitiBaseEntity model = (ActivitiBaseEntity) execution.getVariable(ProcessVariableEnum.model.toString());
		model.setStatus(StatusEnum.success.getValue());
		sessionFactory.getCurrentSession().update(model);
	}

}
