package com.assess.controllor.csv;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.assess.controllor.csv.row.BaseCsvRow;


public class QuestionUploadCsvhandler extends BaseCsvResponseBuilder<BaseCsvRow>
{

	
	public static final String QUESTION_DESIGNATION_NAME_KEY = "designation";
	public static final String QUESTION_CUSTOMER_KEY = "Customer";
	public static final String QUESTION_KEY = "question";
	public static final String QUESTION_TYPE_KEY = "questionType";
	public static final String QUESTION_ASSESSMENT_AREA = "assessmentarea";
	public static final String QUESTION_CHOICE_A_KEY = "choice 1";
	public static final String QUESTION_CHOICE_B_KEY = "choice 2";
	public static final String QUESTION_CHOICE_C_KEY = "choice 3";
	public static final String QUESTION_CHOICE_D_KEY = "choice 4";
	public static final String QUESTION_CHOICE_E_KEY = "choice 5";
	
	
	
//	designation	Customer	question	questionType	choice 1	choice 2	choice 3	choice 4	choice 5
	
	public static Map<Integer, String> indexKeyMap = new HashMap<Integer, String>();

	static
	{
		indexKeyMap.put(0, QUESTION_DESIGNATION_NAME_KEY);
		indexKeyMap.put(1, QUESTION_CUSTOMER_KEY);
		indexKeyMap.put(2, QUESTION_KEY);
		indexKeyMap.put(3, QUESTION_TYPE_KEY);
		indexKeyMap.put(4, QUESTION_ASSESSMENT_AREA);
		indexKeyMap.put(5, QUESTION_CHOICE_A_KEY);
		indexKeyMap.put(6, QUESTION_CHOICE_B_KEY);
		indexKeyMap.put(7, QUESTION_CHOICE_C_KEY);
		indexKeyMap.put(8, QUESTION_CHOICE_D_KEY);
		indexKeyMap.put(9, QUESTION_CHOICE_E_KEY);
	}
	
	public QuestionUploadCsvhandler()
	{
		
	}
	
	public QuestionUploadCsvhandler(List<String> additionalResponseHeaders)
	{
		super(additionalResponseHeaders);
	}



	@Override
	protected Map<Integer, String> getIndexKeyMap()
	{
		return indexKeyMap;
	}


}
