package com.assess.service.domain;

import com.assess.controllor.model.report.FrequencyReportModel;
import com.assess.service.entity.ComparativeReport;
import com.assess.service.entity.IndividualSummaryReport;

public interface IReportService {

	IndividualSummaryReport getIndividualSummaryReport(Integer userId);
	
	FrequencyReportModel getFrequencyReport(Integer userId);

	ComparativeReport getComparativeReport(Integer userId);

	void getIndividualDetailedReport(Integer userId);

	
	
}
