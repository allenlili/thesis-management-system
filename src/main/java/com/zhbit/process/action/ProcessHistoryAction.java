package com.zhbit.process.action;

import javax.annotation.Resource;

import org.activiti.engine.HistoryService;
import org.activiti.engine.history.HistoricProcessInstanceQuery;
import org.activiti.engine.query.Query;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;


@Controller
@Scope("prototype")
public class ProcessHistoryAction extends ProcessBaseAction {

	private static final long serialVersionUID = 1L;
	
	private HistoryService historyService;
	
	@Resource
	public void setHistoryService(HistoryService historyService) {
		this.historyService = historyService;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Query createQuery() {
		HistoricProcessInstanceQuery query = historyService.createHistoricProcessInstanceQuery();
		query = query.finished();
		if (null != definitionKey && !"".equals(definitionKey.trim())) {
			query.processDefinitionKey(definitionKey);
		}
		return query;
	}
	
	public void doDelete(String id) {
		historyService.deleteHistoricProcessInstance(id);
	}
	
}
