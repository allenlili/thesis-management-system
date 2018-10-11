package com.zhbit.core.utils.ExcelFileReader;

public class Cell {

	public static int NUMBER_TYPE = 0;
	
	public static int STRING_TYPE = 1;
	
	public static int BOOLEAN_TYPE = 2;
	
	private String text = null;
	
	private int type;

	private int index;
	
	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
}
