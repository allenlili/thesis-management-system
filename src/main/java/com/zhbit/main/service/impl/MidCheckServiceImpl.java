package com.zhbit.main.service.impl;

import java.util.Date;
import java.util.Set;
import javax.annotation.Resource;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import com.zhbit.core.utils.EnumStatus.StatusEnum;
import com.zhbit.core.utils.EnumStatus.TopicQualityEnum;
import com.zhbit.main.dao.MidCheckDao;
import com.zhbit.main.entity.MidCheck;
import com.zhbit.main.entity.Topic;
import com.zhbit.main.service.MidCheckServiceI;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

@Service("midCheckService")
public class MidCheckServiceImpl implements MidCheckServiceI {

	private static Logger logger = Logger.getLogger(MidCheckServiceImpl.class);
	
	private TeacherDao teacherDao;
	@Resource
	public void setTeacherDao(TeacherDao teacherDao) {
		this.teacherDao = teacherDao;
	}
	
	private MidCheckDao midCheckDao;
	@Resource
	public void setMidCheckDao(MidCheckDao midCheckDao) {
		this.midCheckDao = midCheckDao;
	}
	
	@Override
	public Teacher getTeacher(User user) {
		Teacher teacher = (Teacher) teacherDao.findByUuid(Teacher.class, user.getUuid());
		return teacher;
	}

	@Override
	public MidCheck findMyMidCheck(User currentUser) {
		logger.info("findMyMidCheck(User currentUser)");
		Teacher teacher = getTeacher(currentUser);
		MidCheck midCheck = teacher.getMidCheck();
		return midCheck;
	}
	
	@Override
	public void doCreateMidCheck(User currentUser){
		MidCheck midCheck = new MidCheck();
		Teacher teacher = getTeacher(currentUser);
		midCheck.setTeacher(teacher);
		midCheck.setUser(currentUser);
		midCheck.setStartDate(new Date());
		Set<Student> students = teacher.getStudents();
		Topic topic = null;
		int realTeachNum = 0, theoryResearchNum = 0, technologyScienceResearchNum = 0;
		int a = 0,b = 0;//起草稿人数
		for (Student student : students) {
			topic = student.getTopic();
			if(topic==null){
				continue;
			}
			if(TopicQualityEnum.TheoryResearch.getValue().equals(topic.getQuality())){
				theoryResearchNum++;
			}
			if(TopicQualityEnum.TechnologyScienceResearch.getValue().equals(topic.getQuality())){
				technologyScienceResearchNum++;
			}
			if(student.getThesisScripts().size()!=0){
				a++;
			}
			if(student.getThesisScripts().size()>2){
				b++;
			}
		}
		realTeachNum = students.size();
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("本人共指导"+realTeachNum+"位同学的毕业论文。");
		stringBuilder.append("其中做理论性论文的有"+theoryResearchNum+"人；");
		stringBuilder.append("做技术科学研究的有"+technologyScienceResearchNum+"人；");
		stringBuilder.append(a+"位同学已经提交过起草稿，");
		if(b!=0){
			stringBuilder.append("其中"+b+"位同学提交过多份稿件，");
		}
		stringBuilder.append("进度控制较好。");
		midCheck.setFirstContent(stringBuilder.toString());
		midCheck.setStatus(StatusEnum.success.getValue());
		midCheckDao.save(midCheck);
		teacher.setMidCheck(midCheck);
		teacherDao.save(teacher);
	}
}
