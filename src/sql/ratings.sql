
use assess;

/*
*******************************************************************************************

REPORTING QUERIES

1. How many users  selected a particula MC answer.
2. 

*******************************************************************************************
*/

-- query to find average rating per Designation


select * from AppUSer;



select * from AppUSer;


-- query to get self rating for a question



select -- cur.revieweeId, au.name,  
		q.questionId, AVG(rc.Ranking) as rank
from CustomerUserReviewer cur
join AppUser au on au.AppUserId = cur.RevieweeId 
join EmployeeFeedbackAnswer efa on efa.AppUserReviewerId = cur.AppUserReviewerId 
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId 
join Question q on efa.questionid = q.questionid 
join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId 
where cur.revieweeid = 31 -- and cur.reviewerId = 31
group by cur.RevieweeId,au.name, q.questionId

-- query to get manager's rating for a question


select  m.name,  q.questionId, AVG(rc.Ranking) as rank
from CustomerUserReviewer cur
join AppUser au on au.AppUserId = cur.RevieweeId 
join AppUser m on m.AppUserId = au.managerId 
join EmployeeFeedbackAnswer efa on efa.AppUserReviewerId = cur.AppUserReviewerId 
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId 
join Question q on efa.questionid = q.questionid 
join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId 
where cur.revieweeId = 31 
group by  m.name, q.questionId

-- query to get other's rating for a question. Anybody other than me.


select cur.revieweeId, q.questionId, AVG(rc.Ranking) as rank
from CustomerUserReviewer cur
join EmployeeFeedbackAnswer efa on efa.AppUserReviewerId = cur.AppUserReviewerId 
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId 
join Question q on efa.questionid = q.questionid 
join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId 
where cur.revieweeid = 31 
and cur.revieweeid != cur.reviewerId-- and cur.reviewerId = 31
group by cur.RevieweeId, q.questionId

--  query to get peer's rating for a question. All those who report to my manager


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
group by  p.name, q.questionId



--  query to get direct report's rating for a question. All those who report to me


select  r.name,  q.questionId, AVG(rc.Ranking) as rank
from CustomerUserReviewer cur
join AppUser au on au.AppUserId = cur.RevieweeId 
join AppUser r on r.managerId = au.AppuserId and cur.reviewerId = r.appUserId
join EmployeeFeedbackAnswer efa on efa.AppUserReviewerId = cur.AppUserReviewerId 
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId 
join Question q on efa.questionid = q.questionid 
join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId 
where cur.revieweeId = 31
group by  r.name, q.questionId

select * from AppUser where managerId = 33 or appuserid = 33


-- response frequency report

select 
	mc1.MultipleChoiceId,
	mc1.Answer,
	mc1.questionId,
	q1.Question,
	a.NoOfReviewers
from AppUser a 
join designation d on d.designationId = a.designationid
join question q1 on q1.designationId = d.designationId
join  MultipleChoice mc1 on mc1.questionid = q1.questionId
left join 
( select 
	q.questionId,
	mca.MultipleChoiceId,
	-- cur.reviewerId,
	count(cur.reviewerId) as NoOfReviewers
from CustomerUserReviewer cur
join AppUser au on au.AppUserId = cur.RevieweeId
join Designation d on d.designationid = au.designationid
join Question q on q.designationid = au.designationid
join MultipleChoice mc on mc.questionid = q.questionid
join EmployeeFeedbackAnswer efa on efa.questionid = q.questionid and efa.AppUserReviewerId = cur.AppUserReviewerId
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId and mca.multipleChoiceId = mc.multipleChoiceId
where cur.revieweeId = 31
group by q.questionId,mca.MultipleChoiceId
order by q.questionId, mca.MultipleChoiceId, cur.reviewerId
) a
on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
where a.appuserId = 31
order by mc1.questionId, mc1.MultipleChoiceId

select * from appuser where appuserId = 34


-- self

select 
	mc1.MultipleChoiceId,
	mc1.Answer,
	mc1.questionId,
	q1.Question,
	a.NoOfReviewers
from AppUser a 
join designation d on d.designationId = a.designationid
join question q1 on q1.designationId = d.designationId
join  MultipleChoice mc1 on mc1.questionid = q1.questionId
left join 
( 
select 
	q.questionId,
	mca.MultipleChoiceId,
	-- cur.reviewerId,
	count(cur.reviewerId) as NoOfReviewers
from CustomerUserReviewer cur
join AppUser au on au.AppUserId = cur.RevieweeId
join Designation d on d.designationid = au.designationid
join Question q on q.designationid = au.designationid
join MultipleChoice mc on mc.questionid = q.questionid
join EmployeeFeedbackAnswer efa on efa.questionid = q.questionid and efa.AppUserReviewerId = cur.AppUserReviewerId
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId and mca.multipleChoiceId = mc.multipleChoiceId
where cur.revieweeId = 31
and cur.revieweeId = cur.reviewerId
group by q.questionId,mca.MultipleChoiceId
) a
on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
where a.appuserId = 31
order by mc1.questionId, mc1.MultipleChoiceId

-- manager


select 
	mc1.MultipleChoiceId,
	mc1.Answer,
	mc1.questionId,
	q1.Question,
	a.NoOfReviewers
from AppUser a 
join designation d on d.designationId = a.designationid
join question q1 on q1.designationId = d.designationId
join  MultipleChoice mc1 on mc1.questionid = q1.questionId
left join 
( 
select 
	q.questionId,
	mca.MultipleChoiceId,
	-- cur.reviewerId,
	count(cur.reviewerId) as NoOfReviewers
from CustomerUserReviewer cur
join AppUser au on au.AppUserId = cur.RevieweeId
join AppUser m on m.AppUserId = au.managerId and cur.reviewerId  = m.AppUserId
join Designation d on d.designationid = au.designationid
join Question q on q.designationid = au.designationid
join MultipleChoice mc on mc.questionid = q.questionid
join EmployeeFeedbackAnswer efa on efa.questionid = q.questionid and efa.AppUserReviewerId = cur.AppUserReviewerId
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId and mca.multipleChoiceId = mc.multipleChoiceId
where cur.revieweeId = 31
group by q.questionId,mca.MultipleChoiceId
order by q.questionId, mca.MultipleChoiceId, cur.reviewerId
) a
on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
where a.appuserId = 31
order by mc1.questionId, mc1.MultipleChoiceId

-- others



select 
	mc1.MultipleChoiceId,
	mc1.Answer,
	mc1.questionId,
	q1.Question,
	a.NoOfReviewers
from AppUser a 
join designation d on d.designationId = a.designationid
join question q1 on q1.designationId = d.designationId
join  MultipleChoice mc1 on mc1.questionid = q1.questionId
left join 
( 
select 
	q.questionId,
	mca.MultipleChoiceId,
	-- cur.reviewerId,
	count(cur.reviewerId) as NoOfReviewers
from CustomerUserReviewer cur
join AppUser au on au.AppUserId = cur.RevieweeId
join Designation d on d.designationid = au.designationid
join Question q on q.designationid = au.designationid
join MultipleChoice mc on mc.questionid = q.questionid
join EmployeeFeedbackAnswer efa on efa.questionid = q.questionid and efa.AppUserReviewerId = cur.AppUserReviewerId
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId and mca.multipleChoiceId = mc.multipleChoiceId
where cur.revieweeId = 31
and cur.revieweeId != cur.reviewerId
group by q.questionId,mca.MultipleChoiceId
order by q.questionId, mca.MultipleChoiceId, cur.reviewerId
) a
on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
where a.appuserId = 31
order by mc1.questionId, mc1.MultipleChoiceId

-- peers



select 
	mc1.MultipleChoiceId,
	mc1.Answer,
	mc1.questionId,
	q1.Question,
	a.NoOfReviewers
from AppUser a 
join designation d on d.designationId = a.designationid
join question q1 on q1.designationId = d.designationId
join  MultipleChoice mc1 on mc1.questionid = q1.questionId
left join 
( 
select 
	q.questionId,
	mca.MultipleChoiceId,
	-- cur.reviewerId,
	count(cur.reviewerId) as NoOfReviewers
from CustomerUserReviewer cur
join AppUser au on au.AppUserId = cur.RevieweeId
join AppUser p on p.managerId = au.managerId and cur.reviewerId = p.appUserId
join Designation d on d.designationid = au.designationid
join Question q on q.designationid = au.designationid
join MultipleChoice mc on mc.questionid = q.questionid
join EmployeeFeedbackAnswer efa on efa.questionid = q.questionid and efa.AppUserReviewerId = cur.AppUserReviewerId
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId and mca.multipleChoiceId = mc.multipleChoiceId
where cur.revieweeId = 31
group by q.questionId,mca.MultipleChoiceId
order by q.questionId, mca.MultipleChoiceId, cur.reviewerId
) a
on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
where a.appuserId = 31
order by mc1.questionId, mc1.MultipleChoiceId

-- direct reports


select 
	mc1.MultipleChoiceId,
	mc1.Answer,
	mc1.questionId,
	q1.Question,
	a.NoOfReviewers
from AppUser a 
join designation d on d.designationId = a.designationid
join question q1 on q1.designationId = d.designationId
join  MultipleChoice mc1 on mc1.questionid = q1.questionId
left join 
( 
select 
	q.questionId,
	mca.MultipleChoiceId,
	-- cur.reviewerId,
	count(cur.reviewerId) as NoOfReviewers
from CustomerUserReviewer cur
join AppUser au on au.AppUserId = cur.RevieweeId
join AppUser r on r.managerId = au.AppuserId and cur.reviewerId = r.appUserId
join Designation d on d.designationid = au.designationid
join Question q on q.designationid = au.designationid
join MultipleChoice mc on mc.questionid = q.questionid
join EmployeeFeedbackAnswer efa on efa.questionid = q.questionid and efa.AppUserReviewerId = cur.AppUserReviewerId
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId and mca.multipleChoiceId = mc.multipleChoiceId
where cur.revieweeId = 31
group by q.questionId,mca.MultipleChoiceId
order by q.questionId, mca.MultipleChoiceId, cur.reviewerId
) a
on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
where a.appuserId = 31
order by mc1.questionId, mc1.MultipleChoiceId









-- ----------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------



select  m.name,  q.questionId, AVG(rc.Ranking) as rank
from CustomerUserReviewer cur
join AppUser au on au.AppUserId = cur.RevieweeId 
join AppUser m on m.AppUserId = au.managerId 
join EmployeeFeedbackAnswer efa on efa.AppUserReviewerId = cur.AppUserReviewerId 
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId 
join Question q on efa.questionid = q.questionid 
join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId 
where cur.revieweeId = 31 
group by  m.name, q.questionId




-- Query to get overall rating of the user

select  
	cur.RevieweeId, 
	au.name, 
	AVG(rc.Ranking) as rank
from CustomerUserReviewer cur 
join AppUser au on au.AppUserId = cur.RevieweeId 
join EmployeeFeedbackAnswer efa on efa.AppUserReviewerId = cur.AppUserReviewerId
join Question q on efa.questionid = q.questionid  
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId 
join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId
where q.refQuestionTypeid =  2 -- mc
group by au.name, cur.RevieweeId

-- Query to get overall rating of the user per question

select  
	cur.RevieweeId,
	q.questionId, 
	AVG(rc.Ranking)
from CustomerUserReviewer cur 
join EmployeeFeedbackAnswer efa on efa.AppUserReviewerId = cur.AppUserReviewerId
join Question q on efa.questionid = q.questionid  
join AssessmentArea aa on aa.AssessmentAreaId = q.AssessmentAreaId
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId 
join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId
where q.refQuestionTypeid =  2 -- mc
and RevieweeId = 31
group by cur.RevieweeId, q.questionId


select * from RefFeedbackStatus

-- Query to get overall rating of the user per assessment area

select  
	cur.RevieweeId,
	aa.AssessmentAreaId ,
	AVG(rc.Ranking)
from CustomerUserReviewer cur 
join EmployeeFeedbackAnswer efa on efa.AppUserReviewerId = cur.AppUserReviewerId
join Question q on efa.questionid = q.questionid  
join AssessmentArea aa on aa.AssessmentAreaId = q.AssessmentAreaId
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId 
join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId
where q.refQuestionTypeid =  2 -- mc
-- and RevieweeId = 31
group by cur.RevieweeId, aa.AssessmentAreaId

-- company wide average ranking per Designation

select  
	d.designationId , d.name, 
	AVG(rc.Ranking)
from MultipleChoiceAnswer mca 
join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
join Question q on q.QuestionId = mc.QuestionId
join Designation d on d.DesignationId = q.DesignationId
join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId
group by d.designationId , d.name


-- company wide average ranking per Designation per assessment area

select  
	d.designationId , d.name, 
	AVG(rc.Ranking)
from MultipleChoiceAnswer mca 
join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
join Question q on q.QuestionId = mc.QuestionId
join Designation d on d.DesignationId = q.DesignationId
join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId
group by d.designationId , d.name



select  
	cur.RevieweeId, 
	q.questionId, 
	aa.AssessmentAreaId ,
	-- mc.MultipleChoiceId,  
	-- mc.Answer,  
	-- mca.MultipleChoiceId as MultipleChoiceAnswerId  ,
	AVG(rc.Ranking)
from CustomerUserReviewer cur 
join AppUser au on au.AppUserId = cur.RevieweeId 
join Designation d on d.designationid = au.designationid 
join Question q on q.designationid = au.designationid 
join AssessmentArea aa on aa.AssessmentAreaId = q.AssessmentAreaId
join EmployeeFeedbackAnswer efa on efa.questionid = q.questionid and efa.AppUserReviewerId = cur.AppUserReviewerId
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId 
join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId
where q.refQuestionTypeid =  2 -- mc
and d.DesignationId = 17
group by cur.RevieweeId, aa.AssessmentAreaId, q.questionId

select  
	cur.RevieweeId, 
	au.designationid, 
	q.questionId, 
	aa.AssessmentAreaId ,
	mc.MultipleChoiceId,  
	mc.Answer,  
	mca.MultipleChoiceId as MultipleChoiceAnswerId  ,
	rc.Ranking
from CustomerUserReviewer cur 
join AppUser au on au.AppUserId = cur.RevieweeId 
join Designation d on d.designationid = au.designationid 
join Question q on q.designationid = au.designationid 
join AssessmentArea aa on aa.AssessmentAreaId = q.AssessmentAreaId
join EmployeeFeedbackAnswer efa on efa.questionid = q.questionid and efa.AppUserReviewerId = cur.AppUserReviewerId
join MultipleChoiceAnswer mca  on mca.AppUserFeedbackAnswerId = efa.AppUserFeedbackAnswerId 
join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId
where q.refQuestionTypeid =  2 -- mc
and d.DesignationId = 17
