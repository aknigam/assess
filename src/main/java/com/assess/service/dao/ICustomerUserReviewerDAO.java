package com.assess.service.dao;

import java.util.List;
import java.util.Map;

import com.assess.form.FeedbackSearchForm;
import com.assess.form.NominateReviewersForm;
import com.assess.service.entity.CustomerUserReviewer;

public interface ICustomerUserReviewerDAO
{

	List<CustomerUserReviewer> getListOfReviews(Integer userId);

	CustomerUserReviewer getFeedbackQuestionnaire(Integer feedbackId);

	void addReviewers(List<CustomerUserReviewer> customerUserReviewers);

	void savefeedback(Integer curId, Map<Integer, Integer> mcAnswers,
			Map<Integer, String> dAnswers);

	List<CustomerUserReviewer> getListOfReviews(Integer userId,FeedbackSearchForm searchForm);

	CustomerUserReviewer getFeedbackQuestionsForSelfReview(Integer userId);

	void nominateReviewers(NominateReviewersForm form);

}
