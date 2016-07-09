package com.assess.controllor.csv;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.assess.controllor.csv.row.BaseCsvRow;

public class AssessmentAreaHierarchyUploadCsvhandler extends
		BaseCsvResponseBuilder<BaseCsvRow> {

	private Logger LOGGER = Logger.getLogger(AssessmentAreaHierarchyUploadCsvhandler.class);
//	 Customer	 AssessmentAreaName	 AssessmentAreaDescription	 ParentAssessmentAreaName
	public static final String AA_CUSTOMER_NAME_KEY = "Customer";
	public static final String AA_NAME_KEY = "AssessmentAreaName";
	public static final String AA_PARENT_KEY = "ParentAssessmentAreaName";
	
	public static Map<Integer, String> indexKeyMap = new HashMap<Integer, String>();

	static
	{
		indexKeyMap.put(0, AA_CUSTOMER_NAME_KEY);
		indexKeyMap.put(1, AA_NAME_KEY);
		indexKeyMap.put(2, AA_PARENT_KEY);
	}
	
	public AssessmentAreaHierarchyUploadCsvhandler()
	{
		
	}
	
	public AssessmentAreaHierarchyUploadCsvhandler(List<String> additionalResponseHeaders)
	{
		super(additionalResponseHeaders);
	}



	@Override
	protected Map<Integer, String> getIndexKeyMap()
	{
		return indexKeyMap;
	}


}
