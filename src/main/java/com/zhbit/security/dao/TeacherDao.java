package com.zhbit.security.dao;


import org.springframework.stereotype.Repository;

import com.zhbit.core.dao.GenericDao;
import com.zhbit.security.entity.Teacher;

@Repository
public class TeacherDao extends GenericDao<Teacher> {
	public void saveTeaInfo(Teacher teacher){
		Teacher teacher2 = (Teacher) findByUuid(Teacher.class, teacher.getUuid());
		teacher2.setTeacherEmail(teacher.getTeacherEmail());
		teacher2.setTeacherTel(teacher.getTeacherTel());
		teacher2.setTeacherNote(teacher.getTeacherNote());
		sessionFactory.getCurrentSession().save(teacher2);
	}	
}
