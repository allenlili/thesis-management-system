package com.zhbit.main.service;

import java.util.List;

import com.zhbit.main.entity.Topic;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

public interface TopicServiceI {
	public boolean verifyTopicIfSame(String topicName);
	public Student getStudent(String uuid);
	public Teacher getTeacher(User user);
	public Topic findMyTopic(User currentUser);
	public List<Topic> findSelectableTopics(User currentUser);
	public boolean doConfirmMyTopic(User currentUser, Long id);
	public boolean findEqual(String topicName);
}
