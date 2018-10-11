package com.zhbit.core.utils.EnumStatus;

public enum ChooseStudentRunNumEnum {
	
	defaultValue("0"),firstRun("1"), secondRun("2"),thirdRun("3"),finished("4");
	
	private ChooseStudentRunNumEnum(String value) {
		this.value = value;
	}
	
	private String value;
	
	public String getValue() {
		return value;
	}
	
	public static void main(String[] args) {
		System.out.println(ChooseStudentRunNumEnum.firstRun.value);
	}
	
}
