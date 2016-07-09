package com.assess.service.dao;

import com.assess.service.entity.Customer;

public interface ICustomerDao
{

	Customer getCustomerByName(String customerName);

	void addCustomer(Customer customer);

}
