package com.assess.controllor.csv;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Component;

import com.assess.controllor.csv.row.BaseCsvRow;


public class DesignationUploadCsvhandler extends BaseCsvResponseBuilder<BaseCsvRow>
{

	private Logger LOGGER = Logger.getLogger(DesignationUploadCsvhandler.class);
	
	public static final String DESIGNATION_NAME_KEY = "designation";
	public static final String DESIGNATION_DESCRIPTION_KEY = "description";
	public static final String DESIGNATION_CUSTOMER_KEY = "customer";
	
	public static Map<Integer, String> indexKeyMap = new HashMap<Integer, String>();

	static
	{
		indexKeyMap.put(0, DESIGNATION_NAME_KEY);
		indexKeyMap.put(1, DESIGNATION_DESCRIPTION_KEY);
		indexKeyMap.put(2, DESIGNATION_CUSTOMER_KEY);
	}
	
	public DesignationUploadCsvhandler()
	{
		
	}
	
	public DesignationUploadCsvhandler(List<String> additionalResponseHeaders)
	{
		super(additionalResponseHeaders);
	}



	@Override
	protected Map<Integer, String> getIndexKeyMap()
	{
		return indexKeyMap;
	}


}
