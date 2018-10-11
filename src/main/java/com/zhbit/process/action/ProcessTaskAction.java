package com.zhbit.process.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.query.Query;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.zhbit.core.utils.EnumStatus.ProcessVariableEnum;
import com.zhbit.process.dao.ActivitiDao;
import com.zhbit.security.dao.UserDao;
import com.zhbit.security.entity.User;

@Controller
@Scope("prototype")
public class ProcessTaskAction extends ProcessBaseAction {

	private static final long serialVersionUID = 1L;

	private static Logger logger = Logger.getLogger(ProcessTaskAction.class);
	
	private TaskService taskService;
	@Resource
	public void setTaskService(TaskService taskService) {
		this.taskService = taskService;
	}
	
	private RepositoryServiceImpl repositoryService;
	@Resource
	public void setRepositoryService(RepositoryServiceImpl repositoryService) {
		this.repositoryService = repositoryService;
	}
	
	private RuntimeService runtimeService;
	@Resource
	public void setRuntimeService(RuntimeService runtimeService) {
		this.runtimeService = runtimeService;
	}
	
	private ActivitiDao activitiDao;
	@Resource
	public void setActivitiDao(ActivitiDao activitiDao) {
		this.activitiDao = activitiDao;
	}
	
	private UserDao userDao;
	@Resource
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	/**
	 * 查询条件
	 */
	private String taskId;
	private String taskName;

	/* 
	 * 代办任务的查询条件
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public Query createQuery() {
		TaskQuery query = taskService.createTaskQuery();
		User currentUser = userDao.get(getCurrentUser().getId());
		//候选人是当前用户
		query.taskCandidateUser(currentUser.getUserName());
//		//或者or 候选组等于当前用户的角色
//		List<String> roles = new ArrayList<String>();
//		for (Role r : currentUser.getRoles()) {
//			roles.add(r.getRoleName());
//		}
//		query.taskCandidateGroupIn(roles);

		if (null != definitionKey && !"".equals(definitionKey.trim())) {
			query.processDefinitionKey(definitionKey);
		}
		if (null != taskName && !"".equals(taskName.trim())) {
			query.taskNameLike("%" + taskName + "%");
		}
		return query;
	}

	@Override
	public List<Map<String, Object>> doResult(List<?> list) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		for (Object obj : list) {
			Task task = (Task) obj;
			Map<String, Object> map = new HashMap<String, Object>();
			try {
				Object model = taskService.getVariable(task.getId(),ProcessVariableEnum.model.toString());
				map.put("model", model);
				map.put("task", task);
			} catch (Exception e) {
				logger.info("得不到流程中的变量！");
			}
			ProcessDefinition processDefinition = repositoryService
					.createProcessDefinitionQuery()
					.processDefinitionId(task.getProcessDefinitionId())
					.singleResult();
			map.put("processName", processDefinition.getName());
			result.add(map);
		}
		return result;
	}

	@Override
	protected void doDelete(String id) {
		taskService.deleteTask(id, true);
	}

	/**
	 * 跳到任务执行页
	 * 
	 * @return
	 */
	public void toTask() throws Exception {
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		Object model = taskService.getVariable(taskId,ProcessVariableEnum.model.toString());
		ActionContext.getContext().getValueStack().push(model);

		getButtonsForTransition(task);
		
		ActionContext.getContext().put("taskName", task.getName());
		
		//查询审批意见
		List<Map<String, Object>> list = activitiDao.getComments(task.getProcessInstanceId());
		ActionContext.getContext().put("commentList", list);

		request.getRequestDispatcher(task.getDescription()).forward(request,response);
	}

	private void getButtonsForTransition(Task task) {
		ProcessDefinitionEntity pde = (ProcessDefinitionEntity) repositoryService
				.getDeployedProcessDefinition(task.getProcessDefinitionId());
		ExecutionEntity exe = (ExecutionEntity) runtimeService
				.createExecutionQuery().executionId(task.getExecutionId())
				.singleResult();
		ActivityImpl activity = pde.findActivity(exe.getActivityId());
		List<PvmTransition> transitions = activity.getOutgoingTransitions();
		List<String> buttons = new ArrayList<String>();
		for (PvmTransition pvmTransition : transitions) {
			buttons.add(pvmTransition.getProperty("name").toString());
		}
		ActionContext.getContext().put("buttonList", buttons);
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}
	
}
