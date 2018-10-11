package com.zhbit.main.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import com.zhbit.core.dao.GenericDao;
import com.zhbit.main.entity.Mark;

/**
 * 
 * @author AllenLi
 *
 */
@Repository
public class MarkDao extends GenericDao<Mark> {
	@SuppressWarnings("unchecked")
	public List<Mark> find(DetachedCriteria criteria){
		List<Mark> topics = super.find(criteria);
		return topics;
	}
}
