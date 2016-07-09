package com.assess.service;

public enum QuestionTypeEnum {

	DESCRIPTIVE(1, "Descriptive question"),
	MULTIPLE_CHOICE(2, "Question with multiple choices");
	
	private int m_id;
	private String m_description;
	
	private QuestionTypeEnum(int id , String description) {
		m_id =id;
		m_description = description;
	}

	public int getId() {
		return m_id;
	}

	public String getDescription() {
		return m_description;
	}
	
}
