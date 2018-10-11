package com.zhbit.main.service;

import java.io.File;
import java.io.InputStream;

import com.zhbit.main.entity.ThesisScript;
import com.zhbit.security.entity.Student;

public interface ThesisScriptServiceI {
	public Student getStudent(String uuid);
	public void deleteMyScript(Long[] ids);
	public InputStream download(String absolutePath);
	public void uploadMethod(File script, String realPath, String scriptFileName);
	public void saveToStudent(ThesisScript model);
}
