package com.zhbit.core.utils.EnumStatus;

public enum TopicOriginEnum {
	SocialPractice("社会实践"), ProductionPractice("生产实践"),PersonalMake("自拟题目"),Science("结合科研");
	private TopicOriginEnum(String value) {
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
