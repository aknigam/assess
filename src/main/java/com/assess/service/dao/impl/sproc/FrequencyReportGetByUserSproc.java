package com.assess.service.dao.impl.sproc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;

import com.assess.controllor.model.report.FrequencyReportModel;
import com.assess.controllor.model.report.FrequencyReportModel.FrequencyReportCategory;


public class FrequencyReportGetByUserSproc
{
	private static final String P_USER_ID = "userId";
	
	private SimpleJdbcCall m_FrequencyReportGetByUserSproc;
	
	public FrequencyReportGetByUserSproc(DataSource dataSource)
	{
		
		m_FrequencyReportGetByUserSproc = new SimpleJdbcCall(dataSource);
		m_FrequencyReportGetByUserSproc.useInParameterNames(P_USER_ID)
		.declareParameters(
				new SqlParameter(P_USER_ID, Types.INTEGER)
				)
				.withProcedureName("FrequencyReportGetByUser")
				.withoutProcedureColumnMetaDataAccess()
				.returningResultSet("selffrequencyreport", new FrequencyReportRowMapper())
				.returningResultSet("managerfrequencyreport", new FrequencyReportRowMapper())
				.returningResultSet("othersfrequencyreport", new FrequencyReportRowMapper())
				.returningResultSet("peersfrequencyreport", new FrequencyReportRowMapper())
				.returningResultSet("directreportsfrequencyreport", new FrequencyReportRowMapper());
	}
	

	static class FrequencyReportRowMapper implements RowMapper<FrequencyRow>
	{
		@Override
		public FrequencyRow mapRow(ResultSet rs, int i) throws SQLException
		{
			
			int multipleChoiceId = rs.getInt("MultipleChoiceId");
			String answer = rs.getString("Answer");
			int qId = rs.getInt("questionId");
			String question = rs.getString("Question");
			int frequency = rs.getInt("NoOfReviewers");
			
			return new FrequencyRow(multipleChoiceId, answer, qId, question, frequency);
			
		}
		
	}
	
	static class FrequencyRow
	{
		Integer m_multipleChoiceId;
		String m_answer;
		Integer m_questionId;
		String m_question;
		Integer m_frequency;
		
		
		public FrequencyRow(int multipleChoiceId, String answer, int qId, String question,
				int frequency)
		{
			m_multipleChoiceId = multipleChoiceId;
			m_answer = answer;
			m_questionId = qId;
			m_question = question;
			m_frequency = frequency;
			
			
		}
		public Integer getMultipleChoiceId()
		{
			return m_multipleChoiceId;
		}
		public String getAnswer()
		{
			return m_answer;
		}
		public Integer getQuestionId()
		{
			return m_questionId;
		}
		public String getQuestion()
		{
			return m_question;
		}
		public Integer getFrequency()
		{
			return m_frequency;
		}

	}


	public FrequencyReportModel getFrequencies(Integer userId)
	{
		MapSqlParameterSource in = new MapSqlParameterSource()
		.addValue("userId", userId);
		Map<String, Object> out = m_FrequencyReportGetByUserSproc.execute(in);
		FrequencyReportModel model = new FrequencyReportModel(userId);
		
		model.setSelf(getFrequncyReportCategoryList((List<FrequencyRow>) out.get("selffrequencyreport")));
		model.setManager(getFrequncyReportCategoryList((List<FrequencyRow>) out.get("managerfrequencyreport")));
		model.setOthers(getFrequncyReportCategoryList((List<FrequencyRow>) out.get("othersfrequencyreport")));
		model.setPeers(getFrequncyReportCategoryList((List<FrequencyRow>) out.get("peersfrequencyreport")));
		model.setDirectReports(getFrequncyReportCategoryList((List<FrequencyRow>) out.get("directreportsfrequencyreport")));
		
		
		return model;
	}


	private List<FrequencyReportCategory> getFrequncyReportCategoryList(
			List<FrequencyRow> selfFrequency)
	{
		List<FrequencyReportCategory> frcs =  new ArrayList();
		Map<Integer,FrequencyReportCategory> frcsMap = new HashMap();
		
		Integer questionId;
		String question;
		Integer frequency;
		for (FrequencyRow row : selfFrequency)
		{
			questionId = row.getQuestionId();
			question = row.getQuestion();
			FrequencyReportCategory category = frcsMap.get(questionId);
			if(category == null)
			{
				category = new FrequencyReportCategory(questionId , question);
				frcsMap.put(questionId, category);
				frcs.add(category);
			}
			frequency = row.getFrequency()== null ? 0:row.getFrequency();
			category.getFrequencyMap().put(row.getAnswer(),frequency );
		}
		
		for (FrequencyReportCategory frequencyReportCategory : frcs)
		{
			frequencyReportCategory.setFrequencyMap(frequencyReportCategory.getFrequencyMap());
		}
		return frcs;
	}

}
