package com.assess.form;

public class CustomerForm {

	private Integer customerId;
	private String customerName;
	private Integer noOfUserNominatedReviewers;
	private Integer noOfAdminNominatedReviewers;
	
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public Integer getNoOfUserNominatedReviewers() {
		return noOfUserNominatedReviewers;
	}
	public void setNoOfUserNominatedReviewers(Integer noOfUserNominatedReviewers) {
		this.noOfUserNominatedReviewers = noOfUserNominatedReviewers;
	}
	public Integer getNoOfAdminNominatedReviewers() {
		return noOfAdminNominatedReviewers;
	}
	public void setNoOfAdminNominatedReviewers(Integer noOfAdminNominatedReviewers) {
		this.noOfAdminNominatedReviewers = noOfAdminNominatedReviewers;
	}
	public Integer getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

}
