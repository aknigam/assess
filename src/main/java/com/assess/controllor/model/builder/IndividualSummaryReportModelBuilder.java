package com.assess.controllor.model.builder;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.assess.controllor.model.report.IndividualSummaryReportModel;
import com.assess.controllor.model.report.IndividualSummaryReportModel.AssessmentAreaReport;
import com.assess.service.entity.IndividualSummaryReport;

public class IndividualSummaryReportModelBuilder
{

	public IndividualSummaryReportModel build(IndividualSummaryReport report)
	{
		IndividualSummaryReportModel model = new IndividualSummaryReportModel();
		List<AssessmentAreaReport> maars = model.getAssessmentAreaReports();
		
		Map<Integer,  AssessmentAreaReport> aaMap = new HashMap();
		Map<Integer, IndividualSummaryReportModel.QuestionReport> aaqMap = new HashMap();

		List<com.assess.service.entity.IndividualSummaryReport.AssessmentAreaReport> aars = report.getAssessmentAreaReports();
		
		for (com.assess.service.entity.IndividualSummaryReport.AssessmentAreaReport aar : aars)
		{
			maars.add(new AssessmentAreaReport(aar));
		}
		
		return model;

	}
}
