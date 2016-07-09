package com.assess.service.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Component;

import com.assess.controllor.model.report.FrequencyReportModel;
import com.assess.service.dao.IReportDAO;
import com.assess.service.dao.impl.sproc.FrequencyReportGetByUserSproc;
import com.assess.service.entity.AppUser;
import com.assess.service.entity.AssessmentArea;
import com.assess.service.entity.ComparativeReport;
import com.assess.service.entity.IndividualSummaryReport;
import com.assess.service.entity.IndividualSummaryReport.AssessmentAreaReport;
import com.assess.service.entity.IndividualSummaryReport.QuestionReport;
import com.assess.service.entity.Question;

@Component
public class ReportDAO implements IReportDAO , InitializingBean
{

	private static final String P_USER_ID = "userId";

	private SimpleJdbcCall m_IndividualSummaryReportGetSproc;
	
	private FrequencyReportGetByUserSproc m_frequencyReportGetByUserSproc;
	
//	private DetailedReportGetByUserSproc m_detailedReportGetByUserSproc;
	
	@Autowired
	@Qualifier("assessdataSource")
	private DataSource m_dataSource;
	
	@Override
	public void afterPropertiesSet() throws Exception
	{
		
		m_frequencyReportGetByUserSproc = new FrequencyReportGetByUserSproc(m_dataSource);
		m_IndividualSummaryReportGetSproc = new SimpleJdbcCall(m_dataSource);
		m_IndividualSummaryReportGetSproc
		//        .withCatalogName(STERLING_DB_TRANSACTION_CATALOG)
		.useInParameterNames(P_USER_ID)
		.declareParameters(
				new SqlParameter(P_USER_ID, Types.INTEGER)
				)
				.withProcedureName("IndividualSummaryReportGet")
				.withoutProcedureColumnMetaDataAccess()
				.returningResultSet("self", new RankingRSMapper())
				.returningResultSet("manager", new RankingRSMapper())
				.returningResultSet("others", new RankingRSMapper())
				.returningResultSet("peers", new RankingRSMapper())
				.returningResultSet("directReports", new RankingRSMapper())
				.returningResultSet("questionDetails", new RowMapper<QuestionDetails>()
						{

					@Override
					public QuestionDetails mapRow(ResultSet rs, int i) throws SQLException
					{
						return new QuestionDetails(rs.getInt("questionId"), rs.getString("Question"), rs.getInt("AssessmentAreaId"), rs.getString("AssessmentAreaName"));
					}});		
	}


	public FrequencyReportModel getFrequencyReport(Integer userId)
	{
		MapSqlParameterSource in = new MapSqlParameterSource()
		.addValue("userId", userId);
		FrequencyReportModel out =  m_frequencyReportGetByUserSproc.getFrequencies(userId);
		
		return out;
		
		
	}
	
	@Override
	public IndividualSummaryReport getIndividualSummaryReport(Integer userId)
	{

		MapSqlParameterSource in = new MapSqlParameterSource()
		.addValue("userId", userId);
		Map<String, Object> out = m_IndividualSummaryReportGetSproc.execute(in);

		List<QuestionDetails> questionDetails = (List<QuestionDetails>) out.get("questionDetails");
		
		IndividualSummaryReport report = new IndividualSummaryReport();
		report.setUser(new AppUser(userId));
		
		Map<Integer, AssessmentAreaReport> aaMap = new HashMap();
		Map<Integer, QuestionReport> aaqMap = new HashMap();
		
		for (QuestionDetails qd : questionDetails)
		{
			List<AssessmentAreaReport> aars = report.getAssessmentAreaReports();
			
			AssessmentAreaReport aar = aaMap.get(qd.getAssessmentAreaId());
			if(aar == null)
			{
				aar = new AssessmentAreaReport();
				aar.setAssessmentArea(new AssessmentArea(qd.getAssessmentAreaId(), qd.getAssessmentAreaname()));
				aaMap.put(qd.getAssessmentAreaId() , aar);
				
				aars.add(aar);
			}
			
			List<QuestionReport> qrs = aar.getQuestionReports();
			
			QuestionReport qr = aaqMap.get(qd.getQuestionId());
			if(qr == null)
			{
				qr = new QuestionReport();
				Question q = new Question(qd.getQuestionId());
				q.setQuestion(qd.getQuestion());
				qr.setQuestion(q);
				
				aaqMap.put(qd.getQuestionId(), qr);
				qrs.add(qr);
			}
			
		}

		List<QuestionRank> sranks = (List<QuestionRank>) out.get("self");
		for (QuestionRank r : sranks)
		{
			QuestionReport qr = aaqMap.get(r.getQuestionId());
			qr.setSelfRanking(r.getRank());
		}
		
		List<QuestionRank> mranks = (List<QuestionRank>) out.get("manager");
		for (QuestionRank r : mranks)
		{
			QuestionReport qr = aaqMap.get(r.getQuestionId());
			qr.setManagerRanking(r.getRank());
		}
		
		List<QuestionRank> oranks = (List<QuestionRank>) out.get("others");
		for (QuestionRank r : oranks)
		{
			QuestionReport qr = aaqMap.get(r.getQuestionId());
			qr.setOthersRanking(r.getRank());
		}
		
		List<QuestionRank> pranks = (List<QuestionRank>) out.get("peers");
		for (QuestionRank r : pranks)
		{
			QuestionReport qr = aaqMap.get(r.getQuestionId());
			qr.setPeersRanking(r.getRank());
		}
		
		List<QuestionRank> dranks = (List<QuestionRank>) out.get("directReports");
		for (QuestionRank r : dranks)
		{
			QuestionReport qr = aaqMap.get(r.getQuestionId());
			qr.setDirectReportsRanking(r.getRank());
		}

		addQuestionRanks(aaqMap, sranks);


		return report;
	}
	
	private void addQuestionRanks(Map<Integer, QuestionReport> aaqMap, List<QuestionRank> ranks)
	{
		
	}

	static class RankingRSMapper implements RowMapper<QuestionRank>
	{

		@Override
		public QuestionRank mapRow(ResultSet rs, int i) throws SQLException
		{
			return new QuestionRank(rs.getInt(1), rs.getFloat(2));
		}
		
	}
	
	static class QuestionRank
	{
		private int m_questionId;
		public int getQuestionId()
		{
			return m_questionId;
		}

		public void setQuestionId(int questionId)
		{
			m_questionId = questionId;
		}

		private float m_rank;
		
		public float getRank()
		{
			return m_rank;
		}

		public void setRank(float rank)
		{
			m_rank = rank;
		}

		public QuestionRank(int questionId, float rank)
		{
			m_questionId = questionId;
			m_rank = rank;
		}
		
		@Override
		public String toString()
		{
			return m_questionId+"-"+m_rank;
		}
		
	}
	
	static class QuestionDetails
	{
		private int m_questionId;
		private int m_assessmentAreaId;
		private String m_assessmentAreaname;
		private String m_question;
		
		public QuestionDetails(int questionId, String question, int aaId, String aaName)
		{
			m_questionId = questionId;
			m_question = question;
			m_assessmentAreaId = aaId;
			m_assessmentAreaname = aaName;
			
		}
		public int getQuestionId()
		{
			return m_questionId;
		}
		public void setQuestionId(int questionId)
		{
			m_questionId = questionId;
		}
		public int getAssessmentAreaId()
		{
			return m_assessmentAreaId;
		}
		public void setAssessmentAreaId(int assessmentAreaId)
		{
			m_assessmentAreaId = assessmentAreaId;
		}
		public String getAssessmentAreaname()
		{
			return m_assessmentAreaname;
		}
		public void setAssessmentAreaname(String assessmentAreaname)
		{
			m_assessmentAreaname = assessmentAreaname;
		}
		public String getQuestion()
		{
			return m_question;
		}
		public void setQuestion(String question)
		{
			m_question = question;
		}
		
	}

	@Override
	public ComparativeReport getComparativeReport(Integer userId)
	{
		// TODO anigam Auto-generated method stub
		return null;
	}


	@Override
	public void getIndividualDetailedReport(Integer userId) {
		
	}
	


}
