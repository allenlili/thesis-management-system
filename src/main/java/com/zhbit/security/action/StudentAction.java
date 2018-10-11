package com.zhbit.security.action;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.zhbit.core.action.BaseAction;
import com.zhbit.core.dao.GenericDao;
import com.zhbit.core.utils.EnumStatus.StatusEnum;
import com.zhbit.main.entity.Topic;
import com.zhbit.security.dao.StudentDao;
import com.zhbit.security.entity.Institute;
import com.zhbit.security.entity.Major;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.service.StudentServiceI;

@SuppressWarnings("serial")
@Controller("studentAction")
@Scope("prototype")
public class StudentAction extends BaseAction<Student> {
	
	private static Logger logger = Logger.getLogger(StudentAction.class); 
	
	private File stuinfo;
	private String stuinfoName;
	
	private Long instituteId;
	private Long majorId;
	private Long teacherId;
	private Topic topic;
	
	private String infoString;
	
	private StudentDao studentDao;
	@Resource
	public void setStudentDao(StudentDao studentDao) {
		this.studentDao = studentDao;
	}
	
	private StudentServiceI studentService;
	@Resource
	public void setStudentService(StudentServiceI studentService) {
		this.studentService = studentService;
	}
		
	@Override
	public GenericDao<Student> getDao() {
		return studentDao;
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getName() && !"".equals(model.getName())) {
			criteria.add(Restrictions.like("name", model.getName(),MatchMode.ANYWHERE));
		}
		if (null != model.getStudentId() && !"".equals(model.getStudentId())) {
			criteria.add(Restrictions.like("studentId", model.getStudentId(),MatchMode.ANYWHERE));
		}
	}
	
	@Override
	public void beforeSave(Student student) {
		studentService.doMappingStudentWithUser(student);
		studentService.sexIdentity(student);
	}
	
	@Override
	public void beforToAdd() {
		logger.info("beforToAdd()");
		ActionContext.getContext().put("instituteList", studentService.getInstitutes());
		ActionContext.getContext().put("majorList", studentService.getMajors());
	}
	
	@Override
	public void afterToUpdate(Student student) {
		logger.info("afterToUpdate(Student student)");
		List<Institute> institutes = studentDao.find(DetachedCriteria.forClass(Institute.class));
		Institute studentInstitute = student.getInstitute();
		institutes.remove(studentInstitute);
		ActionContext.getContext().put("instituteList", institutes);	
		
		List<Major> majors = studentDao.find(DetachedCriteria.forClass(Major.class));
		Major studentMajor = student.getMajor();
		majors.remove(studentMajor);
		ActionContext.getContext().put("majorList", majors);	
		
		DetachedCriteria criteria = DetachedCriteria.forClass(Teacher.class);
		criteria.createAlias("institute", "i")
		.createAlias("majors", "ms")
		.add(Restrictions.eq("i.instituteName", student.getInstitute().getInstituteName()))
		.add(Restrictions.eq("ms.majorName", student.getMajor().getMajorName()));		
		List<Teacher> teachers = studentDao.find(criteria);
		ActionContext.getContext().put("teacherList", teachers);
		
		Topic topic = student.getTopic();
		ActionContext.getContext().put("topic", topic);
	}
	
	public String addInstitute() {
		Student student = studentDao.get(model.getId());
		Institute institute = studentDao.get(Institute.class, instituteId);
		student.setInstitute(institute);
		studentDao.save(student);
		return UPDATE_ACTION;
	}
	
	public String deleteInstitute() {
		Student student = studentDao.get(model.getId());
//		Institute institute = studentDao.get(Institute.class, instituteId);
		student.setInstitute(null);
		studentDao.save(student);
		return UPDATE_ACTION;
	}
	
	public String addMajor() {
		Student student = studentDao.get(model.getId());
		Major major = studentDao.get(Major.class, majorId);
		student.setMajor(major);
		studentDao.save(student);
		return UPDATE_ACTION;
	}
	
	public String deleteMajor() {
		Student student = studentDao.get(model.getId());
//		Institute institute = studentDao.get(Institute.class, instituteId);
		student.setMajor(null);
		studentDao.save(student);
		return UPDATE_ACTION;
	}
	
	public String addTeacher() {
		Student student = studentDao.get(model.getId());
		Teacher teacher = studentDao.get(Teacher.class, teacherId);
		studentService.doReplace(teacher,student);
		return UPDATE_ACTION;
	}
	
	public String addTopic(){
		Student student = studentDao.get(model.getId());
		topic.setStartDate(new Date());
		topic.setStatus(StatusEnum.success.getValue());
		topic.setUser(getCurrentUser());
		studentService.doReplace(topic, student);
		return UPDATE_ACTION;
	}
	
	public String uploadStuInfo(){
		Map<String, Object> map = studentService.saveStuInfoList(stuinfo);
		String info = (String) map.get("errormesg");
		@SuppressWarnings("unchecked")
		List<String> uuids = (List<String>) map.get("uuids");
		studentService.doConfigureRoleForStudent(uuids);
		if(info==null||"".equals(info)){
			info = "上传成功！";
			infoString = "上传成功！";
			ActionContext.getContext().getValueStack().push(info);
			return LIST_ACTION;
		}else{
			infoString = info;
			ActionContext.getContext().getValueStack().push(info);
			return LIST_ACTION;
		}
	}

	public File getStuinfo() {
		return stuinfo;
	}

	public void setStuinfo(File stuinfo) {
		this.stuinfo = stuinfo;
	}

	public String getStuinfoName() {
		return stuinfoName;
	}

	public void setStuinfoName(String stuinfoName) {
		this.stuinfoName = stuinfoName;
	}

	public Long getInstituteId() {
		return instituteId;
	}

	public void setInstituteId(Long instituteId) {
		this.instituteId = instituteId;
	}

	public Long getMajorId() {
		return majorId;
	}

	public void setMajorId(Long majorId) {
		this.majorId = majorId;
	}

	public String getInfoString() {
		return infoString;
	}

	public void setInfoString(String infoString) {
		this.infoString = infoString;
	}

	public Long getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(Long teacherId) {
		this.teacherId = teacherId;
	}

	public Topic getTopic() {
		return topic;
	}

	public void setTopic(Topic topic) {
		this.topic = topic;
	}
}
