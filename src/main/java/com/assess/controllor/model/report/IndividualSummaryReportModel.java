package com.assess.controllor.model.report;

import java.util.ArrayList;
import java.util.List;


public class IndividualSummaryReportModel {
	
	private Integer revieweeId;
	private String revieweeName;
	
	private Integer maxRating = 1;
	private Integer minRating = 5;
	
	private Object[][] charData = {
			{"Question1",2.2},
			{"Question3",3.5},
			{"Question4",4},
	};
	
	public Object[][] getCharData()
	{
		return charData;
	}

	public void setCharData(Object[][] charData)
	{
		this.charData = charData;
	}

	private List<AssessmentAreaReport> m_assessmentAreaReports  = new ArrayList();;
	
	public Integer getRevieweeId()
	{
		return revieweeId;
	}

	public void setRevieweeId(Integer revieweeId)
	{
		this.revieweeId = revieweeId;
	}

	public String getRevieweeName()
	{
		return revieweeName;
	}

	public void setRevieweeName(String revieweeName)
	{
		this.revieweeName = revieweeName;
	}

	public Integer getMaxRating()
	{
		return maxRating;
	}

	public void setMaxRating(Integer maxRating)
	{
		this.maxRating = maxRating;
	}

	public Integer getMinRating()
	{
		return minRating;
	}

	public void setMinRating(Integer minRating)
	{
		this.minRating = minRating;
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
		public AssessmentAreaReport(
				com.assess.service.entity.IndividualSummaryReport.AssessmentAreaReport aar)
		{
			assessmentAreaId = aar.getAssessmentArea().getAssessmentAreaId();
			assessmentAreaName = aar.getAssessmentArea().getAssessmentAreaName();
			
			List<com.assess.service.entity.IndividualSummaryReport.QuestionReport> qrs = aar.getQuestionReports();
			
			for (com.assess.service.entity.IndividualSummaryReport.QuestionReport qr : qrs)
			{
				m_questionReports.add(new QuestionReport(qr));
			}
			
		}

		private Integer assessmentAreaId;
		private String assessmentAreaName;
		
		private ReportRank m_rank;
		
		List<QuestionReport> m_questionReports = new ArrayList();

		public Integer getAssessmentAreaId()
		{
			return assessmentAreaId;
		}

		public void setAssessmentAreaId(Integer assessmentAreaId)
		{
			this.assessmentAreaId = assessmentAreaId;
		}

		public String getAssessmentAreaName()
		{
			return assessmentAreaName;
		}

		public void setAssessmentAreaName(String assessmentAreaName)
		{
			this.assessmentAreaName = assessmentAreaName;
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
		private Integer m_questionId;
		private String m_question;
		
		private ReportRank m_rank;

		public QuestionReport(com.assess.service.entity.IndividualSummaryReport.QuestionReport qr)
		{
			m_questionId = qr.getQuestion().getQuestionId();
			m_question = qr.getQuestion().getQuestion();
			
			m_rank = new ReportRank(qr.getSelfRanking(), qr.getManagerRanking(), qr.getDirectReportsRanking(), qr.getPeersRanking(), qr.getOthersRanking());
		}

		public Integer getQuestionId()
		{
			return m_questionId;
		}

		public void setQuestionId(Integer questionId)
		{
			m_questionId = questionId;
		}

		public String getQuestion()
		{
			return m_question;
		}

		public void setQuestion(String question)
		{
			m_question = question;
		}

		public ReportRank getRank()
		{
			return m_rank;
		}

		public void setRank(ReportRank rank)
		{
			m_rank = rank;
		}
		
	}
	

}
