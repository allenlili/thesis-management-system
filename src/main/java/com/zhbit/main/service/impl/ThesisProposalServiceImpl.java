package com.zhbit.main.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import com.zhbit.main.dao.ThesisProposalDao;
import com.zhbit.main.dao.TopicDao;
import com.zhbit.main.entity.ThesisProposal;
import com.zhbit.main.entity.Topic;
import com.zhbit.main.service.ThesisProposalServiceI;
import com.zhbit.security.dao.StudentDao;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@Service("thesisProposalService")
public class ThesisProposalServiceImpl implements ThesisProposalServiceI {

	private static Logger logger = Logger.getLogger(ThesisProposalServiceImpl.class);
	
	private TeacherDao teacherDao;
	@Resource
	public void setTeacherDao(TeacherDao teacherDao) {
		this.teacherDao = teacherDao;
	}
	
	private StudentDao studentDao;
	@Resource
	public void setStudentDao(StudentDao studentDao) {
		this.studentDao = studentDao;
	}
	
	private ThesisProposalDao thesisProposalDao;
	@Resource
	public void setThesisProposalDao(ThesisProposalDao thesisProposalDao) {
		this.thesisProposalDao = thesisProposalDao;
	}
	
	private TopicDao topicDao;
	@Resource
	public void setTopicDao(TopicDao topicDao) {
		this.topicDao = topicDao;
	}
	
	@Override
	public Student getStudent(String uuid) {
		Student student = (Student) studentDao.findByUuid(Student.class, uuid);
		return student;
	}
	
	@Override
	public Topic getTopic(Student student){
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Topic.class);
		detachedCriteria.createAlias("student", "s");
		detachedCriteria.add(Restrictions.eq("s.id", student.getId()));
		List<Topic> topics = topicDao.find(detachedCriteria);
		return topics.isEmpty()?null:topics.get(0);
	}

	@Override
	public ThesisProposal findMyThesisProposal(User currentUser) {
		logger.info("findMyThesisProposal(User currentUser)");
		Student student = (Student) studentDao.findByUuid(Student.class, currentUser.getUuid());
		return student.getThesisProposal();
//		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(ThesisProposal.class);
//		detachedCriteria.createAlias("student", "s").add(Restrictions.eq("s.id", student.getId()));
//		List<ThesisProposal> thesisProposals = thesisProposalDao.find(detachedCriteria);
//		return thesisProposals.isEmpty()?null:thesisProposals.get(0);
	}

	@Override
	public List<ThesisProposal> findStudentProposal(User user) {
		Teacher teacher = (Teacher) teacherDao.findByUuid(Teacher.class, user.getUuid());
		Set<Student> students = teacher.getStudents();
		List<ThesisProposal> thesisProposals = new ArrayList<ThesisProposal>();
		ThesisProposal thesisProposal = null;
		for (Student student : students) {
			thesisProposal = student.getThesisProposal();
			if(thesisProposal!=null){
				thesisProposals.add(thesisProposal);
			}			
		}
		return thesisProposals;
	}

	@Override
	public void saveModelForStudent(ThesisProposal model) {
		Student student = model.getStudent();
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(ThesisProposal.class);
		detachedCriteria.createAlias("student", "s").add(Restrictions.eq("s.id",student.getId()));
		List<ThesisProposal> thesisProposals = (List<ThesisProposal>) thesisProposalDao.find(detachedCriteria);
		if(!thesisProposals.isEmpty()){
			student.setThesisProposal(thesisProposals.get(0));
			studentDao.save(student);
		}
	}
	
}
