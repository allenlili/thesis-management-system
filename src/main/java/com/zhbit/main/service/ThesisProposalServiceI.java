package com.zhbit.main.service;

import java.util.List;

import com.zhbit.main.entity.ThesisProposal;
import com.zhbit.main.entity.Topic;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.User;

public interface ThesisProposalServiceI {
	public Student getStudent(String uuid);
	public ThesisProposal findMyThesisProposal(User currentUser);
	public Topic getTopic(Student student);
	public List<ThesisProposal> findStudentProposal(User user);
	public void saveModelForStudent(ThesisProposal model);
}
