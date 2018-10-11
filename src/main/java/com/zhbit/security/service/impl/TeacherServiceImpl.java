package com.zhbit.security.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import com.zhbit.core.utils.MD5Util;
import com.zhbit.core.utils.Constant.SystemConstant;
import com.zhbit.core.utils.EnumStatus.ChooseStudentRunNumEnum;
import com.zhbit.core.utils.EnumStatus.RoleEnum;
import com.zhbit.core.utils.EnumStatus.StatusEnum;
import com.zhbit.core.utils.ExcelFileReader.ModelRecordFactory;
import com.zhbit.core.utils.ExcelFileReader.ModelVO;
import com.zhbit.security.dao.InstituteDao;
import com.zhbit.security.dao.MajorDao;
import com.zhbit.security.dao.RoleDao;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.dao.UserDao;
import com.zhbit.security.entity.Institute;
import com.zhbit.security.entity.Major;
import com.zhbit.security.entity.Role;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;
import com.zhbit.security.service.TeacherServiceI;

@Service("teacherService")
public class TeacherServiceImpl implements TeacherServiceI {
	
	private static Logger logger = Logger.getLogger(TeacherServiceImpl.class); 
	
	private TeacherDao teacherDao;
	@Resource
	public void setTeacherDao(TeacherDao teacherDao) {
		this.teacherDao = teacherDao;
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
	 * 添加teacher同时初始化给学生分配用户
	 */
	@Override
	public void doMappingTeacherWithUser(Teacher teacher) {
		User user = new User();
		user.setUserName(teacher.getTeacherId());
		String uuidString = UUID.randomUUID().toString();
		user.setUuid(uuidString);
		teacher.setUuid((uuidString));
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
	public void getMajorName(Teacher teacher) {
	}

	@Override
	public void getInstituteName(Teacher teacher) {
	}
	
	public void sexIdentity(Teacher teacher){
		if(teacher.getSex()==SystemConstant.MEN){
			teacher.setSex("男");
		}else{
			teacher.setSex("女");
		}
	}

	@Override
	public Map<String,Object> saveTeaInfoList(File file) {
		logger.info("saveTeaInfoList(File file)");
		Map<String,Object> map = new HashMap<String,Object>();
		ModelRecordFactory modelRecordFactory= ModelRecordFactory.getInstance(file.getAbsolutePath());
		List<ModelVO> moVos = modelRecordFactory.getModelVOList();
		Teacher teacher = null;
		User user = null;
		String uuidString = null;
		DetachedCriteria criteria = null;
		StringBuilder errormesg = new  StringBuilder();
		List<String> uuids = new ArrayList<String>();
		errormesg.append("error:");
		for (ModelVO modelVO : moVos) {
			//首先查询老师表是否存在该老师
			criteria = DetachedCriteria.forClass(Teacher.class);
			criteria.add(Restrictions.eq("teacherId", modelVO.getDetailMap().get("0")));
			List<?> teaList = teacherDao.find(criteria);
			//检查数据库中是否已经存在这个学生，存在则覆盖该学生的数据，否则创建新数据
			if(teaList.isEmpty()){
				teacher = new Teacher();
				uuidString = UUID.randomUUID().toString();
				uuids.add(uuidString);
				teacher.setUuid(uuidString);
				teacher.setTeacherId(modelVO.getDetailMap().get("0"));
			}else{
				teacher = (Teacher) teaList.get(0);
				uuids.add(teacher.getUuid());
			}
			teacher.setName(modelVO.getDetailMap().get("1"));
			//查询Institute对象
			criteria = DetachedCriteria.forClass(Institute.class);
			criteria.add(Restrictions.eq("instituteName", modelVO.getDetailMap().get("2")));
			List<?> instituteList = teacherDao.find(criteria);
			if(instituteList.isEmpty()){
				logger.info("找不到该学院："+modelVO.getDetailMap().get("2"));
				errormesg.append("找不到该学院："+modelVO.getDetailMap().get("2"));
				map.put("errormesg", errormesg.toString());
				return map;
			}else{
				teacher.setInstitute((Institute)instituteList.get(0));
			}
			//查询Major对象
			criteria = DetachedCriteria.forClass(Major.class);
			criteria.add(Restrictions.eq("majorName", modelVO.getDetailMap().get("3")));
			List<?> majorList = teacherDao.find(criteria);
			if(majorList.isEmpty()){
				logger.info("找不到该专业："+modelVO.getDetailMap().get("3"));
				errormesg.append("找不到该专业："+modelVO.getDetailMap().get("3"));
				map.put("errormesg", errormesg.toString());
				return map;
			}else{
				if(teacher.getMajors().size()>0 ){
					teacher.getMajors().clear();
				}
				teacher.getMajors().add(((Major)majorList.get(0)));
			}			
			
			teacher.setLevel(modelVO.getDetailMap().get("4"));
			teacher.setTeachNum(modelVO.getDetailMap().get("5"));
			teacher.setSex(modelVO.getDetailMap().get("6")=="男"?"1":"2");
			teacher.setTeacherEmail(modelVO.getDetailMap().get("7"));
			teacher.setTeacherTel(modelVO.getDetailMap().get("8"));
			teacher.setTeacherNote(modelVO.getDetailMap().get("9"));
			teacher.setChooseStudentRunNum(ChooseStudentRunNumEnum.defaultValue.getValue());
			teacher.setForwardLectureGradeStatus(StatusEnum.unstart.getValue());
			teacher.setForwardTutorGradeStatus(StatusEnum.unstart.getValue());
			teacher.setForwardViewerGradeStatus(StatusEnum.unstart.getValue());
			teacher.setRealTeachNum(SystemConstant.REAL_TEACH_NUM);
			
			//首先查询用户表是否存在该学生的用户名，即学号
			criteria = DetachedCriteria.forClass(User.class);
			criteria.add(Restrictions.eq("userName", modelVO.getDetailMap().get("0")));
			List<?> userList = userDao.find(criteria);
			//检查数据库中是否已经存在这个老师，存在则覆盖该老师的数据，否则创建新数据
			if(userList.isEmpty()){
				user = new User();
				user.setUuid(uuidString);
				user.setUserName(teacher.getTeacherId());
				user.setRealName(teacher.getName());
				user.setPassword(MD5Util.getMD5(SystemConstant.DEFAULT_PASSWORD));
				user.setUserType(SystemConstant.TEACHER);
				userDao.save(user);
			}else{
				user = (User) userList.get(0);
				user.setUuid(teacher.getUuid());
				userDao.save(user);				
			}
			Session session = sessionFactory.getCurrentSession();
			session.flush();
			teacher.setUser(user);
			teacherDao.save(teacher);
		}
		sessionFactory.getCurrentSession().flush();
		errormesg.append("请更正错误后，尝试再次上传！");
		map.put("errormesg", errormesg.toString());
		map.put("uuids", uuids);
		return map;
	}
	
	public void doConfigureRoleForTeacher(List<String> uuids){
		User user = null;
		for (String uuid : uuids) {
			user = (User) userDao.findByUuid(User.class, uuid);
			Set<Role> roles =  user.getRoles();
			for (Role role : roles) {
				role.getUsers().remove(user);
			}
			user.getRoles().clear();
			
			Role roleWorkgroup = roleDao.fineByRoleName(RoleEnum.tutor.getValue());
			Role roleViewer = roleDao.fineByRoleName(RoleEnum.viewer.getValue());
			
			roleWorkgroup.getUsers().add(user);
			roleViewer.getUsers().add(user);
			user.getRoles().add(roleWorkgroup);
			user.getRoles().add(roleViewer);
			
			roleDao.save(roleWorkgroup);
			roleDao.save(roleViewer);
			userDao.save(user);
		}
	}

}
