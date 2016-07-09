
-- CREATE DATABASE `assess_new` /*!40100 DEFAULT CHARACTER SET latin1 */;
-- DROP DATABASE `assess_new`;
--  use assess_new;


CREATE TABLE `AppAuth` (
  `AppAuthId` int(10) unsigned NOT NULL,
  `AuthName` varchar(20) NOT NULL,
  `AuthDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`AppAuthId`),
  UNIQUE KEY `authname_ukey` (`AuthName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `AppRole` (
  `AppRoleId` int(10) unsigned NOT NULL,
  `RoleName` varchar(20) NOT NULL,
  `RoleDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`AppRoleId`),
  UNIQUE KEY `approle_ukey` (`RoleName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `Customer` (
  `CustomerId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CustomerName` varchar(20) NOT NULL,
  `NoOfUserNominatedReviewers` int(10) unsigned DEFAULT NULL,
  `NoOfAdminNominatedReviewers` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`CustomerId`),
  UNIQUE KEY `Customer_name_ukey` (`CustomerName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Department` (
  `DepartmentId` int(11) NOT NULL AUTO_INCREMENT,
  `DepartmentName` varchar(45) NOT NULL,
  PRIMARY KEY (`DepartmentId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;


CREATE TABLE `RefFeedbackStatus` (
  `RefFeedbackStatusId` int(10) unsigned NOT NULL,
  `RefFeedbackStatusName` varchar(20) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`RefFeedbackStatusId`),
  UNIQUE KEY `RefFeedbackStatus_index1351` (`RefFeedbackStatusName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `RefQuestionType` (
  `RefQuestionTypeId` int(10) unsigned NOT NULL ,
  `QuestionType` varchar(20) NOT NULL,
  PRIMARY KEY (`RefQuestionTypeId`),
  UNIQUE KEY `RefQuestionType_QuestionType_ukey` (`QuestionType`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ------------------------------------------------------------------------------
-- MASTER TABLES END
-- ------------------------------------------------------------------------------


CREATE TABLE `RatingScale` (
  `RatingScaleId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CustomerId` int(10) unsigned NOT NULL,
  `Ranking` int(10) unsigned NOT NULL,
  `Name` varchar(20) NOT NULL,
  PRIMARY KEY (`RatingScaleId`),
  KEY `customer_rating_scale_FKIndex1` (`CustomerId`),
  CONSTRAINT `ratingscale_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;



CREATE TABLE `AppRoleAuth` (
  `AppRoleAuthId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `AppAuthId` int(10) unsigned NOT NULL,
  `AppRoleId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`AppRoleAuthId`),
  KEY `AppRoleAuth_FKIndex1` (`AppRoleId`),
  KEY `AppRoleAuth_FKIndex2` (`AppAuthId`),
  UNIQUE KEY `authROLE_ukey` (`AppAuthId`, `AppRoleId`),
  CONSTRAINT `approleauth_ibfk_1` FOREIGN KEY (`AppRoleId`) REFERENCES `AppRole` (`AppRoleId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `approleauth_ibfk_2` FOREIGN KEY (`AppAuthId`) REFERENCES `AppAuth` (`AppAuthId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



CREATE TABLE `Designation` (
  `DesignationId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CustomerId` int(10) unsigned NOT NULL,
  `Name` varchar(20) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DesignationId`),
  UNIQUE KEY `customer_designation_ukey` (`CustomerId`,`Name`),
  KEY `employee_role_FKIndex1` (`CustomerId`),
  CONSTRAINT `designation_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;


CREATE TABLE `AssessmentArea` (
  `AssessmentAreaId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CustomerId` int(10) unsigned NOT NULL,
  `AssessmentAreaName` varchar(20) NOT NULL,
  `AssessmentAreaDescription` varchar(255) DEFAULT NULL,
  `ParentAssessmentAreaId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`AssessmentAreaId`),
  KEY `AssessmentArea_FKIndex1` (`CustomerId`),
  KEY `AssessmentArea_Index2` (`ParentAssessmentAreaId`),
  UNIQUE KEY `customer_assessmentarea_ukey` (`CustomerId`,`AssessmentAreaName`),
  CONSTRAINT `assessmentarea_ibfk_2` FOREIGN KEY (`ParentAssessmentAreaId`) REFERENCES `AssessmentArea` (`AssessmentAreaId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `assessmentarea_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;


CREATE TABLE `Question` (
  `QuestionId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RefQuestionTypeId` int(10) unsigned NOT NULL,
  `CustomerId` int(10) unsigned NOT NULL,
  `Question` varchar(255) NOT NULL,
  `DesignationId` int(10) unsigned NOT NULL,
  `AssessmentAreaId` int(10) unsigned NOT NULL,
  `SerialOrder` int(10) NOT NULL,
  PRIMARY KEY (`QuestionId`),
  KEY `feedback_questions_FKIndex2` (`CustomerId`),
  KEY `RefQuestionType_RefQuestionTypeId` (`RefQuestionTypeId`),
  KEY `question_ibfk_3` (`DesignationId`),
  UNIQUE KEY `customer_question_assessmentarea_ukey` (`CustomerId`,`Question`,`DesignationId`, `AssessmentAreaId`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`RefQuestionTypeId`) REFERENCES `RefQuestionType` (`RefQuestionTypeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `question_ibfk_2` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `question_ibfk_3` FOREIGN KEY (`DesignationId`) REFERENCES `Designation` (`DesignationId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `question_ibfk_4` FOREIGN KEY (`AssessmentAreaId`) REFERENCES `AssessmentArea` (`AssessmentAreaId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=latin1;



CREATE TABLE `MultipleChoice` (
  `MultipleChoiceId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `QuestionId` int(10) unsigned NOT NULL,
  `Answer` varchar(40) NOT NULL,
  `Sequence` int(10) unsigned NOT NULL,
  `RatingScaleId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`MultipleChoiceId`),
  KEY `QuestionId` (`QuestionId`),
  CONSTRAINT `multiplechoice_ibfk_1` FOREIGN KEY (`QuestionId`) REFERENCES `Question` (`QuestionId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `multiplechoice_ibfk_2` FOREIGN KEY (`RatingScaleId`) REFERENCES `RatingScale` (`RatingScaleId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=latin1;


CREATE TABLE `AppUser` (
  `AppUserId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ManagerId` int(10) unsigned DEFAULT NULL, -- will be null for external user or top most executince of the company
  `AppRoleId` int(10) unsigned NOT NULL,
  `DesignationId` int(10) unsigned DEFAULT NULL, -- will be null for external user
  `CustomerId` int(10) unsigned DEFAULT NULL, -- -- will be null for admin user
  `Name` varchar(20) NOT NULL,
  `Email` varchar(20) NOT NULL,
  `IsEmployee` tinyint(1) NOT NULL,
  `UserPassword` varchar(40) NOT NULL,
  `EmployeeId` int(10) unsigned DEFAULT NULL, -- will be null for external user
  `DepartmentId` int(10) DEFAULT NULL, -- will be null for external user
  PRIMARY KEY (`AppUserId`),
  UNIQUE KEY `appUser_email_ukey` (`Email`),
  KEY `employee_FKIndex1` (`DesignationId`),
  KEY `employee_FKIndex2` (`CustomerId`),
  KEY `employee_FKIndex3` (`ManagerId`),
  KEY `Employee_FKIndex4` (`AppRoleId`),
  KEY `appuser_ibfk_5_idx` (`DepartmentId`),
  CONSTRAINT `appuser_ibfk_1` FOREIGN KEY (`DesignationId`) REFERENCES `Designation` (`DesignationId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `appuser_ibfk_2` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `appuser_ibfk_3` FOREIGN KEY (`ManagerId`) REFERENCES `AppUser` (`AppUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `appuser_ibfk_4` FOREIGN KEY (`AppRoleId`) REFERENCES `AppRole` (`AppRoleId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `appuser_ibfk_5` FOREIGN KEY (`DepartmentId`) REFERENCES `Department` (`DepartmentId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `appuser_ibfk_6` FOREIGN KEY (`ManagerId`) REFERENCES `AppUser` (`AppUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

-- CREATED TILL NOW

-- CREATE TABLE `RefFeedbackStatus` (
--  `RefFeedbackStatusId` int(10) unsigned NOT NULL,

/*

CREATE TABLE `RefFeedbackStatus` (
  `RefFeedbackStatusId` int(10) unsigned NOT NULL,
  `RefFeedbackStatusName` varchar(20) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  UNIQUE KEY `RefFeedbackStatus_index1351` (`RefFeedbackStatusName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

*/

CREATE TABLE `CustomerUserReviewer` (
  `AppUserReviewerId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ReviewerId` int(10) unsigned NOT NULL,
  `RevieweeId` int(10) unsigned NOT NULL,
  `NominatedBy` int(10) unsigned NOT NULL,
  `FeedbackStatusId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`AppUserReviewerId`),
  UNIQUE KEY `customeruserreviewer_reviewer_reviewee_ukey` (`ReviewerId`,`RevieweeId`),
  KEY `CustomerEmployeeReviewer_FKIndex1` (`ReviewerId`),
  KEY `RevieweeId` (`RevieweeId`),
  KEY `FeedbackStatusId` (`FeedbackStatusId`),
  CONSTRAINT `customeruserreviewer_ibfk_1` FOREIGN KEY (`ReviewerId`) REFERENCES `AppUser` (`AppUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customeruserreviewer_ibfk_2` FOREIGN KEY (`RevieweeId`) REFERENCES `AppUser` (`AppUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `customeruserreviewer_ibfk_3` FOREIGN KEY (`FeedbackStatusId`) REFERENCES `RefFeedbackStatus` (`RefFeedbackStatusId`) ON DELETE NO ACTION ON UPDATE NO ACTION 
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;



CREATE TABLE `EmployeeFeedbackAnswer` (
  `EmployeeFeedbackAnswerId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `AppUserReviewerId` int(10) unsigned NOT NULL,
  `QuestionId` int(10) unsigned NOT NULL,
  `DescriptiveAnswer` text,
  PRIMARY KEY (`EmployeeFeedbackAnswerId`),
  UNIQUE KEY `employeefeedbackanswer_AppUserReviewer_question_ukey` (`AppUserReviewerId`,`QuestionId`),
  KEY `AppUserReviewerId` (`AppUserReviewerId`),
  KEY `QuestionId` (`QuestionId`),
  CONSTRAINT `employeefeedbackanswer_ibfk_1` FOREIGN KEY (`AppUserReviewerId`) REFERENCES `CustomerUserReviewer` (`AppUserReviewerId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `employeefeedbackanswer_ibfk_2` FOREIGN KEY (`QuestionId`) REFERENCES `Question` (`QuestionId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=latin1;


CREATE TABLE `MultipleChoiceAnswer` (
  `MultipleChoiceAnswerId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `EmployeeFeedbackAnswerId` int(10) unsigned NOT NULL,
  `MultipleChoiceId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`MultipleChoiceAnswerId`),
  UNIQUE KEY `multiplechoiceanswer_AppUserFeedbackAnswer_MultipleChoice_ukey` (`EmployeeFeedbackAnswerId`,`MultipleChoiceId`),
  KEY `multipleChoiceAnswer_FKIndex1` (`EmployeeFeedbackAnswerId`),
  KEY `MultipleChoice_MultipleChoiceId` (`MultipleChoiceId`),
  CONSTRAINT `multiplechoiceanswer_ibfk_1` FOREIGN KEY (`EmployeeFeedbackAnswerId`) REFERENCES `EmployeeFeedbackAnswer` (`EmployeeFeedbackAnswerId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `multiplechoiceanswer_ibfk_2` FOREIGN KEY (`MultipleChoiceId`) REFERENCES `MultipleChoice` (`MultipleChoiceId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

/*
CREATE TABLE `DesignationQuestion` (
  `DesignationQuestionId` int(10) unsigned NOT NULL,
  `QuestionId` int(10) unsigned NOT NULL,
  `DesignationId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`DesignationQuestionId`),
  KEY `employee_role_has_feedback_questions_FKIndex1` (`DesignationQuestionId`),
  KEY `QuestionId` (`QuestionId`),
  KEY `designationquestion_ibfk_3` (`DesignationId`),
  CONSTRAINT `designationquestion_ibfk_2` FOREIGN KEY (`QuestionId`) REFERENCES `Question` (`QuestionId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `designationquestion_ibfk_3` FOREIGN KEY (`DesignationId`) REFERENCES `Designation` (`DesignationId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
*/
