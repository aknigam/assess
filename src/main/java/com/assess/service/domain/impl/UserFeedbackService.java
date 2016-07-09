package com.assess.service.domain.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.assess.form.FeedbackSearchForm;
import com.assess.form.NominateReviewersForm;
import com.assess.service.dao.ICustomerUserReviewerDAO;
import com.assess.service.domain.IUserFeedbackService;
import com.assess.service.entity.CustomerUserReviewer;

@Component
public class UserFeedbackService implements IUserFeedbackService 
{
	@Autowired
	private ICustomerUserReviewerDAO m_customerUserReviewerDAO;
	
	@Override
	@Transactional
	public List<CustomerUserReviewer> getListOfReviews(Integer userId) {
		
		return m_customerUserReviewerDAO.getListOfReviews(userId);
	}

	@Override
	@Transactional
	public void saveFeedback(Integer curId, Map<Integer, Integer> mcAnswers,
			Map<Integer, String> dAnswers) {
		m_customerUserReviewerDAO.savefeedback(curId,mcAnswers, dAnswers);	
	}

	

	@Override
	public void submitFeedback(Integer feedbackId, List questionnaire) {

	}

	@Override
	@Transactional
	public CustomerUserReviewer getFeedbackQuestionnaire(Integer feedbackId) {
		return m_customerUserReviewerDAO.getFeedbackQuestionnaire(feedbackId);
	}

	@Override
	public void nominateReviewers(NominateReviewersForm form) {
		m_customerUserReviewerDAO.nominateReviewers(form);
	}

	@Override
	public List<CustomerUserReviewer> getListOfReviews(Integer userId,
			FeedbackSearchForm searchForm) {
		return m_customerUserReviewerDAO.getListOfReviews(userId, searchForm);
	}

	@Override
	public CustomerUserReviewer getFeedbackQuestionsForSelfReview(Integer userId)
	{
		return m_customerUserReviewerDAO.getFeedbackQuestionsForSelfReview(userId);
	}



}
