package com.assess.controllor.csv;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.assess.controllor.csv.row.BaseCsvRow;

public class OrgHierarchyUploadCsvhandler extends BaseCsvResponseBuilder<BaseCsvRow> {



//	private Logger LOGGER = Logger.getLogger(OrgHierarchyUploadCsvhandler.class);
	
	public static final String OH_USER_EMAIL = "userEmail";
	public static final String OH_MANAGER_EMAIL = "mangerEmail";
	
	public static Map<Integer, String> indexKeyMap = new HashMap<Integer, String>();

	static
	{
		indexKeyMap.put(0, OH_USER_EMAIL);
		indexKeyMap.put(1, OH_MANAGER_EMAIL);
	}
	
	public OrgHierarchyUploadCsvhandler()
	{
		
	}
	
	public OrgHierarchyUploadCsvhandler(List<String> additionalResponseHeaders)
	{
		super(additionalResponseHeaders);
	}



	@Override
	protected Map<Integer, String> getIndexKeyMap()
	{
		return indexKeyMap;
	}



}
