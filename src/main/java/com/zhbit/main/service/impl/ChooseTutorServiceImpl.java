package com.zhbit.main.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhbit.core.utils.Constant.SystemConstant;
import com.zhbit.core.utils.EnumStatus.ChooseStudentRunNumEnum;
import com.zhbit.main.dao.WishDao;
import com.zhbit.main.entity.Wish;
import com.zhbit.main.service.ChooseTutorServiceI;
import com.zhbit.security.dao.StudentDao;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.entity.Institute;
import com.zhbit.security.entity.Major;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@Service("chooseTutorService")
public class ChooseTutorServiceImpl implements ChooseTutorServiceI {

	private TeacherDao teacherDao;
	@Resource
	public void setTeacherDao(TeacherDao teacherDao) {
		this.teacherDao = teacherDao;
	}
	private StudentDao studentDao;
	@Resource
	public void setStudentDao(StudentDao studentDao) {
		this.studentDao = studentDao;
	}
	private WishDao wishDao;
	@Resource
	public void setWishDao(WishDao wishDao) {
		this.wishDao = wishDao;
	}

	/**
	 * 找到未来可能的指导老师
	 */
	@Override
	public List<Teacher> findPossibleTeachers(User user) {
		Student student = (Student) studentDao.findByUuid(Student.class, user.getUuid());
		@SuppressWarnings("unchecked")
		List<Teacher> teachers = (List<Teacher>) teacherDao.findByInstituteAndMajor(Teacher.class, student.getInstitute(), student.getMajor());
		return teachers;
	}

	/**
	 * 找到我的3个志愿信息
	 */
	@Override
	public Wish findMyWish(User user) {
		Wish wish = (Wish) wishDao.findByUuid(Wish.class, user.getUuid());
		return wish;
	}

	/**
	 * 生成3个志愿的wish
	 */
	@Override
	public void doWish(User user, List<String> list) {
		Wish wish = new Wish();
		wish.setFirstTeacherUuid(list.get(0));
		wish.setSecondTeacherUuid(list.get(1));
		wish.setThirdTeacherUuid(list.get(2));
		wish.setUuid(user.getUuid());
		wish.setFirstResultUuid(SystemConstant.NO_RESULT);
		wish.setSecondResultUuid(SystemConstant.NO_RESULT);
		wish.setThirdResultUuid(SystemConstant.NO_RESULT);
		wishDao.add(wish);
	}

	/**
	 * 3个志愿老师信息
	 */
	@Override
	public Map<String,Teacher> getTeachersFromWish(Wish wish) {
		Map<String,Teacher> teachers = new HashMap<String,Teacher>();
		Teacher firstTeacher = (Teacher) teacherDao.findByUuid(Teacher.class, wish.getFirstTeacherUuid());
		Teacher secondTeacher = (Teacher) teacherDao.findByUuid(Teacher.class, wish.getSecondTeacherUuid());
		Teacher thirdTeacher = (Teacher) teacherDao.findByUuid(Teacher.class, wish.getThirdTeacherUuid());
		teachers.put("firstTeacher",firstTeacher);
		teachers.put("secondTeacher",secondTeacher);
		teachers.put("thirdTeacher",thirdTeacher);
		return teachers;
	}

	@Override
	public Teacher getMyTutor(User user) {
		Student student = (Student) studentDao.findByUuid(Student.class, user.getUuid());
		return student.getTeacher();
	}

	/**
	 * 找到老师自己
	 * @param user
	 * @return
	 */
	public Teacher findMyselfTeacher(User user){
		Teacher myselfTeacher =  (Teacher) teacherDao.findByUuid(Teacher.class,user.getUuid());
		return myselfTeacher;
	}
	
	/**
	 * 找到每一轮还没有被选择而且选择了我为志愿的学生
	 */
	@Override
	public Map<String, Object> findUnselectedStudentsEachRun(Teacher myselfTeacher) {
		//查看自己已完成到第几轮，同时看看所在的一个或多个专业的所有老师是否在该轮已经选完，两个条件满足才可以进入下一轮;第一轮进入是无需条件的
		String notifyWhichRun = notifyWhichRun(myselfTeacher);
		List<Wish> wishs = wishDao.findByTeacherUuidAndChooseStudentRunNum(myselfTeacher, notifyWhichRun);
		List<Student> unSelectedStudents = studentDao.findByWish(wishs);
		
		//已经选择的学生
		List<Wish> wishHavingNotNullResultUuid = wishDao.findByResultUuid(myselfTeacher,notifyWhichRun);
		List<Student> studentSelectedByMe = studentDao.findByWish(wishHavingNotNullResultUuid);
		
		//获取老师目前已经选择的学生数目和实际指导数量
		int realHaveSelectedNum = wishDao.getRealHaveSelectedNum(myselfTeacher);
		
		Map<String, Object> map  = new HashMap<String, Object>();
		map.put("notifyWhichRun", notifyWhichRun);
		map.put("unSelectedStudents", unSelectedStudents);
		map.put("studentSelectedByMe", studentSelectedByMe);
		map.put("realHaveSelectedNum", realHaveSelectedNum);
		return map;
	}
	
	/**
	 * 返回目前所有老师的完成情况总结，若当前老师和所有老师都完成第一轮则返回第一轮；
	 * 若当前老师仍未完成第一轮，其他老师完成第一轮，返回默认初始状态
	 * 或者当前老师完成第一轮，其他老师有未完成第一轮，返回默认初始状态
	 * ...依次类推
	 */
	@SuppressWarnings("unchecked")
	public String notifyWhichRun(Teacher teacher){
		Institute institute = teacher.getInstitute();
		Set<Major> majors = teacher.getMajors();
		List<Teacher> teachers = new ArrayList<Teacher>();
		for (Major major : majors) {
			teachers.addAll( (Collection<? extends Teacher>) teacherDao.findByInstituteAndMajor(Teacher.class, institute,major));
		}
		//首先老师判断自己在已经完成到哪轮，再去看看其他老师是否也完成了这轮。如果都完成该轮，则告知已完成该轮，否则告知有老师还没完成当下这一轮
		if(ChooseStudentRunNumEnum.firstRun.getValue().equals(teacher.getChooseStudentRunNum())){
			if(!ChooseStudentRunNumEnum.firstRun.getValue().equals(getIfHaveFinishedFirstRunFromOtherTeachers(teachers))){
				return ChooseStudentRunNumEnum.defaultValue.getValue();
			}
			return ChooseStudentRunNumEnum.firstRun.getValue();
		}
		if(ChooseStudentRunNumEnum.secondRun.getValue().equals(teacher.getChooseStudentRunNum())){
			if(!ChooseStudentRunNumEnum.secondRun.getValue().equals(getIfHaveFinishedSecondRunFromOtherTeachers(teachers))){
				return ChooseStudentRunNumEnum.firstRun.getValue();
			}
			return ChooseStudentRunNumEnum.secondRun.getValue();
		}
		if(ChooseStudentRunNumEnum.thirdRun.getValue().equals(teacher.getChooseStudentRunNum())){
			if(!ChooseStudentRunNumEnum.thirdRun.getValue().equals(getIfHaveFinishedThirdRunFromOtherTeachers(teachers))){
				return ChooseStudentRunNumEnum.secondRun.getValue();
			}
			return ChooseStudentRunNumEnum.thirdRun.getValue();
		}
		return ChooseStudentRunNumEnum.defaultValue.getValue();
	}
	
	/**
	 * 从其他老师的完成轮数情况，获取结果：第一轮结果
	 * @param teachers
	 * @return
	 */
	public String getIfHaveFinishedFirstRunFromOtherTeachers(List<Teacher> teachers){
		for (Teacher teacher : teachers) {
			//如果有老师未完成第一轮，则返回默认值
			if(!(Integer.parseInt(ChooseStudentRunNumEnum.firstRun.getValue())<=Integer.parseInt(teacher.getChooseStudentRunNum()))){
				return ChooseStudentRunNumEnum.defaultValue.getValue();
			}
		}
		//完成则返回第一轮，告知调用函数的上一层函数所有老师都完成第一轮了，可以开始第二轮
		return ChooseStudentRunNumEnum.firstRun.getValue();
	}
	
	/**
	 * 从其他老师的完成轮数情况，获取结果：第二轮结果
	 * @param teachers
	 * @return
	 */	
	public String getIfHaveFinishedSecondRunFromOtherTeachers(List<Teacher> teachers){
		for (Teacher teacher : teachers) {
			//如果有老师未完成第二轮，则返回第一轮，告知只能停留在第一轮，有老师还没有完成
			if(!(Integer.parseInt(ChooseStudentRunNumEnum.secondRun.getValue())<=Integer.parseInt(teacher.getChooseStudentRunNum()))){
				return ChooseStudentRunNumEnum.firstRun.getValue();
			}
		}
		//完成则返回第二轮，告知调用函数的上一层函数所有老师都完成第二轮了，可以开始第三轮
		return ChooseStudentRunNumEnum.secondRun.getValue();
	}
	
	/**
	 * 从其他老师的完成轮数情况，获取结果：第三轮结果
	 * @param teachers
	 * @return
	 */	
	public String getIfHaveFinishedThirdRunFromOtherTeachers(List<Teacher> teachers){
		for (Teacher teacher : teachers) {
			//如果有老师未完成第三轮，则返回第二轮，告知只能停留在第二轮，有老师还没有完成
			if(!(Integer.parseInt(ChooseStudentRunNumEnum.thirdRun.getValue())<=Integer.parseInt(teacher.getChooseStudentRunNum()))){
				return ChooseStudentRunNumEnum.secondRun.getValue();
			}
		}
		//完成则返回第三轮，告知调用函数的上一层函数所有老师都完成第三轮了，可以开始确定最后关系：建立新表，废弃wish表
		return ChooseStudentRunNumEnum.thirdRun.getValue();
	}

	/**
	 * 匹配学生，确定选择学生
	 */
	@Override
	public boolean doWishStudent(User user,String[] uuids) {
		Teacher teacher = (Teacher) teacherDao.findByUuid(Teacher.class, user.getUuid());
		int realHaveSelectedNum = wishDao.getRealHaveSelectedNum(teacher);
		int realtotal = uuids.length +  realHaveSelectedNum;
		int teachNum = Integer.parseInt(teacher.getTeachNum());
		if(realtotal>teachNum){
			return false;
		}
		for (String stuUuid : uuids) {
			Wish wish = wishDao.findByStuUuid(stuUuid);
			if(ChooseStudentRunNumEnum.defaultValue.getValue().equals(teacher.getChooseStudentRunNum())){
				wish.setFirstResultUuid(teacher.getUuid());
				teacher.setRealTeachNum(teacher.getRealTeachNum()+1<=teachNum?(teacher.getRealTeachNum()+1):teachNum);
			}
			if(ChooseStudentRunNumEnum.firstRun.getValue().equals(teacher.getChooseStudentRunNum())){
				wish.setSecondResultUuid(teacher.getUuid());
				teacher.setRealTeachNum(teacher.getRealTeachNum()+1<=teachNum?(teacher.getRealTeachNum()+1):teachNum);
			}
			if(ChooseStudentRunNumEnum.secondRun.getValue().equals(teacher.getChooseStudentRunNum())){
				wish.setThirdResultUuid(teacher.getUuid());
				teacher.setRealTeachNum(teacher.getRealTeachNum()+1<=teachNum?(teacher.getRealTeachNum()+1):teachNum);
			}			
			wishDao.save(wish);
			teacherDao.save(teacher);			
		}
		return true;
	}
	
	/**
	 * 剔除学生
	 */
	@Override
	public boolean doUnWishStudent(User user,String[] uuids) {
		Teacher teacher = (Teacher) teacherDao.findByUuid(Teacher.class, user.getUuid());
		for (String stuUuid : uuids) {
			Wish wish = wishDao.findByStuUuid(stuUuid);
			if(ChooseStudentRunNumEnum.defaultValue.getValue().equals(teacher.getChooseStudentRunNum())){
				wish.setFirstResultUuid(SystemConstant.NO_RESULT);
				teacher.setRealTeachNum(teacher.getRealTeachNum()-1<0?0:teacher.getRealTeachNum()-1);
			}
			if(ChooseStudentRunNumEnum.firstRun.getValue().equals(teacher.getChooseStudentRunNum())){
				wish.setSecondResultUuid(SystemConstant.NO_RESULT);
				teacher.setRealTeachNum(teacher.getRealTeachNum()-1<0?0:teacher.getRealTeachNum()-1);
			}
			if(ChooseStudentRunNumEnum.secondRun.getValue().equals(teacher.getChooseStudentRunNum())){
				wish.setThirdResultUuid(SystemConstant.NO_RESULT);
				teacher.setRealTeachNum(teacher.getRealTeachNum()-1<0?0:teacher.getRealTeachNum()-1);
			}			
			wishDao.save(wish);
			teacherDao.save(teacher);
		}
		return true;
	}

	/**
	 * 每当老师提交一轮结果，需要标识自己让其他老师知道自己已经完成到第几轮了
	 */
	@Override
	public void doChangeTeacherChooseSutdentRunNum(User user) {
		Teacher teacher = (Teacher) teacherDao.findByUuid(Teacher.class, user.getUuid());
		Integer integer = Integer.parseInt(teacher.getChooseStudentRunNum()) + 1;
		teacher.setChooseStudentRunNum(integer.toString());
		teacherDao.save(teacher);
	}
	
	/**
	 * 3轮选择过后，点击完成第三轮选择，即老师自己已经完成自己的选择，可以确定自己的名单了。只执行一次！
	 */
	@Override
	public List<Student> doVerifyMySelectedStudent(Teacher myselfTeacher) {
		List<Wish> wishes = wishDao.findByAllResultUuid(myselfTeacher);
		Student student = null;
		List<Student> myStudents = new ArrayList<Student>();
		for (Wish wish : wishes) {
			student = (Student) studentDao.findByUuid(Student.class, wish.getUuid());
			student.setTeacher(myselfTeacher);
			studentDao.save(student);
			myselfTeacher.getStudents().add(student);
			myStudents.add(student);
		}
		//宣告结束
		myselfTeacher.setChooseStudentRunNum(ChooseStudentRunNumEnum.finished.getValue());
		teacherDao.save(myselfTeacher);
		return myStudents;
	}
	
	/**
	 * 在三轮选择过后，得到我要指导的学生名单
	 */
	public Set<Student> getMyStudents(Teacher myselfTeacher){
		return myselfTeacher.getStudents();
	}
}
