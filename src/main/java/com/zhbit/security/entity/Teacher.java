package com.zhbit.security.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.zhbit.main.entity.MidCheck;
import com.zhbit.main.entity.TutorAdvice;
import com.zhbit.main.entity.ViewerAdvice;


@SuppressWarnings("serial")
@Entity
@Table(name = "teacher")
public class Teacher implements java.io.Serializable {
	private Long id;
	private String uuid;
	private String teacherId;
	private String name;
	private String sex;
	private String level;
	private String teachNum;
	private Integer realTeachNum;
	private String teacherTel;
	private String teacherEmail;
	private String teacherNote;
	private User user;
	
	private Set<Major> majors = new HashSet<Major>();
	private Institute institute;
	
	private Set<Student> students = new HashSet<Student>();
	
	//详见ChooseStudentRunNumEnum.java
	private String chooseStudentRunNum;
	
	private MidCheck midCheck;
	
	//被我评阅的指导老师（可以评阅多为老师）
	private Set<Teacher> teachers = new HashSet<Teacher>();
	
	//我被评语的指导老师（只能有一位）
	private Teacher viewer;
	
	private Set<TutorAdvice> tutorAdvices = new HashSet<TutorAdvice>();
	
	private Set<ViewerAdvice> viewerAdvices = new HashSet<ViewerAdvice>();
	
	/**提交指导成绩状态，未提交为1，已提交为3*/
	private Integer forwardTutorGradeStatus;
	
	/**提交评阅成绩状态，未提交为1，已提交为3*/
	private Integer forwardViewerGradeStatus;
	
	/**提交答辩状态，未提交为1，已提交为3*/
	private Integer forwardLectureGradeStatus;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_")
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	@Column(name = "teacher_uuid_",unique = true,length = 36)
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	
	@Column(name = "teacher_id_",unique = true,length = 10)
	public String getTeacherId() {
		return teacherId;
	}
	public void setTeacherId(String teacherId) {
		this.teacherId = teacherId;
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
	
	@Column(name = "level_")
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	
	@Column(name = "teach_num_")
	public String getTeachNum() {
		return teachNum;
	}
	public void setTeachNum(String teachNum) {
		this.teachNum = teachNum;
	}
	
	@Column(name = "real_teach_num_",length = 1,columnDefinition="int default 0")
	public Integer getRealTeachNum() {
		return realTeachNum;
	}
	public void setRealTeachNum(Integer realTeachNum) {
		this.realTeachNum = realTeachNum;
	}
	
	@Column(name = "teacher_tel_")
	public String getTeacherTel() {
		return teacherTel;
	}
	public void setTeacherTel(String teacherTel) {
		this.teacherTel = teacherTel;
	}
	
	@Column(name = "teacher_email_")
	public String getTeacherEmail() {
		return teacherEmail;
	}
	public void setTeacherEmail(String teacherEmail) {
		this.teacherEmail = teacherEmail;
	}
	
	@Column(name = "teacher_note_")
	public String getTeacherNote() {
		return teacherNote;
	}
	public void setTeacherNote(String teacherNote) {
		this.teacherNote = teacherNote;
	}
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "teacher_major", joinColumns = {@JoinColumn(name = "teacher_id_")} , inverseJoinColumns = {@JoinColumn(name =  "major_id_")} )
	@OrderBy(value = "id ASC")
	public Set<Major> getMajors() {
		return majors;
	}
	public void setMajors(Set<Major> majors) {
		this.majors = majors;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	public Institute getInstitute() {
		return institute;
	}
	public void setInstitute(Institute institute) {
		this.institute = institute;
	}
	
	@OneToMany(fetch = FetchType.LAZY)
	@OrderBy(value = "id ASC")
	public Set<Student> getStudents() {
		return students;
	}
	public void setStudents(Set<Student> students) {
		this.students = students;
	}
	
	@Column(name = "choose_student_run_num",columnDefinition="varchar(1) default '0'")
	public String getChooseStudentRunNum() {
		return chooseStudentRunNum;
	}
	public void setChooseStudentRunNum(String chooseStudentRunNum) {
		this.chooseStudentRunNum = chooseStudentRunNum;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public MidCheck getMidCheck() {
		return midCheck;
	}
	public void setMidCheck(MidCheck midCheck) {
		this.midCheck = midCheck;
	}
	
	@OneToMany(fetch = FetchType.LAZY)//自己可以评阅多位老师
	public Set<Teacher> getTeachers() {
		return teachers;
	}
	public void setTeachers(Set<Teacher> teachers) {
		this.teachers = teachers;
	}
	
	@OneToOne(fetch = FetchType.LAZY)//自己只能被一位评阅老师评阅
	public Teacher getViewer() {
		return viewer;
	}
	public void setViewer(Teacher viewer) {
		this.viewer = viewer;
	}
	
	@OneToMany(fetch = FetchType.LAZY)
	public Set<TutorAdvice> getTutorAdvices() {
		return tutorAdvices;
	}
	public void setTutorAdvices(Set<TutorAdvice> tutorAdvices) {
		this.tutorAdvices = tutorAdvices;
	}
	
	@OneToMany(fetch = FetchType.LAZY)
	public Set<ViewerAdvice> getViewerAdvices() {
		return viewerAdvices;
	}
	public void setViewerAdvices(Set<ViewerAdvice> viewerAdvices) {
		this.viewerAdvices = viewerAdvices;
	}
	
	@Column(name = "forward_lecture_grade_status_",columnDefinition="int default 1")	
	public Integer getForwardLectureGradeStatus() {
		return forwardLectureGradeStatus;
	}
	public void setForwardLectureGradeStatus(Integer forwardLectureGradeStatus) {
		this.forwardLectureGradeStatus = forwardLectureGradeStatus;
	}
	
	@Column(name = "forward_tutor_grade_status_",columnDefinition="int default 1")
	public Integer getForwardTutorGradeStatus() {
		return forwardTutorGradeStatus;
	}
	public void setForwardTutorGradeStatus(Integer forwardTutorGradeStatus) {
		this.forwardTutorGradeStatus = forwardTutorGradeStatus;
	}
	
	@Column(name = "forward_viewer_grade_status_",columnDefinition="int default 1")
	public Integer getForwardViewerGradeStatus() {
		return forwardViewerGradeStatus;
	}
	public void setForwardViewerGradeStatus(Integer forwardViewerGradeStatus) {
		this.forwardViewerGradeStatus = forwardViewerGradeStatus;
	}
}
