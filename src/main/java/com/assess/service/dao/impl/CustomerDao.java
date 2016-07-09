package com.assess.service.dao.impl;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import com.assess.service.dao.ICustomerDao;
import com.assess.service.entity.Customer;

@Component
public class CustomerDao extends BaseDao implements ICustomerDao
{

	private static String customerNameQuery = "Select CustomerId from Customer where CustomerName = ?";
	
	private static String insertCustomerQuery = "insert into Customer (CustomerName, NoOfUserNominatedReviewers, NoOfAdminNominatedReviewers) values (?,?,?)";
	
	@SuppressWarnings("deprecation")
	@Override
	public Customer getCustomerByName(String customerName)
	{
		try {
			int customerId =  m_assessDbTemplate.queryForInt(customerNameQuery, new String[]{customerName});
			return new Customer(customerId, customerName);
		} catch (DataAccessException e) {
			// EmptyResultDataAccessException is thrown when customer table is empty or no matching customer is found.
			// TODO: handle exception
			return null;
		}
		
		
	}

	@Override
	public void addCustomer(Customer customer) {

		if(customer.getCustomerId()!=null)
		{
			System.out.println("update");
		}
		else
		{
			Object[] args = new Object[]{customer.getCustomerName(), customer.getNoOfUserNominatedReviewers(), customer.getNoOfAdminNominatedReviewers()};
			int out = m_assessDbTemplate.update(insertCustomerQuery, args);
		}
		
	}

}
