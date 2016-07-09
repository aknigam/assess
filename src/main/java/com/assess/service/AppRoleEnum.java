package com.assess.service;


public enum AppRoleEnum {

	ADMIN(1, "administrator"),
	USER(2, "normal user");

	int m_id;
	String m_description;

	AppRoleEnum(int id, String description)
	{
		m_id = id;
		m_description = description;
	}

	public int getId() {
		return m_id;
	}

	public String getDescription() {
		return m_description;
	}

	/*
	private static final Map<String, AppRoleEnum> stringToEnum	= new HashMap<String, AppRoleEnum>();
	
	static { // Initialize map from constant name to enum constant
		for (AppRoleEnum op : values())
			stringToEnum.put(op.toString(), op);
	}
	// Returns AppRoleEnum for string, or null if string is invalid
	public static AppRoleEnum fromString(String symbol) {
		return stringToEnum.get(symbol);
	}
	*/
}

