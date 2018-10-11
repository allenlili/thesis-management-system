package com.zhbit.main.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import com.zhbit.core.dao.GenericDao;
import com.zhbit.main.entity.TaskBook;

@Repository
public class TaskBookDao extends GenericDao<TaskBook> {
	@SuppressWarnings("unchecked")
	public List<TaskBook> find(DetachedCriteria criteria){
		List<TaskBook> topics = super.find(criteria);
		return topics;
	}
}
