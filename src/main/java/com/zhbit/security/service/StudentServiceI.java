package com.zhbit.security.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.zhbit.main.entity.Topic;
import com.zhbit.security.entity.Institute;
import com.zhbit.security.entity.Major;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;

public interface StudentServiceI {
	public void doMappingStudentWithUser(Student student);
	public List<Institute> getInstitutes();
	public List<Major> getMajors();
	public void getMajorName(Student student);
	public void getInstituteName(Student student);
	public void sexIdentity(Student student);
	public Map<String, Object> saveStuInfoList(File file);
	public void doReplace(Teacher teacher, Student student);
	public void doReplace(Topic topic, Student student);
	public Map<String, Object> watchTutorRecorder(Student model);
	public void doConfigureRoleForStudent(List<String> uuids);
}
