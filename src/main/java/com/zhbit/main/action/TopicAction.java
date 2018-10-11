package com.zhbit.main.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.zhbit.core.action.ActivitiBaseAction;
import com.zhbit.core.dao.GenericDao;
import com.zhbit.core.utils.EnumStatus.*;
import com.zhbit.main.dao.TopicDao;
import com.zhbit.main.entity.Topic;
import com.zhbit.main.service.TopicServiceI;
import com.zhbit.security.entity.User;

@SuppressWarnings("serial")
@Controller
@Scope("prototype")
public class TopicAction extends ActivitiBaseAction<Topic> {
	
	private Long optionsRadios;
	
	private String result;
	
	private TopicServiceI topicService;
	@Resource
	public void setTopicService(TopicServiceI topicService) {
		this.topicService = topicService;
	}
	
	private TopicDao topicDao;
	@Resource
	public void setTopicDao(TopicDao topicDao) {
		this.topicDao = topicDao;
	}

	@Override
	public GenericDao<Topic> getDao() {
		return topicDao;
	}
	
	@Override
	public void beforeSave(Topic model) {
		User user = getCurrentUser();
		if (model.getUser() == null) {
			model.setUser(user);
		}
		if (model.getStatus() == null) {
			model.setStatus(StatusEnum.unstart.getValue());
		}
		if(model.getTeacher() == null){
			model.setTeacher(topicService.getTeacher(user));
			model.setStartDate(new Date());
		}
	}
	
	@Override
	public void beforFind(DetachedCriteria criteria) {
		if (null != model.getStartDate()) {
			criteria.add(Restrictions.ge("startDate", model.getStartDate()));
		}
		if (null != model.getEndDate()) {
			criteria.add(Restrictions.le("endDate", model.getEndDate()));
		}
		if (null != model.getStatus()) {
			if (StatusEnum.finished.getValue().equals(model.getStatus())) {
				Criterion c1 = Restrictions.eq("status", StatusEnum.success.getValue());
				Criterion c2 = Restrictions.eq("status", StatusEnum.fail.getValue());
				criteria.add(Restrictions.or(c1, c2));
			} else {
				criteria.add(Restrictions.eq("status", model.getStatus()));
			}
		}
		if (model.getQueryByAllUser() == null || "".equals(model.getQueryByAllUser())) {
			criteria.createAlias("user", "u");
			criteria.add(Restrictions.eq("u.id", getCurrentUser().getId()));
		}
		
		if(model.getTopicName() != null || "".equals(model.getTopicName())){
			criteria.add(Restrictions.like("topicName", "%"+model.getTopicName()+"%"));
		}
	}
	
    public String selectMyTopic(){
    	Topic topic = topicService.findMyTopic(getCurrentUser());
    	if(topic == null){
    	   List<Topic> topics = topicService.findSelectableTopics(getCurrentUser());
    	   ActionContext.getContext().put("topics", topics);
    	   return "selectTopic";
    	}
    	ActionContext.getContext().put("topic", topic);
    	return "myTopic";
    }
    
    public String confirmMyTopic(){
    	topicService.doConfirmMyTopic(getCurrentUser(),optionsRadios);
    	return "toMyTopic";
    }

    public String equal(){
    	Map<String, Boolean> map = new HashMap<String,Boolean>();
    	JSONObject jsonObject = null;
    	Topic topic = null;
    	if(model.getId()==null){
    		if(topicService.findEqual(model.getTopicName())){
    			map.put("equal", true);//找到相等的题目，返回true
    			jsonObject = JSONObject.fromObject(map);
    		}else{
    			map.put("equal", false);
    			jsonObject = JSONObject.fromObject(map);
    		}
    		this.result = jsonObject.toString();
    		return Action.SUCCESS;
    	}else if((topic = topicDao.get(model.getId()))!=null){
    		if(topic.getTopicName().equals(model.getTopicName())){
    			map.put("equal", false);
    			jsonObject = JSONObject.fromObject(map);
    			this.result = jsonObject.toString();
    			return Action.SUCCESS;
    		}else if(topicService.findEqual(model.getTopicName())){
    			map.put("equal", true);//找到相等的题目，返回true
    			jsonObject = JSONObject.fromObject(map);
    			this.result = jsonObject.toString();
    			return Action.SUCCESS;
    		}
    	}
		return Action.SUCCESS;
    }
    
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public Long getOptionsRadios() {
		return optionsRadios;
	}

	public void setOptionsRadios(Long optionsRadios) {
		this.optionsRadios = optionsRadios;
	}

}
