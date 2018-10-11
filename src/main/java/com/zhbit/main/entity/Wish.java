package com.zhbit.main.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * 一条志愿信息包含 3个志愿,分梯度,没有使用模型驱动
 * @author AllenLi
 *
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "wish")
public class Wish implements Serializable{
	
	/**自增id*/
	private Long id;
	
	/**唯一标识符，来自于用户，与学生绑定*/
	private String uuid;
	
	/**第一志愿老师的唯一标识符*/
	private String firstTeacherUuid;
	
	/**第二志愿老师的唯一标识符*/
	private String secondTeacherUuid;
	
	/**第三志愿老师的唯一标识符*/
	private String thirdTeacherUuid;
	
	/**在第一志愿被选择，则结果产生于此字段*/
	private String firstResultUuid;
	
	/**在第二志愿被选择，则结果产生于此字段*/
	private String secondResultUuid;
	
	/**在第三志愿被选择，则结果产生于此字段*/
	private String thirdResultUuid;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_")
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	@Column(name = "student_uuid_",unique = true,length = 36)
	public String getUuid() {
		return uuid;
	}
	
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	
	@Column(name = "first_teacher_uuid_",length = 36)
	public String getFirstTeacherUuid() {
		return firstTeacherUuid;
	}
	
	public void setFirstTeacherUuid(String firstTeacherUuid) {
		this.firstTeacherUuid = firstTeacherUuid;
	}
	
	@Column(name = "second_teacher_uuid_",length = 36)
	public String getSecondTeacherUuid() {
		return secondTeacherUuid;
	}
	
	public void setSecondTeacherUuid(String secondTeacherUuid) {
		this.secondTeacherUuid = secondTeacherUuid;
	}
	
	@Column(name = "third_teacher_uuid_",length = 36)
	public String getThirdTeacherUuid() {
		return thirdTeacherUuid;
	}
	
	public void setThirdTeacherUuid(String thirdTeacherUuid) {
		this.thirdTeacherUuid = thirdTeacherUuid;
	}
	
	@Column(name = "first_result_uuid_",length = 36)
	public String getFirstResultUuid() {
		return firstResultUuid;
	}
	
	public void setFirstResultUuid(String firstResultUuid) {
		this.firstResultUuid = firstResultUuid;
	}
	
	@Column(name = "second_result_uuid_",length = 36)
	public String getSecondResultUuid() {
		return secondResultUuid;
	}
	
	public void setSecondResultUuid(String secondResultUuid) {
		this.secondResultUuid = secondResultUuid;
	}
	
	@Column(name = "third_result_uuid_",length = 36)
	public String getThirdResultUuid() {
		return thirdResultUuid;
	}
	
	public void setThirdResultUuid(String thirdResultUuid) {
		this.thirdResultUuid = thirdResultUuid;
	}

}
