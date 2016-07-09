package com.assess.controllor.model.builder;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.assess.controllor.model.FeedbackModel;
import com.assess.controllor.model.FeedbackModel.Choice;
import com.assess.controllor.model.FeedbackModel.Competency;
import com.assess.controllor.model.FeedbackModel.QuestionAnswer;
import com.assess.controllor.model.FeedbackModel.SubCompetency;
import com.assess.service.QuestionTypeEnum;
import com.assess.service.entity.CustomerUserReviewer;
import com.assess.service.entity.EmployeeFeedbackAnswer;
import com.assess.service.entity.MultipleChoice;
import com.assess.service.entity.Question;

public class FeedbackModelBuilder {

	public FeedbackModel build(CustomerUserReviewer cur) 
	{
		FeedbackModel model = new FeedbackModel();
		
		model.setAppUserReviewerId(cur.getAppUserReviewerId());
		model.setDesignationId(cur.getReviewee().getDesignation().getDesignationId());
		model.setRevieweeId(cur.getReviewee().getAppUserId());
		
		List<EmployeeFeedbackAnswer> answers = cur.getEmployeeFeedbackAnswers();
		
		Map<Integer, EmployeeFeedbackAnswer> qaMap = new HashMap();
		
		for (EmployeeFeedbackAnswer efa : answers) {
			qaMap.put(efa.getQuestion().getQuestionId(), efa);
		}
		
		List<Question> questions = cur.getReviewee().getDesignation().getQuestions();
		
		
		List<QuestionAnswer> qaList = model.getQuestionAnswers();
		for (Question question : questions) {
			QuestionAnswer  qa = new FeedbackModel.QuestionAnswer(question.getQuestionId(), question.getQuestionTypeEnum().getId(),  question.getQuestion());
			
			qaList.add(qa);
			List<MultipleChoice> mclist = question.getChoices();
			for (MultipleChoice mc : mclist) {
				qa.getChoices().add(new Choice(mc.getMultipleChoiceId(), mc.getAnswer()));
			}
			
			EmployeeFeedbackAnswer efa = qaMap.get(question.getQuestionId());
			if(efa == null)
				continue;
			if(question.getQuestionTypeEnum() == QuestionTypeEnum.DESCRIPTIVE)
			{
				qa.setDescriptiveAnswer(efa.getDescriptiveAnswer());
			}
			else
			{
				qa.setMultipleChoiceAnswerId(efa.getMultipleChoiceAnswer().getMultipleChoiceId());
				
				
			}
			
		}
		model.setQuestionAnswers(qaList);
		
		return model;

	}
	
	public FeedbackModel build1(CustomerUserReviewer cur) 
	{
		FeedbackModel model = new FeedbackModel();
		
		model.setAppUserReviewerId(cur.getAppUserReviewerId());
		model.setDesignationId(cur.getReviewee().getDesignation().getDesignationId());
		model.setRevieweeId(cur.getReviewee().getAppUserId());
		
		List<EmployeeFeedbackAnswer> answers = cur.getEmployeeFeedbackAnswers();
		
		Map<Integer, EmployeeFeedbackAnswer> qaMap = new HashMap();
		
		Map<String, Competency> competencymap = new HashMap();
		Map<String, SubCompetency> subCompetencymap = new HashMap();
		
		for (EmployeeFeedbackAnswer efa : answers) {
			qaMap.put(efa.getQuestion().getQuestionId(), efa);
		}
		
		List<Question> questions = cur.getReviewee().getDesignation().getQuestions();
		
		
		List<QuestionAnswer> qaList = model.getQuestionAnswers();
		
		for (Question question : questions) {
			
			String subCompetency = question.getAssessmentArea().getAssessmentAreaName();
			
			String competency = question.getAssessmentArea().getParentAssessmentArea() == null?"":question.getAssessmentArea().getParentAssessmentArea().getAssessmentAreaName();
			
			Competency c = getCompetency(competencymap, model, competency);
			SubCompetency sc = getSubCompetency(subCompetencymap, c, subCompetency);
			
			
			
			QuestionAnswer  qa = new FeedbackModel.QuestionAnswer(question.getQuestionId(), question.getQuestionTypeEnum().getId(),  question.getQuestion());
			
			sc.getQuestionAnswers().add(qa);
//			qaList.add(qa);
			List<MultipleChoice> mclist = question.getChoices();
			for (MultipleChoice mc : mclist) {
				qa.getChoices().add(new Choice(mc.getMultipleChoiceId(), mc.getAnswer()));
			}
			
			EmployeeFeedbackAnswer efa = qaMap.get(question.getQuestionId());
			if(efa == null)
				continue;
			if(question.getQuestionTypeEnum() == QuestionTypeEnum.DESCRIPTIVE)
			{
				qa.setDescriptiveAnswer(efa.getDescriptiveAnswer());
			}
			else
			{
				qa.setMultipleChoiceAnswerId(efa.getMultipleChoiceAnswer().getMultipleChoiceId());
				
				
			}
			
		}
		model.setQuestionAnswers(qaList);
		
		return model;

	}

	private SubCompetency getSubCompetency(Map<String, SubCompetency> subCompetencymap,
			Competency c, String subCompetency)
	{
		
		SubCompetency sc= subCompetencymap.get(subCompetency);
		if(sc == null)
		{
			sc = new SubCompetency(subCompetency);
			c.getSubCompetencies().add(sc);
			subCompetencymap.put(subCompetency, sc);
		}
		
		return sc;
	}

	private Competency getCompetency(Map<String, Competency> competencymap, FeedbackModel model,
			String competency)
	{
		
		Competency c = competencymap.get(competency);
		if(c == null)
		{
			c = new Competency(competency);
			model.getCompetencies().add(c);
			competencymap.put(competency, c);
		}
		
		return c;
	}
	
}
