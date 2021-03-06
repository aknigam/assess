package com.assess.service.entity;

import java.util.ArrayList;
import java.util.List;

// Generated Jul 7, 2014 8:27:18 AM by Hibernate Tools 3.4.0.CR1

/**
 * CustomerUserReviewer generated by hbm2java
 */
public class CustomerUserReviewer implements java.io.Serializable {

	private Integer m_appUserReviewerId;
	private AppUser m_reviewee;
	private AppUser m_reviewer;
	private Integer m_reviewerId;
	private Integer m_revieweeId;
	private Integer m_nominatedBy;
	private String m_feedbackStatus;
	
	private List<EmployeeFeedbackAnswer> m_employeeFeedbackAnswers = new ArrayList();
	

	public CustomerUserReviewer() {
	}

	public CustomerUserReviewer(Integer reviewerId, Integer revieweeId) {
		this.m_reviewerId = reviewerId;
		this.m_revieweeId = revieweeId;
	}

	public CustomerUserReviewer(Integer reviewerId, Integer revieweeId,
			Integer nominatedBy, String feedbackStatus) {
		this.m_reviewerId = reviewerId;
		this.m_revieweeId = revieweeId;
		this.m_nominatedBy = nominatedBy;
		this.m_feedbackStatus = feedbackStatus;
	}

	public CustomerUserReviewer(Integer appUserReviewerId) {
		m_appUserReviewerId = appUserReviewerId;
	}

	public Integer getAppUserReviewerId() {
		return m_appUserReviewerId;
	}

	public void setAppUserReviewerId(Integer appUserReviewerId) {
		m_appUserReviewerId = appUserReviewerId;
	}

	public AppUser getReviewee() {
		return m_reviewee;
	}

	public void setReviewee(AppUser reviewee) {
		m_reviewee = reviewee;
	}

	public Integer getReviewerId() {
		return m_reviewerId;
	}

	public void setReviewerId(Integer reviewerId) {
		m_reviewerId = reviewerId;
	}

	public Integer getRevieweeId() {
		return m_revieweeId;
	}

	public void setRevieweeId(Integer revieweeId) {
		m_revieweeId = revieweeId;
	}

	public Integer getNominatedBy() {
		return m_nominatedBy;
	}

	public void setNominatedBy(Integer nominatedBy) {
		m_nominatedBy = nominatedBy;
	}

	public String getFeedbackStatus() {
		return m_feedbackStatus;
	}

	public void setFeedbackStatus(String feedbackStatus) {
		m_feedbackStatus = feedbackStatus;
	}

	public List<EmployeeFeedbackAnswer> getEmployeeFeedbackAnswers() {
		return m_employeeFeedbackAnswers;
	}

	public void setEmployeeFeedbackAnswers(
			List<EmployeeFeedbackAnswer> employeeFeedbackAnswers) {
		m_employeeFeedbackAnswers = employeeFeedbackAnswers;
	}

	public AppUser getReviewer() {
		return m_reviewer;
	}

	public void setReviewer(AppUser reviewer) {
		m_reviewer = reviewer;
	}



}
