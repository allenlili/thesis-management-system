package com.zhbit.security.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import com.zhbit.core.bean.TutorRecorder;
import com.zhbit.core.utils.MD5Util;
import com.zhbit.core.utils.Constant.SystemConstant;
import com.zhbit.core.utils.EnumStatus.RoleEnum;
import com.zhbit.core.utils.ExcelFileReader.ModelRecordFactory;
import com.zhbit.core.utils.ExcelFileReader.ModelVO;
import com.zhbit.main.dao.TopicDao;
import com.zhbit.main.entity.TaskBook;
import com.zhbit.main.entity.ThesisProposal;
import com.zhbit.main.entity.ThesisScript;
import com.zhbit.main.entity.Topic;
import com.zhbit.security.dao.InstituteDao;
import com.zhbit.security.dao.MajorDao;
import com.zhbit.security.dao.RoleDao;
import com.zhbit.security.dao.StudentDao;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.dao.UserDao;
import com.zhbit.security.entity.Institute;
import com.zhbit.security.entity.Major;
import com.zhbit.security.entity.Role;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;
import com.zhbit.security.service.StudentServiceI;

@Service("studentService")
public class StudentServiceImpl implements StudentServiceI {
	
	private static Logger logger = Logger.getLogger(StudentServiceImpl.class); 
	
	private StudentDao studentDao;
	@Resource
	public void setStudentDao(StudentDao studentDao) {
		this.studentDao = studentDao;
	}
	
	private UserDao userDao;
	@Resource
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	private InstituteDao instituteDao;
	@Resource
	public void setInstituteDao(InstituteDao instituteDao) {
		this.instituteDao = instituteDao;
	}
	
	private MajorDao majorDao;
	@Resource
	public void setMajorDao(MajorDao majorDao) {
		this.majorDao = majorDao;
	}
	
	private TeacherDao teacherDao;
	@Resource
	public void setTeacherDao(TeacherDao teacherDao) {
		this.teacherDao = teacherDao;
	}
	
	private TopicDao topicDao;
	@Resource
	public void setTopicDao(TopicDao topicDao) {
		this.topicDao = topicDao;
	}
	
	private RoleDao roleDao;
	@Resource
	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}
	
	private SessionFactory sessionFactory;
	@Resource
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	/**
	 * 添加student同时初始化给学生分配用户
	 */
	@Override
	public void doMappingStudentWithUser(Student student) {
		User user = new User();
		user.setUserName(student.getStudentId());
		String uuidString = UUID.randomUUID().toString();
		user.setUuid(uuidString);
		student.setUuid(uuidString);
		user.setPassword(MD5Util.getMD5(SystemConstant.DEFAULT_PASSWORD));
		userDao.save(user);
	}
	
	@Override
	public List<Institute> getInstitutes() {
		List<Institute> institutes = instituteDao.find(DetachedCriteria.forClass(Institute.class));
		return institutes;
	}

	@Override
	public List<Major> getMajors() {
		List<Major> majors = majorDao.find(DetachedCriteria.forClass(Major.class));
		return majors;
	}

	@Override
	public void getMajorName(Student student) {
	}

	@Override
	public void getInstituteName(Student student) {
	}
	
	public void sexIdentity(Student student){
		if(student.getSex()==SystemConstant.MEN){
			student.setSex("男");
		}else{
			student.setSex("女");
		}
	}

	@Override
	public Map<String,Object> saveStuInfoList(File file) {
		logger.info("saveStuInfoList(File file)");
		//读取Excel文件
		ModelRecordFactory modelRecordFactory= ModelRecordFactory.getInstance(file.getAbsolutePath());		
		List<ModelVO> moVos = modelRecordFactory.getModelVOList();		
		//数据集合
		Map<String,Object> map = new HashMap<String,Object>();
		//错误信息
		StringBuilder errormesg = new  StringBuilder();
		//为用户配角色使用
		List<String> uuids = new ArrayList<String>();
		
		Student student = null;
		User user = null;
		String uuidString = null;
		DetachedCriteria criteria = null;
		
		for (ModelVO modelVO : moVos) {
			//首先查询学生表是否存在该学生
			criteria = DetachedCriteria.forClass(Student.class);
			criteria.add(Restrictions.eq("studentId", modelVO.getDetailMap().get("0")));
			List<?> stuList = studentDao.find(criteria);
			//检查数据库中是否已经存在这个学生，存在则覆盖该学生的数据，否则创建新数据
			if(stuList.isEmpty()){
				student = new Student();
				uuidString = UUID.randomUUID().toString();
				uuids.add(uuidString);
				student.setUuid(uuidString);
				student.setStudentId(modelVO.getDetailMap().get("0"));
			}else{
				student = (Student) stuList.get(0);
				uuids.add(student.getUuid());
			}
			student.setName(modelVO.getDetailMap().get("1"));
			//查询Institute对象
			criteria = DetachedCriteria.forClass(Institute.class);
			criteria.add(Restrictions.eq("instituteName", modelVO.getDetailMap().get("2")));
			List<?> instituteList = studentDao.find(criteria);
			if(instituteList.isEmpty()){
				logger.info("找不到该学院："+modelVO.getDetailMap().get("2"));
				errormesg.append("找不到该学院："+modelVO.getDetailMap().get("2"));
				map.put("errormesg", errormesg.toString());
				return map;
			}else{
				student.setInstitute((Institute)instituteList.get(0));
			}
			
			//查询Major对象
			criteria = DetachedCriteria.forClass(Major.class);
			criteria.add(Restrictions.eq("majorName", modelVO.getDetailMap().get("3")));
			List<?> majorList = studentDao.find(criteria);
			if(majorList.isEmpty()){
				logger.info("找不到该专业："+modelVO.getDetailMap().get("3"));
				errormesg.append("找不到该专业："+modelVO.getDetailMap().get("3"));
				map.put("errormesg", errormesg.toString());
				return map;
			}else{
				student.setMajor((Major)majorList.get(0));
			}			
			
			student.setWhichclass(modelVO.getDetailMap().get("4"));
			student.setGpa(modelVO.getDetailMap().get("5"));
			student.setSex(modelVO.getDetailMap().get("6")=="男"?"1":"2");
			student.setQq(modelVO.getDetailMap().get("7"));
			student.setTelephone(modelVO.getDetailMap().get("8"));
			student.setStudentNote(modelVO.getDetailMap().get("9"));
			student.setWhichGrade(modelVO.getDetailMap().get("10"));
			
			//首先查询用户表是否存在该学生的用户名，即学号
			criteria = DetachedCriteria.forClass(User.class);
			criteria.add(Restrictions.eq("userName", modelVO.getDetailMap().get("0")));
			List<?> userList = userDao.find(criteria);
			//检查数据库中是否已经存在这个学生，存在则覆盖该学生的数据，否则创建新数据
			if(userList.isEmpty()){
				user = new User();
				user.setUuid(uuidString);
				user.setUserName(student.getStudentId());
				user.setRealName(student.getName());
				user.setPassword(MD5Util.getMD5(SystemConstant.DEFAULT_PASSWORD));
				user.setUserType(SystemConstant.STUDENT);
				userDao.save(user);
			}else{
				user = (User) userList.get(0);
				user.setUuid(student.getUuid());
				userDao.save(user);
			}
			student.setUser(user);
			studentDao.save(student);
		}
		sessionFactory.getCurrentSession().flush();
		errormesg.append("请更正错误后，尝试再次上传！");
		map.put("errormesg", errormesg.toString());
		map.put("uuids", uuids);
		return map;
	}
	
	public void doConfigureRoleForStudent(List<String> uuids){
		User user = null;
		for (String uuid : uuids) {
			user = (User) userDao.findByUuid(User.class, uuid);
			Set<Role> roles =  user.getRoles();
			for (Role role : roles) {
				role.getUsers().remove(user);
			}
			user.getRoles().clear();
			
			Role roleStudent = roleDao.fineByRoleName(RoleEnum.student.getValue());
			roleStudent.getUsers().add(user);
			user.getRoles().add(roleStudent);
			roleDao.save(roleStudent);
			userDao.save(user);
		}
	}

	@Override
	public void doReplace(Teacher newer, Student student) {
		Teacher older = student.getTeacher();
		older.getStudents().remove(student);
		newer.getStudents().add(student);
		student.setTeacher(newer);
		studentDao.save(student);
		teacherDao.save(older);
		teacherDao.save(newer);
	}

	@Override
	public void doReplace(Topic newer, Student student) {
		Topic older = student.getTopic();
		topicDao.delete(older);
		newer.setStudent(student);
		newer.setTeacher(student.getTeacher());
		topicDao.save(newer);
		newer = (Topic) topicDao.findByUuid(Topic.class, student.getUuid());
		student.setTopic(newer);
		studentDao.save(student);	
	}

	@Override
	public Map<String, Object> watchTutorRecorder(Student model) {
		Student student = (Student) studentDao.get(model.getId());
		Teacher teacher = student.getTeacher();
		Topic topic = student.getTopic();
		TaskBook taskBook = student.getTaskBook();
		ThesisProposal thesisProposal = student.getThesisProposal();
		Set<ThesisScript> thesisScripts = student.getThesisScripts();
		Map<String, Object> map = new HashMap<String,Object>();
		List<TutorRecorder> tutorRecorders = new ArrayList<TutorRecorder>();
		TutorRecorder tutorRecorder = null;
		Long id = 1l;
		if(topic!=null){
			tutorRecorder = new TutorRecorder();
			tutorRecorder.setId(id++);
			tutorRecorder.setStartDate(topic.getStartDate());
			tutorRecorder.setProgress("选题完成。");
			tutorRecorder.setQuestion("无。");
			tutorRecorder.setAnswer("无。");
			tutorRecorders.add(tutorRecorder);
		}
		if(taskBook != null){
			tutorRecorder = new TutorRecorder();
			tutorRecorder.setId(id++);
			tutorRecorder.setStartDate(taskBook.getStartDate());
			tutorRecorder.setProgress("任务书完成。");
			tutorRecorder.setQuestion("无。");
			tutorRecorder.setAnswer("无。");
			tutorRecorders.add(tutorRecorder);
		}
		if(thesisProposal != null){
			tutorRecorder = new TutorRecorder();
			tutorRecorder.setId(id++);
			tutorRecorder.setStartDate(thesisProposal.getStartDate());
			tutorRecorder.setProgress("开题报告完成。");
			tutorRecorder.setQuestion("无。");
			tutorRecorder.setAnswer("无。");
			tutorRecorders.add(tutorRecorder);
		}
		if(thesisScripts.size()!=0){
			ThesisScript thesisScript = null;
			for (Iterator<ThesisScript> iterator = thesisScripts.iterator(); iterator.hasNext();){
				thesisScript =  (ThesisScript) iterator.next();
				tutorRecorder = new TutorRecorder();
				tutorRecorder.setId(id++);
				tutorRecorder.setStartDate(thesisScript.getStartDate());
				tutorRecorder.setProgress((thesisScript.getLastScript()==0?("上交非终稿。"):("上交终稿。")));
				tutorRecorder.setQuestion(thesisScript.getQuestion());
				tutorRecorder.setAnswer(thesisScript.getAnswer());
				tutorRecorders.add(tutorRecorder);
			}
		}
		map.put("student", student);
		map.put("teacher", teacher);
		map.put("tutorRecorders", tutorRecorders);
		return map;
	}
}
