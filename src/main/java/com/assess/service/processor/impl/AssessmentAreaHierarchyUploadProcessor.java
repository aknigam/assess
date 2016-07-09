package com.assess.service.processor.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.assess.controllor.csv.AssessmentAreaUploadCsvhandler;
import com.assess.controllor.csv.row.BaseCsvRow;
import com.assess.controllor.csv.row.HashCsvRow;
import com.assess.service.dao.IAssessmnetAreaDao;
import com.assess.service.dao.ICustomerDao;
import com.assess.service.entity.AssessmentArea;
import com.assess.service.entity.Customer;
import com.assess.service.processor.IUploadProcessor;

@Component
public class AssessmentAreaHierarchyUploadProcessor implements IUploadProcessor
{

	private static Logger LOGGER  = Logger.getLogger(AssessmentAreaHierarchyUploadProcessor.class);
	
	@Autowired
	private ICustomerDao m_customerDao;
	
	@Autowired
	private IAssessmnetAreaDao  m_assessmnetAreaDao;
	
	@Override
	@Transactional
	public List<BaseCsvRow> upload(List<BaseCsvRow> csvRows)
	{
		if(csvRows == null || csvRows.size()== 0)
		{
			return csvRows;
		}
		LOGGER.info("Uploading ["+ csvRows.size()+"] assessmnet areas");
		HashCsvRow row =  null;
		List<AssessmentArea> assessmentAreas = new ArrayList();
		
		for (BaseCsvRow baseCsvRow : csvRows)
		{
			if(!(row instanceof HashCsvRow))
			{
//				throw exception()
			}
//			Customer	 AssessmentAreaName	 AssessmentAreaDescription	 ParentAssessmentAreaName
			row = (HashCsvRow) baseCsvRow;
			String customerName = row.getColValue(AssessmentAreaUploadCsvhandler.AA_CUSTOMER_NAME_KEY);
			Customer customer = m_customerDao.getCustomerByName(customerName);
			
			String assessmentAreaName = row.getColValue(AssessmentAreaUploadCsvhandler.AA_NAME_KEY);
			String parentAssessmentAreaName = row.getColValue(AssessmentAreaUploadCsvhandler.AA_PARENT_KEY);
			if(StringUtils.isEmpty(parentAssessmentAreaName.trim()))
			{
				parentAssessmentAreaName = null;
				continue;
			}

			assessmentAreas.add(new AssessmentArea(assessmentAreaName, null, parentAssessmentAreaName, customer));
		}
		m_assessmnetAreaDao.addAssessmentAreaHierarchy(assessmentAreas);
		
		return csvRows;
		

	}

}
