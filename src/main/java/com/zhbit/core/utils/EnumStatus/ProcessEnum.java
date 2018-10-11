package com.zhbit.core.utils.EnumStatus;

public enum ProcessEnum {
	
	topic("选题审批流程"), 
	taskBook("任务书审批流程"),
	thesisProposal("开题报告审批流程"),
	thesisScript("论文稿件审批流程"),
	endScript("终稿审批流程");
	private ProcessEnum(String value) {
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
