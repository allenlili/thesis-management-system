package com.zhbit.main.action;

import java.io.File;
import java.io.FileInputStream;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.zhbit.core.action.ActivitiBaseAction;
import com.zhbit.core.dao.GenericDao;
import com.zhbit.core.utils.TimeUtil;
import com.zhbit.core.utils.Constant.SystemConstant;
import com.zhbit.core.utils.EnumStatus.*;
import com.zhbit.main.dao.ThesisScriptDao;
import com.zhbit.main.entity.ThesisScript;
import com.zhbit.main.service.ThesisScriptServiceI;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@SuppressWarnings("serial")
@Controller("thesisScriptAction")
@Scope("prototype")
public class ThesisScriptAction extends ActivitiBaseAction<ThesisScript> {
	
	private File script;
	private String scriptFileName;
	private FileInputStream targetFile;
	private String fileUuid;//下载需要的稿件唯一标识
	private Long id;
	
	private ThesisScriptServiceI thesisScriptService;
	@Resource
	public void setThesisScriptService(ThesisScriptServiceI thesisScriptService) {
		this.thesisScriptService = thesisScriptService;
	}
	
	private ThesisScriptDao thesisScriptDao;
	@Resource
	public void setThesisScriptDao(ThesisScriptDao thesisScriptDao) {
		this.thesisScriptDao = thesisScriptDao;
	}

	@Override
	public GenericDao<ThesisScript> getDao() {
		return thesisScriptDao;
	}
	
	@Override
	public void beforeSave(ThesisScript model) {
		User user = getCurrentUser();
		Student student = thesisScriptService.getStudent(user.getUuid());
		if (model.getUser() == null) {
			model.setUser(user);
		}
		if (model.getStatus() == null) {
			model.setStatus(StatusEnum.unstart.getValue());
		}
		if(model.getLastScript() == null){
			model.setLastScript(LastScriptEnum.no.getValue());
		}
		if(model.getPath()==null){
			String realPath = SystemConstant.FILE_PATH + 
					File.separator + student.getWhichGrade() + "届毕业生论文稿" +
					File.separator + student.getInstitute().getInstituteName() +
					File.separator + student.getMajor().getMajorName() +
					File.separator + user.getUserName() + 
					File.separator + TimeUtil.getFileFormatTime(new Date()) + 
					File.separator;
			thesisScriptService.uploadMethod(script, realPath, scriptFileName);
			model.setPath(realPath);
		}
		if(model.getFileName() == null){
			model.setFileName(scriptFileName);
		}
		if(model.getStartDate() == null){
			model.setStartDate(new Date());
		}
		if(model.getStudent()==null){
			model.setStudent(student);
		}
		if(model.getTeacher() == null){
			model.setTeacher(model.getStudent().getTeacher());
		}
		if(model.getTopic() == null){
			model.setTopic(model.getStudent().getTopic());
		}
		if(model.getUuid() == null){
			model.setUuid(UUID.randomUUID().toString());
			model.setStartDate(new Date());
		}
	}
	
	@Override
	public void afterSave(ThesisScript model) {
		thesisScriptService.saveToStudent(model);
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (model.getStartDate() != null  ) {
			criteria.add(Restrictions.ge("startDate", model.getStartDate()));
		}
		if (model.getEndDate() != null  ) {
			criteria.add(Restrictions.le("endDate", model.getEndDate()));
		}
		if (model.getStatus() != null ) {
			if (StatusEnum.finished.getValue().equals(model.getStatus())) {
				Criterion c1 = Restrictions.eq("status", StatusEnum.success.getValue());
				Criterion c2 = Restrictions.eq("status", StatusEnum.fail.getValue());
				criteria.add(Restrictions.or(c1, c2));
			} else {
				criteria.add(Restrictions.eq("status", model.getStatus()));
			}
		}
		if (model.getQueryByAllUser() == null || "".equals(model.getQueryByAllUser())) {
			criteria.createAlias("user", "u");
			criteria.add(Restrictions.eq("u.id", getCurrentUser().getId()));
		}
		if(model.getFileName()!=null && !"".equals(model.getFileName())){
			criteria.add(Restrictions.like("fileName", model.getFileName(),MatchMode.ANYWHERE));
		}
		Student student = thesisScriptService.getStudent(getCurrentUser().getUuid());
		ActionContext.getContext().put("student", student);
	}
	
	public String  deleteMyScript() {
		thesisScriptService.deleteMyScript(ids);
		return LIST_ACTION;
	}
	
	/**
	 * 下载稿件控制页面    
	 * @return
	 * @throws Exception
	 */
	public String download() throws Exception{
		ThesisScript thesisScript = (ThesisScript) thesisScriptDao.findByUuid(ThesisScript.class, fileUuid);
		this.scriptFileName = new String(thesisScript.getFileName().getBytes(),"ISO8859-1");
		String absolutePath = thesisScript.getPath() + thesisScript.getFileName();
		this.targetFile = (FileInputStream) thesisScriptService.download(absolutePath);
		return "download";
	}
	
    public String findMyStudents(){
    	Teacher teacher = (Teacher) thesisScriptDao.findByUuid(Teacher.class, getCurrentUser().getUuid());
    	ActionContext.getContext().put("students", teacher.getStudents());
    	return "toMyStudent";
    }
    
    public String findMyStudentScript(){
    	DetachedCriteria detachedCriteria = DetachedCriteria.forClass(ThesisScript.class);
    	detachedCriteria.createAlias("student", "s");
    	detachedCriteria.add(Restrictions.eq("s.uuid", model.getUuid()));
    	List<ThesisScript> thesisScripts = thesisScriptDao.find(detachedCriteria);
    	ActionContext.getContext().put("thesisScripts", thesisScripts);
    	return "toMyStudentScript";
    }
   
    public String getMystudentScriptDetails(){
    	ThesisScript thesisScript = (ThesisScript) thesisScriptDao.findByUuid(ThesisScript.class, model.getUuid());
    	ActionContext.getContext().put("thesisScript", thesisScript);
    	return "toMyStudentScriptDetails";
    }
    
	public File getScript() {
		return script;
	}
	public void setScript(File script) {
		this.script = script;
	}


	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}

	public void setTargetFile(FileInputStream targetFile) {
		this.targetFile = targetFile;
	}	
	public FileInputStream getTargetFile() {
		return targetFile;
	}

	public String getScriptFileName() {
		return scriptFileName;
	}

	public void setScriptFileName(String scriptFileName) {
		this.scriptFileName = scriptFileName;
	}

	public String getFileUuid() {
		return fileUuid;
	}

	public void setFileUuid(String fileUuid) {
		this.fileUuid = fileUuid;
	}
}
