package com.zhbit.main.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.zhbit.core.entity.ActivitiBaseEntity;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;


/**
 * 任务书，由老师下发给学生
 *  @author AllenLi
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "taskBook")
public class TaskBook extends ActivitiBaseEntity{
	/**关联任务书对应的题目*/
	private Topic topic;
	
	/**第一栏内容*/
	private String firstContent;
	
	/**第二栏内容*/
	private String secondContent;
	
	/**第三栏内容*/
	private Student student;
	
	/**关联老师*/
	private Teacher teacher;
	
	@OneToOne(fetch = FetchType.LAZY)
	public Topic getTopic() {
		return topic;
	}
	
	public void setTopic(Topic topic) {
		this.topic = topic;
	}
	
	@Column(name = "first_content_",columnDefinition="text")
	public String getFirstContent() {
		return firstContent;
	}
	
	public void setFirstContent(String firstContent) {
		this.firstContent = firstContent;
	}
	
	@Column(name = "second_content_",columnDefinition="text")
	public String getSecondContent() {
		return secondContent;
	}
	
	public void setSecondContent(String secondContent) {
		this.secondContent = secondContent;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public Student getStudent() {
		return student;
	}
	
	public void setStudent(Student student) {
		this.student = student;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	public Teacher getTeacher() {
		return teacher;
	}
	
	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}
}
