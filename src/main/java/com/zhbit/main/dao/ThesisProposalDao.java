package com.zhbit.main.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import com.zhbit.core.dao.GenericDao;
import com.zhbit.main.entity.ThesisProposal;

@Repository
public class ThesisProposalDao extends GenericDao<ThesisProposal> {
	@SuppressWarnings("unchecked")
	public List<ThesisProposal> find(DetachedCriteria criteria){
		List<ThesisProposal> topics = super.find(criteria);
		return topics;
	}
}
