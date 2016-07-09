package com.assess.service.domain.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.assess.service.dao.IDesignationDAO;
import com.assess.service.domain.IDesignationService;
import com.assess.service.entity.Designation;

@Component
public class DesignationService implements IDesignationService {

	@Autowired
	IDesignationDAO m_designationDAO;
	
	@Override
	@Transactional
	public Designation getDesignationByName(String designationName) {
		return m_designationDAO.getDesignationByName(designationName);
	}

}
