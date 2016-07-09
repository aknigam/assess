-- ------------------------------------------------------------
-- Following types are possiblle:
-- 
-- 1. Multiple choice with one answer.
-- 2. Multiple choice with more than one answers.
-- 3. Descriptive 
-- 
-- ------------------------------------------------------------

CREATE TABLE RefQuestionType (
  RefQuestionTypeId INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  QuestionType VARCHAR(20) NULL,
  PRIMARY KEY(RefQuestionTypeId)
);

CREATE TABLE Customer (
  CustomerId INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  CustomerName VARCHAR(20) NULL,
  NoOfUserNominatedReviewers INTEGER UNSIGNED NULL,
  NoOfAdminNominatedReviewers INTEGER UNSIGNED NULL,
  PRIMARY KEY(CustomerId)
);

CREATE TABLE AppAuth (
  AppAuthId INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  AuthName VARCHAR(20) NULL,
  AuthDescription VARCHAR(255) NULL,
  PRIMARY KEY(AppAuthId)
);

CREATE TABLE AppRole (
  AppRoleId INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  RoleName VARCHAR(20) NULL,
  RoleDescription VARCHAR(255) NULL,
  PRIMARY KEY(AppRoleId)
);

CREATE TABLE Designation (
  DesignationId INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  CustomerId INTEGER UNSIGNED NOT NULL,
  Name VARCHAR(20) NULL,
  Description VARCHAR(20) NULL,
  PRIMARY KEY(DesignationId),
  INDEX employee_role_FKIndex1(CustomerId),
  FOREIGN KEY(CustomerId)
    REFERENCES Customer(CustomerId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE RatingScale (
  RatingScaleId INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  CustomerId INTEGER UNSIGNED NOT NULL,
  Ranking INTEGER UNSIGNED NULL,
  Name VARCHAR(20) NULL,
  PRIMARY KEY(RatingScaleId),
  INDEX customer_rating_scale_FKIndex1(CustomerId),
  FOREIGN KEY(CustomerId)
    REFERENCES Customer(CustomerId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Question (
  QuestionId INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  RefQuestionType_RefQuestionTypeId INTEGER UNSIGNED NOT NULL,
  CustomerId INTEGER UNSIGNED NOT NULL,
  Question VARCHAR(255) NULL,
  PRIMARY KEY(QuestionId),
  INDEX feedback_questions_FKIndex2(CustomerId),
  FOREIGN KEY(RefQuestionType_RefQuestionTypeId)
    REFERENCES RefQuestionType(RefQuestionTypeId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(CustomerId)
    REFERENCES Customer(CustomerId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE AppRoleAuth (
  AppRoleAuthId INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  AppAuthId INTEGER UNSIGNED NOT NULL,
  AppRoleId INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(AppRoleAuthId),
  INDEX AppRoleAuth_FKIndex1(AppRoleId),
  INDEX AppRoleAuth_FKIndex2(AppAuthId),
  FOREIGN KEY(AppRoleId)
    REFERENCES AppRole(AppRoleId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(AppAuthId)
    REFERENCES AppAuth(AppAuthId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE DesignationQuestion (
  DesignationQuestionId INTEGER UNSIGNED NOT NULL,
  QuestionId INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(DesignationQuestionId, QuestionId),
  INDEX employee_role_has_feedback_questions_FKIndex1(DesignationQuestionId),
  FOREIGN KEY(DesignationQuestionId)
    REFERENCES Designation(DesignationId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(QuestionId)
    REFERENCES Question(QuestionId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Employee (
  EmployeeId INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  AppRoleId INTEGER UNSIGNED NOT NULL,
  DesignationId INTEGER UNSIGNED NOT NULL,
  CustomerId INTEGER UNSIGNED NOT NULL,
  managerId INTEGER UNSIGNED NOT NULL,
  Name VARCHAR(20) NULL,
  Email VARCHAR(20) NULL,
  IsEmployee BOOL NULL,
  UserPassword VARCHAR(40) NULL,
  PRIMARY KEY(EmployeeId),
  INDEX employee_FKIndex1(DesignationId),
  INDEX employee_FKIndex2(CustomerId),
  INDEX employee_FKIndex3(managerId),
  INDEX Employee_FKIndex4(AppRoleId),
  FOREIGN KEY(DesignationId)
    REFERENCES Designation(DesignationId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(CustomerId)
    REFERENCES Customer(CustomerId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(managerId)
    REFERENCES Employee(employeeId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(AppRoleId)
    REFERENCES AppRole(AppRoleId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE MultipleChoice (
  MultipleChoiceId INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  QuestionId INTEGER UNSIGNED NOT NULL,
  Answer VARCHAR(40) NULL,
  Sequesnce INTEGER UNSIGNED NULL,
  PRIMARY KEY(MultipleChoiceId),
  FOREIGN KEY(QuestionId)
    REFERENCES Question(QuestionId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE CustomerEmployeeReviewer (
  CustomerEmployeeReviewerId INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  reviewerId INTEGER UNSIGNED NOT NULL,
  EmployeeId INTEGER UNSIGNED NOT NULL,
  NominatedBy INTEGER UNSIGNED NULL,
  FeedbackStatus VARCHAR(20) NULL,
  PRIMARY KEY(CustomerEmployeeReviewerId),
  INDEX CustomerEmployeeReviewer_FKIndex1(EmployeeId),
  FOREIGN KEY(EmployeeId)
    REFERENCES Employee(employeeId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(ReviewerId)
    REFERENCES Employee(employeeId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE EmployeeFeedbackAnswer (
  EmployeeFeedbackAnswerId INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  EmployeeReviewerId INTEGER UNSIGNED NOT NULL,
  QuestionId INTEGER UNSIGNED NOT NULL,
  DescriptiveAnswer TEXT NULL,
  PRIMARY KEY(EmployeeFeedbackAnswerId),
  INDEX EmployeeFeedback_FKIndex1(EmployeeReviewerId),
  FOREIGN KEY(EmployeeReviewerId)
    REFERENCES CustomerEmployeeReviewer(CustomerEmployeeReviewerId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(QuestionId)
    REFERENCES Question(QuestionId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE MultipleChoiceAnswer (
  MultipleChoiceAnswerId INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  EmployeeFeedbackAnswerId INTEGER UNSIGNED NOT NULL,
  MultipleChoice_MultipleChoiceId INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY(MultipleChoiceAnswerId),
  INDEX multipleChoiceAnswer_FKIndex1(EmployeeFeedbackAnswerId),
  FOREIGN KEY(EmployeeFeedbackAnswerId)
    REFERENCES EmployeeFeedbackAnswer(EmployeeFeedbackAnswerId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(MultipleChoice_MultipleChoiceId)
    REFERENCES MultipleChoice(MultipleChoiceId)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

