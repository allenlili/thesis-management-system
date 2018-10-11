package com.zhbit.core.utils.ExcelFileReader;

import java.util.HashMap;
import java.util.Map;

public class ModelVO {

	private Map<String,String> detailMap = new HashMap<String,String>();
	
	public Map<String,String> getDetailMap() {
		return detailMap;
	}

	public void setDetailMap(Map<String,String> detailMap) {
		this.detailMap = detailMap;
	}
}
