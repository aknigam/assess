package com.assess.service.entity;

import java.util.ArrayList;
import java.util.List;

public class IndividualSummaryReport
{

	private AppUser m_user;
	
	private List<AssessmentAreaReport> m_assessmentAreaReports = new ArrayList();
	
	public AppUser getUser()
	{
		return m_user;
	}

	public void setUser(AppUser user)
	{
		m_user = user;
	}

	public List<AssessmentAreaReport> getAssessmentAreaReports()
	{
		return m_assessmentAreaReports;
	}

	public void setAssessmentAreaReports(List<AssessmentAreaReport> assessmentAreaReports)
	{
		m_assessmentAreaReports = assessmentAreaReports;
	}

	public static class AssessmentAreaReport
	{
		private AssessmentArea m_assessmentArea;

		private List<QuestionReport> m_questionReports = new ArrayList();
		
		
		public AssessmentArea getAssessmentArea()
		{
			return m_assessmentArea;
		}

		public void setAssessmentArea(AssessmentArea assessmentArea)
		{
			m_assessmentArea = assessmentArea;
		}

		public List<QuestionReport> getQuestionReports()
		{
			return m_questionReports;
		}

		public void setQuestionReports(List<QuestionReport> questionReports)
		{
			m_questionReports = questionReports;
		}

	}
	
	public static class QuestionReport
	{
		private Question m_question;
		private Float selfRanking;
		private Float managerRanking;
		private Float othersRanking;
		private Float peersRanking;
		private Float directReportsRanking;
		
		public Question getQuestion()
		{
			return m_question;
		}
		public void setQuestion(Question question)
		{
			m_question = question;
		}
		public Float getSelfRanking()
		{
			return selfRanking;
		}
		public void setSelfRanking(Float selfRanking)
		{
			this.selfRanking = selfRanking;
		}
		public Float getManagerRanking()
		{
			return managerRanking;
		}
		public void setManagerRanking(Float managerRanking)
		{
			this.managerRanking = managerRanking;
		}
		public Float getOthersRanking()
		{
			return othersRanking;
		}
		public void setOthersRanking(Float othersRanking)
		{
			this.othersRanking = othersRanking;
		}
		public Float getPeersRanking()
		{
			return peersRanking;
		}
		public void setPeersRanking(Float peersRanking)
		{
			this.peersRanking = peersRanking;
		}
		public Float getDirectReportsRanking()
		{
			return directReportsRanking;
		}
		public void setDirectReportsRanking(Float directReportsRanking)
		{
			this.directReportsRanking = directReportsRanking;
		}
	}
	
	
}
