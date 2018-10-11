package com.zhbit.core.utils.EnumStatus;

public enum LastScriptEnum {
	
	yes(1), no(0);
	private LastScriptEnum(Integer value) {
		this.value = value;
	}
	
	private Integer value;
	
	public Integer getValue() {
		return value;
	}
	
	public static void main(String[] args) {
		for (LastScriptEnum p : LastScriptEnum.values()) {
			System.out.println(p);
		}
	}
	
}
