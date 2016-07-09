package com.assess.controllor.model.builder;

import java.util.ArrayList;
import java.util.List;

import com.assess.controllor.model.CustomerReviewerListModel;
import com.assess.service.entity.CustomerUserReviewer;

public class CustomerReviewerListModelBuilder {

	public CustomerReviewerListModel build(List<CustomerUserReviewer> reviews) {
		
		CustomerReviewerListModel model = new CustomerReviewerListModel();
		
		List<CustomerReviewerListModel.CustomerReviewer> reviewList = new ArrayList();
		model.setData(reviewList);
		
		Integer customerReviewerId = null;
		Integer revieweeId = null;
		String revieweeEmail = null;
		String revieweeDesignation = null;
		String revieweeName = null;
		
		Integer reviewerId = null;
		String reviewerEmail = null;
		String reviewerDesignation = null;
		String reviewerName = null;
		
		
		for (CustomerUserReviewer cur : reviews) {
			
			customerReviewerId  = cur.getAppUserReviewerId();
			revieweeId = cur.getReviewee().getAppUserId();
			revieweeEmail = cur.getReviewee().getEmail();
			revieweeName = cur.getReviewee().getName();
			revieweeDesignation = cur.getReviewee().getDesignation().getName();
			
			reviewerId = cur.getReviewer().getAppUserId();
			reviewerEmail = cur.getReviewer().getEmail();
			reviewerName = cur.getReviewer().getName();
			reviewerDesignation = cur.getReviewer().getDesignation().getName();
			
			
			reviewList.add(new CustomerReviewerListModel.CustomerReviewer(customerReviewerId, revieweeId, revieweeEmail, revieweeDesignation, cur.getFeedbackStatus(), revieweeName, 
					 reviewerName, reviewerId, reviewerEmail, reviewerDesignation ));
		}
		
		return model;
	}

}
