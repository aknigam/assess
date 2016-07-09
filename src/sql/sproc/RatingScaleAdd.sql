-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RatingScaleAdd`(
	pRatingScaleName varchar(20),
	pCustomerName varchar(20),
	pRanking int

)
BEGIN

	DECLARE  vCustomerId INT DEFAULT 0;

	select CustomerId into vCustomerId from Customer where CustomerName =  pCustomerName;

	INSERT INTO RatingScale (Customerid, Ranking, `Name`) values (vCustomerId, pRanking, pRatingScaleName);

	Select ratingScaleId from RatingScale where `name` = pRatingScaleName;

END