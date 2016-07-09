package com.assess.service.dao;

import java.util.List;

import com.assess.service.entity.Designation;

public interface IDesignationDAO
{

	void addDesignations(List<Designation> designations);

	Designation getDesignationByName(String designationName);

}
