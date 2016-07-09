package com.assess.controllor.csv;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.assess.controllor.csv.row.BaseCsvRow;


public class UserUploadCsvhandler extends BaseCsvResponseBuilder<BaseCsvRow> 
{

	
	public static final String REVIEWEE_NAME_KEY = "name";
	public static final String REVIEWEE_EMAIL_KEY = "email";
	public static final String REVIEWEE_COMPANY_KEY = "customer";
	public static final String REVIEWEE_DESIGNATION_KEY = "designation";
	public static final String REVIEWEE_ISEMPLOYEE_KEY = "isEmployee";
	public static final String REVIEWEE_EMPLOYEEID_KEY = "employeeId";
	public static final String REVIEWEE_MANAGER_KEY = "manager";
//	name	email	customer	designation	isEmployee	employeeId	manager
	
	public static Map<Integer, String> indexKeyMap = new HashMap<Integer, String>();

	
	static
	{
		indexKeyMap.put(0, REVIEWEE_NAME_KEY);
		indexKeyMap.put(1, REVIEWEE_EMAIL_KEY);
		indexKeyMap.put(2, REVIEWEE_COMPANY_KEY);
		indexKeyMap.put(3, REVIEWEE_DESIGNATION_KEY);
		indexKeyMap.put(4, REVIEWEE_ISEMPLOYEE_KEY);
		indexKeyMap.put(5, REVIEWEE_EMPLOYEEID_KEY);
		indexKeyMap.put(6, REVIEWEE_MANAGER_KEY);
	}
	
	public UserUploadCsvhandler(List<String> additionalResponseHeaders)
	{
		super(additionalResponseHeaders);
	}



	@Override
	protected Map<Integer, String> getIndexKeyMap()
	{
		return indexKeyMap;
	}


}
