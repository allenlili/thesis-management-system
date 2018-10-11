package com.zhbit.main.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.zhbit.core.entity.ActivitiBaseEntity;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;


/**
 * 论文稿件，由学生上交
 * @author AllenLi
 *
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "thesisScript")
public class ThesisScript extends ActivitiBaseEntity{
	
	/**稿件名称*/
	private String fileName;
	
	/**稿件路径*/
	private String path;
	
	/**问题*/
	private String question;
	
	/**回答*/
	private String answer;
	
	/**唯一标识*/
	private String uuid;
	
	/**是否终稿的标识,0代表普通稿，1代表终稿*/
	private Integer lastScript;
	
	/**关联学生*/
	private Student student;
	
	/**关联题目*/
	private Topic topic;
	
	/**指导老师*/
	private Teacher teacher;
	
	/**只有终稿才需要关联评阅老师，评阅老师*/
	private Teacher viewer;
	
	@Column(name = "file_name_")
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	@Column(name = "path_")
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public Student getStudent() {
		return student;
	}
	public void setStudent(Student student) {
		this.student = student;
	}
	
	@Column(name = "last_script")
	public Integer getLastScript() {
		return lastScript;
	}
	public void setLastScript(Integer lastScript) {
		this.lastScript = lastScript;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	public Topic getTopic() {
		return topic;
	}
	public void setTopic(Topic topic) {
		this.topic = topic;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	public Teacher getTeacher() {
		return teacher;
	}
	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	public Teacher getViewer() {
		return viewer;
	}
	public void setViewer(Teacher viewer) {
		this.viewer = viewer;
	}
	
	@Column(name = "question_")
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	
	@Column(name = "answer_")
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	
	@Column(name = "uuid_")
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
}
