package testMappings;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zhbit.core.utils.EnumStatus.RoleEnum;
import com.zhbit.main.dao.TaskBookDao;
import com.zhbit.main.dao.WishDao;
import com.zhbit.main.entity.TaskBook;
import com.zhbit.main.entity.Wish;
import com.zhbit.process.dao.ActivitiDao;
import com.zhbit.security.dao.RoleDao;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.entity.Role;
import com.zhbit.security.entity.Student;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;

public class TestSearch {
	private SessionFactory sessionFactory;
	private WishDao wishDao;
	@SuppressWarnings("unused")
	private TeacherDao teacherDao;
	private ActivitiDao activitiDao;
	private TaskBookDao taskBookDao;
	private RoleDao roleDao;
	
	private static Logger logger = Logger.getLogger(TestSearch.class);
	
	public TestSearch(){
		ApplicationContext ac = new ClassPathXmlApplicationContext("config/spring3XML/applicationContext*.xml");
		sessionFactory =  ac.getBean(SessionFactory.class);
		wishDao = ac.getBean(WishDao.class);
		activitiDao = ac.getBean(ActivitiDao.class);
		teacherDao = ac.getBean(TeacherDao.class);
		taskBookDao = ac.getBean(TaskBookDao.class);
		roleDao = ac.getBean(RoleDao.class);
	}
	
	@Test
	public void testMethodFindByInstituteAndMajor(){
		logger.info(sessionFactory);
		Session session = sessionFactory.openSession();
		Criteria criteria = session.createCriteria(Teacher.class)
		.createAlias("institute", "i")
		.createAlias("majors", "ms")
		.add(Restrictions.eq("i.instituteName", "商学院"))
		.add(Restrictions.eq("ms.majorName", "信息管理与信息系统"));
		@SuppressWarnings("unchecked")
		List<Teacher> list = criteria.list();
		for (Teacher teacher : list) {
			logger.info(teacher.getName());
		}
	}
	
	@Test
	public void testGetRealHaveSelectedNum(){
		String uuidString = "c140f009-f4db-41dc-9450-3e7e3fceeb14";
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Wish.class);
		detachedCriteria.add(Restrictions.or(
				Restrictions.eq("firstResultUuid",uuidString),
				Restrictions.eq("secondResultUuid",uuidString),
				Restrictions.eq("thirdResultUuid",uuidString)));
		List<Wish> wishs = wishDao.find(detachedCriteria);
		logger.info(wishs.isEmpty()?0:wishs.size());
	}
	
	@SuppressWarnings("unchecked")
	@Test
	public void getWorkgroup(){
		DetachedCriteria criteria = null;
		Session session = sessionFactory.openSession();
		String uuidString = "c140f009-f4db-41dc-9450-3e7e3fceeb14";
		criteria = DetachedCriteria.forClass(Teacher.class);
		criteria.add(Restrictions.eq("uuid", uuidString));
		Teacher teacher = (Teacher) criteria.getExecutableCriteria(session).uniqueResult();		
		logger.info(teacher.getName());
		Criteria criteria2  = session.createCriteria(Teacher.class)
		.createAlias("institute", "i")
		.createAlias("majors", "ms")
		.add(Restrictions.eq("i.instituteName", teacher.getInstitute().getInstituteName()))
		.add(Restrictions.eq("ms.majorName", teacher.getMajors().iterator().next().getMajorName()))
		.createAlias("user", "u")
		.createAlias("u.roles", "u_rs")
		.add(Restrictions.eq("u_rs.roleName", RoleEnum.leadergroup.getValue()));
		List<Teacher> list = criteria2.list();
		for (Teacher teacher3 : list) {
			logger.info(teacher3.getName());
		}
	}
	
	@Test
	public void getWorkgroup2(){
		String uuidString = "c140f009-f4db-41dc-9450-3e7e3fceeb14";
		User user = new User();
		user.setUuid(uuidString);
		List<User> users = activitiDao.findWorkgroupForUserByTeacherUser(user);
		for (User user2 : users) {
			logger.info(user2.getUserName());
		}
	}
	
	@Test
	public void getWorkgroup3(){
		String uuidString = "c140f009-f4db-41dc-9450-3e7e3fceeb14";
		Session session = sessionFactory.openSession();
		List<User> workgroupList = new ArrayList<User>();
		DetachedCriteria detachedCriteria = null;
		Criteria criteria2 = null;
		Criteria criteria3 = null;
		//查出该用户对应的老师对象
		detachedCriteria = DetachedCriteria.forClass(Teacher.class);
		detachedCriteria.add(Restrictions.eq("uuid", uuidString));
		Teacher teacher = (Teacher) detachedCriteria.getExecutableCriteria(session).uniqueResult();		
		//找出该老师所在专业的所有老师，然后关联user的userName和roles属性，得出工作小组
		criteria2  = session.createCriteria(Teacher.class)
		.createAlias("institute", "i")
		.createAlias("majors", "ms")
		.add(Restrictions.eq("i.instituteName", teacher.getInstitute().getInstituteName()))
		.add(Restrictions.eq("ms.majorName", teacher.getMajors().iterator().next().getMajorName()));
		@SuppressWarnings("unchecked")
		List<Teacher> teachers = criteria2.list();		
		for (Teacher teacher2 : teachers) {
			criteria3 = session.createCriteria(User.class)
			.add(Restrictions.eq("uuid", teacher2.getUuid()))
			.createAlias("roles", "rs")
			.add(Restrictions.eq("rs.roleName", RoleEnum.workgroup.getValue()));
			@SuppressWarnings("unchecked")
			List<User> list = criteria3.list();
			if(!list.isEmpty()){
				workgroupList.add(list.get(0));
				logger.info(list.get(0).getUserName());
			}
		}		
	}	
	
	@Test
	public void getMyTaskbook(){
		Student student = new Student();
		student.setId(32l);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(TaskBook.class);
		detachedCriteria.createAlias("student", "s").add(Restrictions.eq("s.id", student.getId()));
		List<TaskBook> taskBooks = taskBookDao.find(detachedCriteria);
		for (TaskBook taskBook : taskBooks) {
			logger.info(taskBook.getStudent().getName());
		}
	}
	
	@Test
	public void getRole(){
		logger.info("getRole()");
		Role role = roleDao.fineByRoleName(RoleEnum.student.getValue());
		logger.info(role);
	}
}
