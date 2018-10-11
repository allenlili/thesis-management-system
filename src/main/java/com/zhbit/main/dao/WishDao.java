package com.zhbit.main.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.zhbit.core.dao.GenericDao;
import com.zhbit.core.utils.Constant.SystemConstant;
import com.zhbit.core.utils.EnumStatus.ChooseStudentRunNumEnum;
import com.zhbit.main.entity.Wish;
import com.zhbit.security.entity.Teacher;

@Repository
public class WishDao extends GenericDao<Wish>{
	/**
	 * 找到新一轮还没有被选择的学生
	 * @param teacher
	 * @param whcihRun
	 * @return
	 */
	public List<Wish> findByTeacherUuidAndChooseStudentRunNum(Teacher teacher,String whcihRun){
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Wish.class);
		if(ChooseStudentRunNumEnum.defaultValue.getValue().equals(whcihRun)){
			detachedCriteria.add(Restrictions.eq("firstTeacherUuid", teacher.getUuid()));
			detachedCriteria.add(Restrictions.eq("firstResultUuid",SystemConstant.NO_RESULT ));
		}
		if(ChooseStudentRunNumEnum.firstRun.getValue().equals(whcihRun)){
			detachedCriteria.add(Restrictions.eq("secondTeacherUuid", teacher.getUuid()));
			detachedCriteria.add(Restrictions.eq("firstResultUuid",SystemConstant.NO_RESULT ));
			detachedCriteria.add(Restrictions.eq("secondResultUuid",SystemConstant.NO_RESULT ));
		}
		if(ChooseStudentRunNumEnum.secondRun.getValue().equals(whcihRun)){
			detachedCriteria.add(Restrictions.eq("thirdTeacherUuid", teacher.getUuid()));
			detachedCriteria.add(Restrictions.eq("firstResultUuid",SystemConstant.NO_RESULT ));
			detachedCriteria.add(Restrictions.eq("secondResultUuid",SystemConstant.NO_RESULT ));			
			detachedCriteria.add(Restrictions.eq("thirdResultUuid",SystemConstant.NO_RESULT ));
		}
	    List<Wish> wishs = find(detachedCriteria);
		return wishs;		
	}
	
	/**
	 * 查询某一轮结果uuid是该老师uuid的集合，即得到在当轮被该老师选择的wish集合，或者说是有助于查询到在当轮被选择的同学集合
	 * @param teacher
	 * @param notifyWhichRun
	 * @return
	 */
	public List<Wish> findByResultUuid(Teacher teacher,String whichRun){
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Wish.class);
		if(whichRun.equals(ChooseStudentRunNumEnum.defaultValue.getValue())){
			detachedCriteria.add(Restrictions.eq("firstResultUuid",teacher.getUuid()));
		}
		if(whichRun.equals(ChooseStudentRunNumEnum.firstRun.getValue())){
			detachedCriteria.add(Restrictions.eq("secondResultUuid",teacher.getUuid()));
		}
		if(whichRun.equals(ChooseStudentRunNumEnum.secondRun.getValue())){
			detachedCriteria.add(Restrictions.eq("thirdResultUuid",teacher.getUuid()));
		}
		if(whichRun.equals(ChooseStudentRunNumEnum.thirdRun.getValue())){
			detachedCriteria.add(Restrictions.eq("thirdResultUuid",teacher.getUuid()));
		}
		List<Wish> wishs = find(detachedCriteria);
		return wishs;
	}

	/**
	 * 查询wish中某一轮的结果uuid等于该老师的uuid的集合，即查询三轮过后被该老师选择的wish集合
	 * @param teacher
	 * @return
	 */
	public List<Wish> findByAllResultUuid(Teacher teacher) {
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Wish.class);
		detachedCriteria.add(Restrictions.or(
				Restrictions.eq("firstResultUuid",teacher.getUuid()),
				Restrictions.eq("secondResultUuid",teacher.getUuid()),
				Restrictions.eq("thirdResultUuid",teacher.getUuid())));
		List<Wish> wishs = find(detachedCriteria);
		return wishs;
	}

	/**
	 * 查询wish中某一轮的结果uuid等于该老师的uuid的集合的长度，即查询三轮过后被该老师选择的有多少人
	 * @param teacher
	 * @return
	 */	
	public int getRealHaveSelectedNum(Teacher teacher) {
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Wish.class);
		detachedCriteria.add(Restrictions.or(
				Restrictions.eq("firstResultUuid",teacher.getUuid()),
				Restrictions.eq("secondResultUuid",teacher.getUuid()),
				Restrictions.eq("thirdResultUuid",teacher.getUuid())));
		List<Wish> wishs = find(detachedCriteria);
		return wishs.isEmpty()?0:wishs.size();
	}

	public Wish findByStuUuid(String stuUuid) {
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Wish.class);
		detachedCriteria.add(Restrictions.eq("uuid",stuUuid));
		return (Wish) (find(detachedCriteria).isEmpty()?null:find(detachedCriteria).get(0));
	}
	
}
