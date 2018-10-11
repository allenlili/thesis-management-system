package com.zhbit.core.utils.EnumStatus;

public enum TopicTypeEnum {
	Design("毕业设计"), Thesis("毕业论文");
	
	private TopicTypeEnum(String value) {
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
