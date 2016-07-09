
use assess_new;

INSERT INTO AppRole(AppRoleId,RoleName,RoleDescription) VALUES (1, 'admin', 'Adminsitrator');
INSERT INTO AppRole(AppRoleId,RoleName,RoleDescription) VALUES (2, 'user', 'Normal user');


INSERT INTO RefFeedbackStatus(RefFeedbackStatusId,RefFeedbackStatusName,Description)VALUES(1, 'New', 'New');
INSERT INTO RefFeedbackStatus(RefFeedbackStatusId,RefFeedbackStatusName,Description)VALUES(2, 'Draft', 'In progress');
INSERT INTO RefFeedbackStatus(RefFeedbackStatusId,RefFeedbackStatusName,Description)VALUES(3, 'Submitted', 'Submitted');

INSERT INTO RefQuestionType(RefQuestionTypeId,QuestionType) VALUES(1, 'DESCRIPTIVE');
INSERT INTO RefQuestionType(RefQuestionTypeId,QuestionType) VALUES(2, 'MULTIPLE_CHOICE');


INSERT INTO ratingscale (CustomerId, Ranking, Name) VALUES ('1', '1', 'poor');
INSERT INTO ratingscale (CustomerId, Ranking, Name) VALUES ('1', '2', 'average');
INSERT INTO ratingscale (CustomerId, Ranking, Name) VALUES ('1', '3', 'good');
INSERT INTO ratingscale (CustomerId, Ranking, Name) VALUES ('1', '4', 'Good');
INSERT INTO ratingscale (CustomerId, Ranking, Name) VALUES ('1', '5', 'Excellent');

INSERT INTO Customer (CustomerId, CustomerName, NoOfUserNominatedReviewers, NoOfAdminNominatedReviewers) VALUES ('1', 'Expedia1', '2', '2');

select * from ratingscale

insert into Appuser (AppRoleId , CustomerId, Name, Email, IsEmployee, UserPassword, EmployeeId ) values (1, 1, 'Adminitrator user', 'admin@assess.com', 0, 'password', null)

select * from AppRole
select AssessmentAreaId  from AssessmentArea where assessmentAreaname like  'Strength';

select * from MultipleChoiceAnswer

select * from assess_new.ratingscale;
select * from AssessmentArea
select * from MultipleCHoice;
truncate MultipleChoiceAnswer;
delete from MultipleChoice;
delete from question;

select q.designationId, question, count(mc.answer) 
from question q
join MultipleChoice mc on mc.questionId = q.questionId
where q.refquestiontypeId = 2
group by q.designationId, q.question;

select * from MultipleChoice;
delete from AssessmentArea;

select * from question;
delete from question

CALL `assess`.`IndividualSummaryReportGet`(31) ;
CALL `assess`.`FrequencyReportGetByUser`(31);

CALL `assess_new`.`AssessmentAreaParentUpdate`(' Improvements',' Driving for sucess');


CALL `assess_new`.`QuestionAdd`('Manager','Expedia','Q3','MULTIPLE_CHOICE','Strength', 'Choice A1', 'Choice B1', 'Choice C', 'Choice D', 'Choice E', 'Choice F', 'Choice G', 'poor','poor','poor','poor','poor','poor','poor');

select * from RefQuestionType
select questionId from Question where question = 'Question1';

select * from MultipleChoice

select * from assess.Customer

select * from Designation

select * from MultipleChoice where questionId = 88


12:56:50	CALL `assess_new`.`QuestionAdd`('Developer', 'Expedia','Question', 'MULTIPLE_CHOICE', 'Strength', '', '', '', '', '', '', '')	
Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 
(`assess_new`.`question`, CONSTRAINT `question_ibfk_2` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION)	0.016 sec



-- 		{#update-count-1=0, rs5=[], rs4=[68-3.0, 69-5.0], rs3=[68-2.0, 69-3.25], rs2=[68-2.0, 69-3.25], rs1=[68-2.0, 69-3.25]}

CALL `assess`.`test`;




	select  p.name,  q.questionId, AVG(rc.Ranking) as rank
	from CustomerUserReviewer cur
	join AppUser au on au.AppUserId = cur.RevieweeId 
	join AppUser p on p.managerId = au.managerId and cur.reviewerId = p.appUserId
	join EmployeeFeedbackAnswer efa on efa.AppUserReviewerId = cur.AppUserReviewerId 
	join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId 
	join Question q on efa.questionid = q.questionid 
	join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
	join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId 
	where cur.revieweeId = 31 
	group by  p.name, q.questionId;



