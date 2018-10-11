package com.zhbit.security.action;

import javax.annotation.Resource;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.zhbit.core.action.BaseAction;
import com.zhbit.core.dao.GenericDao;
import com.zhbit.security.dao.InstituteDao;
import com.zhbit.security.entity.Institute;

@Controller("instituteAction")
@Scope("prototype")
public class InstituteAction extends BaseAction<Institute> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private InstituteDao instituteDao;
	
	@Resource
	public void setInstituteDao(InstituteDao instituteDao) {
		this.instituteDao = instituteDao;
	}

	@Override
	public GenericDao<Institute> getDao() {
		return instituteDao;
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getInstituteName() && !"".equals(model.getInstituteName())) {
			criteria.add(Restrictions.like("instituteName", model.getInstituteName(),
					MatchMode.ANYWHERE));
		}
	}
	
}
