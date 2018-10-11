package com.zhbit.core.utils.EnumStatus;

public enum TopicLevelEnum {
	Hard("难"), Meditate("中"),Easy("易");
	
	private TopicLevelEnum(String value) {
		this.value = value;
	}
	
	private String value;
	
	public String getValue() {
		return value;
	}
	
	public static void main(String[] args) {
		for (ProcessEnum p : ProcessEnum.values()) {
			System.out.println(p.getValue());
		}
	}
}
