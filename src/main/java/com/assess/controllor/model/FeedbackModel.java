package com.assess.controllor.model;

import java.util.ArrayList;
import java.util.List;


public class FeedbackModel
{
	
	Integer m_appUserReviewerId;
	Integer m_RevieweeId;
	Integer m_designationId;
	
	List<QuestionAnswer> m_questionAnswers = new ArrayList();
	
	List<Competency> m_competencies  = new ArrayList();
	
	public static class Competency
	{
		String competencyName; 
		List<SubCompetency> m_subCompetencies = new ArrayList();
		
		public Competency(String competency)
		{
			competencyName = competency;
		}
		public String getCompetencyName()
		{
			return competencyName;
		}
		public void setCompetencyName(String competencyName)
		{
			this.competencyName = competencyName;
		}
		public List<SubCompetency> getSubCompetencies()
		{
			return m_subCompetencies;
		}
		public void setSubCompetencies(List<SubCompetency> subCompetencies)
		{
			m_subCompetencies = subCompetencies;
		}
	}
	
	public static class SubCompetency
	{
		String subCompetencyName; 
		List<QuestionAnswer> m_questionAnswers = new ArrayList();
		
		public SubCompetency(String subCompetency)
		{
			subCompetencyName = subCompetency;
		}
		public String getSubCompetencyName()
		{
			return subCompetencyName;
		}
		public void setSubCompetencyName(String subCompetencyName)
		{
			this.subCompetencyName = subCompetencyName;
		}
		public List<QuestionAnswer> getQuestionAnswers()
		{
			return m_questionAnswers;
		}
		public void setQuestionAnswers(List<QuestionAnswer> questionAnswers)
		{
			m_questionAnswers = questionAnswers;
		}
	}
	
	public static class QuestionAnswer
	{
		// question
		Integer m_questionId;
		String m_question;
		Integer m_refQuestionTypeId;
		
		// answer
		String m_descriptiveAnswer="Please type answer here.";
		Integer m_multipleChoiceAnswerId;
		
		List<Choice> m_choices = new ArrayList();
		
		public QuestionAnswer() {
			
		}
		
		public QuestionAnswer(Integer questionId, int refQuestionTypeId, String question) {
			m_questionId = questionId;
			m_question = question;
			m_refQuestionTypeId = refQuestionTypeId;
		}

		

		public Integer getQuestionId() {
			return m_questionId;
		}

		public void setQuestionId(Integer questionId) {
			m_questionId = questionId;
		}

		public String getQuestion() {
			return m_question;
		}

		public void setQuestion(String question) {
			m_question = question;
		}

		public Integer getRefQuestionTypeId() {
			return m_refQuestionTypeId;
		}

		public void setRefQuestionTypeId(Integer refQuestionTypeId) {
			m_refQuestionTypeId = refQuestionTypeId;
		}

		public String getDescriptiveAnswer() {
			return m_descriptiveAnswer;
		}

		public void setDescriptiveAnswer(String descriptiveAnswer) {
			m_descriptiveAnswer = descriptiveAnswer;
		}

		public Integer getMultipleChoiceAnswerId() {
			return m_multipleChoiceAnswerId;
		}

		public void setMultipleChoiceAnswerId(Integer multipleChoiceAnswerId) {
			m_multipleChoiceAnswerId = multipleChoiceAnswerId;
		}

		public List<Choice> getChoices() {
			return m_choices;
		}

		public void setChoices(List<Choice> choices) {
			m_choices = choices;
		}
		
	}
	
	public static class Choice
	{
		public Choice(Integer multipleChoiceId, String answer) {
			m_choiceId = multipleChoiceId;
			m_choiceAnswer = answer;
		}
		Integer m_choiceId;
		String m_choiceAnswer;
		public Integer getChoiceId() {
			return m_choiceId;
		}
		public void setChoiceId(Integer choiceId) {
			m_choiceId = choiceId;
		}
		public String getChoiceAnswer() {
			return m_choiceAnswer;
		}
		public void setChoiceAnswer(String choiceAnswer) {
			m_choiceAnswer = choiceAnswer;
		}
	}

	public Integer getAppUserReviewerId() {
		return m_appUserReviewerId;
	}

	public void setAppUserReviewerId(Integer appUserReviewerId) {
		m_appUserReviewerId = appUserReviewerId;
	}

	public Integer getRevieweeId() {
		return m_RevieweeId;
	}

	public void setRevieweeId(Integer revieweeId) {
		m_RevieweeId = revieweeId;
	}

	public Integer getDesignationId() {
		return m_designationId;
	}

	public void setDesignationId(Integer designationId) {
		m_designationId = designationId;
	}

	public List<QuestionAnswer> getQuestionAnswers() {
		return m_questionAnswers;
	}

	public void setQuestionAnswers(List<QuestionAnswer> questionAnswers) {
		m_questionAnswers = questionAnswers;
	}

	public List<Competency> getCompetencies()
	{
		return m_competencies;
	}

	public void setCompetencies(List<Competency> competencies)
	{
		m_competencies = competencies;
	}
	

/**
 * 
 * // Query to get the questions and answers in the feedback.
	private static String questionsQuery = " select  "+ 
			" 	cur.AppUserReviewerId, " +
			"	cur.RevieweeId, " +
			"	au.designationid, "+ 
			" 	q.questionId,  "+ 
			" 	q.refQuestionTypeid,  "+ 
			" 	q.Question,  "+ 
			" 	mc.MultipleChoiceId,  "+ 
			" 	mc.Answer,  "+ 
			" 	mc.Sequence , "+ 
			" 	efa.DescriptiveAnswer, "+ 
			" 	mca.MultipleChoiceId as MultipleChoiceAnswerId  "+ 
			" from CustomerUserReviewer cur "+ 
			" join AppUser au on au.AppUserId = cur.RevieweeId "+ 
			" join Designation d on d.designationid = au.designationid "+ 
			" join Question q on q.designationid = au.designationid "+ 
			" left join MultipleChoice mc on mc.questionid = q.questionid "+ 
			" left join EmployeeFeedbackAnswer efa on efa.questionid = q.questionid "+ 
			" left join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId "+ 
			" where cur.AppUserReviewerId = ? ";
 * @author anigam
 *
 */
	

}
