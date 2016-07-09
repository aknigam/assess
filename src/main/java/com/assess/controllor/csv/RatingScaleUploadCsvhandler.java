package com.assess.controllor.csv;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.assess.controllor.csv.row.BaseCsvRow;

public class RatingScaleUploadCsvhandler extends
		BaseCsvResponseBuilder<BaseCsvRow> {

	private Logger LOGGER = Logger.getLogger(RatingScaleUploadCsvhandler.class);
//	 Customer	 AssessmentAreaName	 AssessmentAreaDescription	 ParentAssessmentAreaName
	public static final String RS_CUSTOMER_NAME_KEY = "Customer";
	public static final String RS_RANKING_KEY = "Ranking";
	public static final String RS_NAME_KEY = "name";
	
	public static Map<Integer, String> indexKeyMap = new HashMap<Integer, String>();

	static
	{
		indexKeyMap.put(0, RS_CUSTOMER_NAME_KEY);
		indexKeyMap.put(1, RS_RANKING_KEY);
		indexKeyMap.put(2, RS_NAME_KEY);
	}
	
	public RatingScaleUploadCsvhandler()
	{
		
	}
	
	public RatingScaleUploadCsvhandler(List<String> additionalResponseHeaders)
	{
		super(additionalResponseHeaders);
	}



	@Override
	protected Map<Integer, String> getIndexKeyMap()
	{
		return indexKeyMap;
	}


}
