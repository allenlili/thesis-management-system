package com.zhbit.core.action;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.HistoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.task.Task;

import com.opensymphony.xwork2.ActionContext;
import com.zhbit.core.entity.ActivitiBaseEntity;
import com.zhbit.core.utils.Core.BeanUtil;
import com.zhbit.process.dao.ActivitiDao;

@SuppressWarnings("serial")
public abstract class ActivitiBaseAction<T> extends BaseAction<T> {

	private TaskService taskService;
	private ActivitiDao activitiDao;
	private HistoryService historyService;
	private String taskId;
	private String transition;
	private String definitionKey;
	/**
	 * 审批意见
	 */
	private String comment;

	@Resource
	public void setTaskService(TaskService taskService) {
		this.taskService = taskService;
	}

	@Resource
	public void setActivitiDao(ActivitiDao activitiDao) {
		this.activitiDao = activitiDao;
	}

	/**
	 * 启动流程
	 * 
	 * @return
	 */
	public String start() {
		for (Long id : ids) {
			ActivitiBaseEntity entity = (ActivitiBaseEntity) getDao().get(id);
			activitiDao.doStart(entity, definitionKey);
		}
		return LIST_ACTION;
	}

	/**
	 * 执行任务
	 * 
	 * @return
	 */
	public String performTask() {
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		activitiDao.doTask(transition, task, model, getCurrentUser(), comment);
		return "listTask";
	}

	/**
	 * 审批结束的查看
	 * @return
	 */
	public String watch() throws Exception {
		Method idGetter = BeanUtil.getMethod(modelClass, ID_GET_METHOD);
		// 调用getId方法得到id
		Long id = (Long) idGetter.invoke(model);
		beforToUpdate();
		T entity = getDao().get(id);
		afterToUpdate(entity);
		ActionContext.getContext().getValueStack().push(entity);

		HistoricProcessInstance processInstance = historyService.createHistoricProcessInstanceQuery()
				.processDefinitionKey(definitionKey)
				.processInstanceBusinessKey(id.toString()).singleResult();
		
		List<Map<String, Object>> list = activitiDao.getComments(processInstance.getId());
		
		ActionContext.getContext().put("commentList", list);

		return "watch";
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public void setTransition(String transition) {
		this.transition = transition;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public void setDefinitionKey(String definitionKey) {
		this.definitionKey = definitionKey;
	}

	@Resource
	public void setHistoryService(HistoryService historyService) {
		this.historyService = historyService;
	}

}
