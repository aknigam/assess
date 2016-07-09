package com.assess.service;

public enum RefFeedbackStatusEnum {

	
	NEW(1, "New"),
	DRAFT(2, "Draft"),
	SUBMITTED(3, "Submitted");
	
	private Integer m_id;
	private String m_name;

	RefFeedbackStatusEnum(Integer id,  String name)
	{
		m_id = id;
		m_name = name;
	}

	public Integer getId() {
		return m_id;
	}

	public void setId(Integer id) {
		m_id = id;
	}

	public String getName() {
		return m_name;
	}

	public void setName(String name) {
		m_name = name;
	}
	
}
