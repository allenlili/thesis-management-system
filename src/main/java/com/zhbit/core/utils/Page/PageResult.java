package com.zhbit.core.utils.Page;

import java.util.List;

public class PageResult {
	
	private List<?> result;
	private long rowCount;
	
	public List<?> getResult() {
		return result;
	}
	public void setResult(List<?> result) {
		this.result = result;
	}
	public long getRowCount() {
		return rowCount;
	}
	public void setRowCount(long rowCount) {
		this.rowCount = rowCount;
	}

}
