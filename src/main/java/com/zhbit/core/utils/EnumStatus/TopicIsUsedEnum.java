package com.zhbit.core.utils.EnumStatus;

public enum TopicIsUsedEnum {
	Used("是"), NotUsed("否");
	
	private TopicIsUsedEnum(String value) {
		this.value = value;
	}
	
	private String value;
	
	public String getValue() {
		return value;
	}
	
	public static void main(String[] args) {
		for (ProcessEnum p : ProcessEnum.values()) {
			System.out.println(p);
		}
	}
}
