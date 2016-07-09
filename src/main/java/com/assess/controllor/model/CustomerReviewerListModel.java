package com.assess.controllor.model;

import java.util.List;

/**
 * 
 *  reviewee userId/name/emailId/designation - to show the link in the UI. 
 * 	status - indicates  the current status of the review.
 * @author anigam
 *
 */

public class CustomerReviewerListModel
{

	private List<CustomerReviewer> m_data;
	
	public List<CustomerReviewer> getData() {
		return m_data;
	}

	public void setData(List<CustomerReviewer> m_data) {
		this.m_data = m_data;
	}

	public static class CustomerReviewer
	{
		private Integer m_customerReviewerId;
		private Integer m_revieweeId;
		private String m_revieweeName;
		private String m_revieweeEmail;
		private String m_revieweeDesignation;
		
		private Integer m_reviewerId;
		private String m_reviewerName;
		private String m_reviewerEmail;
		private String m_reviewerDesignation;
		
		private String m_feedbackStatus;
		
		public CustomerReviewer(Integer customerReviewerId, Integer revieweeId, String revieweeEmail, String revieweeDesignation,  String feedbackStatus, String revieweeName, String reviewerName, Integer reviewerId, String reviewerEmail, String reviewerDesignation) 
		{
			m_customerReviewerId = customerReviewerId;
			m_feedbackStatus = feedbackStatus;
			
			m_revieweeId = revieweeId;
			m_revieweeEmail = revieweeEmail;
			m_revieweeDesignation = revieweeDesignation;
			m_revieweeName =  revieweeName;
			
			m_reviewerId = reviewerId;
			m_reviewerEmail = reviewerEmail;
			m_reviewerDesignation = reviewerDesignation;
			m_reviewerName =  reviewerName;
		}

		public Integer getCustomerReviewerId() {
			return m_customerReviewerId;
		}

		public void setCustomerReviewerId(Integer customerReviewerId) {
			m_customerReviewerId = customerReviewerId;
		}

		public Integer getRevieweeId() {
			return m_revieweeId;
		}

		public void setRevieweeId(Integer revieweeId) {
			m_revieweeId = revieweeId;
		}

		public String getRevieweeEmail() {
			return m_revieweeEmail;
		}

		public void setRevieweeEmail(String revieweeEmail) {
			m_revieweeEmail = revieweeEmail;
		}

		public String getFeedbackStatus() {
			return m_feedbackStatus;
		}

		public void setFeedbackStatus(String feedbackStatus) {
			m_feedbackStatus = feedbackStatus;
		}

		public String getRevieweeName() {
			return m_revieweeName;
		}

		public void setRevieweeName(String revieweeName) {
			m_revieweeName = revieweeName;
		}

		public String getRevieweeDesignation() {
			return m_revieweeDesignation;
		}

		public void setRevieweeDesignation(String revieweeDesignation) {
			m_revieweeDesignation = revieweeDesignation;
		}

		public Integer getReviewerId() {
			return m_reviewerId;
		}

		public void setReviewerId(Integer reviewerId) {
			m_reviewerId = reviewerId;
		}

		public String getReviewerName() {
			return m_reviewerName;
		}

		public void setReviewerName(String reviewerName) {
			m_reviewerName = reviewerName;
		}

		public String getReviewerEmail() {
			return m_reviewerEmail;
		}

		public void setReviewerEmail(String reviewerEmail) {
			m_reviewerEmail = reviewerEmail;
		}

		public String getReviewerDesignation() {
			return m_reviewerDesignation;
		}

		public void setReviewerDesignation(String reviewerDesignation) {
			m_reviewerDesignation = reviewerDesignation;
		}
		
		
		
		
	}
}
