package com.zhbit.core.utils.EnumStatus;

public enum StatusEnum {
	
//	public static final StatusEnum unstart = new StatusEnum(1);
//	public static final StatusEnum start = new StatusEnum(2); 
//	public static final StatusEnum success = new StatusEnum(3); 
//	public static final StatusEnum fail = new StatusEnum(4); 
	
	unstart(1), start(2), success(3), fail(4), finished(34);
	
	private Integer value;

	private StatusEnum(Integer value) {
		this.value = value;
	}
	
	public Integer getValue() {
		return value;
	}

}
