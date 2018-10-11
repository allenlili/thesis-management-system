package com.zhbit.core.utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;


public class TimeUtil {
	public static String getCurrentStringTime(){
		Date now = new Date();
		DateFormat format = DateFormat.getDateTimeInstance();
		String chooseTime = format.format(now);
		return chooseTime;
	}
	
	public static String getYear(Date now){
		DateFormat format = DateFormat.getDateInstance(DateFormat.YEAR_FIELD);
		return format.format(now);
	}
	
	public static String getMonth(Date now){
		DateFormat format = DateFormat.getDateInstance(DateFormat.MONTH_FIELD);
		return format.format(now);
	}
	
	public static String getDay(Date now){
		DateFormat format = DateFormat.getDateInstance(DateFormat.DATE_FIELD);
		return format.format(now);
	}
	
	public static String getSpecialFormatTime(Date now){
		DateFormat dd = new SimpleDateFormat("yyyy年MM月dd日");
		String prased = dd.format(now);
		return prased;
	}
	
	public static String getCommentFormatTime(Date now){
		DateFormat dd = new SimpleDateFormat("yyyy年MM月dd日 hh:MM:ss");
		String prased = dd.format(now);
		return prased;
	}
	
	public static String getFileFormatTime(Date now){
		DateFormat dd = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
		String prased = dd.format(now);
		return prased;
	}	
	
	public static String prase(String time) throws Exception{
		DateFormat dd = new SimpleDateFormat("yyyy-MM-dd");
		Date prased = dd.parse(time);
		return TimeUtil.getYear(prased);
	}
	//生成教务管理时间格式
	public static String prase2(String time) throws Exception{
		DateFormat dd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date prased = dd.parse(time);
		return TimeUtil.getSpecialFormatTime(prased);
	}	
	
	public static void main(String[] args) throws Exception {
		Date now = new Date();
		System.out.println(TimeUtil.getSpecialFormatTime(now));
		System.out.println(TimeUtil.prase(TimeUtil.getCurrentStringTime()));
		System.out.println(TimeUtil.getYear(now));
		System.out.println(TimeUtil.getMonth(now));
		System.out.println(TimeUtil.getDay(now));
		System.out.println(TimeUtil.getCurrentStringTime());
	}
}
