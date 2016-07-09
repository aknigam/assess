-- ------------------------------------------------------------
-- Following types are possiblle:
-- 
-- 1. Multiple choice with one answer.
-- 2. Multiple choice with more than one answers.
-- 3. Descriptive 
-- 
-- ------------------------------------------------------------

use assess_temp;

CREATE TABLE AppAuth (
  AppAuthId int(10) unsigned NOT NULL,
  AuthName varchar(20) DEFAULT NULL,
  AuthDescription varchar(255) DEFAULT NULL,
  PRIMARY KEY (AppAuthId),
  CONSTRAINT authname_ukey UNIQUE (AuthName)
) ;

CREATE TABLE AppRole (
  AppRoleId int(10) unsigned NOT NULL ,
  RoleName varchar(20) DEFAULT NULL,
  RoleDescription varchar(255) DEFAULT NULL,
  PRIMARY KEY (AppRoleId),
  CONSTRAINT approle_ukey UNIQUE (RoleName)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE AppRoleAuth (
  AppRoleAuthId int(10) unsigned NOT NULL AUTO_INCREMENT,
  AppAuthId int(10) unsigned NOT NULL,
  AppRoleId int(10) unsigned NOT NULL,
  PRIMARY KEY (AppRoleAuthId),
  KEY AppRoleAuth_FKIndex1 (AppRoleId),
  KEY AppRoleAuth_FKIndex2 (AppAuthId),
  CONSTRAINT approleauth_ibfk_1 FOREIGN KEY (AppRoleId) REFERENCES AppRole (AppRoleId) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT approleauth_ibfk_2 FOREIGN KEY (AppAuthId) REFERENCES AppAuth (AppAuthId) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;


CREATE TABLE Customer (
  CustomerId int(10) unsigned NOT NULL AUTO_INCREMENT,
  CustomerName varchar(20) DEFAULT NULL,
  NoOfUserNominatedReviewers int(10) unsigned DEFAULT NULL,
  NoOfAdminNominatedReviewers int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (CustomerId),
  CONSTRAINT Customer_name_ukey UNIQUE (CustomerName)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;


CREATE TABLE Designation (
  DesignationId int(10) unsigned NOT NULL AUTO_INCREMENT,
  CustomerId int(10) unsigned NOT NULL,
  Name varchar(20) DEFAULT NULL,
  Description varchar(255) DEFAULT NULL,
  PRIMARY KEY (DesignationId),
  UNIQUE KEY customer_designation_ukey (CustomerId,Name),
  KEY employee_role_FKIndex1 (CustomerId),
  CONSTRAINT designation_ibfk_1 FOREIGN KEY (CustomerId) REFERENCES Customer (CustomerId) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;


CREATE TABLE AppUser (
  AppUserId int(10) unsigned NOT NULL AUTO_INCREMENT,
  ManagerId int(10) unsigned DEFAULT NULL,
  AppRoleId int(10) unsigned NOT NULL,
  DesignationId int(10) unsigned DEFAULT NULL,
  CustomerId int(10) unsigned NOT NULL,
  Name varchar(20) NOT NULL,
  Email varchar(20) NOT NULL,
  IsEmployee tinyint(1) NOT NULL,
  UserPassword varchar(40) NOT NULL,
  EmployeeId int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (AppUserId),
  KEY employee_FKIndex1 (DesignationId),
  KEY employee_FKIndex2 (CustomerId),
  KEY employee_FKIndex3 (ManagerId),
  KEY Employee_FKIndex4 (AppRoleId),
  CONSTRAINT appUser_email_ukey UNIQUE (email),
  CONSTRAINT appuser_ibfk_1 FOREIGN KEY (DesignationId) REFERENCES Designation (DesignationId) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT appuser_ibfk_2 FOREIGN KEY (CustomerId) REFERENCES Customer (CustomerId) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT appuser_ibfk_3 FOREIGN KEY (ManagerId) REFERENCES AppUser (AppUserId) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT appuser_ibfk_4 FOREIGN KEY (AppRoleId) REFERENCES AppRole (AppRoleId) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;


CREATE TABLE CustomerUserReviewer (
  AppUserReviewerId int(10) unsigned NOT NULL AUTO_INCREMENT,
  ReviewerId int(10) unsigned NOT NULL,
  RevieweeId int(10) unsigned NOT NULL,
  NominatedBy int(10) unsigned DEFAULT NULL,
  FeedbackStatus varchar(20) DEFAULT NULL,
  PRIMARY KEY (AppUserReviewerId),
  KEY CustomerEmployeeReviewer_FKIndex1 (ReviewerId),
  KEY RevieweeId (RevieweeId),
  CONSTRAINT customeruserreviewer_reviewer_reviewee_ukey UNIQUE (ReviewerId,RevieweeId ),
  CONSTRAINT customeruserreviewer_ibfk_1 FOREIGN KEY (ReviewerId) REFERENCES AppUser (AppUserId) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT customeruserreviewer_ibfk_2 FOREIGN KEY (RevieweeId) REFERENCES AppUser (AppUserId) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;


CREATE TABLE RefQuestionType (
  RefQuestionTypeId int(10) unsigned NOT NULL AUTO_INCREMENT,
  QuestionType varchar(20) DEFAULT NULL,
  PRIMARY KEY (RefQuestionTypeId),
  CONSTRAINT RefQuestionType_QuestionType_ukey UNIQUE (QuestionType)
) ;


CREATE TABLE Question (
  QuestionId int(10) unsigned NOT NULL AUTO_INCREMENT,
  RefQuestionTypeId int(10) unsigned NOT NULL,
  CustomerId int(10) unsigned NOT NULL,
  Question varchar(255) DEFAULT NULL,
  PRIMARY KEY (QuestionId),
  KEY feedback_questions_FKIndex2 (CustomerId),
  KEY RefQuestionType_RefQuestionTypeId (RefQuestionTypeId),
  CONSTRAINT question_ibfk_1 FOREIGN KEY (RefQuestionTypeId) REFERENCES RefQuestionType (RefQuestionTypeId) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT question_ibfk_2 FOREIGN KEY (CustomerId) REFERENCES Customer (CustomerId) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;


CREATE TABLE MultipleChoice (
  MultipleChoiceId int(10) unsigned NOT NULL AUTO_INCREMENT,
  QuestionId int(10) unsigned NOT NULL,
  Answer varchar(40) DEFAULT NULL,
  Sequence int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (MultipleChoiceId),
  KEY QuestionId (QuestionId),
  CONSTRAINT multiplechoice_ibfk_1 FOREIGN KEY (QuestionId) REFERENCES Question (QuestionId) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;


CREATE TABLE DesignationQuestion (
  DesignationQuestionId int(10) unsigned NOT NULL,
  QuestionId int(10) unsigned NOT NULL,
  PRIMARY KEY (DesignationQuestionId,QuestionId),
  KEY employee_role_has_feedback_questions_FKIndex1 (DesignationQuestionId),
  KEY QuestionId (QuestionId),
  CONSTRAINT designationquestion_ibfk_1 FOREIGN KEY (DesignationQuestionId) REFERENCES Designation (DesignationId) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT designationquestion_ibfk_2 FOREIGN KEY (QuestionId) REFERENCES Question (QuestionId) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;

CREATE TABLE EmployeeFeedbackAnswer (
  AppUserFeedbackAnswerId int(10) unsigned NOT NULL AUTO_INCREMENT,
  AppUserReviewerId int(10) unsigned NOT NULL,
  QuestionId int(10) unsigned NOT NULL,
  DescriptiveAnswer text,
  PRIMARY KEY (AppUserFeedbackAnswerId),
  KEY AppUserReviewerId (AppUserReviewerId),
  KEY QuestionId (QuestionId),
  CONSTRAINT employeefeedbackanswer_AppUserReviewer_question_ukey UNIQUE (AppUserReviewerId,QuestionId ),
  CONSTRAINT employeefeedbackanswer_ibfk_1 FOREIGN KEY (AppUserReviewerId) REFERENCES CustomerUserReviewer (AppUserReviewerId) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT employeefeedbackanswer_ibfk_2 FOREIGN KEY (QuestionId) REFERENCES Question (QuestionId) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;

CREATE TABLE MultipleChoiceAnswer (
  MultipleChoiceAnswerId int(10) unsigned NOT NULL AUTO_INCREMENT,
  AppUserFeedbackAnswerId int(10) unsigned NOT NULL,
  MultipleChoiceId int(10) unsigned NOT NULL,
  PRIMARY KEY (MultipleChoiceAnswerId),
  KEY multipleChoiceAnswer_FKIndex1 (AppUserFeedbackAnswerId),
  KEY MultipleChoice_MultipleChoiceId (MultipleChoiceId),
  CONSTRAINT multiplechoiceanswer_AppUserFeedbackAnswer_MultipleChoice_ukey UNIQUE (AppUserFeedbackAnswerId,MultipleChoiceId ),
  CONSTRAINT multiplechoiceanswer_ibfk_1 FOREIGN KEY (AppUserFeedbackAnswerId) REFERENCES EmployeeFeedbackAnswer (AppUserFeedbackAnswerId) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT multiplechoiceanswer_ibfk_2 FOREIGN KEY (MultipleChoiceId) REFERENCES MultipleChoice (MultipleChoiceId) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;


CREATE TABLE RatingScale (
  RatingScaleId int(10) unsigned NOT NULL AUTO_INCREMENT,
  CustomerId int(10) unsigned NOT NULL,
  Ranking int(10) unsigned DEFAULT NULL,
  Name varchar(20) DEFAULT NULL,
  PRIMARY KEY (RatingScaleId),
  KEY customer_rating_scale_FKIndex1 (CustomerId),
  CONSTRAINT ratingscale_ibfk_1 FOREIGN KEY (CustomerId) REFERENCES Customer (CustomerId) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;
