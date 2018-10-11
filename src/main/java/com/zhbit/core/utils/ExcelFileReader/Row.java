package com.zhbit.core.utils.ExcelFileReader;

import java.util.ArrayList;
import java.util.List;

public class Row {

	public Row() {
		this.cellList = new ArrayList<Cell>();
	}
	
	private List<Cell> cellList = null;

	public List<Cell> getCellList() {
		return cellList;
	}

	public void setCellList(List<Cell> cellList) {
		this.cellList = cellList;
	}
	
}
