package com.zhbit.security.dao;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.zhbit.core.dao.GenericDao;
import com.zhbit.main.entity.Wish;
import com.zhbit.security.entity.Student;

@Repository
public class StudentDao extends GenericDao<Student> {
	public void saveStuInfo(Student student){
		Student student2 = (Student) findByUuid(Student.class, student.getUuid());
		student2.setQq(student.getQq());
		student2.setTelephone(student.getTelephone());
		student2.setStudentNote(student.getStudentNote());
		sessionFactory.getCurrentSession().save(student2);
	}
	
	public List<Student> findByWish(List<Wish> wishes){
		List<Student> students = new ArrayList<Student>();
		for (Wish wish : wishes) {
			Student student= (Student) findByUuid(Student.class, wish.getUuid());
			students.add(student);
		}
		return students;
	}
	
	public Student find(String studentId){
		Student student = get(Student.class, studentId);
		return student;
	}
}
