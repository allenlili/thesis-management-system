package com.zhbit.security.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;


@Entity
@Table(name = "resource")
public class Resource implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1175741324536566394L;
	
	private Long id;
	private String url;
	
	private Set<Role> roles = new HashSet<Role>();
	
	@Id
	@GeneratedValue
	@Column(name = "id_")
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "url_")
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "resources")
	@OrderBy(value = "id ASC")
	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
	
}
