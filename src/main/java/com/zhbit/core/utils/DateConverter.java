package com.zhbit.core.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.struts2.util.StrutsTypeConverter;

public class DateConverter extends StrutsTypeConverter {
	
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:MM:ss");

	@Override
	public Object convertFromString(@SuppressWarnings("rawtypes") Map context, String[] params, @SuppressWarnings("rawtypes") Class targetClass) {
		Date date = null;
		if (targetClass == java.util.Date.class) {
			if (null != params && null != params[0] && !"".equals(params[0])) {
				try {
					date = sdf.parse(params[0]);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}
		return date;
	}

	@Override
	public String convertToString(@SuppressWarnings("rawtypes") Map context, Object target) {
		Date date = (Date) target;
		return sdf.format(date);
	}

}
