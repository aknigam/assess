package com.assess.controllor;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.assess.controllor.model.CustomerReviewerListModel;
import com.assess.controllor.model.FeedbackModel;
import com.assess.controllor.model.builder.CustomerReviewerListModelBuilder;
import com.assess.controllor.model.builder.FeedbackModelBuilder;
import com.assess.form.FeedbackSearchForm;
import com.assess.form.NominateReviewersForm;
import com.assess.service.QuestionTypeEnum;
import com.assess.service.domain.IUserFeedbackService;
import com.assess.service.entity.AppUser;
import com.assess.service.entity.CustomerUserReviewer;

/**
 * 
 * Operations:
 * 
 * 1. Choose my reviewers
 * 
 * 2. Get the list of reviews that I have to do (List of users whose review I have to do)-
 * 	INPUT-
 * 		a) logged-in user id
 * 	OUTPUT-
 * 		a) reviewee name
 * 		b) review status
 * 
 * 3. Get the questionnaire
 * 	INPUT-	
 * 		a) revieweeId
 * 		b) reviewerId (this is the user who is logged in)
 * 	OUTPUT
 * 		a) Questions
 * 		b) Answers - if some of the questions have already been answered
 * 
 * 4. Nominate reviewers.
 * 	it can be self nomination or nomination by admin
 * 
 * 5. 
 * 
 * 
 * @author anigam
 *
 */
@Controller
@RequestMapping("/UserFeedback")
public class UserFeedbackControllor {

	
	@Autowired
	private IUserFeedbackService userFeedbackService;
	
	/**
	 * Get the list of reviews that I have to do (List of users whose review I have to do)-
	 * 	INPUT-
	 * 		a) logged-in user id
	 * 	OUTPUT-
	 * 		a) reviewee name
	 * 		b) review status
	 * 
	 */
	@RequestMapping(value = "/reviews",method = RequestMethod.GET)
	public ModelAndView showReviews(Integer userId)
	{
		List<CustomerUserReviewer> reviews = userFeedbackService.getListOfReviews(userId);
		
		CustomerReviewerListModel customerReviewerListModel = new CustomerReviewerListModelBuilder().build(reviews);
		
		ModelMap model = new ModelMap("myreviews", customerReviewerListModel);
		  
		// myreviews.ftl will be resolved
		return new ModelAndView("reviews-list", model);
		
	}
	
	@RequestMapping(value = "/reviews_search",method = RequestMethod.POST)
	public ModelAndView showSearchReviews(FeedbackSearchForm searchForm)
	{
		
		List<CustomerUserReviewer> reviews = userFeedbackService.getListOfReviews(41, searchForm);
		
		CustomerReviewerListModel customerReviewerListModel = new CustomerReviewerListModelBuilder().build(reviews);

		ModelMap model = new ModelMap("myreviews", customerReviewerListModel);
		  
		// myreviews.ftl will be resolved
		return new ModelAndView("reviews-list", model);
		
	}
	
	@RequestMapping(value = "/reviews_search_json",method = RequestMethod.POST)
	public @ResponseBody CustomerReviewerListModel showSearchReviewsJson(FeedbackSearchForm searchForm, HttpServletRequest request)
	{
		HttpSession session = request.getSession(true);
		AppUser appUser = (AppUser) session.getAttribute("userId");
		
		List<CustomerUserReviewer> reviews = userFeedbackService.getListOfReviews(appUser.getAppUserId(), searchForm);
		
		return new CustomerReviewerListModelBuilder().build(reviews);

		
	}
	
	
	@RequestMapping(value = "/reviews-json", headers = "Content-Type=application/json", method = RequestMethod.GET)
	public @ResponseBody CustomerReviewerListModel showReviewsJson(Integer userId)
	{
		List<CustomerUserReviewer> reviews = userFeedbackService.getListOfReviews(userId);
		
		return new CustomerReviewerListModelBuilder().build(reviews);
		
	}
	
	/**
	 * 3. Get the questionnaire
	 * 	INPUT-	
	 * 		a) revieweeId
	 * 		b) reviewerId (this is the user who is logged in)
	 * 	OUTPUT
	 * 		a) Questions
	 * 		b) Answers - if some of the questions have already been answered
	 * @return
	 */
	@RequestMapping(value = "/questions",method = RequestMethod.GET)
	public ModelAndView getFeedbackQuestions(Integer feedbackId)
	{
		CustomerUserReviewer cur = userFeedbackService.getFeedbackQuestionnaire(feedbackId);
		
		FeedbackModel fm = new FeedbackModelBuilder().build(cur);
		
		ModelMap model = new ModelMap("feedbackQuestions", fm);
		
		return new ModelAndView("feedback-questions", model);
		
	}
	
	@RequestMapping(value = "/questionsself",method = RequestMethod.GET)
	public ModelAndView getFeedbackQuestionsForSelfReview(Integer userId)
	{
		CustomerUserReviewer cur = userFeedbackService.getFeedbackQuestionsForSelfReview(userId);
		
		FeedbackModel fm = new FeedbackModelBuilder().build1(cur);
		
		ModelMap model = new ModelMap("feedbackQuestions", fm);
		
		return new ModelAndView("feedback-questions", model);
		
	}
	
	@RequestMapping(value = "/questionsselfJson",method = RequestMethod.GET)
	public @ResponseBody FeedbackModel getFeedbackQuestionsForSelfReviewJson(Integer userId)
	{
		CustomerUserReviewer cur = userFeedbackService.getFeedbackQuestionsForSelfReview(userId);
		
		FeedbackModel fm = new FeedbackModelBuilder().build1(cur);
		
		return fm;
		
	}
	
	@RequestMapping(value = "/questions-json", headers = "Content-Type=application/json", method = RequestMethod.GET)
	public @ResponseBody FeedbackModel getFeedbackQuestionsJson(Integer feedbackId)
	{
		CustomerUserReviewer cur = userFeedbackService.getFeedbackQuestionnaire(feedbackId);
		
		return new FeedbackModelBuilder().build(cur);
	}
		
	
	
	/**
	 * 4. Nominate reviewers.
	 * 	it can be self nomination or nomination by admin
	 * 
	 * @return
	 */
	@RequestMapping(value = "/nominate",method = RequestMethod.POST)
	public ModelAndView nominateReviewers(NominateReviewersForm form)
	{
		userFeedbackService.nominateReviewers(form);
		
		ModelMap model = new ModelMap("feedbackQuestions", null);
		
		return new ModelAndView("feedback-questions", model);
		
	}
	
	@RequestMapping(value = "/savefeedback",method = RequestMethod.POST)
	/**
	 * Integer feedbackId, List questionnaire,
	 * @param request
	 */
	public String saveFeedback( HttpServletRequest request)
	{
		Enumeration attributes = request.getParameterNames();
		
		Map<Integer, Integer> mcAnswers =  new HashMap();
		Map<Integer, String> dAnswers =  new HashMap();
		Integer curId = null;
		for(;attributes.hasMoreElements();)
		{
			String q = (String) attributes.nextElement();
			
			if(q.equals("curid"))
			{
				curId = Integer.valueOf(request.getParameter(q));
				continue;
			}
			
			String[] qt = q.split("-");
			Integer questionId = Integer.valueOf(qt[0]);
			Integer questionTypeId = Integer.valueOf(qt[1]);
			QuestionTypeEnum questionTypeEnum = QuestionTypeEnum.DESCRIPTIVE;
			if(questionTypeId == QuestionTypeEnum.MULTIPLE_CHOICE.getId())
			{
				questionTypeEnum = QuestionTypeEnum.MULTIPLE_CHOICE;
				mcAnswers.put(questionId, Integer.parseInt(request.getParameter(q)));
			}
			else
			{
				dAnswers.put(questionId, request.getParameter(q));
			}
		}
		
		userFeedbackService.saveFeedback(curId,mcAnswers, dAnswers);
		
		return "redirect:/UserFeedback/questions?&feedbackId="+curId;
		
	}
	
	
	public void submitFeedback(Integer feedbackId, List questionnaire)
	{
		
	}
	
	

}
