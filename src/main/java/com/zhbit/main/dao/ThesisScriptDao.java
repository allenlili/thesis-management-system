package com.zhbit.main.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import com.zhbit.core.dao.GenericDao;
import com.zhbit.main.entity.ThesisScript;

@Repository
public class ThesisScriptDao extends GenericDao<ThesisScript> {
	@SuppressWarnings("unchecked")
	public List<ThesisScript> find(DetachedCriteria criteria){
		List<ThesisScript> topics = super.find(criteria);
		return topics;
	}
}
