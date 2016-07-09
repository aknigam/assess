package com.assess.service.domain.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.assess.controllor.model.report.FrequencyReportModel;
import com.assess.service.dao.IReportDAO;
import com.assess.service.domain.IReportService;
import com.assess.service.entity.ComparativeReport;
import com.assess.service.entity.IndividualSummaryReport;


@Component
public class ReportService implements IReportService {

	@Autowired
	IReportDAO m_reportDao;
	
	/**
	 * 
	 * 
	 * Each row in this report will have following data:
	 * 
	 * 1. assessment area
	 * 2. question
	 * 3. self rating
	 * 4. manager rating
	 * 5. peer rating
	 * 6. others rating
	 * 7. direct reports rating
	 * 8. client rating
	 * @return 
	 * 
	 * 
	 * 
	 * @see com.assess.service.domain.IReportService#getIndividualSummaryReport(java.lang.Integer)
	 */
	@Transactional
	@Override
	public IndividualSummaryReport getIndividualSummaryReport(Integer userId) {
		
		return m_reportDao.getIndividualSummaryReport(userId);
		
		
	}
	
	
	public FrequencyReportModel getFrequencyReport(Integer userId)
	{
		return m_reportDao.getFrequencyReport(userId);
	}


	@Override
	public ComparativeReport getComparativeReport(Integer userId)
	{
		return m_reportDao.getComparativeReport(userId);
	}


	@Override
	public void getIndividualDetailedReport(Integer userId) {
		m_reportDao.getIndividualDetailedReport(userId);
		
	}

}
