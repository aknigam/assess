package com.assess.service.entity;

import java.util.List;

public class AssessmentArea
{
	private Integer m_assessmentAreaId;
	private Customer m_customer;
	private String m_assessmentAreaName;
	private String m_assessmentAreaDescription;
	
	private AssessmentArea m_parentAssessmentArea;
	
	@Override
	public String toString() {
		if(m_assessmentAreaId!=null)
			if(m_parentAssessmentArea == null)
				return m_assessmentAreaId +"-"+m_assessmentAreaName+"-"+m_assessmentAreaDescription;
			else
				return m_assessmentAreaId +"-"+m_assessmentAreaName+"-"+m_assessmentAreaDescription+" ["+m_parentAssessmentArea+"]";
		else
			if(m_parentAssessmentArea == null)
				return m_assessmentAreaName+"-"+m_assessmentAreaDescription;
			else
				return m_assessmentAreaName+"-"+m_assessmentAreaDescription+" ["+m_parentAssessmentArea+"]";
	}
	
	private List<Question> m_questions;
	
	public AssessmentArea(int assessmentAreaId, String assessmentAreaname)
	{
		this.m_assessmentAreaId = assessmentAreaId;
		this.m_assessmentAreaName = assessmentAreaname;
	}
	
	public AssessmentArea(String assessmentAreaName,
			String assessmentAreaDescription, String parentAssessmentAreaName,
			Customer customer) {
		m_assessmentAreaName = assessmentAreaName;
		m_assessmentAreaDescription = assessmentAreaDescription;
		if(parentAssessmentAreaName!= null && !parentAssessmentAreaName.trim().equals(""))
			m_parentAssessmentArea = new AssessmentArea(parentAssessmentAreaName);
		m_customer = customer;
	}

	public AssessmentArea(String assessmentAreaName) {
		
		m_assessmentAreaName = assessmentAreaName;
	}

	public Integer getAssessmentAreaId()
	{
		return m_assessmentAreaId;
	}
	public void setAssessmentAreaId(Integer assessmentAreaId)
	{
		this.m_assessmentAreaId = assessmentAreaId;
	}
	public Customer getCustomer()
	{
		return m_customer;
	}
	public void setCustomer(Customer customer)
	{
		m_customer = customer;
	}
	public String getAssessmentAreaName()
	{
		return m_assessmentAreaName;
	}
	public void setAssessmentAreaName(String assessmentAreaName)
	{
		this.m_assessmentAreaName = assessmentAreaName;
	}
	public String getAssessmentAreaDescription()
	{
		return m_assessmentAreaDescription;
	}
	public void setAssessmentAreaDescription(String assessmentAreaDescription)
	{
		this.m_assessmentAreaDescription = assessmentAreaDescription;
	}
	public List<Question> getQuestions()
	{
		return m_questions;
	}
	public void setQuestions(List<Question> questions)
	{
		m_questions = questions;
	}

	public AssessmentArea getParentAssessmentArea() {
		return m_parentAssessmentArea;
	}

	public void setParentAssessmentArea(AssessmentArea parentAssessmentArea) {
		m_parentAssessmentArea = parentAssessmentArea;
	}
	
	
}
