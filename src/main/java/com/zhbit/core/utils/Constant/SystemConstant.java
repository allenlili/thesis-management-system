package com.zhbit.core.utils.Constant;

import java.io.File;

public interface SystemConstant {
	
	public static final String CURRENT_USER = "currentUser";
	
	public static final String DEFAULT_PASSWORD  = "";
	
	public static final String REQUEST_TASK  = "提交申请";
	
	public static final String THESIS_SCRIPT_TUTOR_TASK  = "指导老师指导论文";
	
	public static final Integer PAGESIZE  = 5;
	
	public static final String MEN = "1";
	
	/**登录用户类型*/
	public static final String STUDENT = "1";
	public static final String TEACHER = "2";
	
	/**选择老师每一轮的结果默认初始值*/
	public static final String NO_RESULT = "0";
	
	/**稿件存放路径*/
	public static final String FILE_PATH = "F:"+File.separator+"script";
	
	/**指导学生实际人数 默认0*/
	public static final int REAL_TEACH_NUM = 0;
}
