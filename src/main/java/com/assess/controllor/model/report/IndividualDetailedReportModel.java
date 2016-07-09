package com.assess.controllor.model.report;

import java.util.List;


public class IndividualDetailedReportModel {
	
	private Integer revieweeId;
	private String revieweeName;
	
	private Integer maxRating;
	private Integer minRating;
	
	private List<QuestionWiseReport> m_questionWiseReports;
	
	public static class QuestionWiseReport
	{
		private Integer assessmentAreaId;
		private String assessmentAreaName;
		
		private Integer questionId;
		private String question;
		
		private  ReportRank m_rank;
	}
	
	

}
