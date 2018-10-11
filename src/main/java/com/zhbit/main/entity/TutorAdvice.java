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
 * 指导意见表
 * @author AllenLi
 *
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "tutorAdvice")
public class TutorAdvice  extends ActivitiBaseEntity{
	
	/**意见内容*/
	private String opinion;
	
	/**指导分数*/
	private Integer tutorGrade;
	
	/**是够同意答辩 ：0不同意、1同意*/
	private Integer agreeOrNot;//
	
	/**关联老师*/
	private Teacher teacher;
	
	/**关联题目*/
	private Topic topic;
	
	/**关联学生*/
	private Student student;
	
	/**唯一标识符*/
	private String uuid;
	
	@Column(name = "opinion_")
	public String getOpinion() {
		return opinion;
	}
	
	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}
	
	@Column(name = "tutor_grade_",columnDefinition="int default 0")
	public Integer getTutorGrade() {
		return tutorGrade;
	}
	
	public void setTutorGrade(Integer tutorGrade) {
		this.tutorGrade = tutorGrade;
	}
	
	@Column(name = "agree_or_not",columnDefinition="int default 1")
	public Integer getAgreeOrNot() {
		return agreeOrNot;
	}
	
	public void setAgreeOrNot(Integer agreeOrNot) {
		this.agreeOrNot = agreeOrNot;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	public Teacher getTeacher() {
		return teacher;
	}
	
	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public Topic getTopic() {
		return topic;
	}
	
	public void setTopic(Topic topic) {
		this.topic = topic;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public Student getStudent() {
		return student;
	}
	
	public void setStudent(Student student) {
		this.student = student;
	}
	
	@Column(name = "uuid_")
	public String getUuid() {
		return uuid;
	}
	
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
}
