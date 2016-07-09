package com.assess.controllor.csv;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.assess.controllor.csv.row.BaseCsvRow;


public class FeedbackReviewerUploadCsvhandler extends BaseCsvResponseBuilder<BaseCsvRow> 
{

	public static final String FEEDBACK_REVIEWEE_NAME_KEY = "Reviewee name";
	public static final String FEEDBACK_REVIEWEE_EMAIL_KEY = "Reviewee email";
	public static final String FEEDBACK_REVIEWER_NAME_KEY = "Reviewer name";
	public static final String FEEDBACK_REVIEWER_EMAIL_KEY = "Reviewer email";
	public static final String FEEDBACK_NOMINATEDBY_KEY = "isSelfNominated";
	
//	Reviewee name	Reviewee email	Reviewer name	Reviewer email	isSelfNominated
	
	private static Map<Integer, String> indexKeyMap = new HashMap<Integer, String>();

	static
	{
		indexKeyMap.put(0, FEEDBACK_REVIEWEE_NAME_KEY);
		indexKeyMap.put(1, FEEDBACK_REVIEWEE_EMAIL_KEY);
		indexKeyMap.put(2, FEEDBACK_REVIEWER_NAME_KEY);
		indexKeyMap.put(3, FEEDBACK_REVIEWER_EMAIL_KEY);
		indexKeyMap.put(4, FEEDBACK_NOMINATEDBY_KEY);
	}
	
	public FeedbackReviewerUploadCsvhandler()
	{
		
	}
	
	public FeedbackReviewerUploadCsvhandler(List<String> additionalResponseHeaders)
	{
		super(additionalResponseHeaders);
	}



	@Override
	protected Map<Integer, String> getIndexKeyMap()
	{
		return indexKeyMap;
	}


}
