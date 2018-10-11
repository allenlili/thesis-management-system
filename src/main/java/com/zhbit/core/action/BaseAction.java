package com.zhbit.core.action;

import java.lang.reflect.Method;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;
import com.zhbit.core.dao.GenericDao;
import com.zhbit.core.utils.Core.BeanUtil;
import com.zhbit.core.utils.Core.GenericUtil;
import com.zhbit.core.utils.Page.PageAction;
import com.zhbit.core.utils.Page.PageResult;
import com.zhbit.security.action.UserAction;

@SuppressWarnings("serial")
public abstract class BaseAction<T> extends PageAction implements ModelDriven<T> {
	
	public static final String ID_GET_METHOD = "getId";
	
	private static Logger logger = Logger.getLogger(UserAction.class);
	
	protected T model;
	protected Class<T> modelClass;
	
	protected Long[] ids;
	
	public BaseAction() {
		this.modelClass = GenericUtil.getSuperGenericClass(this.getClass());
	}

	@Override
	public T getModel() {
		if (null == model) {
			try {
				model = (T) modelClass.newInstance();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return model;
	}
	
	/**
	 * 返回正在使用的Dao
	 * @return
	 */
	public abstract GenericDao<T> getDao();
	
	/**
	 * 模板方法：在跳到添加页面执行之前执行
	 */
	public void beforToAdd() {
		
	}
	
	/**
	 * 模板方法: 在加载前执行
	 */
	public void beforToUpdate() {
		
	}
	
	/**
	 * 模板方法：在加载之后执行
	 * @param entity
	 */
	public void afterToUpdate(T entity) {
		
	}
	
	/**
	 * 模板方法： 在添加或修改之前执行
	 * @param model
	 */
	public void beforeSave(T model) {
		
	}
	
	public void afterSave(T model){
		
	}
	
	/**
	 * 模板方法
	 * 在查询执行之前执行，一般用来组织查询条件
	 * 这个方法在子类重写之后，用来在子类组织查询条件
	 * @param criteria
	 */
	public void beforFind(DetachedCriteria criteria) {
		
	}
	
	
	/**
	 * 跳到添加页面
	 * @return
	 */
	public String toAdd() {
		beforToAdd();
		return ADD;
	}
	
	/**
	 * 删除前的操作
	 */
	public void beforeDelete(){
		
	}
	
	/**
	 * 加载
	 * @return
	 */
	public String toUpdate() throws Exception {
		logger.info("toUpdate()");
		Method idGetter = BeanUtil.getMethod(modelClass, ID_GET_METHOD);
		Long id = (Long) idGetter.invoke(model);
		beforToUpdate();
		T entity = getDao().get(id);
		afterToUpdate(entity);
		ActionContext.getContext().getValueStack().push(entity);
		return UPDATE;
	}	
	
	/**
	 * 增加
	 */
	public String save() throws Exception {
		beforeSave(model);
		//得到主键的值
		Long id = (Long) BeanUtil.getMethod(modelClass, ID_GET_METHOD).invoke(model);
		
		T entity = null;
		if (null == id) {
			entity = modelClass.newInstance();
		} else {
			entity = getDao().get(id);
		}
		BeanUtil.copy(model, entity);
		
		getDao().save(entity);
		
		afterSave(entity);
		
		return LIST_ACTION; 
	}
	
	/**
	 * 更新
	 */
	public String update() throws Exception {
		//得到主键的值
		Long id = (Long) BeanUtil.getMethod(modelClass, ID_GET_METHOD).invoke(model);
		
		T entity = null;
		if (null == id) {
			entity = modelClass.newInstance();
		} else {
			entity = getDao().get(id);
		}
		BeanUtil.copy(model, entity);
		
		getDao().save(entity);
		return LIST_ACTION; 
	}	
	
	/**
	 * 删除
	 */
	public String delete() {
		beforeDelete();
		for (Long id : ids) {
			T entity = getDao().get(id);
			getDao().delete(entity);
		}
		return LIST_ACTION; 
	}
	
	/**
	 * 分页查询
	 * @return
	 */
	public String findPage() {
		DetachedCriteria criteria = DetachedCriteria.forClass(modelClass);
		
		beforFind(criteria);
		PageResult page = getDao().find(criteria, start, pageSize);
		
		ActionContext.getContext().put(PAGE, page);
		return LIST;
	}
	
	/**
	 * 标准查询
	 * @return
	 */
	public String find() {
		DetachedCriteria criteria = DetachedCriteria.forClass(modelClass);
		
		beforFind(criteria);
		List<T> list = getDao().find(criteria);
		
		ActionContext.getContext().put(LIST, list);
		return LIST;
	}
	
	public void setIds(Long[] ids) {
		this.ids = ids;
	}

}
