-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AppUserManagerUpdate`(
	pUserName varchar(20),
	pManagerName varchar(20)
)
BEGIN

	DECLARE AaId, pAaId INT DEFAULT 0;

	Select AppUserId into AaId from AppUser where `name` =  pUserName;
	Select AppUserId into pAaId from AppUser where `name` =  pUserName;
	
	update AppUser  set ManagerId = pAaId where AppUserId  =  AaId;
	

END