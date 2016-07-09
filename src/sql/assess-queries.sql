Use assess_new;

select * from AppRole

select * from designation

select * from Customer

select * from AppUser

update AppUser set ManagerId = (select m.appUserid from AppUser m where m.email = '') where email = ''

select * from assessmentarea

select au.appuserid, au.name, au.managerId, m.* from AppUser au
join AppUser m on m.AppUserId = au.managerId 
where au.appuserid = 31

select * from AppUser where managerId = 32 -- 31, 35
select * from AppUser where appuserid = 35

select * from CustomerUserReviewer where revieweeId  = 31

select * from question where designationid = 15 and refQuestionTypeId = 2

select au.name from CustomerUserReviewer cur
join  AppUser au on au.AppUserId = cur.ReviewerId 
where revieweeid = 31;

			select   
				au.name,
				au.appuserId,
				au.designationid,  
			 	q.questionId,   
			 	q.refQuestionTypeid,   
			 	q.Question, 
				aa.AssessmentAreaId,
				aa.AssessmentAreaName
			 from AppUser au 
			 join Designation d on d.designationid = au.designationid  
			 join Question q on q.designationid = au.designationid  and q.RefQuestionTypeId = 2
			 join AssessmentArea aa on aa.AssessmentAreaId = q.AssessmentAreaId
			 where au.appuserId = 31


select cer.AppUserreviewerid,  
			 ur.AppuserId, ur.name, ur.email , 
			 ul.AppuserId as reviewerId, ul.name as reviewerName, ul.email as reviewerEmail ,  
			 dr.name as reviewerDesignationName,  
			 rfs.RefFeedbackStatusName,  
			 d.name as designationName  
			 from CustomerUserReviewer cer  
			 join AppUser ul on ul.AppUserId = cer.reviewerId 
			 join AppUser ur on ur.AppUserId = cer.RevieweeId  
			 join Designation d on d.designationId =  ur.designationId  
			 join Designation dr on dr.designationId =  ul.designationId  
			 join RefFeedbackStatus rfs on rfs.RefFeedbackStatusId = cer.FeedbackStatusId
where cer.revieweeid = 31;

select d.name, au.* from AppUser au
join Designation d on d.designationid = au.designationid 
order by d.name 

-- where approleid =  1


select * from Department

update Appuser set managerId = 33 where AppUserId in (34)


update Appuser set managerId = 33 where AppUserId in (32, 37)

update Appuser set managerId = 37 where AppUserId in (36, 38)

update Appuser set managerId = 37 where AppUserId in (39, 40)


update Appuser set DepartmentId =  1 where appuserid in (32, 31, 35)

update Appuser set DepartmentId =  2 where appuserid in (34, 37, 38, 39, 40)

update Appuser set DepartmentId =  1 where 



select distinct approleid from appuser 

update appuser set approleid = 2 where approleid = 1

insert into Appuser (AppRoleId , CustomerId, Name, Email, IsEmployee, UserPassword, EmployeeId ) values (1, 1, 'Adminitrator user', 'admin@assess.com', 0, 'password', null)

Select CustomerId from Customer where CustomerName = 'Expedia'

Select * from assess.Customer

select * from Appuser

Select * from assess.CustomerUserreviewer

select * from RefFeedbackStatus
 select cer.AppUserreviewerid,  ur.AppuserId, ur.name, ur.email , ul.AppuserId as reviewerId, ul.name as reviewerName, ul.email as reviewerEmail , dr.name as reviewerDesignationName,  rfs.RefFeedbackStatusName,  d.name as designationName  from CustomerUserReviewer cer  join AppUser ul on ul.AppUserId = cer.reviewerId join AppUser ur on ur.AppUserId = cer.RevieweeId  join Designation d on d.designationId =  ur.designationId  join Designation dr on dr.designationId =  ul.designationId  join RefFeedbackStatus rfs on rfs.RefFeedbackStatusId = cer.FeedbackStatusId  where  ur.name like  '%Rocky Fan%' 

update CustomerUserReviewer set FeedbackStatusId = 1 

select cer.AppUserreviewerid, ur.AppuserId, ur.name, ur.email , rfs.RefFeedbackStatusName from CustomerUserReviewer cer join AppUser ul on ul.AppUserId = cer.reviewerId join AppUser ur on ur.AppUserId = cer.RevieweeId  join RefFeedbackStatus rfs on rfs.RefFeedbackStatusId = cer.FeedbackStatusId 
   
insert into RefFeedbackStatus (RefFeedbackStatusId, RefFeedbackStatusName, Description) values (1,  'New', 'Newly created feedback')
insert into RefFeedbackStatus (RefFeedbackStatusId, RefFeedbackStatusName, Description) values (2,  'Draft', 'In progress')
insert into RefFeedbackStatus (RefFeedbackStatusId, RefFeedbackStatusName, Description) values (3,  'Submitted', 'Submitted')

CREATE TABLE RefFeedbackStatus (
  RefFeedbackStatusId INTEGER UNSIGNED NOT NULL,
  RefFeedbackStatusName VARCHAR(20) NULL,
  Description VARCHAR(255) NULL,
  UNIQUE INDEX RefFeedbackStatus_index1351(RefFeedbackStatusName)
);

ALTER TABLE `assess`.`CustomerUserReviewer` 
CHANGE COLUMN `FeedbackStatus` `FeedbackStatusId` INT(10) default NULL ;

alter table DesignationQuestion
ADD  CONSTRAINT `designationquestion_ibfk_3` FOREIGN KEY (`DesignationId`) REFERENCES `Designation` (`DesignationId`) ON DELETE NO ACTION ON UPDATE NO ACTION

ALTER TABLE `assess`.`CustomerUserReviewer` 
ADD CONSTRAINT `customeruserreviewer_ibfk_3`
  FOREIGN KEY (`FeedbackStatusId`)
  REFERENCES `assess`.`RefFeedbackStatus` (`RefFeedbackStatusId`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

select * from question where designationId = 15

select q.questionId, 
	q.refQuestionTypeid, 
	q.Question, 
	mc.MultipleChoiceId, 
	mc.Answer, 
	mc.Sequence 
from Question q 
left join MultipleChoice mc on mc.questionid = q.questionid
where q.designationid = 15 and q.customerid = 1


select efa.questionId, efa.DescriptiveAnswer, mca.MultipleChoiceId  from EmployeeFeedbackAnswer efa
join CustomerUserReviewer cur on cur.AppUserReviewerId = efa.AppUserReviewerId
left join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId
where cur.AppUserReviewerId = 1

select * from question

select * from EmployeeFeedbackAnswer

select * from CustomerUserReviewer cur
join AppUser au on au.AppUserId = cur.RevieweeId
join Designation d on d.designationid = au.designationid
-- join Question q on d.designationId = q.designationid
order by cur.AppUserReviewerId


-- query to get the questionnaire START

select 
	cur.AppUserReviewerId,
	q.questionId, 
	q.refQuestionTypeid, 
	q.Question, 
	mc.MultipleChoiceId, 
	mc.Answer, 
	mc.Sequence ,
	efa.DescriptiveAnswer,
	mca.MultipleChoiceId as MultipleChoiceAnswerId 
from CustomerUserReviewer cur
join AppUser au on au.AppUserId = cur.RevieweeId
join Designation d on d.designationid = au.designationid
join Question q on q.designationid = au.designationid
left join MultipleChoice mc on mc.questionid = q.questionid
left join EmployeeFeedbackAnswer efa on efa.questionid = q.questionid
left join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId
where cur.AppUserReviewerId = 1

select * from CustomerUserReviewer where reviewerid = 34

select  
	efa.AppUserFeedbackAnswerId,
	efa.AppUserReviewerId,
	cur.AppUserReviewerId, 
	cur.RevieweeId, 
	au.designationid, 
	q.questionId,  
	q.refQuestionTypeid,  
	q.Question,  
	mc.MultipleChoiceId,  
	mc.Answer,  
	mc.Sequence , 
	efa.DescriptiveAnswer, 
	mca.MultipleChoiceId as MultipleChoiceAnswerId  
from CustomerUserReviewer cur 
join AppUser au on au.AppUserId = cur.RevieweeId 
join Designation d on d.designationid = au.designationid 
join Question q on q.designationid = au.designationid 
left join MultipleChoice mc on mc.questionid = q.questionid 
left join EmployeeFeedbackAnswer efa on efa.questionid = q.questionid and efa.AppUserReviewerId = cur.AppUserReviewerId
left join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId 
where cur.AppUserReviewerId = 3

update MultipleChoiceAnswer set MultipleChoiceId = 161 where AppUserFeedbackAnswerId =
(select AppUserFeedbackAnswerId from EmployeeFeedbackAnswer where questionId = 69 and AppUserReviewerId = 3)

select * from MultipleChoiceAnswer mca 
join  EmployeeFeedbackAnswer efa on efa.AppUserFeedbackAnswerId = mca.AppUserFeedbackAnswerId 
where questionid  in (68, 69)

-- query to get the list of users whose review I (reviewer) have to do.

select cer.AppUserReviewerId, ur.designationId, ur.AppuserId, ul.AppUserId, ul.name ReviewerName, ul.email as ReviewerEmail,
 ur.name RevieweeName, d.name, cer.*
from CustomerUserReviewer cer
join AppUser ul on ul.AppUserId = cer.reviewerId -- this is the logged-in user
join AppUser ur on ur.AppUserId = cer.RevieweeId -- this is the user whose review will be done
join Designation d on d.designationId = ur.designationId
order by cer.reviewerId

		


-- query give

select * from MultipleChoiceAnswer;

select * from MultipleChoice;


-- query to get the questionnaire END

select * from EmployeeFeedbackAnswer

select q.questionId, 
	q.refQuestionTypeid, 
	q.Question, 
	mc.MultipleChoiceId, 
	mc.Answer, 
	mc.Sequence ,
	efa.DescriptiveAnswer,
	mca.MultipleChoiceId as MultipleChoiceAnswerId 
from Question q 
left join MultipleChoice mc on mc.questionid = q.questionid
left join EmployeeFeedbackAnswer efa on efa.questionid = q.questionid
left join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId
-- left join CustomerUserReviewer cur on cur.AppUserReviewerId = efa.AppUserReviewerId
where q.designationid = 15 and q.customerid = 1
and cur.AppUserReviewerId = 1

update MultipleChoiceAnswer set MultipleChoiceId = ? where AppUserFeedbackAnswerId = ?

select efa.questionId, efa.DescriptiveAnswer, mca.MultipleChoiceId  
from EmployeeFeedbackAnswer efa
join CustomerUserReviewer cur on cur.AppUserReviewerId = efa.AppUserReviewerId
left join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId
where cur.AppUserReviewerId = 39

select efa.questionId, efa.AppUserFeedbackAnswerId
from EmployeeFeedbackAnswer efa
join CustomerUserReviewer cur on cur.AppUserReviewerId = efa.AppUserReviewerId
join Question q on q.questionId = efa.questionid
where cur.AppUserReviewerId = 39

update EmployeeFeedbackAnswer set DescriptiveAnswer = ? where AppUserReviewerId = ? and questionId = ?

insert into EmployeeFeedbackAnswer (AppUserReviewerId,QuestionId,DescriptiveAnswer) values (?, ?, ?)

select * from EmployeeFeedbackAnswer


select ur.AppuserId, ur.name, ur.email, ul.name, ul.email 
from CustomerUserReviewer cer
join AppUser ul on ul.AppUserId = cer.reviewerId -- this is the logged-in user
-- where ul.AppUserId =
order by cer.reviewerId

Alter table Designation
modify column Description VARCHAR(240) NULL;

Alter table Question
add column DesignationId int(10) unsigned NOT NULL

Alter table AppUser
modify column ManagerId int(10) unsigned DEFAULT NULL



Alter table AppRole
modify column  AppRoleId int(10) unsigned NOT NULL

alter table DesignationQuestion
ADD CONSTRAINT customer_designation_ukey UNIQUE (Customerid,Name)

alter table DesignationQuestion
ADD column DesignationId int(10) unsigned NOT NULL

alter table DesignationQuestion
drop   FOREIGN KEY designationquestion_ibfk_1 

alter table DesignationQuestion
add PRIMARY KEY (DesignationQuestionId)

alter table DesignationQuestion
ADD  CONSTRAINT `designationquestion_ibfk_3` FOREIGN KEY (`DesignationId`) REFERENCES `Designation` (`DesignationId`) ON DELETE NO ACTION ON UPDATE NO ACTION

alter table Question
ADD  CONSTRAINT `Question_FKIndex4(AssessmentAreaId` FOREIGN KEY (`AssessmentAreaId`) REFERENCES `AssessmentArea` (`AssessmentAreaId`) ON DELETE NO ACTION ON UPDATE NO ACTION

alter table MultipleChoice
ADD column RatingScaleId INTEGER UNSIGNED  NULL

select * from MultipleChoice

alter table Question
add Column  AssessmentAreaId INTEGER  NULL

delete from  AppRole where AppRoleId in (1,2)-- ,3,4,5,6)

select * from assess.Question
select * from assess.MultipleChoice

select * from assess.Designation
select * from DesignationQuestion

select * from AppRole
select * from AppUser

delete from AppUser where AppUserId < 30

select * from AppUser
select AppUserId from AppUser where Email = ?

select * from AppUser where appuserid = 31

delete from  designation where designationId in (1,2,3,4,5,6)

alter table Designation
ADD CONSTRAINT customer_designation_ukey UNIQUE (Customerid,Name)



select * from RatingScale;

select distinct answer from MultipleCHoice where RatingScaleid is not null

update MultipleCHoice set ratingScaleId = 1 where answer = 'Poor';
update MultipleCHoice set ratingScaleId = 2 where answer = 'Average';
update MultipleCHoice set ratingScaleId = 3 where answer = 'Good';
update MultipleCHoice set ratingScaleId = 4 where answer = 'Very good';
update MultipleCHoice set ratingScaleId = 5 where answer = 'Excellent';

/*
'Poor'
'Average'
'Good'
'Very good'
'Excellent'
*/

select * from MultipleChoiceAnswer mca
join EmployeeFeedbackAnswer efa on efa.AppUserFeedbackAnswerId = mca.AppUserFeedbackAnswerId
join Question q on q.QuestionId = efa.QuestionId

update multipleChoice set RatingScaleId = 3 where MultipleChoiceId = 172 ;
update multipleChoice set RatingScaleId = 4 where MultipleChoiceId = 178 ;


insert into RatingScale (CustomerId, Ranking, `Name`) values (1, 1, 'poor');
insert into RatingScale (CustomerId, Ranking, `Name`) values (1, 2, 'below average');
insert into RatingScale (CustomerId, Ranking, `Name`) values (1, 3, 'Average');
insert into RatingScale (CustomerId, Ranking, `Name`) values (1, 4, 'Good');
insert into RatingScale (CustomerId, Ranking, `Name`) values (1, 5, 'Excellent');

select * from AssessmentArea

insert into AssessmentArea (CustomerId,  AssessmentAreaName, AssessmentAreaDescription) values (1, 'Strength', 'key strength');
insert into AssessmentArea (CustomerId,  AssessmentAreaName, AssessmentAreaDescription) values (1, 'Improvements', 'Improvements');
insert into AssessmentArea (CustomerId,  AssessmentAreaName, AssessmentAreaDescription) values (1, 'technical', 'technical');
insert into AssessmentArea (CustomerId,  AssessmentAreaName, AssessmentAreaDescription) values (1, 'management', 'management');

select * from Question where AssessmentAreaId is  null

update Question set AssessmentAreaId = 1 where question = 'What do you see as 2-3 key strengths?';
update Question set AssessmentAreaId = 2 where question = 'What are 2-3 key areas for improvement and/or development.';
update Question set AssessmentAreaId = 3 where question = 'How do you rate his/her technical skills. Please select one of the following.';
update Question set AssessmentAreaId = 4 where question = 'How do you rate his/her management skills. Please select one of the following.';

select distinct question from Question

/*
'What do you see as 2-3 key strengths?'
'What are 2-3 key areas for improvement and/or development.'
'How do you rate his/her technical skills. Please select one of the following.'
'How do you rate his/her management skills. Please select one of the following.'
*/
/*

END

*******************************************************************************************
*/

drop table AssessmentArea

select * from RatingScale

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

ALTER TABLE `assess`.`AppUser` 
ADD COLUMN `DepartmentId` INT(10) NULL DEFAULT NULL AFTER `EmployeeId`;

ALTER TABLE `assess`.`AppUser` 
ADD INDEX `appuser_ibfk_5_idx` (`DepartmentId` ASC);
ALTER TABLE `assess`.`AppUser` 
ADD CONSTRAINT `appuser_ibfk_5`
  FOREIGN KEY (`DepartmentId`)
  REFERENCES `assess`.`Department` (`DepartmentId`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;