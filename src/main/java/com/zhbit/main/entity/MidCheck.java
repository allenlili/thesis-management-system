package com.zhbit.main.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import com.zhbit.core.entity.ActivitiBaseEntity;
import com.zhbit.security.entity.Teacher;


/**
 * 中期检查表 
 *  @author AllenLi
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "midCheck")
public class MidCheck extends ActivitiBaseEntity implements Serializable{
	
	/**第一栏内容*/
	private String firstContent;
	
	/**第二栏内容*/
	private String secondContent;
	
	/**第三栏内容*/
	private String thirdContent;
	
	/**关联老师*/
	private Teacher teacher;
	
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
	
	@Column(name = "third_content_",columnDefinition="text")
	public String getThirdContent() {
		return thirdContent;
	}
	public void setThirdContent(String thirdContent) {
		this.thirdContent = thirdContent;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public Teacher getTeacher() {
		return teacher;
	}
	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}
}
