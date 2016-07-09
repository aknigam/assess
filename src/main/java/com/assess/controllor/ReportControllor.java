package com.assess.controllor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.assess.controllor.model.builder.ComparativeReportModelBuilder;
import com.assess.controllor.model.builder.IndividualSummaryReportModelBuilder;
import com.assess.controllor.model.report.ComparativeReportModel;
import com.assess.controllor.model.report.FrequencyReportModel;
import com.assess.controllor.model.report.IndividualDetailedReportModel;
import com.assess.controllor.model.report.IndividualSummaryReportModel;
import com.assess.service.domain.IReportService;
import com.assess.service.entity.ComparativeReport;
import com.assess.service.entity.IndividualSummaryReport;

@Controller
@RequestMapping("/UserFeedback/")
public class ReportControllor {

	@Autowired
	private IReportService m_ReportService;
	
	@RequestMapping(value = "/individualsummaryjson", method = RequestMethod.GET)
	public @ResponseBody IndividualSummaryReportModel showIndividualSummaryReportJson(Integer userId)
	{
		IndividualSummaryReport report = m_ReportService.getIndividualSummaryReport(userId);
		
		IndividualSummaryReportModel model = new IndividualSummaryReportModelBuilder().build(report);
		return model;
		
	}
	
	@RequestMapping(value = "/individualdetailed", method = RequestMethod.GET)
	public @ResponseBody IndividualDetailedReportModel showIndividualDetailedReport(Integer userId)
	{
		 m_ReportService.getIndividualDetailedReport(userId);
		
		return null;
		
	}
	
	@RequestMapping(value = "/comparativejson", method = RequestMethod.GET)
	public @ResponseBody ComparativeReportModel showComparativeReportJson(Integer userId)
	{
		ComparativeReport report = m_ReportService.getComparativeReport(userId);
		
		ComparativeReportModel model = new ComparativeReportModelBuilder().build(report);
		return model;
		
	}
	

	@RequestMapping(value = "/frequencyreportjson",method = RequestMethod.GET)
	public @ResponseBody FrequencyReportModel getFrequencyReportJson(Integer userId)
	{
		return m_ReportService.getFrequencyReport(userId);
	}
	
	
	@RequestMapping(value = "/individualsummary",method = RequestMethod.GET)
	public ModelAndView showIndividualSummaryReport(Integer userId)
	{
		IndividualSummaryReport report = m_ReportService.getIndividualSummaryReport(userId);
		
		IndividualSummaryReportModel customerReviewerListModel = new IndividualSummaryReportModelBuilder().build(report);
		
		ModelMap model = new ModelMap("report", customerReviewerListModel);
		  
		return new ModelAndView("summary-report", model);
		
	}
	
	
	
	
}
