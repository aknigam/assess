package com.assess.service.processor.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.assess.controllor.csv.QuestionUploadCsvhandler;
import com.assess.controllor.csv.RatingScaleUploadCsvhandler;
import com.assess.controllor.csv.row.BaseCsvRow;
import com.assess.controllor.csv.row.HashCsvRow;
import com.assess.service.QuestionTypeEnum;
import com.assess.service.dao.IQuestionDAO;
import com.assess.service.dao.IRatingScaleDAO;
import com.assess.service.domain.ICustomerService;
import com.assess.service.domain.IDesignationService;
import com.assess.service.entity.AssessmentArea;
import com.assess.service.entity.Customer;
import com.assess.service.entity.Designation;
import com.assess.service.entity.MultipleChoice;
import com.assess.service.entity.Question;
import com.assess.service.entity.RatingScale;
import com.assess.service.processor.IUploadProcessor;

@Component
public class RatingScaleUploadProcessor implements IUploadProcessor
{

	private static Logger LOGGER  = Logger.getLogger(RatingScaleUploadProcessor.class);
	
	@Autowired
	private IRatingScaleDAO m_ratingScaleDAO;
	
	@Autowired
	private ICustomerService m_customerService;
	
	@Autowired
	private IDesignationService m_designationService;
	
	@Override
	@Transactional
	public List<BaseCsvRow> upload(List<BaseCsvRow> csvRows)
	{
		if(csvRows == null || csvRows.size()== 0)
		{
			return csvRows;
		}
		LOGGER.info("Uploading ["+ csvRows.size()+"] designations");
		HashCsvRow row =  null;
		List<RatingScale>  ratingScales = new ArrayList();
		
		for (BaseCsvRow baseCsvRow : csvRows)
		{
			if(!(row instanceof HashCsvRow))
			{
//				throw exception()
			}
			
			row = (HashCsvRow) baseCsvRow;
			String customerName = row.getColValue(RatingScaleUploadCsvhandler.RS_CUSTOMER_NAME_KEY);
			Integer ranking = Integer.parseInt(row.getColValue(RatingScaleUploadCsvhandler.RS_RANKING_KEY));
			String name = row.getColValue(RatingScaleUploadCsvhandler.RS_NAME_KEY);
			
			
			ratingScales.add(new RatingScale(name, ranking, new Customer(null, customerName)));
		}
		m_ratingScaleDAO.addRatingScales(ratingScales);
		
		return csvRows;
		

	}

}
