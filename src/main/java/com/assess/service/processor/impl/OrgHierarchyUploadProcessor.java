package com.assess.service.processor.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.assess.controllor.csv.OrgHierarchyUploadCsvhandler;
import com.assess.controllor.csv.row.BaseCsvRow;
import com.assess.controllor.csv.row.HashCsvRow;
import com.assess.service.dao.IAppUserDAO;
import com.assess.service.domain.ICustomerService;
import com.assess.service.processor.IUploadProcessor;

@Component
public class OrgHierarchyUploadProcessor implements IUploadProcessor
{

	private static Logger LOGGER  = Logger.getLogger(OrgHierarchyUploadProcessor.class);
	
	@Autowired
	private IAppUserDAO  m_appUserDAO;

	
	@Autowired
	private ICustomerService m_customerService;
	
	@Override
	@Transactional
	public List<BaseCsvRow> upload(List<BaseCsvRow> csvRows)
	{
		if(csvRows == null || csvRows.size()== 0)
		{
			return csvRows;
		}
		LOGGER.info("Uploading ["+ csvRows.size()+"] org hierarchy");
		HashCsvRow row =  null;

		Map<String, String> userManagers = new HashMap();
		for (BaseCsvRow baseCsvRow : csvRows)
		{
			if(!(row instanceof HashCsvRow))
			{
//				throw exception()
			}
				
			row = (HashCsvRow) baseCsvRow;
			String userEmail = row.getColValue(OrgHierarchyUploadCsvhandler.OH_USER_EMAIL);
			String managerEmail = row.getColValue(OrgHierarchyUploadCsvhandler.OH_MANAGER_EMAIL);
			userManagers.put(userEmail, managerEmail);
			
		}
		m_appUserDAO.updateHierarchy(userManagers);
		
		return csvRows;
		

	}

}
