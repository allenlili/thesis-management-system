package com.zhbit.main.service.impl;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import com.zhbit.core.utils.EnumStatus.StatusEnum;
import com.zhbit.main.dao.TaskBookDao;
import com.zhbit.main.dao.TopicDao;
import com.zhbit.main.entity.TaskBook;
import com.zhbit.main.entity.Topic;
import com.zhbit.main.service.TopicServiceI;
import com.zhbit.security.dao.StudentDao;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@Service("topicService")
public class TopicServiceImpl implements TopicServiceI {

	private static Logger logger = Logger.getLogger(TopicServiceImpl.class);
	
	private TeacherDao teacherDao;
	@Resource
	public void setTeacherDao(TeacherDao teacherDao) {
		this.teacherDao = teacherDao;
	}
	
	private TaskBookDao taskBookDao;
	@Resource
	public void setTaskBookDao(TaskBookDao taskBookDao) {
		this.taskBookDao = taskBookDao;
	}
	
	private StudentDao studentDao;
	@Resource
	public void setStudentDao(StudentDao studentDao) {
		this.studentDao = studentDao;
	}
	
	private TopicDao topicDao;
	@Resource
	public void setTopicDao(TopicDao topicDao) {
		this.topicDao = topicDao;
	}
	

	/**
	 * 验证题目是否有重复，若有重复提示不能重复
	 * @param topicName
	 * @return
	 */
	public boolean verifyTopicIfSame(String topicName){
		logger.info("verifyTopicIfSame(String topicName)");
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Topic.class);
		detachedCriteria.add(Restrictions.eq("topicName", topicName));
		List<Topic> topics = topicDao.find(detachedCriteria);
		if(topics.isEmpty()){
			return false;
		}
		return true;
	}

	@Override
	public Student getStudent(String uuid) {
		Student student = (Student) studentDao.findByUuid(Student.class, uuid);
		return student;
	}

	@Override
	public Teacher getTeacher(User user) {
		Teacher teacher = (Teacher) teacherDao.findByUuid(Teacher.class, user.getUuid());
		return teacher;
	}

	@Override
	public Topic findMyTopic(User currentUser) {
		Topic topic = null;
		Student student = (Student) studentDao.findByUuid(Student.class, currentUser.getUuid());
		topic = student.getTopic();
		if(topic != null){
			return topic;
		}
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Topic.class);
		detachedCriteria.createAlias("student", "s").add(Restrictions.eq("s.id", student.getId()));
		List<Topic> topics = topicDao.find(detachedCriteria);
		if(topic == null && !topics.isEmpty()){
			topic = topics.get(0);
			student.setTopic(topic);
			studentDao.save(student);
			return topic;
		}
		return null;
	}

	@Override
	public List<Topic> findSelectableTopics(User currentUser) {
	    Student student = (Student) studentDao.findByUuid(Student.class, currentUser.getUuid());
	    Teacher teacher = student.getTeacher();
		DetachedCriteria criteria = DetachedCriteria.forClass(Topic.class);
		List<Topic> topics = null;
		if(teacher!=null){
			criteria.add(Restrictions.eq("status", StatusEnum.success.getValue()));
			criteria.createAlias("teacher", "t").add(Restrictions.eq("t.id", teacher.getId()));
			topics = topicDao.find(criteria);
			return topics;
		}
		return topics;
	}

	@Override
	public boolean doConfirmMyTopic(User currentUser,Long id) {
		Student student = (Student) studentDao.findByUuid(Student.class, currentUser.getUuid());
		Teacher teacher = student.getTeacher();
		User user = teacher.getUser();
		Topic topic = topicDao.get(Topic.class, id);
		topic.setStudent(student);
		topic.setStartDate(new Date());
		topic.setUuid(student.getUuid());
		topicDao.save(topic);
		student.setTopic(topic);
		studentDao.save(topic);
		TaskBook taskBook = doMakeTaskBook(student,teacher,topic,user);
		taskBookDao.save(taskBook);
		return true;
	}


	public TaskBook doMakeTaskBook(Student student,Teacher teacher,Topic topic,User user) {
		TaskBook taskBook = new TaskBook();
		taskBook.setStudent(student);
		taskBook.setTeacher(teacher);
		taskBook.setTopic(topic);
		taskBook.setStatus(StatusEnum.unstart.getValue());
		taskBook.setUser(user);
		taskBook.setStartDate(new Date());
		return taskBook;
	}


	@Override
	public boolean findEqual(String topicName) {
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Topic.class);
		detachedCriteria.add(Restrictions.eq("topicName", topicName));
		List<Topic> topics = topicDao.find(detachedCriteria);
		if(topics.isEmpty()){
			return false;
		}
		return true;
	}
	
}
