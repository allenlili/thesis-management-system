package com.zhbit.core.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MappedSuperclass;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.zhbit.security.entity.User;

/**
 * MappedSuperclass：注解可以被继承
 */
@SuppressWarnings("serial")
@MappedSuperclass
public class ActivitiBaseEntity implements Serializable {
	/**对象id*/
	private Long id;
	
	/**发起者*/
	private User user;
	
	/**开始时间或者确认时间*/
    private Date startDate;
    
    /**结束时间，作为查询使用，不作持久化*/
    private Date endDate;
    
	/**查询条件，如果不为空，查询所有用户*/
	private String queryByAllUser;
	
	/**对象状态*/
	private Integer status;	
	
	@Id
	@GeneratedValue
	@Column(name = "id_")
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	@Column(name = "status_")
	public Integer getStatus() {
		return status;
	}
	
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id_")
	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}
	
	@Transient
	public String getQueryByAllUser() {
		return queryByAllUser;
	}
	
	public void setQueryByAllUser(String queryByAllUser) {
		this.queryByAllUser = queryByAllUser;
	}
	
	@Temporal(TemporalType.DATE)
	@Column(name = "start_date_")
	public Date getStartDate() {
		return startDate;
	}
	
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	@Transient
	public Date getEndDate() {
		return endDate;
	}
	
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
}
