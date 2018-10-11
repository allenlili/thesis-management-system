package com.zhbit.security.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;


import com.zhbit.main.entity.Mark;
import com.zhbit.main.entity.TaskBook;
import com.zhbit.main.entity.ThesisProposal;
import com.zhbit.main.entity.ThesisScript;
import com.zhbit.main.entity.Topic;
import com.zhbit.main.entity.TutorAdvice;
import com.zhbit.main.entity.ViewerAdvice;


@SuppressWarnings("serial")
@Entity
@Table(name = "student",uniqueConstraints={@UniqueConstraint(columnNames={"stu_uuid_","student_id_"})})
public class Student implements java.io.Serializable {
	/***/
	private Long id;
	
	private String uuid;
	
	private String studentId;
	
	private String name;
	
	private String sex;
	
	/**哪一届*/
	private String whichGrade;
	
	private String whichclass;
	
	/**成绩*/
	private String gpa;
	
	private String telephone;
	
	private String qq;
	
	private String studentNote;
	
	private User user;
	
	private Institute institute;
	
	private Major major;
	
	private Teacher teacher;
	
	private Topic topic;
	
	private TaskBook taskBook;
	
	private ThesisProposal thesisProposal;
	
	private Set<ThesisScript> thesisScripts = new HashSet<ThesisScript>();
	
	private Mark mark;
	
	private TutorAdvice tutorAdvice;
	
	private ViewerAdvice viewerAdvice;
	
	private ThesisScript lastThesisScript;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_")
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	@Column(name = "stu_uuid_",unique = true,length = 36)
	public String getUuid() {
		return uuid;
	}
	
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	
	@Column(name = "student_id_",unique = true,length = 12)
	public String getStudentId() {
		return studentId;
	}
	
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	
	@Column(name = "name_")
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	@Column(name = "sex_",length = 1)
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	
	@Column(name = "class_")
	public String getWhichclass() {
		return whichclass;
	}
	
	public void setWhichclass(String whichclass) {
		this.whichclass = whichclass;
	}
	
	@Column(name = "tel_")
	public String getTelephone() {
		return telephone;
	}
	
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	
	@Column(name = "qq_")
	public String getQq() {
		return qq;
	}
	
	public void setQq(String qq) {
		this.qq = qq;
	}
	
	@Column(name = "student_note_")
	public String getStudentNote() {
		return studentNote;
	}
	
	public void setStudentNote(String studentNote) {
		this.studentNote = studentNote;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public Institute getInstitute() {
		return institute;
	}
	
	public void setInstitute(Institute institute) {
		this.institute = institute;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public Major getMajor() {
		return major;
	}
	
	public void setMajor(Major major) {
		this.major = major;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public Teacher getTeacher() {
		return teacher;
	}
	
	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public Topic getTopic() {
		return topic;
	}
	
	public void setTopic(Topic topic) {
		this.topic = topic;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public TaskBook getTaskBook() {
		return taskBook;
	}
	
	public void setTaskBook(TaskBook taskBook) {
		this.taskBook = taskBook;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public ThesisProposal getThesisProposal() {
		return thesisProposal;
	}
	
	public void setThesisProposal(ThesisProposal thesisProposal) {
		this.thesisProposal = thesisProposal;
	}
	
	@OneToMany(fetch = FetchType.LAZY, cascade = {CascadeType.REMOVE,CascadeType.REFRESH})
	@OrderBy(value = "id ASC")
	public Set<ThesisScript> getThesisScripts() {
		return thesisScripts;
	}
	
	public void setThesisScripts(Set<ThesisScript> thesisScripts) {
		this.thesisScripts = thesisScripts;
	}
	
	@Column(name = "which_grade_")
	public String getWhichGrade() {
		return whichGrade;
	}
	
	public void setWhichGrade(String whichGrade) {
		this.whichGrade = whichGrade;
	}
	
	@Column(name = "gpa_")
	public String getGpa() {
		return gpa;
	}
	
	public void setGpa(String gpa) {
		this.gpa = gpa;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public Mark getMark() {
		return mark;
	}
	
	public void setMark(Mark mark) {
		this.mark = mark;
	}

	@OneToOne(fetch = FetchType.LAZY)
	public TutorAdvice getTutorAdvice() {
		return tutorAdvice;
	}
	
	public void setTutorAdvice(TutorAdvice tutorAdvice) {
		this.tutorAdvice = tutorAdvice;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public ViewerAdvice getViewerAdvice() {
		return viewerAdvice;
	}
	
	public void setViewerAdvice(ViewerAdvice viewerAdvice) {
		this.viewerAdvice = viewerAdvice;
	}

	@OneToOne(fetch = FetchType.LAZY)
	public ThesisScript getLastThesisScript() {
		return lastThesisScript;
	}

	public void setLastThesisScript(ThesisScript lastThesisScript) {
		this.lastThesisScript = lastThesisScript;
	}
	
}
