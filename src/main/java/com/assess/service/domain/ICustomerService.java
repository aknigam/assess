package com.assess.service.domain;

import com.assess.form.CustomerForm;
import com.assess.service.entity.Customer;

public interface ICustomerService
{

	Customer getCustomerByName(String customerName);

	void addCustomer(CustomerForm form);


}
