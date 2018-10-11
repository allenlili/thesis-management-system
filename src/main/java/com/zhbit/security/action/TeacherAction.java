package com.zhbit.security.action;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.entity.Institute;
import com.zhbit.security.entity.Major;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.service.SententceSecurityServiceI;
import com.zhbit.security.service.TeacherServiceI;

@SuppressWarnings("serial")
@Controller("teacherAction")
@Scope("prototype")
public class TeacherAction extends BaseAction<Teacher> {
	
	private static Logger logger = Logger.getLogger(TeacherAction.class); 
	
	private File teainfo;
	private String teainfoName;
	
	private Long instituteId;
	private Long majorId;
	private Long viwerId;

	private String infoString;
	
	private TeacherDao teacherDao;
	@Resource
	public void setTeacherDao(TeacherDao teacherDao) {
		this.teacherDao = teacherDao;
	}
	
	private TeacherServiceI teacherService;
	@Resource
	public void setTeacherService(TeacherServiceI teacherService) {
		this.teacherService = teacherService;
	}
	
	private SententceSecurityServiceI sententceSecurityService;
	@Resource
	public void setSententceSecurityService(
			SententceSecurityServiceI sententceSecurityService) {
		this.sententceSecurityService = sententceSecurityService;
	}
	
	@Override
	public GenericDao<Teacher> getDao() {
		return teacherDao;
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getName() && !"".equals(model.getName())) {
			criteria.add(Restrictions.like("name", model.getName(),MatchMode.ANYWHERE));
		}
		if (null != model.getTeacherId() && !"".equals(model.getTeacherId())) {
			criteria.add(Restrictions.like("teacherId", model.getTeacherId(),MatchMode.ANYWHERE));
		}
		sententceSecurityService.getFindSecurityByRole(getCurrentUser(), criteria);
	}
	
	@Override
	public void beforeSave(Teacher teacher) {
		teacherService.doMappingTeacherWithUser(teacher);
		teacherService.sexIdentity(teacher);
	}
	
	@Override
	public void beforToAdd() {
		logger.info("beforToAdd()");
		ActionContext.getContext().put("instituteList", teacherService.getInstitutes());
		ActionContext.getContext().put("majorList", teacherService.getMajors());
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void afterToUpdate(Teacher teacher) {
		logger.info("afterToUpdate(Teacher teacher)");
		List<Institute> institutes = teacherDao.find(DetachedCriteria.forClass(Institute.class));
		Institute teacherInstitute = teacher.getInstitute();
		institutes.remove(teacherInstitute);
		ActionContext.getContext().put("instituteList", institutes);	
		
		List<Major> majors = teacherDao.find(DetachedCriteria.forClass(Major.class));
		Set<Major> teacherMajors = teacher.getMajors();
		for (Major major : teacherMajors) {
			majors.remove(major);
		}
		ActionContext.getContext().put("majorList", majors);	
		
		List<Teacher> viwers = new ArrayList<Teacher>();
		Institute institute = teacher.getInstitute();
		Set<Major> ms = teacher.getMajors();
		for (Major m : ms) {
			viwers.addAll((Collection<? extends Teacher>) teacherDao.findByInstituteAndMajor(Teacher.class, institute, m));
		}
		viwers.remove(teacher);
		viwers.remove(teacher.getViewer());
		ActionContext.getContext().put("viwerList", viwers);
	}
	
	public String addInstitute() {
		Teacher teacher = teacherDao.get(model.getId());
		Institute institute = teacherDao.get(Institute.class, instituteId);
		teacher.setInstitute(institute);
		teacherDao.save(teacher);
		return UPDATE_ACTION;
	}
	
	public String deleteInstitute() {
		Teacher teacher = teacherDao.get(model.getId());
//		Institute institute = studentDao.get(Institute.class, instituteId);
		teacher.setInstitute(null);
		teacherDao.save(teacher);
		return UPDATE_ACTION;
	}
	
	public String addMajor() {
		Teacher teacher = teacherDao.get(model.getId());
		Major major = teacherDao.get(Major.class, majorId);
		teacher.getMajors().add(major);
		teacherDao.save(teacher);
		return UPDATE_ACTION;
	}
	
	public String deleteMajor() {
		Teacher teacher = teacherDao.get(model.getId());
		Major major = teacherDao.get(Major.class, majorId);
		teacher.getMajors().remove(major);
		teacherDao.save(teacher);
		return UPDATE_ACTION;
	}			
	
	public String addViwer() {
		Teacher teacher = teacherDao.get(model.getId());
		Teacher viwer = teacherDao.get(Teacher.class, viwerId);
		viwer.getTeachers().add(teacher);
		teacher.setViewer(viwer);
		teacherDao.save(teacher);
		teacherDao.save(viwer);
		return UPDATE_ACTION;
	}
	
	public String deleteViwer() {
		//获取需要修改的老师
		Teacher teacher = teacherDao.get(model.getId());
		//获取该老师对应的唯一一位评阅者
		Teacher viwer = teacher.getViewer();
		//评阅老师去掉自己评阅对象（一个老师可以评语多位老师，但是一个老师只有一个评阅对象）
		viwer.getTeachers().remove(teacher);
		teacher.setViewer(null);
		teacherDao.save(teacher);
		teacherDao.save(viwer);
		return UPDATE_ACTION;
	}	
	
	public String uploadTeaInfo(){
		Map<String, Object> map = teacherService.saveTeaInfoList(teainfo);
		String info = (String) map.get("errormesg");
		@SuppressWarnings("unchecked")
		List<String> uuids = (List<String>) map.get("uuids");
		teacherService.doConfigureRoleForTeacher(uuids);
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

	public File getTeainfo() {
		return teainfo;
	}

	public void setTeainfo(File teainfo) {
		this.teainfo = teainfo;
	}

	public String getTeainfoName() {
		return teainfoName;
	}

	public void setTeainfoName(String teainfoName) {
		this.teainfoName = teainfoName;
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
	
	public Long getViwerId() {
		return viwerId;
	}

	public void setViwerId(Long viwerId) {
		this.viwerId = viwerId;
	}	
}
