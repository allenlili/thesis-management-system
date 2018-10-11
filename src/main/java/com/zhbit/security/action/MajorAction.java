package com.zhbit.security.action;

import javax.annotation.Resource;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.zhbit.core.action.BaseAction;
import com.zhbit.core.dao.GenericDao;
import com.zhbit.security.dao.MajorDao;
import com.zhbit.security.entity.Major;

@SuppressWarnings("serial")
@Controller("majorAction")
@Scope("prototype")
public class MajorAction extends BaseAction<Major> {
	
	private MajorDao majorDao;

	@Resource
	public void setMajorDao(MajorDao majorDao) {
		this.majorDao = majorDao;
	}

	@Override
	public GenericDao<Major> getDao() {
		return majorDao;
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getMajorName() && !"".equals(model.getMajorName().trim())) {
			criteria.add(Restrictions.like("majorName", model.getMajorName(), MatchMode.ANYWHERE));
		}
	}
}
