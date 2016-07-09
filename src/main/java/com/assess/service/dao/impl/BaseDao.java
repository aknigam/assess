package com.assess.service.dao.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;

public abstract class BaseDao
{

	@Autowired
	@Qualifier("assessJdbcTemplate")
	protected JdbcTemplate m_assessDbTemplate;

	public JdbcTemplate getM_assessDbTemplate() {
		return m_assessDbTemplate;
	}

	public void setM_assessDbTemplate(JdbcTemplate m_assessDbTemplate) {
		this.m_assessDbTemplate = m_assessDbTemplate;
	}
}
