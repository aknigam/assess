package com.assess.service.processor.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.assess.controllor.csv.QuestionUploadCsvhandler;
import com.assess.controllor.csv.row.BaseCsvRow;
import com.assess.controllor.csv.row.HashCsvRow;
import com.assess.service.QuestionTypeEnum;
import com.assess.service.dao.IQuestionDAO;
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
public class QuestionUploadProcessor implements IUploadProcessor
{

	private static Logger LOGGER  = Logger.getLogger(QuestionUploadProcessor.class);
	
	@Autowired
	private IQuestionDAO m_questionDAO;
	
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
		List<Question> questions = new ArrayList();
		
		for (BaseCsvRow baseCsvRow : csvRows)
		{
			if(!(row instanceof HashCsvRow))
			{
//				throw exception()
			}
			// designation	Customer	question	questionType	choice 1	choice 2	choice 3	choice 4	choice 5
			
			row = (HashCsvRow) baseCsvRow;
			String designationName = row.getColValue(QuestionUploadCsvhandler.QUESTION_DESIGNATION_NAME_KEY);
			String customerName = row.getColValue(QuestionUploadCsvhandler.QUESTION_CUSTOMER_KEY);
			String questionStr = row.getColValue(QuestionUploadCsvhandler.QUESTION_KEY);
			String questionType = row.getColValue(QuestionUploadCsvhandler.QUESTION_TYPE_KEY);
			String assessmentAreaName = row.getColValue(QuestionUploadCsvhandler.QUESTION_ASSESSMENT_AREA);
			
			
			
//			String choiceA = row.getColValue(QuestionUploadCsvhandler.QUESTION_CHOICE_A_KEY);
//			String choiceB = row.getColValue(QuestionUploadCsvhandler.QUESTION_CHOICE_B_KEY);
//			String choiceC = row.getColValue(QuestionUploadCsvhandler.QUESTION_CHOICE_C_KEY);
//			String choiceD = row.getColValue(QuestionUploadCsvhandler.QUESTION_CHOICE_D_KEY);
//			String choiceE = row.getColValue(QuestionUploadCsvhandler.QUESTION_CHOICE_E_KEY);
			
			
			
			Customer customer =  m_customerService.getCustomerByName(customerName);
			
			Designation designation = m_designationService.getDesignationByName(designationName);

			if(customer == null)
			{
				//			throw exception()
			}
			QuestionTypeEnum questionTypeEnum = QuestionTypeEnum.valueOf(questionType.toUpperCase());
			if(questionTypeEnum == null)
			{
//				throw exception
			}
			
			Question question = new Question(customer,  designation.getDesignationId(), questionStr, questionTypeEnum);
			question.setAssessmentArea(new AssessmentArea(assessmentAreaName));
			question.setDesignation(new Designation(designationName));
			LOGGER.info(question);
			if(questionTypeEnum == QuestionTypeEnum.MULTIPLE_CHOICE)	
			{
				List<MultipleChoice> choices = new ArrayList();
				parseAndAdddChoice(choices, row.getColValue(QuestionUploadCsvhandler.QUESTION_CHOICE_A_KEY));
				parseAndAdddChoice(choices, row.getColValue(QuestionUploadCsvhandler.QUESTION_CHOICE_B_KEY));
				parseAndAdddChoice(choices, row.getColValue(QuestionUploadCsvhandler.QUESTION_CHOICE_C_KEY));
				parseAndAdddChoice(choices, row.getColValue(QuestionUploadCsvhandler.QUESTION_CHOICE_D_KEY));
				parseAndAdddChoice(choices, row.getColValue(QuestionUploadCsvhandler.QUESTION_CHOICE_E_KEY));
				
//				String ratingA = choiceRatingA== null?null:choiceRatingA[0];
//				String choiceA = choiceRatingA== null?null:choiceRatingA[1];

//				int sequence = 0;
//				if(!StringUtils.isEmpty(choiceA))
//					choices.add(new MultipleChoice(choiceA, sequence++));
//				if(!StringUtils.isEmpty(choiceB))
//					choices.add(new MultipleChoice(choiceB, sequence++));
//				if(!StringUtils.isEmpty(choiceC))
//					choices.add(new MultipleChoice(choiceC, sequence++));
//				if(!StringUtils.isEmpty(choiceD))
//					choices.add(new MultipleChoice(choiceD, sequence++));
//				if(!StringUtils.isEmpty(choiceE))
//					choices.add(new MultipleChoice(choiceE, sequence++));
				
				question.setChoices(choices);
			}
			
			questions.add(question);
		}
		m_questionDAO.addQuestions(questions);
		
		return csvRows;
		

	}

	
	public static void main(String[] args)
	{
		String s = "poor-poor";
		String[] a = s.split("-");
		
		for (String string : a)
		{
			System.out.println(string);
		}
	}
	
	private void parseAndAdddChoice(List<MultipleChoice> choices, String choice) {
		String[] choiceRating = null;
		if(!StringUtils.isEmpty(choice))
		{
			choiceRating = choice.split("-");
			if(choiceRating.length== 2)
			{
				choices.add(new MultipleChoice(choiceRating[1], new RatingScale(choiceRating[0]), 1));
			}
		}
		return;
	}

}
