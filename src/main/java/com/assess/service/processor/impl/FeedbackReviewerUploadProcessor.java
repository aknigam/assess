package com.assess.service.processor.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.assess.controllor.csv.FeedbackReviewerUploadCsvhandler;
import com.assess.controllor.csv.row.BaseCsvRow;
import com.assess.controllor.csv.row.HashCsvRow;
import com.assess.service.dao.ICustomerUserReviewerDAO;
import com.assess.service.domain.IAppUserService;
import com.assess.service.entity.AppUser;
import com.assess.service.entity.CustomerUserReviewer;
import com.assess.service.exception.UserNotFoundException;
import com.assess.service.processor.IUploadProcessor;

@Component
public class FeedbackReviewerUploadProcessor implements IUploadProcessor
{

	private static Logger LOGGER  = Logger.getLogger(FeedbackReviewerUploadProcessor.class);
	
	@Autowired
	private ICustomerUserReviewerDAO m_customerUserReviewerDAO;
	
	@Autowired
	private IAppUserService m_appUserService;
	
	@Override
	@Transactional
	public List<BaseCsvRow> upload(List<BaseCsvRow> csvRows)
	{
		if(csvRows == null || csvRows.size()== 0)
		{
			return csvRows;
		}
		LOGGER.info("Uploading ["+ csvRows.size()+"] feedback reviewers");
		HashCsvRow row =  null;
		List<CustomerUserReviewer> customerUserReviewers = new ArrayList();
		
		Integer nominatedBy = null;
		Integer revieweeId = null;
		Integer reviewerId = null;
		
		for (BaseCsvRow baseCsvRow : csvRows)
		{
			if(!(row instanceof HashCsvRow))
			{
//				throw exception()
			}
				//Reviewee name	Reviewee email	Reviewer name	Reviewer email	isSelfNominated
			row = (HashCsvRow) baseCsvRow;
			String revieweeEmail = row.getColValue(FeedbackReviewerUploadCsvhandler.FEEDBACK_REVIEWEE_EMAIL_KEY);
			String reviewerEmail = row.getColValue(FeedbackReviewerUploadCsvhandler.FEEDBACK_REVIEWER_EMAIL_KEY);
			String isSelfNominated = row.getColValue(FeedbackReviewerUploadCsvhandler.FEEDBACK_NOMINATEDBY_KEY);
			
			
			AppUser reviewee = null;
			AppUser reviewer = null;
			try
			{
				reviewee = m_appUserService.getUserByEmail(revieweeEmail);
				reviewer = m_appUserService.getUserByEmail(reviewerEmail);
			}
			catch (UserNotFoundException e)
			{
				e.printStackTrace();
				return null;
			}
			

			
			if(reviewee == null || reviewer == null)
			{
				LOGGER.debug("Reviewee or reviewer does not exists: "+ revieweeEmail+" - "+ reviewerEmail);
				continue;
			}
			LOGGER.info("Adding reviewer ["+ reviewerEmail+"] for user ["+ revieweeEmail+"]");
			revieweeId = reviewee.getAppUserId();
			reviewerId = reviewer.getAppUserId();
			
			customerUserReviewers.add(new CustomerUserReviewer(reviewerId, revieweeId, nominatedBy, null));
		}
		m_customerUserReviewerDAO.addReviewers(customerUserReviewers);
		
		return csvRows;
		

	}

}
