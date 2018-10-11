package com.zhbit.core.dao;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import com.zhbit.core.utils.Page.PageResult;
import com.zhbit.security.entity.Institute;
import com.zhbit.security.entity.Major;
import com.zhbit.security.entity.Teacher;

@SuppressWarnings("unchecked")
public class BaseDao {
	protected SessionFactory sessionFactory;
	@Resource
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	/**
	 * 添加修改
	 * 为方法声明泛型 
	 *    比如下面的声明public <T> void save(T obj) 表示add方法操作的对象类型是T
	 *    T类型到底是什么类型对象，是由方法调用的时候决定
	 *    dao.add(Dept) T类型Dept
	 *    dao.add(User) T类型User
	 * @param obj 添加的对象
	 */
	public <T> void save(T obj) {
		sessionFactory.getCurrentSession().saveOrUpdate(obj);
	}
	
	/**
	 * 添加方法
	 * @param obj
	 */
	public <T> void add(T obj) {
		sessionFactory.getCurrentSession().save(obj);
	}
	/**
	 * 修改方法
	 * @param obj
	 */
	public <T> void update(T obj) {
		sessionFactory.getCurrentSession().update(obj);
	}
	/**
	 * 删除方法
	 * @param obj
	 */
	public <T> void delete(T obj) {
		sessionFactory.getCurrentSession().delete(obj);
	}
	/**
	 * 加载方法
	 * @param clz
	 * @param id
	 * @return
	 */
	public <T> T get(Class<T> clz, Serializable id) {
		return (T) sessionFactory.getCurrentSession().get(clz, id);
	}
	
	/**
	 * 标准查询
	 * @param criteria
	 */
	public <T> List<T> find(DetachedCriteria criteria) {
		Criteria c = criteria.getExecutableCriteria(sessionFactory.getCurrentSession());
		return c.list();
	}
	
	/**
	 * 分页查询
	 * @param dept 封装了查询条件的对象
	 * @param start 起始的下标
	 * @param pageSize 每页行数
	 * @return pageResult 里面有一页数据，和总行数
	 */
	public PageResult find(DetachedCriteria criteria, int start, int pageSize) {
		PageResult page = new PageResult();
		Criteria c = criteria.getExecutableCriteria(sessionFactory.getCurrentSession());
		//总行数
		long rowCount = (Long) c.setProjection(Projections.rowCount()).uniqueResult();
		page.setRowCount(rowCount);
		//一页数据
		c.setProjection(null);
		c.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);
		List<?> list =  c.setFirstResult(start).setMaxResults(pageSize).list();
		page.setResult(list);
		return page;
	}
	
	/**
	 * 找老师、学生、用户
	 * @param clz
	 * @param uuid
	 * @return
	 */
	public Object findByUuid(Class<?> clz,String uuid){
		DetachedCriteria criteria = DetachedCriteria.forClass(clz);
		criteria.add(Restrictions.eq("uuid", uuid));
		Object object = criteria.getExecutableCriteria(sessionFactory.getCurrentSession()).uniqueResult();		
		return object;
	}
	
	public List<?> findByInstituteAndMajor(Class<?> clz,Institute institute,Major major){
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(clz)
		.createAlias("institute", "i")
		.createAlias("majors", "ms")
		.add(Restrictions.eq("i.instituteName", institute.getInstituteName()))
		.add(Restrictions.eq("ms.majorName", major.getMajorName()));
		List<Teacher> list = criteria.list();
		return list;
	}
}
