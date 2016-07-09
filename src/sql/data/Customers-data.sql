INSERT INTO assess.Customer (CustomerId, CustomerName, NoOfUserNominatedReviewers, NoOfAdminNominatedReviewers) VALUES ('1', 'Expedia1', '2', '2');


insert into Appuser (AppRoleId , CustomerId, Name, Email, IsEmployee, UserPassword, EmployeeId ) values (1, 1, 'Adminitrator user', 'admin@assess.com', 0, 'password', null)

use assess_new;

INSERT INTO AppRole(AppRoleId,RoleName,RoleDescription) VALUES (1, 'admin', 'Adminsitrator');
INSERT INTO AppRole(AppRoleId,RoleName,RoleDescription) VALUES (2, 'user', 'Normal user');

INSERT INTO ratingscale (CustomerId, Ranking, Name) VALUES ('1', '1', 'poor');
INSERT INTO ratingscale (CustomerId, Ranking, Name) VALUES ('1', '2', 'below average');
INSERT INTO ratingscale (CustomerId, Ranking, Name) VALUES ('1', '3', 'Average');
INSERT INTO ratingscale (CustomerId, Ranking, Name) VALUES ('1', '4', 'Good');
INSERT INTO ratingscale (CustomerId, Ranking, Name) VALUES ('1', '5', 'Excellent');

INSERT INTO RefFeedbackStatus(RefFeedbackStatusId,RefFeedbackStatusName,Description)VALUES(1, 'New', 'New');
INSERT INTO RefFeedbackStatus(RefFeedbackStatusId,RefFeedbackStatusName,Description)VALUES(2, 'Draft', 'In progress');
INSERT INTO RefFeedbackStatus(RefFeedbackStatusId,RefFeedbackStatusName,Description)VALUES(3, 'Submitted', 'Submitted');

INSERT INTO RefQuestionType(RefQuestionTypeId,QuestionType) VALUES(1, 'DESCRIPTIVE');
INSERT INTO RefQuestionType(RefQuestionTypeId,QuestionType) VALUES(2, 'MULTIPLE_CHOICE');