package com.assess.service.processor.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.assess.controllor.csv.CustomerUploadCsvhandler;
import com.assess.controllor.csv.row.BaseCsvRow;
import com.assess.controllor.csv.row.HashCsvRow;
import com.assess.service.dao.ICustomerDao;
import com.assess.service.entity.Customer;
import com.assess.service.processor.IUploadProcessor;

@Component
public class CustomerUploadProcessor implements IUploadProcessor
{

	private static Logger LOGGER  = Logger.getLogger(CustomerUploadProcessor.class);
	
	@Autowired
	private ICustomerDao m_customerDao;
	
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
		List<Customer> customers = new ArrayList();
		
		for (BaseCsvRow baseCsvRow : csvRows)
		{
			if(!(row instanceof HashCsvRow))
			{
//				throw exception()
			}
			row = (HashCsvRow) baseCsvRow;
			String name = row.getColValue(CustomerUploadCsvhandler.CUSTOMER_NAME_KEY);
			Integer noOfUserNominatedReviewers = Integer.parseInt(row.getColValue(CustomerUploadCsvhandler.CUSTOMER_UNR_KEY));
			Integer noOfAdminNominatedReviewers = Integer.parseInt(row.getColValue(CustomerUploadCsvhandler.CUSTOMER_ANR_KEY));

			customers.add(new Customer(name, noOfUserNominatedReviewers, noOfAdminNominatedReviewers));
		}
//		m_customerDao.addCustomers(customers);
		
		return csvRows;
		

	}

}
