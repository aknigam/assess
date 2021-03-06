package com.assess.service.entity;

import java.util.ArrayList;
import java.util.List;

// Generated Jul 7, 2014 8:27:18 AM by Hibernate Tools 3.4.0.CR1

/**
 * Designation generated by hbm2java
 */
public class Designation implements java.io.Serializable {

	private Integer designationId;
	private int customerId;
	private String name;
	private String description;
	
	private List<Question> m_questions = new ArrayList();

	public Designation() {
	}

	public Designation(int designationId) {
		this.designationId = designationId;
	}

	public Designation(int customerId, String name, String description) {
		this.customerId = customerId;
		this.name = name;
		this.description = description;
	}

	public Designation(String designationName) {
		name = designationName;
	}

	public Integer getDesignationId() {
		return this.designationId;
	}

	public void setDesignationId(Integer designationId) {
		this.designationId = designationId;
	}

	public int getCustomerId() {
		return this.customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<Question> getQuestions() {
		return m_questions;
	}

	public void setQuestions(List<Question> questions) {
		m_questions = questions;
	}

}
