package com.zhbit.main.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import com.zhbit.core.utils.EnumStatus.LastScriptEnum;
import com.zhbit.main.dao.ThesisScriptDao;
import com.zhbit.main.dao.TopicDao;
import com.zhbit.main.entity.ThesisScript;
import com.zhbit.main.service.ThesisScriptServiceI;
import com.zhbit.security.dao.StudentDao;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.entity.Student;

@Service("thesisScriptService")
public class ThesisScriptServiceImpl implements ThesisScriptServiceI {

	private static Logger logger = Logger.getLogger(ThesisScriptServiceImpl.class);
	
	@SuppressWarnings("unused")
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
	
	private ThesisScriptDao thesisScriptDao;
	@Resource
	public void setThesisScriptDao(ThesisScriptDao thesisScriptDao) {
		this.thesisScriptDao = thesisScriptDao;
	}
	
	@SuppressWarnings("unused")
	private TopicDao topicDao;
	@Resource
	public void setTopicDao(TopicDao topicDao) {
		this.topicDao = topicDao;
	}
	
	@Override
	public Student getStudent(String uuid) {
		Student student = (Student) studentDao.findByUuid(Student.class, uuid);
		return student;
	}
	
	/**
	 * 上传文件方法
	 * @param file
	 * @param realPath
	 * @param fileFileName
	 */
	public void uploadMethod(File file,String realPath,String fileFileName){
		logger.info("uploadMethod(File file,String realPath,String fileFileName)");
		File sa = new File(realPath,fileFileName);
		InputStream in=null; 
		OutputStream ou=null;
		try { 
			sa.getParentFile().mkdirs();
			in=new FileInputStream(file);
			ou=new FileOutputStream(sa);
			byte[] b=new byte[1024];
			int len=0;
		    while((len=in.read(b))!=-1){
			  ou.write(b,0,len); 
			}
			in.close(); 
			ou.close();
		}catch (IOException e) {
			e.printStackTrace();
		}					
	}
	
	@Override
	public InputStream download(String absolutePath){
		File file = new  File(absolutePath);
		InputStream inputStream = null;
		try {
			inputStream = new FileInputStream(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return inputStream;
	}	

	@Override
	public void deleteMyScript(Long[] ids) {
		ThesisScript thesisScript = null;
		File file = null;
		for (int i = 0; i < ids.length; i++) {
			thesisScript  = thesisScriptDao.get(ids[i]);
			file = new File(thesisScript.getPath() + thesisScript.getFileName());
			thesisScriptDao.delete(thesisScript);
			file.delete();
		}
	}

	@Override
	public void saveToStudent(ThesisScript model) {
		Student student = model.getStudent();
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(ThesisScript.class);
		detachedCriteria.createAlias("student", "s")
		.add(Restrictions.eq("s.id", student.getId()))
		.add(Restrictions.eq("startDate", model.getStartDate()));
		List<ThesisScript> thesisScripts = thesisScriptDao.find(detachedCriteria); 
		Set<ThesisScript> thesisScriptsSet = student.getThesisScripts();
		List<ThesisScript> removedList = new ArrayList<ThesisScript>();
		ThesisScript lastThesisScript = null;
		if(!thesisScripts.isEmpty()){
			for (ThesisScript thesisScript : thesisScripts) {
				if(LastScriptEnum.yes.getValue().equals(thesisScript.getLastScript())){
					lastThesisScript = thesisScript;
				}
				if(thesisScriptsSet.contains(thesisScript)){
					removedList.add(thesisScript);
				}
			}
			thesisScripts.removeAll(removedList);
			student.setLastThesisScript(lastThesisScript);
			student.getThesisScripts().addAll(thesisScripts);
		}
		studentDao.save(student);
	}
}
