package com.zhbit.main.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import com.zhbit.core.dao.GenericDao;
import com.zhbit.main.entity.Topic;

@Repository
public class TopicDao extends GenericDao<Topic> {
	@SuppressWarnings("unchecked")
	public List<Topic> find(DetachedCriteria criteria){
		List<Topic> topics = super.find(criteria);
		return topics;
	}
}
