-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AssessmentAreaParentUpdate`(
	pAssessmentAreaName varchar(20),
	pParentAssessmentAreaName varchar(20)

)
BEGIN

	DECLARE AaId, pAaId INT DEFAULT 0;
	Select AssessmentAreaId into AaId from AssessmentArea where AssessmentAreaName =  pAssessmentAreaName;
	Select AssessmentAreaId into pAaId from AssessmentArea where AssessmentAreaName =  pParentAssessmentAreaName;

	update AssessmentArea  set ParentAssessmentAreaId = pAaId where AssessmentAreaId =  AaId;

	


END