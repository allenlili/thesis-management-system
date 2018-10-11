package com.zhbit.security.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.zhbit.security.entity.Institute;
import com.zhbit.security.entity.Major;
import com.zhbit.security.entity.Teacher;

public interface TeacherServiceI {
	public void doMappingTeacherWithUser(Teacher teacher);
	public List<Institute> getInstitutes();
	public List<Major> getMajors();
	public void getMajorName(Teacher teacher);
	public void getInstituteName(Teacher teacher);
	public void sexIdentity(Teacher teacher);
	public Map<String, Object> saveTeaInfoList(File file);
	public void doConfigureRoleForTeacher(List<String> uuids);
}
