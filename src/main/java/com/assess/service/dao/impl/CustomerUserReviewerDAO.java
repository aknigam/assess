
package com.assess.service.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.sql.DataSource;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import com.assess.form.FeedbackSearchForm;
import com.assess.form.NominateReviewersForm;
import com.assess.service.AppRoleEnum;
import com.assess.service.QuestionTypeEnum;
import com.assess.service.RefFeedbackStatusEnum;
import com.assess.service.dao.ICustomerUserReviewerDAO;
import com.assess.service.dao.util.DBQueryUtil;
import com.assess.service.entity.AppUser;
import com.assess.service.entity.AssessmentArea;
import com.assess.service.entity.CustomerUserReviewer;
import com.assess.service.entity.Designation;
import com.assess.service.entity.EmployeeFeedbackAnswer;
import com.assess.service.entity.MultipleChoice;
import com.assess.service.entity.MultipleChoiceAnswer;
import com.assess.service.entity.Question;

@Component
public class CustomerUserReviewerDAO extends BaseDao implements ICustomerUserReviewerDAO,
		InitializingBean
{

	// get the data from CustomerUserReviewer table where userId is the reviewer
	private static String m_revieweesListQuery = " select cer.AppUserreviewerid, "
			+ " ur.AppuserId, ur.name, ur.email ,"
			+ " ul.AppuserId as reviewerId, ul.name as reviewerName, ul.email as reviewerEmail , "
			+ " dr.name as reviewerDesignationName, " + " rfs.RefFeedbackStatusName, "
			+ " d.name as designationName " + " from CustomerUserReviewer cer "
			+ " join AppUser ul on ul.AppUserId = cer.reviewerId"
			+ " join AppUser ur on ur.AppUserId = cer.RevieweeId "
			+ " join Designation d on d.designationId =  ur.designationId "
			+ " join Designation dr on dr.designationId =  ul.designationId "
			+ " join RefFeedbackStatus rfs on rfs.RefFeedbackStatusId = cer.FeedbackStatusId ";
	// " where ul.AppUserId =  ? order by ur.AppuserId";

	private static String m_queryToGetUserRole = "select appRoleId from AppUser where appUserid  = ?";

	private String m_insertQuery = "INSERT INTO CustomerUserReviewer (ReviewerId, RevieweeId, NominatedBy ,FeedbackStatusId) VALUES (?,?, ?,?)";

	private static final String P_REVIEWER_Id = "pReviewerId";
	private static final String P_REVIEWEE_ID = "pRevieweeId";
	private static final String P_NOMINATEDBY_ID = "pNominatedById";
	private static final String P_FEEDBACK_STATUS = "FeedbackStatusId";

	@Autowired
	@Qualifier("assessdataSource")
	private DataSource m_dataSource;

	private SimpleJdbcCall m_CustomerUserReviewerByIdAddSproc;

	@Override
	public void afterPropertiesSet() throws Exception
	{

		m_CustomerUserReviewerByIdAddSproc = new SimpleJdbcCall(m_dataSource);
		m_CustomerUserReviewerByIdAddSproc
				.useInParameterNames(P_REVIEWER_Id, P_REVIEWEE_ID, P_NOMINATEDBY_ID,
						P_FEEDBACK_STATUS)
				.declareParameters(new SqlParameter(P_REVIEWER_Id, Types.VARCHAR),
						new SqlParameter(P_REVIEWEE_ID, Types.VARCHAR),
						new SqlParameter(P_NOMINATEDBY_ID, Types.VARCHAR),
						new SqlParameter(P_FEEDBACK_STATUS, Types.INTEGER))
				.withProcedureName("CustomerUserReviewerByIdAdd")
				.withoutProcedureColumnMetaDataAccess();
	}

	private String buildQuery(Integer userId, int roleId, FeedbackSearchForm sf, List<Object> args)
	{

		StringBuilder revieweesListQuery = new StringBuilder();

		revieweesListQuery.append(m_revieweesListQuery);
		DBQueryUtil dbQueryUtil = new DBQueryUtil();

		if (roleId == AppRoleEnum.USER.getId())
		{
			dbQueryUtil.addIntCondition("ul.AppUserId", userId, revieweesListQuery, args);
		}
		dbQueryUtil.addIntCondition("rfs.RefFeedbackStatusId", sf.getStatus(), revieweesListQuery,
				args);

		dbQueryUtil.addIntCondition("d.designationId", sf.getRevieweeDesignation(),
				revieweesListQuery, args);
		dbQueryUtil.addStringCondition("ur.email", sf.getRevieweeEmail(), revieweesListQuery, args);
		dbQueryUtil.addStringCondition("ur.name", sf.getRevieweeName(), revieweesListQuery, args);

		dbQueryUtil.addIntCondition("dr.designationId", sf.getReviewerDesignation(),
				revieweesListQuery, args);
		dbQueryUtil.addStringCondition("ul.email", sf.getReviewerEmail(), revieweesListQuery, args);
		dbQueryUtil.addStringCondition("ul.name", sf.getReviewerName(), revieweesListQuery, args);

		return revieweesListQuery.toString();
	}

	@Override
	public List<CustomerUserReviewer> getListOfReviews(Integer userId)
	{

		int roleId = m_assessDbTemplate.queryForInt(m_queryToGetUserRole, new Integer[] { userId });

		String revieweesListQuery = m_revieweesListQuery;

		Object[] args = null;
		if (roleId == AppRoleEnum.USER.getId())
		{
			revieweesListQuery = revieweesListQuery + " where ul.AppUserId =  ?";
			args = new Integer[] { userId };
		}

		List<CustomerUserReviewer> curs = null;
		try
		{
			curs = m_assessDbTemplate.query(revieweesListQuery, args,
					new RowMapper<CustomerUserReviewer>()
						{

							@Override
							public CustomerUserReviewer mapRow(ResultSet rs, int i)
									throws SQLException
							{

								CustomerUserReviewer cur = new CustomerUserReviewer();

								int feedbackId = rs.getInt("AppUserreviewerid");
								int revieweeId = rs.getInt("AppuserId");
								String revieweeName = rs.getString("name");
								String revieweeEmail = rs.getString("email");
								String refFeedbackStatusName = rs
										.getString("RefFeedbackStatusName");
								String designationName = rs.getString("designationName");

								// " ul.AppuserId as reviewerId, ul.name as reviewerName, ul.email as reviewerEmail ,"
								// +

								int reviewerId = rs.getInt("reviewerId");
								String reviewerName = rs.getString("reviewerName");
								String reviewerEmail = rs.getString("reviewerEmail");
								String reviewerDesignationName = rs
										.getString("reviewerDesignationName");

								cur.setAppUserReviewerId(feedbackId);
								cur.setRevieweeId(revieweeId);
								AppUser reviewee = new AppUser();
								reviewee.setAppUserId(revieweeId);
								reviewee.setName(revieweeName);
								reviewee.setEmail(revieweeEmail);
								reviewee.setDesignation(new Designation(designationName));
								cur.setReviewee(reviewee);

								AppUser reviewer = new AppUser();
								reviewer.setAppUserId(revieweeId);
								reviewer.setName(reviewerName);
								reviewer.setEmail(reviewerEmail);
								reviewer.setDesignation(new Designation(reviewerDesignationName));
								cur.setReviewer(reviewer);

								cur.setFeedbackStatus(refFeedbackStatusName);

								return cur;
							}
						});
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return null;
		}

		return curs;
	}

	@Override
	public List<CustomerUserReviewer> getListOfReviews(Integer userId, FeedbackSearchForm searchForm)
	{

		int roleId = m_assessDbTemplate.queryForInt(m_queryToGetUserRole, new Integer[] { userId });

		String revieweesListQuery = m_revieweesListQuery;

		// if(roleId == AppRoleEnum.USER.getId())
		// {
		// revieweesListQuery = revieweesListQuery + " where ul.AppUserId =  ?";
		// args = new Integer[]{userId};
		// }
		List<Object> argsList = new ArrayList();
		revieweesListQuery = buildQuery(userId, roleId, searchForm, argsList);

		System.out.println(revieweesListQuery);

		Object[] args = argsList.toArray();
		List<CustomerUserReviewer> curs = null;
		try
		{
			curs = m_assessDbTemplate.query(revieweesListQuery, args,
					new RowMapper<CustomerUserReviewer>()
						{

							@Override
							public CustomerUserReviewer mapRow(ResultSet rs, int i)
									throws SQLException
							{

								CustomerUserReviewer cur = new CustomerUserReviewer();

								int feedbackId = rs.getInt("AppUserreviewerid");
								int revieweeId = rs.getInt("AppuserId");
								String revieweeName = rs.getString("name");
								String revieweeEmail = rs.getString("email");
								String refFeedbackStatusName = rs
										.getString("RefFeedbackStatusName");
								String designationName = rs.getString("designationName");

								// " ul.AppuserId as reviewerId, ul.name as reviewerName, ul.email as reviewerEmail ,"
								// +

								int reviewerId = rs.getInt("reviewerId");
								String reviewerName = rs.getString("reviewerName");
								String reviewerEmail = rs.getString("reviewerEmail");
								String reviewerDesignationName = rs
										.getString("reviewerDesignationName");

								cur.setAppUserReviewerId(feedbackId);
								cur.setRevieweeId(revieweeId);
								AppUser reviewee = new AppUser();
								reviewee.setAppUserId(revieweeId);
								reviewee.setName(revieweeName);
								reviewee.setEmail(revieweeEmail);
								reviewee.setDesignation(new Designation(designationName));
								cur.setReviewee(reviewee);

								AppUser reviewer = new AppUser();
								reviewer.setAppUserId(revieweeId);
								reviewer.setName(reviewerName);
								reviewer.setEmail(reviewerEmail);
								reviewer.setDesignation(new Designation(reviewerDesignationName));
								cur.setReviewer(reviewer);

								cur.setFeedbackStatus(refFeedbackStatusName);

								return cur;
							}
						});
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return null;
		}

		return curs;

	}

	// Query to get the questions and answers in the feedback.
	private static String questionsQuery = " select  "
			+ "	efa.EmployeeFeedbackAnswerId as AppUserFeedbackAnswerId, "
			+ " 	cur.AppUserReviewerId, "
			+ "	cur.RevieweeId, "
			+ "	au.designationid, "
			+ " 	q.questionId,  "
			+ " 	q.refQuestionTypeid,  "
			+ " 	q.Question,  "
			+ " 	mc.MultipleChoiceId,  "
			+ " 	mc.Answer,  "
			+ " 	mc.Sequence , "
			+ " 	efa.DescriptiveAnswer, "
			+ " 	mca.MultipleChoiceId as MultipleChoiceAnswerId,  "
			+ "   aa.assessmentAreaName as assessmentAreaName, "
			+ " 	aap.assessmentAreaName as parentAssessmentAreaName "
			+ " from CustomerUserReviewer cur "
			+ " join AppUser au on au.AppUserId = cur.RevieweeId "
			+ " join Designation d on d.designationid = au.designationid "
			+ " join Question q on q.designationid = au.designationid "
			+ " join AssessmentArea aa on q.assessmentAreaid = aa.assessmentAreaid "
			+ " join AssessmentArea aap on aap.assessmentAreaid = aa.parentassessmentAreaid  "
			+ " left join MultipleChoice mc on mc.questionid = q.questionid "
			+ " left join EmployeeFeedbackAnswer efa on efa.questionid = q.questionid and efa.AppUserReviewerId = cur.AppUserReviewerId"
			+ " left join MultipleChoiceAnswer mca  on mca.EmployeeFeedbackAnswerId = efa.EmployeeFeedbackAnswerId "
			+ " where cur.AppUserReviewerId = ? "
			+ " order by refQuestionTypeId desc, aap.assessmentAreaName, aa.assessmentAreaName , q.question  ";

	@Override
	public CustomerUserReviewer getFeedbackQuestionnaire(Integer feedbackId)
	{

		Object[] args = new Integer[] { feedbackId };
		final CustomerUserReviewer cur = new CustomerUserReviewer(feedbackId);
		final AppUser appUser = new AppUser();
		cur.setReviewee(appUser);

		final Map<Integer, Question> questionMap = new HashMap();

		final Map<Integer, EmployeeFeedbackAnswer> questionAnswereMap = new HashMap();

		m_assessDbTemplate.query(questionsQuery, args, new RowMapper<CustomerUserReviewer>()
			{

				@Override
				public CustomerUserReviewer mapRow(ResultSet rs, int i) throws SQLException
				{

					Integer appUserFeedbackAnswerId = rs.getInt("AppUserFeedbackAnswerId");
					Integer appUserReviewerId = rs.getInt("AppUserReviewerId");
					Integer revieweeId = rs.getInt("RevieweeId");
					Integer designationId = rs.getInt("designationid");
					Integer questionId = rs.getInt("questionId");
					Integer refQuestionTypeid = rs.getInt("refQuestionTypeid");
					String questionCintent = rs.getString("Question");
					Integer multipleChoiceId = rs.getInt("MultipleChoiceId");
					String mcAnswer = rs.getString("Answer");
					Integer sequence = rs.getInt("Sequence");

					String descriptiveAnswer = rs.getString("DescriptiveAnswer");
					Integer multipleChoiceAnswerId = rs.getInt("MultipleChoiceAnswerId");

					String assessmentArea = rs.getString("assessmentAreaName");
					String parentAssessmentArea = rs.getString("parentAssessmentAreaName");

					if (appUser.getAppUserId() == null)
					{
						appUser.setAppUserId(revieweeId);
						appUser.setDesignation(new Designation(designationId));
						cur.setReviewee(appUser);

					}
					Designation designation = appUser.getDesignation();
					List<Question> questions = designation.getQuestions();

					Question question = getQuestionFromMap(questionId, questionMap,
							questionCintent, refQuestionTypeid, questions, assessmentArea,
							parentAssessmentArea);
					appUser.getDesignation().getQuestions();
					QuestionTypeEnum questionTypeEnum = question.getQuestionTypeEnum();

					if (questionTypeEnum == QuestionTypeEnum.MULTIPLE_CHOICE)
					{
						MultipleChoice mc = new MultipleChoice(multipleChoiceId, questionId,
								mcAnswer, sequence);
						mc.setQuestion(question);
						question.getChoices().add(mc);

						if (multipleChoiceAnswerId != null
								&& questionAnswereMap.get(questionId) == null)
						{
							EmployeeFeedbackAnswer efa = new EmployeeFeedbackAnswer(
									appUserReviewerId, questionId, descriptiveAnswer);
							efa.setQuestion(question);
							cur.getEmployeeFeedbackAnswers().add(efa);

							MultipleChoiceAnswer mca = new MultipleChoiceAnswer(
									appUserFeedbackAnswerId, multipleChoiceAnswerId);
							efa.setMultipleChoiceAnswer(mca);

							questionAnswereMap.put(questionId, efa);
							System.out.println(questionAnswereMap);

						}

					}
					else if (questionAnswereMap.get(questionId) == null)
					{

						EmployeeFeedbackAnswer efa = new EmployeeFeedbackAnswer(appUserReviewerId,
								questionId, descriptiveAnswer);
						efa.setQuestion(question);
						cur.getEmployeeFeedbackAnswers().add(efa);
						questionAnswereMap.put(questionId, efa);
						System.out.println(questionAnswereMap);
					}

					return cur;
				}
			});
		System.out.println(questionAnswereMap);
		System.out.println(questionAnswereMap);
		return cur;
	}

	// Query to get the questions and answers in the feedback.
	private static String questionsQueryForSelfreview = " select  "
			+ "	efa.EmployeeFeedbackAnswerId as AppUserFeedbackAnswerId, "
			+ " 	cur.AppUserReviewerId, "
			+ "	cur.RevieweeId, "
			+ "	au.designationid, "
			+ " 	q.questionId,  "
			+ " 	q.refQuestionTypeid,  "
			+ " 	q.Question,  "
			+ " 	mc.MultipleChoiceId,  "
			+ " 	mc.Answer,  "
			+ " 	mc.Sequence , "
			+ " 	efa.DescriptiveAnswer, "
			+ " 	mca.MultipleChoiceId as MultipleChoiceAnswerId,  "
			+ "   aa.assessmentAreaName as assessmentAreaName, "
			+ " 	aap.assessmentAreaName as parentAssessmentAreaName "
			+ " from CustomerUserReviewer cur "
			+ " join AppUser au on au.AppUserId = cur.RevieweeId "
			+ " join Designation d on d.designationid = au.designationid "
			+ " join Question q on q.designationid = au.designationid "
			+ " join AssessmentArea aa on q.assessmentAreaid = aa.assessmentAreaid "
			+ " join AssessmentArea aap on aap.assessmentAreaid = aa.parentassessmentAreaid  "
			+ " left join MultipleChoice mc on mc.questionid = q.questionid "
			+ " left join EmployeeFeedbackAnswer efa on efa.questionid = q.questionid and efa.AppUserReviewerId = cur.AppUserReviewerId"
			+ " left join MultipleChoiceAnswer mca  on mca.EmployeeFeedbackAnswerId = efa.EmployeeFeedbackAnswerId "
			+ " where cur.RevieweeId = ? and cur.reviewerId = ? "
			+ " order by refQuestionTypeId desc, aap.assessmentAreaName, aa.assessmentAreaName , q.question  ";

	@Override
	public CustomerUserReviewer getFeedbackQuestionsForSelfReview(Integer userId)
	{

		Object[] args = new Integer[] { userId, userId };
		final CustomerUserReviewer cur = new CustomerUserReviewer();
		final AppUser appUser = new AppUser();
		cur.setReviewee(appUser);

		final Map<Integer, Question> questionMap = new HashMap();

		final Map<Integer, EmployeeFeedbackAnswer> questionAnswereMap = new HashMap();
		Integer appUserReviewerId = null;
		m_assessDbTemplate.query(questionsQueryForSelfreview, args,
				new RowMapper<CustomerUserReviewer>()
					{

						@Override
						public CustomerUserReviewer mapRow(ResultSet rs, int i) throws SQLException
						{

							Integer appUserFeedbackAnswerId = rs.getInt("AppUserFeedbackAnswerId");
							Integer appUserReviewerId = rs.getInt("AppUserReviewerId");
							Integer revieweeId = rs.getInt("RevieweeId");
							Integer designationId = rs.getInt("designationid");
							Integer questionId = rs.getInt("questionId");
							Integer refQuestionTypeid = rs.getInt("refQuestionTypeid");
							String questionContent = rs.getString("Question");
							Integer multipleChoiceId = rs.getInt("MultipleChoiceId");
							String mcAnswer = rs.getString("Answer");
							Integer sequence = rs.getInt("Sequence");

							String descriptiveAnswer = rs.getString("DescriptiveAnswer");
							Integer multipleChoiceAnswerId = rs.getInt("MultipleChoiceAnswerId");

							String assessmentArea = rs.getString("assessmentAreaName");
							String parentAssessmentArea = rs.getString("parentAssessmentAreaName");

							if (appUser.getAppUserId() == null)
							{
								appUser.setAppUserId(revieweeId);
								appUser.setDesignation(new Designation(designationId));
								cur.setReviewee(appUser);
								cur.setAppUserReviewerId(appUserReviewerId);

							}
							Designation designation = appUser.getDesignation();
							List<Question> questions = designation.getQuestions();

							Question question = getQuestionFromMap(questionId, questionMap,
									questionContent, refQuestionTypeid, questions, assessmentArea,
									parentAssessmentArea);
							appUser.getDesignation().getQuestions();
							QuestionTypeEnum questionTypeEnum = question.getQuestionTypeEnum();

							if (questionTypeEnum == QuestionTypeEnum.MULTIPLE_CHOICE)
							{
								MultipleChoice mc = new MultipleChoice(multipleChoiceId,
										questionId, mcAnswer, sequence);
								mc.setQuestion(question);
								question.getChoices().add(mc);

								if (multipleChoiceAnswerId != null
										&& questionAnswereMap.get(questionId) == null)
								{
									EmployeeFeedbackAnswer efa = new EmployeeFeedbackAnswer(
											appUserReviewerId, questionId, descriptiveAnswer);
									efa.setQuestion(question);
									cur.getEmployeeFeedbackAnswers().add(efa);

									MultipleChoiceAnswer mca = new MultipleChoiceAnswer(
											appUserFeedbackAnswerId, multipleChoiceAnswerId);
									efa.setMultipleChoiceAnswer(mca);

									questionAnswereMap.put(questionId, efa);
									System.out.println(questionAnswereMap);

								}

							}
							else if (questionAnswereMap.get(questionId) == null)
							{

								EmployeeFeedbackAnswer efa = new EmployeeFeedbackAnswer(
										appUserReviewerId, questionId, descriptiveAnswer);
								efa.setQuestion(question);
								cur.getEmployeeFeedbackAnswers().add(efa);
								questionAnswereMap.put(questionId, efa);
								System.out.println(questionAnswereMap);
							}

							return cur;
						}
					});
		System.out.println(questionAnswereMap);
		System.out.println(questionAnswereMap);
		return cur;

	}

	protected Question getQuestionFromMap(Integer questionId, Map<Integer, Question> questionMap,
			String questionContent, int questionTypeId, List<Question> questions,
			String assessmentAreaName, String parentAssessmentAreaName)
	{

		Question question = questionMap.get(questionId);
		if (question == null)
		{
			question = new Question(questionId);
			question.setQuestion(questionContent);

			AssessmentArea assessmentArea = new AssessmentArea(assessmentAreaName);
			assessmentArea.setParentAssessmentArea(new AssessmentArea(parentAssessmentAreaName));

			question.setAssessmentArea(assessmentArea);

			QuestionTypeEnum questionTypeEnum = null;
			if (questionTypeId == 1)
				questionTypeEnum = QuestionTypeEnum.DESCRIPTIVE;
			else
				questionTypeEnum = QuestionTypeEnum.MULTIPLE_CHOICE;
			question.setQuestionTypeEnum(questionTypeEnum);
			questions.add(question);

			questionMap.put(questionId, question);
		}
		return question;
	}

	@Override
	public void addReviewers(final List<CustomerUserReviewer> customerUserReviewers)
	{

		try
		{

			int[] updateCounts = m_assessDbTemplate.batchUpdate(m_insertQuery,
					new BatchPreparedStatementSetter()
						{
							public void setValues(PreparedStatement ps, int i) throws SQLException
							{
								CustomerUserReviewer cur = customerUserReviewers.get(i);
								ps.setInt(1, cur.getReviewerId());
								ps.setInt(2, cur.getRevieweeId());
								ps.setInt(3, 43);
								ps.setInt(4, 1);
							}

							public int getBatchSize()
							{
								return customerUserReviewers.size();
							}
						});
			// return updateCounts;
		}
		catch (DataAccessException e)
		{
			e.printStackTrace();
		}

	}

	private static String m_QueryToGetQuestionsAlreadyAnswered = " select efa.questionId , efa.EmployeeFeedbackAnswerId"
			+ " from EmployeeFeedbackAnswer efa "
			+ " join CustomerUserReviewer cur on cur.AppUserReviewerId = efa.AppUserReviewerId "
			+ " where cur.AppUserReviewerId = ? ";

	@Override
	public void savefeedback(final Integer curId, Map<Integer, Integer> mcAnswers,
			Map<Integer, String> dAnswers)
	{

		// 1. Get the list of qa which exist for this curId
		// 2. If the questionId exists in the already existing qa then it will
		// be updated.
		// 3. Otherwise insert the new answers

		List<Integer> questionIds = getAlreadyAnsweredQuestions(curId);

		final Map<Integer, String> existingDAnswers = new HashMap();
		Map<Integer, Integer> existingMcAnswers = new HashMap();

		for (Integer qId : questionIds)
		{

			if (mcAnswers.containsKey(qId))
			{
				existingMcAnswers.put(qId, mcAnswers.get(qId));
				mcAnswers.remove(qId);
			}
			if (dAnswers.containsKey(qId))
			{

				existingDAnswers.put(qId, dAnswers.get(qId));
				dAnswers.remove(qId);
			}

		}

		updateAlreadyAnsweredDescriptiveQuestions(existingDAnswers, curId);

		updateAlreadyAnsweredMcQuestions(existingMcAnswers, curId);

		insertNewDescriptiveAnswers(dAnswers, curId);

		insertNewMcAnswers(mcAnswers, curId);

		updateFeedbackStatus(curId);

	}

	private static String updateStatusQuery = "update CustomerUserReviewer set FeedbackStatusId = ? where AppUserReviewerId = ? ";

	private void updateFeedbackStatus(Integer curId)
	{

		int n = m_assessDbTemplate.update(updateStatusQuery, new Integer[] {
				RefFeedbackStatusEnum.DRAFT.getId(), curId });
		System.out.println(n);
	}

	private static String m_insertEFAQuery = "insert into EmployeeFeedbackAnswer (AppUserReviewerId,QuestionId) values (?, ?)";

	private void insertNewMcAnswers(Map<Integer, Integer> mcAnswers, final Integer curId)
	{

		Set<Entry<Integer, Integer>> newMcEntries = mcAnswers.entrySet();
		final List<Entry<Integer, Integer>> newMcEntriesList = new ArrayList();
		for (Entry<Integer, Integer> entry : newMcEntries)
		{
			newMcEntriesList.add(entry);
		}

		for (final Entry<Integer, Integer> entry : newMcEntriesList)
		{

			KeyHolder keyHolder = new GeneratedKeyHolder();
			m_assessDbTemplate.update(new PreparedStatementCreator()
				{
					@Override
					public PreparedStatement createPreparedStatement(Connection con)
							throws SQLException
					{
						PreparedStatement ps = con.prepareStatement(m_insertEFAQuery,
								new String[] { "id" });
						ps.setInt(1, curId);
						ps.setInt(2, entry.getKey());

						return ps;
					}
				}, keyHolder);

			final Number key = keyHolder.getKey();

			String insertMcQuery = "insert into MultipleChoiceAnswer (EmployeeFeedbackAnswerId, MultipleChoiceId) values (?, ?)";

			m_assessDbTemplate.update(insertMcQuery, new PreparedStatementSetter()
				{

					@Override
					public void setValues(PreparedStatement ps) throws SQLException
					{
						ps.setInt(1, key.intValue());
						ps.setInt(2, entry.getValue());
					}
				});

		}

	}

	private void insertNewDescriptiveAnswers(Map<Integer, String> dAnswers, final Integer curId)
	{

		String m_InsertDAnswerQuery = "insert into EmployeeFeedbackAnswer (AppUserReviewerId,QuestionId,DescriptiveAnswer) values (?, ?, ?)";

		Set<Entry<Integer, String>> newDEntries = dAnswers.entrySet();
		final List<Entry<Integer, String>> newDEntriesList = new ArrayList();
		for (Entry<Integer, String> entry : newDEntries)
		{
			newDEntriesList.add(entry);
		}

		m_assessDbTemplate.batchUpdate(m_InsertDAnswerQuery, new BatchPreparedStatementSetter()
			{

				@Override
				public void setValues(PreparedStatement ps, int i) throws SQLException
				{
					Entry<Integer, String> entry = newDEntriesList.get(i);

					ps.setInt(1, curId);
					ps.setInt(2, entry.getKey());
					ps.setString(3, entry.getValue());
				}

				@Override
				public int getBatchSize()
				{
					return newDEntriesList.size();
				}
			});

	}

	private void updateAlreadyAnsweredMcQuestions(Map<Integer, Integer> existingMcAnswers,
			final Integer curId)
	{

		Set<Entry<Integer, Integer>> existingmcEntries = existingMcAnswers.entrySet();
		final List<Entry<Integer, Integer>> existingMcEntriesList = new ArrayList();
		for (Entry<Integer, Integer> entry : existingmcEntries)
		{
			existingMcEntriesList.add(entry);
		}

		// String m_updateMcQuery =
		// "update MultipleChoiceAnswer set MultipleChoiceId = ? where AppUserFeedbackAnswerId = ?";

		String m_updateMcQuery = "update MultipleChoiceAnswer set MultipleChoiceId = ? where EmployeeFeedbackAnswerId = "
				+ " (select EmployeeFeedbackAnswerId from EmployeeFeedbackAnswer where questionId = ? and AppUserReviewerId = ?) ";

		m_assessDbTemplate.batchUpdate(m_updateMcQuery, new BatchPreparedStatementSetter()
			{

				@Override
				public void setValues(PreparedStatement ps, int i) throws SQLException
				{
					Entry<Integer, Integer> entry = existingMcEntriesList.get(i);
					ps.setInt(1, entry.getValue());
					ps.setInt(2, entry.getKey());
					ps.setInt(3, curId); // this is the bug. curId is not same
											// as AppUserFeedbackAnswerId
				}

				@Override
				public int getBatchSize()
				{
					return existingMcEntriesList.size();
				}
			});
	}

	private void updateAlreadyAnsweredDescriptiveQuestions(
			final Map<Integer, String> existingDAnswers, final Integer curId)
	{

		Set<Entry<Integer, String>> existingDEntries = existingDAnswers.entrySet();
		final List<Entry<Integer, String>> existingDEntriesList = new ArrayList();
		for (Entry<Integer, String> entry : existingDEntries)
		{
			existingDEntriesList.add(entry);
		}

		// update existing descriptive answers.

		String m_updateQuery = "update EmployeeFeedbackAnswer set DescriptiveAnswer = ? "
				+ " where AppUserReviewerId = ? and questionId = ? ";

		m_assessDbTemplate.batchUpdate(m_updateQuery, new BatchPreparedStatementSetter()
			{

				@Override
				public void setValues(PreparedStatement ps, int i) throws SQLException
				{
					Entry<Integer, String> entry = existingDEntriesList.get(i);
					ps.setString(1, entry.getValue());
					ps.setInt(2, curId);
					ps.setInt(3, entry.getKey());

				}

				@Override
				public int getBatchSize()
				{
					return existingDEntriesList.size();
				}
			});
	}

	private List<Integer> getAlreadyAnsweredQuestions(Integer curId)
	{
		Object[] args = new Integer[] { curId };
		return m_assessDbTemplate.query(m_QueryToGetQuestionsAlreadyAnswered, args,
				new RowMapper<Integer>()
					{

						@Override
						public Integer mapRow(ResultSet rs, int arg1) throws SQLException
						{
							return rs.getInt("questionId");
						}
					});

	}

	@Override
	public void nominateReviewers(NominateReviewersForm form)
	{
		Integer revieweeId = form.getReviewee();

		if (form.getReviewer1() != null)
			nominateReviewer(revieweeId, form.getReviewer1());

		if (form.getReviewer2() != null)
			nominateReviewer(revieweeId, form.getReviewer2());

		if (form.getReviewer3() != null)
			nominateReviewer(revieweeId, form.getReviewer3());

		if (form.getReviewer4() != null)
			nominateReviewer(revieweeId, form.getReviewer4());

		if (form.getReviewer5() != null)
			nominateReviewer(revieweeId, form.getReviewer5());
		if (form.getReviewer6() != null)
			nominateReviewer(revieweeId, form.getReviewer6());

		if (form.getReviewer7() != null)
			nominateReviewer(revieweeId, form.getReviewer7());

		if (form.getReviewer8() != null)
			nominateReviewer(revieweeId, form.getReviewer8());

	}

	public void nominateReviewer(Integer revieweeId, Integer reviewerid)
	{
		try
		{
			MapSqlParameterSource in = new MapSqlParameterSource();
			String email = null;
			in.addValue(P_REVIEWER_Id, email);
			in.addValue(P_REVIEWEE_ID, email);
			in.addValue(P_NOMINATEDBY_ID, email);
			in.addValue(P_FEEDBACK_STATUS, RefFeedbackStatusEnum.NEW.getId());
			m_CustomerUserReviewerByIdAddSproc.execute(in);
		}
		catch (Exception e)
		{
			e.printStackTrace();
			throw e;
		}

	}

}
