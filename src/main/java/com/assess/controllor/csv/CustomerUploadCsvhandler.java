package com.assess.controllor.csv;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.assess.controllor.csv.row.BaseCsvRow;

public class CustomerUploadCsvhandler extends
		BaseCsvResponseBuilder<BaseCsvRow> {

	private Logger LOGGER = Logger.getLogger(CustomerUploadCsvhandler.class);
	//name,NoOfUserNominatedReviewers,NoOfAdminNominatedReviewers
	public static final String CUSTOMER_NAME_KEY = "name";
	public static final String CUSTOMER_UNR_KEY = "NoOfUserNominatedReviewers";
	public static final String CUSTOMER_ANR_KEY = "NoOfAdminNominatedReviewers";
	
	public static Map<Integer, String> indexKeyMap = new HashMap<Integer, String>();

	static
	{
		indexKeyMap.put(0, CUSTOMER_NAME_KEY);
		indexKeyMap.put(1, CUSTOMER_UNR_KEY);
		indexKeyMap.put(2, CUSTOMER_ANR_KEY);
	}
	
	public CustomerUploadCsvhandler()
	{
		
	}
	
	public CustomerUploadCsvhandler(List<String> additionalResponseHeaders)
	{
		super(additionalResponseHeaders);
	}



	@Override
	protected Map<Integer, String> getIndexKeyMap()
	{
		return indexKeyMap;
	}


}
