package com.assess.service.domain;

import java.util.List;
import java.util.Map;

import com.assess.form.FeedbackSearchForm;
import com.assess.form.NominateReviewersForm;
import com.assess.service.entity.CustomerUserReviewer;

public interface IUserFeedbackService {

	
	
	/**
	 * This method returns the list of reviews. It takes the logged in userId as input.
	 * If the user is a normal application user then a list of there reviews is returned along with there status.
	 * If administrator (a user with admin privilege) is logged in then a list of all the users list is returned.
	 * 
	 * @param userId 
	 * 
	 * @return each element in the list will have following information:
	 * 	feedbackId - unique identifier of the review. (PK of the table which has the user-reviewer relationship) . This will give
	 * 				information about the reviewer and reviewee both. It will be sent from UI to get the list of questions and 
	 * 				pre-filled answers if the review is in progress.
	 * 	reviewee userId/name/emailId/designation - to show the link in the UI. 
	 * 	status - indicates  the current status of the review.
	 * 
	 */
	public List<CustomerUserReviewer> getListOfReviews(Integer userId);
	
	
	
	/**
	 * This method returns the the list of questions along with there answers in a serial order. 
	 * It will also send the feedback status so the submit button at the UI can be enabled based on its value.
	 * 
	 * @param feedbackId - unique identifier of the review. (PK of the table which has the user-reviewer relationship) 
	 * @param revieweeId
	 * 
	 * @return Following information should be present in the response.
	 * 	a) revieweeId/email/name - the user whose review questions are sent tin the response
	 * 	b) status - review status
	 * 	c) last saved date - when was the review edited last time. (this is currently not in DB).
	 * 	d) List of questions and there respective answers in a definite order.  
	 *
	 */
	public CustomerUserReviewer getFeedbackQuestionnaire(Integer feedbackId);
	
	/**
	 * 
	 * Save the answers provided by the user for a feedback. Status will remain IN-PROGRESS.
	 * 
	 */
	public void saveFeedback(Integer curId, Map<Integer, Integer> mcAnswers, Map<Integer, String> dAnswers);
	
	/**
	 * Save the answers provided by the user for a feedback. Status will be changed to SUBMITTED
	 * If any mandatory question is not answered then error will be sent back.
	 */
	public void submitFeedback(Integer feedbackId, List questionnaire);



	public void nominateReviewers(NominateReviewersForm form);



	public List<CustomerUserReviewer> getListOfReviews(Integer userId,
			FeedbackSearchForm searchForm);



	public CustomerUserReviewer getFeedbackQuestionsForSelfReview(Integer userId);
	
	
	
	
}
