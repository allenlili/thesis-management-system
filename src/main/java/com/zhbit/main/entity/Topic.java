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
 * 论文题目
 * @author AllenLi
 *
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "topic")
public class Topic extends ActivitiBaseEntity{
	
	/**题目名称*/
	private String topicName;
	
	/**类型  Design("毕业设计"), Thesis("毕业论文");*/
    private String type ;
    
    /**
     * 题目来源  SocialPractice("社会实践"), 
     * ProductionPractice("生产实践"),
     * PersonalMake("自拟题目"),
     * Science("结合科研");
     * */
    private String origin;
    
    /**
     * 难度
     * Hard("难"), Meditate("中"),Easy("易"); 
     */
    private String level;
    
    /**
     *性质 ：TheoryResearch("理论研究"), TechnologyScienceResearch("技术科学研究"); 
     */
    private String quality ;
    
    /**是否新题*/
    private String oldOrNew;
    
    /**关联学生*/
    private Student student;
    
    /**关联老师*/
    private Teacher teacher;
    
    /**唯一标识*/
    private String uuid;

    @Column(name = "topic_name_")
	public String getTopicName() {
		return topicName;
	}
    
	public void setTopicName(String topicName) {
		this.topicName = topicName;
	}
	
	@Column(name = "type_")
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	@Column(name = "origin_")
	public String getOrigin() {
		return origin;
	}
	
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	
	@Column(name = "level_")
	public String getLevel() {
		return level;
	}
	
	public void setLevel(String level) {
		this.level = level;
	}
	
	@Column(name = "quality_")
	public String getQuality() {
		return quality;
	}
	
	public void setQuality(String quality) {
		this.quality = quality;
	}
	
	@Column(name = "old_or_new_")
	public String getOldOrNew() {
		return oldOrNew;
	}
	
	public void setOldOrNew(String oldOrNew) {
		this.oldOrNew = oldOrNew;
	}
	
	@OneToOne(fetch = FetchType.LAZY)
	public Student getStudent() {
		return student;
	}
	
	public void setStudent(Student student) {
		this.student = student;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	public Teacher getTeacher() {
		return teacher;
	}
	
	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
}
