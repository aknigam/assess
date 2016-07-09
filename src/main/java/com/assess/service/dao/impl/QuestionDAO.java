package com.assess.service.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import com.assess.service.dao.IQuestionDAO;
import com.assess.service.entity.MultipleChoice;
import com.assess.service.entity.Question;

@Component
public class QuestionDAO extends BaseDao implements IQuestionDAO, InitializingBean {

	private static final String P_DESIGNATION = "pdesignation";
	private static final String P_CUSTOMER = "pCustomer";
	private static final String P_QUESTION = "pquestion";
	private static final String P_QUESTIONTTYPE = "pquestionType";
	private static final String P_ASSESSMENTAREA = "pAssessmentarea";
	private static final String P_CHOICEA = "pchoiceA";
	private static final String P_CHOICEB = "pchoiceB";
	private static final String P_CHOICEC = "pchoiceC";
	private static final String P_CHOICED = "pchoiceD";
	private static final String P_CHOICEE = "pchoiceE";
	private static final String P_CHOICEF = "pchoiceF";
	private static final String P_CHOICEG = "pchoiceG";
	
	private static final String P_CHOICE_RATINGSCALEA = "pchoiceRatingScaleA";
	private static final String P_CHOICE_RATINGSCALEB = "pchoiceRatingScaleB";
	private static final String P_CHOICE_RATINGSCALEC = "pchoiceRatingScaleC";
	private static final String P_CHOICE_RATINGSCALED = "pchoiceRatingScaleD";
	private static final String P_CHOICE_RATINGSCALEE = "pchoiceRatingScaleE";
	private static final String P_CHOICE_RATINGSCALEF = "pchoiceRatingScaleF";
	private static final String P_CHOICE_RATINGSCALEG = "pchoiceRatingScaleG";

	private static Logger LOGGER  = Logger.getLogger(QuestionDAO.class);
	
	private static String m_insertQuestionQuery = "INSERT INTO QUESTION (designationId, refQuestionTypeId, CustomerId, Question)" +
														" values (?,?,?,?)";
	
	private static String m_insertMultipleChoiceQuery = "INSERT INTO MultipleChoice (questionid, answer, sequence) values (?,?,?)";

	@Autowired
	@Qualifier("assessdataSource")
	private DataSource m_dataSource;
	
	private SimpleJdbcCall m_QuestionAddSproc;
	
	@Override
	public void afterPropertiesSet() throws Exception {
		m_QuestionAddSproc = new SimpleJdbcCall(m_dataSource);
		m_QuestionAddSproc = new SimpleJdbcCall(m_dataSource);
		m_QuestionAddSproc.useInParameterNames(
				 P_DESIGNATION
				,P_CUSTOMER
				,P_QUESTION
				,P_QUESTIONTTYPE
				,P_ASSESSMENTAREA
				,P_CHOICEA
				,P_CHOICEB
				,P_CHOICEC
				,P_CHOICED
				,P_CHOICEE
				,P_CHOICEF
				,P_CHOICEG
				,P_CHOICE_RATINGSCALEA
				,P_CHOICE_RATINGSCALEB
				,P_CHOICE_RATINGSCALEC
				,P_CHOICE_RATINGSCALED
				,P_CHOICE_RATINGSCALEE
				,P_CHOICE_RATINGSCALEF
				,P_CHOICE_RATINGSCALEG
				)
		.declareParameters(
				new SqlParameter(P_DESIGNATION, Types.VARCHAR),
				new SqlParameter(P_CUSTOMER, Types.VARCHAR),
				new SqlParameter(P_QUESTION, Types.VARCHAR),
				new SqlParameter(P_QUESTIONTTYPE, Types.VARCHAR),
				new SqlParameter(P_ASSESSMENTAREA, Types.VARCHAR),
				new SqlParameter(P_CHOICEA, Types.VARCHAR),
				new SqlParameter(P_CHOICEB, Types.VARCHAR),
				new SqlParameter(P_CHOICEC, Types.VARCHAR),
				new SqlParameter(P_CHOICED, Types.VARCHAR),
				new SqlParameter(P_CHOICEE, Types.VARCHAR),
				new SqlParameter(P_CHOICEF, Types.VARCHAR),
				new SqlParameter(P_CHOICEG, Types.VARCHAR),
				new SqlParameter(P_CHOICE_RATINGSCALEA, Types.VARCHAR),
				new SqlParameter(P_CHOICE_RATINGSCALEB, Types.VARCHAR),
				new SqlParameter(P_CHOICE_RATINGSCALEC, Types.VARCHAR),
				new SqlParameter(P_CHOICE_RATINGSCALED, Types.VARCHAR),
				new SqlParameter(P_CHOICE_RATINGSCALEE, Types.VARCHAR),
				new SqlParameter(P_CHOICE_RATINGSCALEF, Types.VARCHAR),
				new SqlParameter(P_CHOICE_RATINGSCALEG, Types.VARCHAR)
		)
		.withProcedureName("QuestionAdd")
		.withoutProcedureColumnMetaDataAccess();
	}

	@Override
	public void addQuestions(List<Question> questions) {

		StringBuilder s= new StringBuilder();
		try {

			for (Question q : questions) {
				try{
					MapSqlParameterSource in = new MapSqlParameterSource();
					in.addValue(P_DESIGNATION, q.getDesignation().getName());
					in.addValue(P_CUSTOMER, q.getCustomer().getCustomerName());
					in.addValue(P_QUESTION, q.getQuestion());
					in.addValue(P_QUESTIONTTYPE, q.getQuestionTypeEnum().name());
					in.addValue(P_ASSESSMENTAREA, q.getAssessmentArea().getAssessmentAreaName());

					String choiceA = null;
					String choiceB = null;
					String choiceC = null;
					String choiceD = null;
					String choiceE = null;
					String choiceF = null;
					String choiceG = null;
					String choiceRatingScaleA = null;
					String choiceRatingScaleB = null;
					String choiceRatingScaleC = null;
					String choiceRatingScaleD = null;
					String choiceRatingScaleE = null;
					String choiceRatingScaleF = null;
					String choiceRatingScaleG = null;
					List<MultipleChoice> choices = q.getChoices();
					int noOfChoices = q.getChoices().size();

					if(noOfChoices >= 1)	
					{
						MultipleChoice mc = choices.get(0);
						choiceA = mc.getAnswer();
						choiceRatingScaleA = mc.getRatingScale().getName();

					}
					if(noOfChoices >= 2)
					{
						MultipleChoice mc = choices.get(1);
						choiceB = mc.getAnswer();
						choiceRatingScaleB = mc.getRatingScale().getName();

					}
					if(noOfChoices >= 3)
					{
						MultipleChoice mc = choices.get(2);
						choiceC = mc.getAnswer();
						choiceRatingScaleC = mc.getRatingScale().getName();	
					}

					if(noOfChoices >= 4)
					{
						MultipleChoice mc = choices.get(3);
						choiceD = mc.getAnswer();
						choiceRatingScaleD = mc.getRatingScale().getName();	
					}

					if(noOfChoices >= 5)
					{
						MultipleChoice mc = choices.get(4);
						choiceE = mc.getAnswer();
						choiceRatingScaleE = mc.getRatingScale().getName();	
					}

					if(noOfChoices >= 6)
					{
						MultipleChoice mc = choices.get(5);
						choiceF = mc.getAnswer();
						choiceRatingScaleF = mc.getRatingScale().getName();	
					}

					if(noOfChoices >= 7)
					{
						MultipleChoice mc = choices.get(6);
						choiceG = mc.getAnswer();
						choiceRatingScaleG = mc.getRatingScale().getName();	
					}

					in.addValue(P_CHOICEA, choiceA);
					in.addValue(P_CHOICEB, choiceB);
					in.addValue(P_CHOICEC, choiceC);
					in.addValue(P_CHOICED, choiceD);
					in.addValue(P_CHOICEE, choiceE);
					in.addValue(P_CHOICEF, choiceF);
					in.addValue(P_CHOICEG, choiceG);

					in.addValue(P_CHOICE_RATINGSCALEA, choiceRatingScaleA);
					in.addValue(P_CHOICE_RATINGSCALEB, choiceRatingScaleB);
					in.addValue(P_CHOICE_RATINGSCALEC, choiceRatingScaleC);
					in.addValue(P_CHOICE_RATINGSCALED, choiceRatingScaleD);
					in.addValue(P_CHOICE_RATINGSCALEE, choiceRatingScaleE);
					in.addValue(P_CHOICE_RATINGSCALEF, choiceRatingScaleF);
					in.addValue(P_CHOICE_RATINGSCALEG, choiceRatingScaleG);
					System.out.println(q);
					s.append(in.getValues()).append("\n");
					m_QuestionAddSproc.execute(in);
				} catch (DataAccessException e) {
					System.out.println(s);
					e.printStackTrace();
					throw e;
				}
			}

		} catch (DataAccessException e) {
			System.out.println(s);
			e.printStackTrace();
			throw e;
		}

	

		System.out.println("Done");
		
	}
	
	public void addQuestionsOld(List<Question> questions) {
		
		
		for (final Question question : questions) {
			
			
			KeyHolder keyHolder = new GeneratedKeyHolder();
			m_assessDbTemplate.update(
			    new PreparedStatementCreator() {
			        public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
			            PreparedStatement ps =
			                connection.prepareStatement(m_insertQuestionQuery, new String[] {"id"});
			            ps.setInt(1, question.getDesignationid());
			            ps.setInt(2, question.getQuestionTypeEnum().getId());
			            ps.setInt(3, question.getCustomerId());
			            ps.setString(4, question.getQuestion());
			            LOGGER.info(ps);
			            return ps;
			        }
			        
			    },
			    keyHolder);
			
			final Integer questionId = keyHolder.getKey().intValue();
			
			List<MultipleChoice> choices = question.getChoices();
			if(choices == null || choices.isEmpty())
			{
				continue;
			}
			for (final MultipleChoice choice : choices) {

				m_assessDbTemplate.update(m_insertMultipleChoiceQuery, new PreparedStatementSetter() {

					@Override
					public void setValues(PreparedStatement ps) throws SQLException {
						ps.setInt(1, questionId);
						ps.setString(2, choice.getAnswer());
						ps.setInt(3, choice.getSequesnce());
					}
				});
			}
			System.out.println("Question added...");

		}
		
		
		
		
	}


}

