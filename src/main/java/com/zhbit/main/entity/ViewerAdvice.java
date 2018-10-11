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
 * 评阅意见表
 * @author AllenLi
 *
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "viewerAdvice")
public class ViewerAdvice extends ActivitiBaseEntity{
	
	/**评阅意见表*/
	private String opinion;
	
	/**评阅意见分数*/
	private Integer viewerGrade;
	
	/**是否同意答辩*/
	private Integer agreeOrNot;//0不同意、1同意
	
	/**评阅意见表唯一标识*/
	private String uuid;
	
	/**关联老师*/
	private Teacher teacher;
	
	/**关联题目*/
	private Topic topic;
	
	/**关联学生*/
	private Student student;
	
	@Column(name = "opinion_")
	public String getOpinion() {
		return opinion;
	}
	
	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}
	
	@Column(name = "viewer_grade_")
	public Integer getViewerGrade() {
		return viewerGrade;
	}
	
	public void setViewerGrade(Integer viewerGrade) {
		this.viewerGrade = viewerGrade;
	}
	
	@Column(name = "agree_or_not")
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
