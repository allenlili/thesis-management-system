package com.zhbit.process.action;

import java.util.List;

import org.activiti.engine.query.Query;

import com.opensymphony.xwork2.ActionContext;
import com.zhbit.core.utils.Page.PageAction;
import com.zhbit.core.utils.Page.PageResult;

@SuppressWarnings("serial")
public abstract class ProcessBaseAction extends PageAction {
	protected String[] ids;
	/**
	 * 查询条件
	 */
	protected String definitionKey;
	
	/**
	 * 分页查询
	 * @return
	 */
	public String findPage() {
		@SuppressWarnings("rawtypes")
		Query query = createQuery();
		long rowCount = query.count();
		List<?> result = query.listPage(start, pageSize);
		PageResult page = new PageResult();
		page.setRowCount(rowCount);
		result = doResult(result);
		page.setResult(result);
		ActionContext.getContext().put(PAGE, page);
		return LIST;
	}
	
	public String delete() {
		for (String id : ids) {
			doDelete(id);
		}
		return LIST_ACTION;
	}
	
	/**
	 * 产生query
	 * 处理查询条件
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	protected Query createQuery() {
		return null;
	}
	
	/**
	 * 处理查询结果
	 * @param result
	 * @return
	 */
	protected List<?> doResult(List<?> result) {
		return result;
	}	
	/**
	 * 根据id调用service删除
	 * @param id
	 */
	protected void doDelete(String id) {
	}

	public void setIds(String[] ids) {
		this.ids = ids;
	}
	public String getDefinitionKey() {
		return definitionKey;
	}
	public void setDefinitionKey(String definitionKey) {
		this.definitionKey = definitionKey;
	}
}
