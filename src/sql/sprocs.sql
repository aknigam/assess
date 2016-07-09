use assess_new;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `FrequencyReportGetByUser`(
in userId int
)
BEGIN



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
	-- join MultipleChoiceAnswer mca  on mca.EmployeeFeedbackAnswerId = efa.EmployeeFeedbackAnswerId and mca.multipleChoiceId = mc.multipleChoiceId
	join MultipleChoiceAnswer mca  on mca.EmployeeFeedbackAnswerId = efa.EmployeeFeedbackAnswerId and mca.multipleChoiceId = mc.multipleChoiceId
	where cur.revieweeId = 31
	and cur.revieweeId = cur.reviewerId
	group by q.questionId,mca.MultipleChoiceId
	) a
	on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
	where a.appuserId = 31
	order by mc1.questionId, mc1.MultipleChoiceId;

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
	join MultipleChoiceAnswer mca  on mca.EmployeeFeedbackAnswerId = efa.EmployeeFeedbackAnswerId and mca.multipleChoiceId = mc.multipleChoiceId
	where cur.revieweeId = 31
	group by q.questionId,mca.MultipleChoiceId
	order by q.questionId, mca.MultipleChoiceId, cur.reviewerId
	) a
	on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
	where a.appuserId = 31
	order by mc1.questionId, mc1.MultipleChoiceId;

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
	join MultipleChoiceAnswer mca  on mca.EmployeeFeedbackAnswerId = efa.EmployeeFeedbackAnswerId and mca.multipleChoiceId = mc.multipleChoiceId
	where cur.revieweeId = 31
	and cur.revieweeId != cur.reviewerId
	group by q.questionId,mca.MultipleChoiceId
	order by q.questionId, mca.MultipleChoiceId, cur.reviewerId
	) a
	on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
	where a.appuserId = 31
	order by mc1.questionId, mc1.MultipleChoiceId;

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
	join MultipleChoiceAnswer mca  on mca.EmployeeFeedbackAnswerId = efa.EmployeeFeedbackAnswerId and mca.multipleChoiceId = mc.multipleChoiceId
	where cur.revieweeId = 31
	group by q.questionId,mca.MultipleChoiceId
	order by q.questionId, mca.MultipleChoiceId, cur.reviewerId
	) a
	on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
	where a.appuserId = 31
	order by mc1.questionId, mc1.MultipleChoiceId;

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
	join MultipleChoiceAnswer mca  on mca.EmployeeFeedbackAnswerId = efa.EmployeeFeedbackAnswerId and mca.multipleChoiceId = mc.multipleChoiceId
	where cur.revieweeId = 31
	group by q.questionId,mca.MultipleChoiceId
	order by q.questionId, mca.MultipleChoiceId, cur.reviewerId
	) a
	on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
	where a.appuserId = 31
	order by mc1.questionId, mc1.MultipleChoiceId;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `IndividualSummaryReportGet`(
	in userId int
)
BEGIN



		
	-- query to get self rating for a question


	select -- cur.revieweeId, au.name,  
		q.questionId, AVG(rc.Ranking) as rank
	from CustomerUserReviewer cur
	join AppUser au on au.AppUserId = cur.RevieweeId 
	join EmployeeFeedbackAnswer efa on efa.AppUserReviewerId = cur.AppUserReviewerId 
	join MultipleChoiceAnswer mca  on mca.EmployeeFeedbackAnswerId = efa.EmployeeFeedbackAnswerId 
	join Question q on efa.questionid = q.questionid 
	join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
	join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId 
	where cur.revieweeid = userId
	and cur.revieweeId = cur.reviewerId
	group by cur.RevieweeId,au.name, q.questionId;

	
	

	-- query to get manager's rating for a question


	select  -- m.name,  
		q.questionId, AVG(rc.Ranking) as rank
	from CustomerUserReviewer cur
	join AppUser au on au.AppUserId = cur.RevieweeId 
	join AppUser m on m.AppUserId = au.managerId and cur.reviewerId  = m.AppUserId
	join EmployeeFeedbackAnswer efa on efa.AppUserReviewerId = cur.AppUserReviewerId 
	join MultipleChoiceAnswer mca  on mca.EmployeeFeedbackAnswerId = efa.EmployeeFeedbackAnswerId 
	join Question q on efa.questionid = q.questionid 
	join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
	join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId 
	where cur.revieweeId = userId 
	group by  m.name, q.questionId;

	-- query to get other's rating for a question. Anybody other than me.


	select -- cur.revieweeId, 
		q.questionId, AVG(rc.Ranking) as rank
	from CustomerUserReviewer cur
	join EmployeeFeedbackAnswer efa on efa.AppUserReviewerId = cur.AppUserReviewerId 
	join MultipleChoiceAnswer mca  on mca.EmployeeFeedbackAnswerId = efa.EmployeeFeedbackAnswerId 
	join Question q on efa.questionid = q.questionid 
	join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
	join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId 
	where cur.revieweeid = userId 
	and cur.revieweeid != cur.reviewerId-- and cur.reviewerId = 31
	group by cur.RevieweeId, q.questionId;

	--  query to get peer's rating for a question. All those who report to my manager


	select  -- p.name,  
		q.questionId, AVG(rc.Ranking) as rank
	from CustomerUserReviewer cur
	join AppUser au on au.AppUserId = cur.RevieweeId 
	join AppUser p on p.managerId = au.managerId and cur.reviewerId = p.appUserId
	join EmployeeFeedbackAnswer efa on efa.AppUserReviewerId = cur.AppUserReviewerId 
	join MultipleChoiceAnswer mca  on mca.EmployeeFeedbackAnswerId = efa.EmployeeFeedbackAnswerId 
	join Question q on efa.questionid = q.questionid 
	join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
	join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId 
	where cur.revieweeId = userId 
	group by  p.name, q.questionId;



	--  query to get direct report's rating for a question. All those who report to me


	select  -- r.name,  
		q.questionId, AVG(rc.Ranking) as rank
	from CustomerUserReviewer cur
	join AppUser au on au.AppUserId = cur.RevieweeId 
	join AppUser r on r.managerId = au.AppuserId and cur.reviewerId = r.appUserId
	join EmployeeFeedbackAnswer efa on efa.AppUserReviewerId = cur.AppUserReviewerId 
	join MultipleChoiceAnswer mca  on mca.EmployeeFeedbackAnswerId = efa.EmployeeFeedbackAnswerId 
	join Question q on efa.questionid = q.questionid 
	join MultipleChoice mc on mc.MultipleChoiceId = mca.MultipleChoiceId
	join RatingScale rc on rc.RatingScaleId = mc.RatingScaleId 
	where cur.revieweeId = userId
	group by  r.name, q.questionId;


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
	 where au.appuserId = userId;



END$$
DELIMITER ;
