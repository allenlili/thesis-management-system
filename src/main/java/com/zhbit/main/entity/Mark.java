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
 * 毕业论文分数，由指导成绩、评阅成绩和答辩成绩组成
 *  @author AllenLi
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "mark")
public class Mark extends ActivitiBaseEntity{
	
	/** 指导成绩*/
	private Integer tutorGrade;
	
	/** 评阅成绩*/
	private Integer viewerGrade;
	
	/** 答辩成绩*/
	private Integer lectureGrade;
	
	/** 总成绩*/
	private Integer totalGrade;
	
	/** 关联学生*/
	private Student student;
	
	/** 关联导师*/	
	private Teacher tutor;
	
	/** 关联评阅老师*/	
	private Teacher viewer;
	
	/** 唯一标识*/
	private String uuid;
	
	/**计算总成绩*/
	public Integer calculate(){
		if(tutorGrade!=null&&viewerGrade!=null&&lectureGrade!=null){
			this.totalGrade = (int) (tutorGrade*0.4 + viewerGrade*0.2 + lectureGrade*0.4);
		}
		return this.totalGrade;
	}
	
	@Column(name = "tutor_grade_",columnDefinition="int default 0")
	public Integer getTutorGrade() {
		return tutorGrade;
	}
	public void setTutorGrade(Integer tutorGrade) {
		this.tutorGrade = tutorGrade;
	}
	
	@Column(name = "viewer_grade_",columnDefinition="int default 0")
	public Integer getViewerGrade() {
		return viewerGrade;
	}
	public void setViewerGrade(Integer viewerGrade) {
		this.viewerGrade = viewerGrade;
	}
	
	@Column(name = "lecture_grade_",columnDefinition="int default 0")
	public Integer getLectureGrade() {
		return lectureGrade;
	}
	public void setLectureGrade(Integer lectureGrade) {
		this.lectureGrade = lectureGrade;
	}
	
	@Column(name = "total_grade_",columnDefinition="int default 0")
	public Integer getTotalGrade() {
		return totalGrade;
	}
	public void setTotalGrade(Integer totalGrade) {
		this.totalGrade = totalGrade;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public Student getStudent() {
		return student;
	}
	public void setStudent(Student student) {
		this.student = student;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	public Teacher getTutor() {
		return tutor;
	}
	public void setTutor(Teacher tutor) {
		this.tutor = tutor;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	public Teacher getViewer() {
		return viewer;
	}
	public void setViewer(Teacher viewer) {
		this.viewer = viewer;
	}
	
	@Column(name = "uuid_")
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	
}
