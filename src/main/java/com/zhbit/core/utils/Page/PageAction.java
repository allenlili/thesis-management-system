package com.zhbit.core.utils.Page;


import com.zhbit.core.action.AbstractAction;
import com.zhbit.core.utils.Constant.SystemConstant;

@SuppressWarnings("serial")
public class PageAction extends AbstractAction {
	
	/**
	 * 分页起始下标
	 */
	protected Integer start = 0;
	/**
	 * 每页行数
	 */
	protected Integer pageSize = SystemConstant.PAGESIZE;
	
	public Integer getStart() {
		return start;
	}
	
	public void setStart(Integer start) {
		this.start = start;
	}
	
	public Integer getPageSize() {
		return pageSize;
	}
	
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

}
