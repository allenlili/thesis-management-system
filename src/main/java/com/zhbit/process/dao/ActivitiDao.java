package com.zhbit.process.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.activiti.engine.task.Task;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.zhbit.core.entity.ActivitiBaseEntity;
import com.zhbit.core.utils.Constant.SystemConstant;
import com.zhbit.core.utils.Core.BeanUtil;
import com.zhbit.core.utils.EnumStatus.RoleEnum;
import com.zhbit.core.utils.EnumStatus.ProcessVariableEnum;
import com.zhbit.core.utils.EnumStatus.StatusEnum;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@Repository
@SuppressWarnings("unchecked")
public class ActivitiDao {
	
	private static Logger logger = Logger.getLogger(ActivitiDao.class);
	
	private SessionFactory sessionFactory;
	private RuntimeService runtimeService;
	private HistoryService historyService;
	private TaskService taskService;
	@Resource
	public void setRuntimeService(RuntimeService runtimeService) {
		this.runtimeService = runtimeService;
	}
	@Resource
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	@Resource
	public void setTaskService(TaskService taskService) {
		this.taskService = taskService;
	}
	@Resource
	public void setHistoryService(HistoryService historyService) {
		this.historyService = historyService;
	}
	
	/**
	 * 启动流程
	 * @param entity
	 * @param definitionKey
	 */
	public void doStart(ActivitiBaseEntity entity, String definitionKey) {
		logger.info("doStart(ActivitiBaseEntity entity, String definitionKey)");
		entity.setStatus(StatusEnum.start.getValue());
		sessionFactory.getCurrentSession().save(entity);
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put(ProcessVariableEnum.model.toString(), entity);
		ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(definitionKey, entity.getId().toString(), variables);
		Task task = taskService.createTaskQuery().processInstanceId(processInstance.getId()).singleResult();
		taskService.complete(task.getId());
	}
	
	/**
	 * 查询当前用户的工作小组人员/用户为老师用户
	 * @param user
	 * @return
	 */
	public List<User> findWorkgroupForUserByTeacherUser(User user) {
		DetachedCriteria detachedCriteria = null;
		detachedCriteria = DetachedCriteria.forClass(Teacher.class);
		detachedCriteria.add(Restrictions.eq("uuid", user.getUuid()));
		Teacher teacher = (Teacher) detachedCriteria.getExecutableCriteria(sessionFactory.getCurrentSession()).uniqueResult();		
		
		Criteria criteria = null;
		criteria  = sessionFactory.getCurrentSession().createCriteria(Teacher.class)
		.createAlias("institute", "i")
		.createAlias("majors", "ms")
		.add(Restrictions.eq("i.instituteName", teacher.getInstitute().getInstituteName()))
		.add(Restrictions.eq("ms.majorName", teacher.getMajors().iterator().next().getMajorName()))
		.createAlias("user", "u")
		.createAlias("u.roles", "u_rs")
		.add(Restrictions.eq("u_rs.roleName", RoleEnum.workgroup.getValue()));
		List<Teacher> teachers = criteria.list();
		List<User> users = new ArrayList<User>();
		for (Teacher t : teachers) {
			users.add(t.getUser());
		}
		return users;
	}
	
	/**
	 * 查询当前用户的工作小组人员/用户为老师用户
	 * @param user
	 * @return
	 */	
	public List<User> findWorkgroupForUserByStudentUser(User requestUser) {
		DetachedCriteria detachedCriteria = null;
		detachedCriteria = DetachedCriteria.forClass(Student.class);
		detachedCriteria.add(Restrictions.eq("uuid", requestUser.getUuid()));
		Student student = (Student) detachedCriteria.getExecutableCriteria(sessionFactory.getCurrentSession()).uniqueResult();
		Teacher teacher = student.getTeacher();
		
		Criteria criteria = null;
		criteria  = sessionFactory.getCurrentSession().createCriteria(Teacher.class)
		.createAlias("institute", "i")
		.createAlias("majors", "ms")
		.add(Restrictions.eq("i.instituteName", teacher.getInstitute().getInstituteName()))
		.add(Restrictions.eq("ms.majorName", teacher.getMajors().iterator().next().getMajorName()))
		.createAlias("user", "u")
		.createAlias("u.roles", "u_rs")
		.add(Restrictions.eq("u_rs.roleName", RoleEnum.workgroup.getValue()));
		List<Teacher> teachers = criteria.list();
		List<User> users = new ArrayList<User>();
		for (Teacher t : teachers) {
			users.add(t.getUser());
		}		
		return users;
	}	
	
	/**
	 * 查询当前用户的领导小组人员
	 * @param user
	 * @return
	 */
	public List<User> findLeadergroupForUser(User user) {
		DetachedCriteria detachedCriteria = null;
		detachedCriteria = DetachedCriteria.forClass(Teacher.class);
		detachedCriteria.add(Restrictions.eq("uuid", user.getUuid()));
		Teacher teacher = (Teacher) detachedCriteria.getExecutableCriteria(sessionFactory.getCurrentSession()).uniqueResult();		
		
		Criteria criteria = null;
		criteria  = sessionFactory.getCurrentSession().createCriteria(Teacher.class)
		.createAlias("institute", "i")
		.createAlias("majors", "ms")
		.add(Restrictions.eq("i.instituteName", teacher.getInstitute().getInstituteName()))
		.add(Restrictions.eq("ms.majorName", teacher.getMajors().iterator().next().getMajorName()))
		.createAlias("user", "u")
		.createAlias("u.roles", "u_rs")
		.add(Restrictions.eq("u_rs.roleName", RoleEnum.leadergroup.getValue()));
		List<Teacher> teachers = criteria.list();
		List<User> users = new ArrayList<User>();
		for (Teacher t : teachers) {
			users.add(t.getUser());
		}
		return users;
	}	
	
	/**
	 * 查找我的指导老师
	 * @param requestUser
	 * @return
	 */
	public User findTutorForUser(User requestUser) {
		DetachedCriteria detachedCriteria = null;
		detachedCriteria = DetachedCriteria.forClass(Student.class);
		detachedCriteria.add(Restrictions.eq("uuid", requestUser.getUuid()));
		Student student = (Student) detachedCriteria.getExecutableCriteria(sessionFactory.getCurrentSession()).uniqueResult();		 
		Teacher teacher = student.getTeacher();
		return teacher.getUser();
	}
		
	/**
	 * 执行任务
	 * @param transition ：seqenceFlow的名字,用于驳回
	 * @param task       ：任务
	 * @param model      : 业务数据
	 * @param currentUser：申请人
	 * @param comment：审批意见
	 */
	public void doTask(String transition, Task task, Object model, User currentUser, String comment) {
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put(ProcessVariableEnum.transition.toString(), transition);
		if (SystemConstant.REQUEST_TASK.equals(task.getName())||SystemConstant.THESIS_SCRIPT_TUTOR_TASK.equals(task.getName())) {
			ActivitiBaseEntity m = (ActivitiBaseEntity) model;
			ActivitiBaseEntity entity = (ActivitiBaseEntity) sessionFactory.getCurrentSession().get(model.getClass(), m.getId());
			BeanUtil.copy(model, entity);
			sessionFactory.getCurrentSession().save(entity);
			variables.put(ProcessVariableEnum.model.toString(), entity);
		}
		if (null != comment && !"".equals(comment.trim())) {
			taskService.addComment(task.getId(), task.getProcessInstanceId(), currentUser.getUserName()+"/"+currentUser.getRealName(), comment);
		}
		taskService.claim(task.getId(), currentUser.getUserName());
		taskService.complete(task.getId(), variables);
	}
	
	/**
	 * 查询流程实例的审批意见
	 * @param processInstance
	 * @return
	 */
	public List<Map<String, Object>> getComments(String processInstanceId) {
		List<Comment> comments = taskService.getProcessInstanceComments(processInstanceId);
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = null;
		for (Comment comment : comments) {
			map = new HashMap<String, Object>();
			HistoricTaskInstance historicTaskInstance = historyService.createHistoricTaskInstanceQuery().taskId(comment.getTaskId()).singleResult();
			String commentOwner = historicTaskInstance.getName() + "(" + comment.getType() + ")";
			map.put("commentOwner", commentOwner);
			map.put("comment", comment.getFullMessage());
			map.put("commentDate", comment.getTime());
			list.add(map);
		}		
		return list;
	}
}
