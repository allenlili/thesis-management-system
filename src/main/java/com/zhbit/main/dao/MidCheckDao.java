package com.zhbit.main.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import com.zhbit.core.dao.GenericDao;
import com.zhbit.main.entity.MidCheck;

@Repository
public class MidCheckDao extends GenericDao<MidCheck> {
	@SuppressWarnings("unchecked")
	public List<MidCheck> find(DetachedCriteria criteria){
		List<MidCheck> topics = super.find(criteria);
		return topics;
	}
}
