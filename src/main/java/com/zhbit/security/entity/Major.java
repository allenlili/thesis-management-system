package com.zhbit.security.entity;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

@SuppressWarnings("serial")
@Entity
@Table(name = "major")
public class Major implements Serializable {
	
	private Long id;
	private String majorName;
	private Set<Teacher> teachers;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_")
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	@Column(name = "major_name_",unique = true,length = 40)
	public String getMajorName() {
		return majorName;
	}
	
	public void setMajorName(String majorName) {
		this.majorName = majorName;
	}
	
	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "majors")
	@OrderBy(value = "id ASC")
	public Set<Teacher> getTeachers() {
		return teachers;
	}
	public void setTeachers(Set<Teacher> teachers) {
		this.teachers = teachers;
	}
	
}
