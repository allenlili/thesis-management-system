package com.zhbit.main.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.zhbit.core.utils.EnumStatus.ChooseStudentRunNumEnum;
import com.zhbit.core.utils.Page.PageAction;
import com.zhbit.main.entity.Wish;
import com.zhbit.main.service.ChooseTutorServiceI;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@SuppressWarnings("serial")
@Controller("chooseTutorAction")
@Scope("prototype")
public class ChooseTutorAction extends PageAction{
	
	private String firstTeacherUuid;
	public void setFirstTeacherUuid(String firstTeacherUuid) {
		this.firstTeacherUuid = firstTeacherUuid;
	}
	
	private String secondTeacherUuid;
	public void setSecondTeacherUuid(String secondTeacherUuid) {
		this.secondTeacherUuid = secondTeacherUuid;
	}
	
	private String thirdTeacherUuid;
	public void setThirdTeacherUuid(String thirdTeacherUuid) {
		this.thirdTeacherUuid = thirdTeacherUuid;
	}
	
	private String[] uuids;
	public void setUuids(String[] uuids) {
		this.uuids = uuids;
	}
	
	private ChooseTutorServiceI chooseTutorService;
	@Resource
	public void setChooseTutorService(ChooseTutorServiceI chooseTutorService) {
		this.chooseTutorService = chooseTutorService;
	}
	
	public String findPossibleTeachers(){
		User user = getCurrentUser();
		Wish match = chooseTutorService.findMyWish(user);
		if(match!=null){
			Map<String, Teacher> teachers = chooseTutorService.getTeachersFromWish(match);
			Teacher mytutorTeacher = chooseTutorService.getMyTutor(user);
			ActionContext.getContext().put("teachers", teachers);
			ActionContext.getContext().put("mytutorTeacher", mytutorTeacher);
			return "student-myTutor";
		}
		List<Teacher> teachers = chooseTutorService.findPossibleTeachers(user);
		ActionContext.getContext().put("teachers", teachers);
		return "student-chooseTutor";
	}
	
	/**
	 * 学生提交自己的志愿
	 * @return
	 */
	public String forwardMatch(){
		User user = getCurrentUser();
		List<String> list = new ArrayList<String>();
		list.add(firstTeacherUuid);
		list.add(secondTeacherUuid);
		list.add(thirdTeacherUuid);
		chooseTutorService.doWish(user,list);
		return "haveForwardMatch";
	}
	
	@SuppressWarnings("unchecked")
	public String findUnselectedStudents(){
		User user = getCurrentUser();
		Teacher myselfTeacher = chooseTutorService.findMyselfTeacher(user);
		if(ChooseStudentRunNumEnum.finished.getValue().equals(myselfTeacher.getChooseStudentRunNum())){
			Set<Student> mystudents = chooseTutorService.getMyStudents(myselfTeacher);
			ActionContext.getContext().put("mystudents",mystudents);
			return "teacher-chooseTutor-finished";
		}
		
		Map<String, Object> map = chooseTutorService.findUnselectedStudentsEachRun(myselfTeacher);
		//告知根据所有老师完成情况（包括自己），我们是否都完成了某一轮，只要有一个人没有完成某轮，那么就不能进入下一轮
		String notifyWhichRun = (String) map.get("notifyWhichRun");
		List<Student> unSelectedStudents = (List<Student>) map.get("unSelectedStudents");
		List<Student> studentSelectedByMe = (List<Student>) map.get("studentSelectedByMe");
		int realHaveSelectedNum = (int) map.get("realHaveSelectedNum");
		
		ActionContext.getContext().put("notifyWhichRun",notifyWhichRun);
		ActionContext.getContext().put("unSelectedStudents",unSelectedStudents);
		ActionContext.getContext().put("studentSelectedByMe",studentSelectedByMe);
		ActionContext.getContext().put("myselfTeacher",myselfTeacher);
		ActionContext.getContext().put("realHaveSelectedNum",realHaveSelectedNum);
		
		if(ChooseStudentRunNumEnum.thirdRun.getValue().equals(myselfTeacher.getChooseStudentRunNum())){
			chooseTutorService.doVerifyMySelectedStudent(myselfTeacher);
			return "teacher-chooseTutor-thirdRun";
		}		
		if(ChooseStudentRunNumEnum.secondRun.getValue().equals(notifyWhichRun)){
			return "teacher-chooseTutor-thirdRun";
		}		
		if(ChooseStudentRunNumEnum.firstRun.getValue().equals(notifyWhichRun)){
			return "teacher-chooseTutor-secondRun";
		}
		return "teacher-chooseTutor-firstRun";
	}
	
	public String matchStudent(){
		User user = getCurrentUser();
		if(!chooseTutorService.doWishStudent(user,uuids)){
			String errorString = "超过最大指导人数！";
			ActionContext.getContext().put("errorString",errorString);
			return "listAction";
		}
		return "listAction";
	}
	
	public String unMatchStudent(){
		User user = getCurrentUser();
		chooseTutorService.doUnWishStudent(user, uuids);
		return "listAction";
	}
	
	public String forwardInverseMatch(){
		User user = getCurrentUser();
		chooseTutorService.doChangeTeacherChooseSutdentRunNum(user);
		return "haveForwardEachRunMatch";
	}	
}
