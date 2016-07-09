package com.assess.form;

public class FeedbackSearchForm {

	Integer status;
	String revieweeName;
	String revieweeEmail;
	Integer revieweeDesignation;
	
	String reviewerName;
	String reviewerEmail;
	Integer reviewerDesignation;
	
	
	@Override
	public String toString() {
		return status+","+revieweeName+","+revieweeEmail+","+revieweeEmail
				+","+reviewerName+","+reviewerEmail+","+reviewerDesignation;
	}
	
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getRevieweeName() {
		return revieweeName;
	}
	public void setRevieweeName(String revieweeName) {
		this.revieweeName = revieweeName;
	}
	public String getRevieweeEmail() {
		return revieweeEmail;
	}
	public void setRevieweeEmail(String revieweeEmail) {
		this.revieweeEmail = revieweeEmail;
	}
	public Integer getRevieweeDesignation() {
		return revieweeDesignation;
	}
	public void setRevieweeDesignation(Integer revieweeDesignation) {
		this.revieweeDesignation = revieweeDesignation;
	}
	public String getReviewerName() {
		return reviewerName;
	}
	public void setReviewerName(String reviewerName) {
		this.reviewerName = reviewerName;
	}
	public String getReviewerEmail() {
		return reviewerEmail;
	}
	public void setReviewerEmail(String reviewerEmail) {
		this.reviewerEmail = reviewerEmail;
	}
	public Integer getReviewerDesignation() {
		return reviewerDesignation;
	}
	public void setReviewerDesignation(Integer reviewerDesignation) {
		this.reviewerDesignation = reviewerDesignation;
	}
	
	/*	
	<label for="status">Feedback Status</label>
	<select id="status">
	  <option value="1">Developer</option>
	  <option value="2">Director</option>
	  <option value="3">Manager</option>
	  <option value="4">VP</option>
	</select>
	</br>

 	<label for="revieweeName">Reviewee name</label>
 	<input type="text" name="revieweeName" id="revieweeName" value=""><br>
		
		<label for="revieweeEmail">Reviewee email</label>
 	<input type="text" name="revieweeEmail" id="revieweeEmail" value=""><br>
 	
 	<label for="revieweeDesignation">Reviewee designation</label>
 	<input type="text" name="revieweeDesignation" id="revieweeDesignation" value=""><br>
 	
 	<label for="reviewerName">Reviewer name</label>
 	<input type="text" name="reviewerName" id="reviewerName" value=""><br>
		
		<label for="reviewerEmail">Reviewer email</label>
 	<input type="text" name="reviewerEmail" id="reviewerEmail" value=""><br>
 	
 	<label for="reviewerDesignation">Reviewer designation</label>
 	<input type="text" name="reviewerDesignation" id="reviewerDesignation" value=""><br>
 	
 	*/
}
