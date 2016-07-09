package com.assess.service.entity;

import java.util.ArrayList;
import java.util.List;

import com.assess.service.QuestionTypeEnum;

// Generated Jul 7, 2014 8:27:18 AM by Hibernate Tools 3.4.0.CR1

/**
 * Question generated by hbm2java
 */
public class Question
{

	private Integer m_questionId;
	private QuestionTypeEnum m_questionTypeEnum;
	private Integer m_customerId;
	private String m_question;
//	private List<DesignationQuestion> m_designationQuestions; 
	private Integer m_designationid;
	
	private AssessmentArea m_assessmentArea;
	
	private List<MultipleChoice> m_choices = new ArrayList();
	
	
	private List<EmployeeFeedbackAnswer> m_employeeFeedbackAnswers;
	private Designation m_designation;
	private Customer m_customer; 
	
	

	@Override
	public String toString() {
		return m_questionTypeEnum+","+m_customerId+","+m_designationid+","+m_question;
	}

	
	
	public Question(Customer customer, Integer designationId, String question,
			QuestionTypeEnum questionTypeEnum) {
		
//		m_customerId = customer;
		m_customer = customer;
//		m_designationQuestions = new ArrayList();
//		m_designationQuestions.add(new DesignationQuestion(m_questionId, designationId));
		m_designationid = designationId;
		m_question = question;
		m_questionTypeEnum = questionTypeEnum;
		
	}
	public Question(Integer questionId) {
		m_questionId = questionId;
	}



	public Question(int questionId, String question)
	{
		m_questionId = questionId;
		m_question = question;
	}



	public Integer getQuestionId() {
		return m_questionId;
	}
	public void setQuestionId(Integer questionId) {
		m_questionId = questionId;
	}
	public Integer getCustomerId() {
		return m_customerId;
	}
	public void setCustomerId(Integer customerId) {
		m_customerId = customerId;
	}
	public String getQuestion() {
		return m_question;
	}
	public void setQuestion(String question) {
		m_question = question;
	}
//	public List<DesignationQuestion> getDesignationQuestions() {
//		return m_designationQuestions;
//	}
//	public void setDesignationQuestions(
//			List<DesignationQuestion> designationQuestions) {
//		m_designationQuestions = designationQuestions;
//	}
	public List<MultipleChoice> getChoices() {
		return m_choices;
	}
	public void setChoices(List<MultipleChoice> choices) {
		m_choices = choices;
	}
	public QuestionTypeEnum getQuestionTypeEnum() {
		return m_questionTypeEnum;
	}
	public void setQuestionTypeEnum(QuestionTypeEnum questionTypeEnum) {
		m_questionTypeEnum = questionTypeEnum;
	}
	public Integer getDesignationid() {
		return m_designationid;
	}
	public void setDesignationid(Integer designationid) {
		m_designationid = designationid;
	}



	public AssessmentArea getAssessmentArea() {
		return m_assessmentArea;
	}



	public void setAssessmentArea(AssessmentArea assessmentArea) {
		m_assessmentArea = assessmentArea;
	}



	public List<EmployeeFeedbackAnswer> getEmployeeFeedbackAnswers() {
		return m_employeeFeedbackAnswers;
	}



	public void setEmployeeFeedbackAnswers(
			List<EmployeeFeedbackAnswer> employeeFeedbackAnswers) {
		m_employeeFeedbackAnswers = employeeFeedbackAnswers;
	}

	public void setDesignation(Designation designation) {
		m_designation = designation;
		
	}

	public Designation getDesignation() {
		return m_designation;
	}



	public Customer getCustomer() {
		return m_customer;
	}



	public void setCustomer(Customer customer) {
		m_customer = customer;
	}
	


}