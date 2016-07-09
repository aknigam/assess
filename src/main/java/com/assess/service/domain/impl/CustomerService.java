package com.assess.service.domain.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.assess.form.CustomerForm;
import com.assess.service.dao.ICustomerDao;
import com.assess.service.domain.ICustomerService;
import com.assess.service.entity.Customer;

@Component
public class CustomerService implements ICustomerService
{

	@Autowired
	private ICustomerDao customerDao;
	
	@Override
	@Cacheable("customerNameCache")
	@Transactional
	public Customer getCustomerByName(String customerName)
	{
		
		return customerDao.getCustomerByName(customerName);
	}

	@Override
	@Transactional
	public void addCustomer(CustomerForm form) {
		Customer customer = new Customer(form.getCustomerName(), form.getNoOfUserNominatedReviewers(), form.getNoOfAdminNominatedReviewers());
		customerDao.addCustomer(customer);
	}


}
