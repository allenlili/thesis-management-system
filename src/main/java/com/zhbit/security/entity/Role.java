package com.zhbit.security.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

@Entity
@Table(name = "role")
public class Role implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1175741324536566394L;
	
	private Long id;
	private String roleName;
	
	private Set<User> users = new HashSet<User>();
	private Set<Resource> resources = new HashSet<Resource>();
	
	@Id
	@GeneratedValue
	@Column(name = "id_")
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	@Column(name = "role_name_")
	public String getRoleName() {
		return roleName;
	}
	
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	/**
	 * JoinTable标签：配置关系表
	 * 		name: 关系表的名字
	 * 	 	joinColumns:当前表在关系表中的外键
	 * 		inverseJoinColumns:	对方在关系表中的外键
	 * @return
	 */
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "role_user", joinColumns = {@JoinColumn(name = "role_id_")}, inverseJoinColumns = {@JoinColumn(name = "user_id_")} ) 
	@OrderBy(value = "id ASC")
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "role_resource", joinColumns = {@JoinColumn(name = "role_id_")}, inverseJoinColumns = {@JoinColumn(name = "resource_id_")} ) 
	@OrderBy(value = "id ASC")
	public Set<Resource> getResources() {
		return resources;
	}

	public void setResources(Set<Resource> resources) {
		this.resources = resources;
	}
	
}
