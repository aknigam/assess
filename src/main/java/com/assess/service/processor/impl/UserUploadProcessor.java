package com.assess.service.processor.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.assess.controllor.csv.UserUploadCsvhandler;
import com.assess.controllor.csv.row.BaseCsvRow;
import com.assess.controllor.csv.row.HashCsvRow;
import com.assess.service.AppRoleEnum;
import com.assess.service.domain.IAppUserService;
import com.assess.service.domain.ICustomerService;
import com.assess.service.domain.IDesignationService;
import com.assess.service.entity.AppUser;
import com.assess.service.entity.Customer;
import com.assess.service.entity.Designation;
import com.assess.service.processor.IUploadProcessor;

@Component
public class UserUploadProcessor implements IUploadProcessor
{

	private static Logger LOGGER  = Logger.getLogger(UserUploadProcessor.class);
	
	@Autowired
	private IAppUserService m_appUserService;
	
	@Autowired
	private ICustomerService m_customerService;
	
	@Autowired
	private IDesignationService m_designationService;
	
	@Override
	@Transactional
	public List<BaseCsvRow> upload(List<BaseCsvRow> csvRows)
	{
		if(csvRows == null || csvRows.size()== 0)
		{
			return csvRows;
		}
		LOGGER.info("Uploading ["+ csvRows.size()+"] designations");
		HashCsvRow row =  null;
		List<AppUser> appUsers = new ArrayList();
		
		boolean isEmployee = true;
		Integer managerId = null;
		String userPassword = "password";
		Integer employeeId = null;
		Integer designationId =null;
		
		for (BaseCsvRow baseCsvRow : csvRows)
		{
			if(!(row instanceof HashCsvRow))
			{
//				throw exception()
			}
			
			row = (HashCsvRow) baseCsvRow;
			
			String name = row.getColValue(UserUploadCsvhandler.REVIEWEE_NAME_KEY);
			String designationName = row.getColValue(UserUploadCsvhandler.REVIEWEE_DESIGNATION_KEY);
			String email = row.getColValue(UserUploadCsvhandler.REVIEWEE_EMAIL_KEY);
			String employeeIdStr = row.getColValue(UserUploadCsvhandler.REVIEWEE_EMPLOYEEID_KEY);
			if(!StringUtils.isEmpty(employeeIdStr))
			{
				employeeId = Integer.valueOf(employeeIdStr);	
			}
			String isEmployeeStr = row.getColValue(UserUploadCsvhandler.REVIEWEE_ISEMPLOYEE_KEY);
			
			if(!StringUtils.isEmpty(isEmployeeStr))
			{
				isEmployee = Boolean.valueOf(isEmployeeStr);	
			}
			
			String manager = row.getColValue(UserUploadCsvhandler.REVIEWEE_MANAGER_KEY);
			manager = manager.trim().equals("")? null:manager;
			String customerName = row.getColValue(UserUploadCsvhandler.REVIEWEE_COMPANY_KEY);
			
			Customer customer =  m_customerService.getCustomerByName(customerName);
			Designation designation = m_designationService.getDesignationByName(designationName);
			

			if(customer == null)
			{
				//			throw exception()
			}
			
			if(designation != null)
			{
				designationId = designation.getDesignationId();
			}
			else
			{
				System.out.println("Designation not found...."+ designationName);
			}

			LOGGER.info("processing : "+ email);
			appUsers.add(new AppUser(manager, AppRoleEnum.USER.getId(), designationId , customer.getCustomerId(), name, email, isEmployee, userPassword, employeeId));
		}
		m_appUserService.addUsers(appUsers);
		
		return csvRows;
		

	}

}
