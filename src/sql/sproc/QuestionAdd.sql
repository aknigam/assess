-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `QuestionAdd#1`(
	pdesignation varchar(20),
	pCustomer varchar(20),
	pquestion varchar(255),
	pquestionType varchar(20),
	pAssessmentarea varchar(20),
	pchoiceA varchar(40),
	pchoiceB varchar(40),
	pchoiceC varchar(40),
	pchoiceD varchar(40),
	pchoiceE varchar(40),
	pchoiceF varchar(40),
	pchoiceG varchar(40),
	pchoiceRatingScaleA varchar(40),
	pchoiceRatingScaleB varchar(40),
	pchoiceRatingScaleC varchar(40),
	pchoiceRatingScaleD varchar(40),
	pchoiceRatingScaleE varchar(40),
	pchoiceRatingScaleF varchar(40),
	pchoiceRatingScaleG varchar(40)
	
)
BEGIN

	DECLARE vdesignationId, vCustomerId, vAssessmentAreaid , vRefQuestiontypeId , vQuestionId , vRatingScale INT DEFAULT 0;

	
	select AssessmentAreaId into vAssessmentAreaid from AssessmentArea where assessmentAreaname =  pAssessmentarea;
	select CustomerId into vCustomerId from Customer where CustomerName =  pCustomer;
	select designationId into vdesignationId from Designation where `Name` =  pdesignation;
	select RefQuestionTypeId into vRefQuestiontypeId from RefQuestionType where QuestionType = pquestionType;
	select vdesignationId, vCustomerId, vAssessmentAreaid , vRefQuestiontypeId;

	INSERT INTO QUESTION (designationId, refQuestionTypeId, CustomerId, Question, AssessmentAreaId, SerialOrder) values (vdesignationId, vRefQuestiontypeId,vCustomerId, pquestion , vAssessmentAreaid, 1);

	select questionId into vQuestionId from Question where question = pquestion;
	select vQuestionId;
	
	if(vRefQuestiontypeId = 2)
	then
		if(pchoiceA is not null)
		then
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleA;
			INSERT INTO MultipleChoice (questionid, answer, sequence, RatingScaleid) values (vQuestionId,pchoiceA,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceA;

		ELSE
			select  pchoiceA;
		end If;


		if(pchoiceB is not null)
		then
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleB;
			INSERT INTO MultipleChoice (questionid, answer, sequence) values (vQuestionId,pchoiceB,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceB;
		ELSE
			select  pchoiceB;
		end If;

		if(pchoiceC is not null)
		then
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleC;
			INSERT INTO MultipleChoice (questionid, answer, sequence) values (vQuestionId,pchoiceC,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceC;
		ELSE
			select  pchoiceC;
		end If;

		if(pchoiceD is not null)
		then
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleD;
			INSERT INTO MultipleChoice (questionid, answer, sequence) values (vQuestionId,pchoiceD,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceD;
		ELSE
			select  pchoiceD;
		end If;

		if(pchoiceE is not null)
		then
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleE;
			INSERT INTO MultipleChoice (questionid, answer, sequence) values (vQuestionId,pchoiceE,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceE;
		ELSE
			select  pchoiceE;
		end If;

		if(pchoiceF is not null)
		then
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleF;
			INSERT INTO MultipleChoice (questionid, answer, sequence) values (vQuestionId,pchoiceF,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceF;
		ELSE
			select  pchoiceF;
		end If;

		if(pchoiceG is not null)
		then
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleG;
			INSERT INTO MultipleChoice (questionid, answer, sequence) values (vQuestionId,pchoiceG,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceG;
		ELSE
			select  pchoiceG;
		end If;
	end if;


END