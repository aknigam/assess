package com.assess.service.dao.util;

import java.util.List;

import org.apache.commons.lang.StringUtils;

public class DBQueryUtil {

	
	private String condition = "";
	
	public DBQueryUtil() {
	}
	
	public void addIntCondition(String columnName, Integer value, StringBuilder query, List<Object> args)
	{
		if(value!= null && value!= 0)
		{
			condition = whereOrAnd(condition);
			query.append(condition+" "+columnName+" =  ? ");
			args.add(value);
		}
	}
	
	public void addStringCondition(String columnName, String value, StringBuilder query, List<Object> args)
	{
		if(!StringUtils.isEmpty(value))
		{
			condition = whereOrAnd(condition);
			query.append(condition+" "+columnName+" like  ? ");
			args.add("%"+value+"%");
		}
	}

	public String whereOrAnd(String condition) {
		if(condition.equals(""))
			return " where ";
		else if(condition.equals("where"))
			return "and";
		else
			return "and";
	}
}
