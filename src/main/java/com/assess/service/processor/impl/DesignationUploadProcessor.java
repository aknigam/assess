package com.assess.service.processor.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.assess.controllor.csv.DesignationUploadCsvhandler;
import com.assess.controllor.csv.row.BaseCsvRow;
import com.assess.controllor.csv.row.HashCsvRow;
import com.assess.service.dao.IDesignationDAO;
import com.assess.service.domain.ICustomerService;
import com.assess.service.entity.Customer;
import com.assess.service.entity.Designation;
import com.assess.service.processor.IUploadProcessor;

@Component
public class DesignationUploadProcessor implements IUploadProcessor
{

	private static Logger LOGGER  = Logger.getLogger(DesignationUploadProcessor.class);
	
	@Autowired
	private IDesignationDAO m_designationDAO;
	
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
		LOGGER.info("Uploading ["+ csvRows.size()+"] designations");
		HashCsvRow row =  null;
		List<Designation> designations = new ArrayList();
		
		for (BaseCsvRow baseCsvRow : csvRows)
		{
			if(!(row instanceof HashCsvRow))
			{
//				throw exception()
			}
				
			row = (HashCsvRow) baseCsvRow;
			String name = row.getColValue(DesignationUploadCsvhandler.DESIGNATION_NAME_KEY);
			String description = row.getColValue(DesignationUploadCsvhandler.DESIGNATION_DESCRIPTION_KEY);
			String customerName = row.getColValue(DesignationUploadCsvhandler.DESIGNATION_CUSTOMER_KEY);
			Customer customer =  m_customerService.getCustomerByName(customerName);

			if(customer == null)
			{
				//			throw exception()
			}
			designations.add(new Designation(customer.getCustomerId(),  name, description));
		}
		m_designationDAO.addDesignations(designations);
		
		return csvRows;
		

	}

}
