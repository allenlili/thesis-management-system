package com.zhbit.process.action;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.HistoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.bpmn.diagram.ProcessDiagramGenerator;
import org.activiti.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.query.Query;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;

@Controller
@Scope("prototype")
public class ProcessInstanceAction extends ProcessBaseAction {

	private static final long serialVersionUID = 1L;
    
	private ProcessEngineConfigurationImpl processEngineConfiguration;
	@Resource
	public void setProcessEngineConfiguration(ProcessEngineConfigurationImpl processEngineConfiguration) {
		this.processEngineConfiguration = processEngineConfiguration;
	}
	
	private RuntimeService runtimeService;
	@Resource
	public void setRepositoryService(RepositoryServiceImpl repositoryService) {
		this.repositoryService = repositoryService;
	}
	
	private RepositoryServiceImpl repositoryService;
	@Resource
	public void setRuntimeService(RuntimeService runtimeService) {
		this.runtimeService = runtimeService;
	}
	
	@SuppressWarnings("unused")
	private HistoryService historyService;
	@Resource
	public void setHistoryService(HistoryService historyService) {
		this.historyService = historyService;
	}
	
	/**
	 * 流程实例的Id
	 */
	private String id;
	private String definitionId;

	@SuppressWarnings("rawtypes")
	@Override
	public Query createQuery() {
		ProcessInstanceQuery query = runtimeService
				.createProcessInstanceQuery();
		if (null != definitionKey && !"".equals(definitionKey.trim())) {
			query.processDefinitionKey(definitionKey);
		}

		return query;
	}

	public void doDelete(String id) {
		runtimeService.deleteProcessInstance(id, "删除原因测试");
	}
	
	public String watch() {
		return "watch";
	}

	public void picture() throws Exception {
		if (null != definitionId && !"".equals(definitionId.trim())) {
			definitionKey = repositoryService.createProcessDefinitionQuery().processDefinitionId(definitionId).singleResult().getKey();
		}
		ProcessInstance processInstance = runtimeService
				.createProcessInstanceQuery().processInstanceBusinessKey(id, definitionKey)
				.singleResult();
		BpmnModel bpmnModel = repositoryService.getBpmnModel(processInstance.getProcessDefinitionId());
		List<Execution> executions = runtimeService.createExecutionQuery().processInstanceId(processInstance.getId()).list();
		//正在活动的activity的id
		List<String> activeIds = new ArrayList<String>(); 
		for (Execution exe : executions) {
			List<String> list = runtimeService.getActiveActivityIds(exe.getId());
			activeIds.addAll(list);
		}
		Context.setProcessEngineConfiguration(processEngineConfiguration);
		InputStream in = ProcessDiagramGenerator.generateDiagram(bpmnModel, "png", activeIds);
		FileCopyUtils.copy(in, response.getOutputStream());
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setDefinitionId(String definitionId) {
		this.definitionId = definitionId;
	}

}
