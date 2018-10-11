package com.zhbit.core.utils.Core;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

import com.zhbit.core.utils.EnumStatus.StatusEnum;

public class GenericUtil {

	@SuppressWarnings("unchecked")
	public static <T> Class<T> getSuperGenericClass(Class<?> clz) {
		Class<T> result = null;
		//得到当前对象的父类"泛型类型"(也叫参数化类型)
		//superclass == GenericDao<Dept>成为参数化类型
		//superclass == BaseDao不是参数化类型
		Type superclass = clz.getGenericSuperclass();
		//判断类型是否为参数化类型
		if (superclass instanceof ParameterizedType) {
			//把父类类型转换成参数化类型（泛型类型）
			//只有ParameterizedType才能通过getActualTypeArguments得到参数
			ParameterizedType parameterizedType = (ParameterizedType) superclass;
			//得到参数化类型类型的参数
			//types == GenericDao<Dept>的"<Dept>"参数
			Type[] types = parameterizedType.getActualTypeArguments();
			//返回子类传递的类型
			result = (Class<T>) types[0];
		}			
		return result;
	}
	

	public static void main(String[] args) {
		System.out.println(StatusEnum.success.getValue());
	}	
}
