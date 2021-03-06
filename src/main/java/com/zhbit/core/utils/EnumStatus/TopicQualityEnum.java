package com.zhbit.core.utils.EnumStatus;

public enum TopicQualityEnum {
	TheoryResearch("理论研究"), TechnologyScienceResearch("技术科学研究");
	
	private TopicQualityEnum(String value) {
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
