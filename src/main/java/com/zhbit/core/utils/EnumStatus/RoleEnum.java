package com.zhbit.core.utils.EnumStatus;

public enum RoleEnum {

	tutor("指导老师"),viewer("评阅老师"),workgroup("工作小组"),leadergroup("领导小组"),superAdmin("超级管理员"),student("学生");
	
	private RoleEnum(String value) {
		this.value = value;
	}
	
	private String value;

	public String getValue() {
		return value;
	}
	
}
