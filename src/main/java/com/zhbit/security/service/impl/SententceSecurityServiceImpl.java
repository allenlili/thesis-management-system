package com.zhbit.security.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import com.zhbit.core.utils.EnumStatus.RoleEnum;
import com.zhbit.security.dao.RoleDao;
import com.zhbit.security.dao.TeacherDao;
import com.zhbit.security.entity.Institute;
import com.zhbit.security.entity.Major;
import com.zhbit.security.entity.Role;
import com.zhbit.security.entity.Teacher;
import com.zhbit.security.entity.User;
import com.zhbit.security.service.SententceSecurityServiceI;

@Service("sententceSecurityService")
public class SententceSecurityServiceImpl implements SententceSecurityServiceI{
	
	private TeacherDao teacherDao;
	@Resource
	public void setTeacherDao(TeacherDao teacherDao) {
		this.teacherDao = teacherDao;
	}
	
	private RoleDao roleDao;
	@Resource
	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}
	
	public void getFindSecurityByRole(User user,DetachedCriteria criteria){
		List<String> roleNames = new ArrayList<String>();
		List<Role> roles = roleDao.findRolesByUser(user);
		for (Role role : roles) {
			roleNames.add(role.getRoleName());
		}
		String highestSecurityRoleName = getHighestSecurity(roleNames);
		Teacher teacher = (Teacher) teacherDao.findByUuid(Teacher.class, user.getUuid());
		Institute institute = null;
		Set<Major> majors = null;
		if(RoleEnum.superAdmin.getValue().equals(highestSecurityRoleName)){
			return;
		}			
		if(RoleEnum.leadergroup.getValue().equals(highestSecurityRoleName)){
			institute = teacher.getInstitute();
			criteria.createAlias("institute", "i")
			        .add(Restrictions.eq("i.instituteName", institute.getInstituteName()));
			return;
		}
		if(RoleEnum.workgroup.getValue().equals(highestSecurityRoleName)){
			institute = teacher.getInstitute();
			majors = teacher.getMajors();
			criteria.createAlias("institute", "i")
			        .createAlias("majors", "ms")
			        .add(Restrictions.eq("i.instituteName", institute.getInstituteName()))
			        .add(Restrictions.eq("ms.majorName", majors.iterator().next().getMajorName()));
			return;
		}
	}
	
	public String getHighestSecurity(List<String> roleNames){
		if(roleNames==null){
			return null;
		}
		if(roleNames.contains(RoleEnum.superAdmin.getValue())){
			return RoleEnum.superAdmin.getValue();
		}
		if(roleNames.contains(RoleEnum.leadergroup.getValue())){
			return RoleEnum.leadergroup.getValue();
		}
		if(roleNames.contains(RoleEnum.workgroup.getValue())){
			return RoleEnum.workgroup.getValue();
		}
		return null;
	}
}
