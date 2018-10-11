package com.zhbit.core.utils.Core;

import java.lang.reflect.Method;
import java.util.Set;

import com.zhbit.security.entity.Institute;


/**
 * 对于类，属性，方法，操作的工具类
 * @author Administrator
 *
 */
public class BeanUtil {
	
	/**
	 * get,set方法的最小长度 - 1
	 */
	private static final int SET_START = "set".length();

	/**
	 * is 方法最小长度 - 1
	 */
	private static final int IS_START = "is".length();
	
	/**
	 * 把source的属性的值，拷贝给target同名属性
	 * @param source
	 * @param target
	 */
	public static void copy(Object source, Object target) {
		try {
			//得到source类的所有方法
			Method[] methods = source.getClass().getMethods();
			for (Method method : methods) {
				//得到get方法
				if (isGetter(method)) {
					//得到get方法的返回值类型
					Class<?> returnType = method.getReturnType();
					//得到source对象get方法的返回值
					Object result = method.invoke(source);
					//不拷贝source值==null的属性
					if (null == result) {
						continue;
					}
					if (result instanceof Set) {
						@SuppressWarnings("rawtypes")
						Set set = (Set) result;
						if (set.size() <= 0) {
							continue;
						}
					}
					//通过get方法得到set方法名字
					String setterName = getterToSetter(method.getName());
					//得到set方法,set方法的参数类型==get方法的返回值类型
					Method setter = getMethod(source.getClass(), setterName, returnType);
					//把soure对象get方法返回值，拷贝给对象的target对象的set方法
					setter.invoke(target, result);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 得到指定的方法
	 * 
	 * @param clz
	 *            方法的类型
	 * @param methodName
	 *            方法的名字
	 * @param paramTypes
	 *            方法的参数列表
	 * @return
	 */
	public static Method getMethod(Class<?> clz, String methodName,Class<?>... paramTypes) {
		Method method = null;
		try {
			method = clz.getMethod(methodName, paramTypes);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return method;
	}

	/**
	 * getter方法名转换成setter方法名.
	 * 
	 * @param methodName
	 *            getter方法名
	 * @return setter方法名isUserName setUserName
	 */
	public static String getterToSetter(String methodName) {
		if (methodName.startsWith("get")) {
			return "s" + methodName.substring(1);
		} else if (methodName.startsWith("is")) {
			return "set" + methodName.substring(2);
		} else {
			throw new IllegalArgumentException(
					"method not start with get or is.");
		}
	}

	/**
	 * 判断方法名是否符合setter. 1.方法名是3个字符以上 2.方法名以set开头 3.方法只有一个参数 满足这三个条件，就被认为是setter
	 * 
	 * @param method
	 *            方法
	 * @return boolean
	 */
	public static boolean isSetter(Method method) {
		String name = method.getName();
		boolean hasOneParam = method.getParameterTypes().length == 1;
		boolean startsWithGet = (name.length() > SET_START)
				&& name.startsWith("set");

		return startsWithGet && hasOneParam;
	}

	/**
	 * 判断方法名是否符合getter. 1.方法名以get开头，并在3个字符以上 2.方法名以is开头，并在2个字符以上111 3.方法没有参数
	 * 满足这三个条件，就被认为是getter
	 * 
	 * @param method
	 *            方法
	 * @return boolean
	 */
	public static boolean isGetter(Method method) {
		String name = method.getName();
		//方法没有参数
		boolean hasNoParam = method.getParameterTypes().length == 0;
		//方法有返回值
		boolean noResultType = method.getReturnType() != void.class;
		//方法方法名已get开头，大于3位
		boolean startsWithGet = (name.length() > SET_START)
				&& name.startsWith("get");
		//方法以is开头，大于2位
		boolean startsWithIs = (name.length() > IS_START)
				&& name.startsWith("is");
		//不是getClass方法
		boolean notGetClass = !name.equals("getClass");

		return hasNoParam && noResultType && notGetClass && (startsWithGet || startsWithIs);
	}
	
	public static void main(String[] args) {
		Institute d1 = new Institute();
		d1.setId(456l);
		d1.setInstituteName("abc");
		
		Institute d2 = new Institute();
		d2.setId(123l);
		d2.setInstituteName("a");
		
		copy(d1, d2);
		System.out.println(d2.getId());
		System.out.println(d2.getInstituteName());
	}

}
