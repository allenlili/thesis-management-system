package testMappings;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zhbit.security.dao.StudentDao;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.entity.Student;

public class TestMappings {
	@SuppressWarnings("unused")
	private TeacherDao teacherDao;
	private StudentDao studentDao;
	
	public TestMappings(){
		ApplicationContext ac = new ClassPathXmlApplicationContext("config/spring3XML/applicationContext*.xml");
		teacherDao = ac.getBean(TeacherDao.class);
		studentDao = ac.getBean(StudentDao.class);
	}
	
	private static Logger logger = Logger.getLogger(TestMappings.class); 
	
	@Test
	public void testTeacherAndInstitute(){
//		List<Institute> institutes = teacherDao.find(DetachedCriteria.forClass(Institute.class));
//		for (Institute institute : institutes) {
//			logger.info(institute.getInstituteName());
//		}
//		List<Teacher> teachers = teacherDao.find(DetachedCriteria.forClass(Teacher.class));
//		for (Teacher teacher : teachers) {
//			logger.info(teacher.getName());
//			logger.info(teacher.getInstitute().getInstituteName());
//		}
//		Student student = new Student();
//		DetachedCriteria criteria = DetachedCriteria.forClass(Institute.class);
//		criteria.add(Restrictions.eq("instituteName", "商学院"));
//		student.setInstitute((Institute)studentDao.find(criteria).get(0));
//		logger.info(student.getInstitute().getInstituteName());
		
		DetachedCriteria criteria = DetachedCriteria.forClass(Student.class);
		criteria.add(Restrictions.eq("studentId", "100802011017"));
		List<?> stuList = studentDao.find(criteria);
		logger.info(stuList);
	}
	

}
