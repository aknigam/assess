CREATE DATABASE  IF NOT EXISTS `assess_new` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `assess_new`;
-- MySQL dump 10.13  Distrib 5.6.13, for osx10.6 (i386)
--
-- Host: 127.0.0.1    Database: assess_new
-- ------------------------------------------------------
-- Server version	5.6.14

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `AppAuth`
--

DROP TABLE IF EXISTS `AppAuth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AppAuth` (
  `AppAuthId` int(10) unsigned NOT NULL,
  `AuthName` varchar(20) NOT NULL,
  `AuthDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`AppAuthId`),
  UNIQUE KEY `authname_ukey` (`AuthName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AppAuth`
--

LOCK TABLES `AppAuth` WRITE;
/*!40000 ALTER TABLE `AppAuth` DISABLE KEYS */;
/*!40000 ALTER TABLE `AppAuth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AppRole`
--

DROP TABLE IF EXISTS `AppRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AppRole` (
  `AppRoleId` int(10) unsigned NOT NULL,
  `RoleName` varchar(20) NOT NULL,
  `RoleDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`AppRoleId`),
  UNIQUE KEY `approle_ukey` (`RoleName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AppRole`
--

LOCK TABLES `AppRole` WRITE;
/*!40000 ALTER TABLE `AppRole` DISABLE KEYS */;
INSERT INTO `AppRole` VALUES (1,'admin','Adminsitrator'),(2,'user','Normal user');
/*!40000 ALTER TABLE `AppRole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AppRoleAuth`
--

DROP TABLE IF EXISTS `AppRoleAuth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AppRoleAuth` (
  `AppRoleAuthId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `AppAuthId` int(10) unsigned NOT NULL,
  `AppRoleId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`AppRoleAuthId`),
  UNIQUE KEY `authROLE_ukey` (`AppAuthId`,`AppRoleId`),
  KEY `AppRoleAuth_FKIndex1` (`AppRoleId`),
  KEY `AppRoleAuth_FKIndex2` (`AppAuthId`),
  CONSTRAINT `approleauth_ibfk_1` FOREIGN KEY (`AppRoleId`) REFERENCES `AppRole` (`AppRoleId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `approleauth_ibfk_2` FOREIGN KEY (`AppAuthId`) REFERENCES `AppAuth` (`AppAuthId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AppRoleAuth`
--

LOCK TABLES `AppRoleAuth` WRITE;
/*!40000 ALTER TABLE `AppRoleAuth` DISABLE KEYS */;
/*!40000 ALTER TABLE `AppRoleAuth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AppUser`
--

DROP TABLE IF EXISTS `AppUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AppUser` (
  `AppUserId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ManagerId` int(10) unsigned DEFAULT NULL,
  `AppRoleId` int(10) unsigned NOT NULL,
  `DesignationId` int(10) unsigned DEFAULT NULL,
  `CustomerId` int(10) unsigned DEFAULT NULL,
  `Name` varchar(20) NOT NULL,
  `Email` varchar(20) NOT NULL,
  `IsEmployee` tinyint(1) NOT NULL,
  `UserPassword` varchar(40) NOT NULL,
  `EmployeeId` int(10) unsigned DEFAULT NULL,
  `DepartmentId` int(10) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AppUser`
--

LOCK TABLES `AppUser` WRITE;
/*!40000 ALTER TABLE `AppUser` DISABLE KEYS */;
INSERT INTO `AppUser` VALUES (43,NULL,1,NULL,1,'Adminitrator user','admin@assess.com',0,'password',NULL,NULL),(64,73,2,19,2,'Anand Nigam','anigam@assess.com',1,'password',35522,NULL),(65,73,2,20,2,'Matt Hong','mhing@assess.com',1,'password',35523,NULL),(66,72,2,22,2,'Michael Nixon','mnixon@assess.com',1,'password',35524,NULL),(67,72,2,21,2,'Sandy Anurus','sandy@assess.com',1,'password',35525,NULL),(68,70,2,19,2,'Rocky Fan','rocky@assess.com',1,'password',35526,NULL),(69,68,2,19,2,'Chris Rico','crico@assess.com',1,'password',35527,NULL),(70,NULL,2,20,2,'Unoose Ayoob','unoose@assess.com',1,'password',35528,NULL),(71,64,2,19,2,'Sveta West','swest@assess.com',1,'password',35529,NULL),(72,68,2,19,2,'Jordan Chan','jordan@citi.com',0,'password',35529,NULL),(73,68,2,19,2,'Abhinav Nigam','abhi@assess.com',0,'password',35529,NULL);
/*!40000 ALTER TABLE `AppUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AssessmentArea`
--

DROP TABLE IF EXISTS `AssessmentArea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AssessmentArea` (
  `AssessmentAreaId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CustomerId` int(10) unsigned NOT NULL,
  `AssessmentAreaName` varchar(20) NOT NULL,
  `AssessmentAreaDescription` varchar(255) DEFAULT NULL,
  `ParentAssessmentAreaId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`AssessmentAreaId`),
  UNIQUE KEY `customer_assessmentarea_ukey` (`CustomerId`,`AssessmentAreaName`),
  KEY `AssessmentArea_FKIndex1` (`CustomerId`),
  KEY `AssessmentArea_Index2` (`ParentAssessmentAreaId`),
  CONSTRAINT `assessmentarea_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `assessmentarea_ibfk_2` FOREIGN KEY (`ParentAssessmentAreaId`) REFERENCES `AssessmentArea` (`AssessmentAreaId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AssessmentArea`
--

LOCK TABLES `AssessmentArea` WRITE;
/*!40000 ALTER TABLE `AssessmentArea` DISABLE KEYS */;
INSERT INTO `AssessmentArea` VALUES (8,2,'Driving for sucess','Driving for sucess',NULL),(9,2,'Strength','key strength',13),(10,2,'Improvements','Improvements',13),(11,2,'technical','technical',8),(12,2,'management','management',8),(13,2,'Building commitment','Building commitment',NULL);
/*!40000 ALTER TABLE `AssessmentArea` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customer` (
  `CustomerId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CustomerName` varchar(20) NOT NULL,
  `NoOfUserNominatedReviewers` int(10) unsigned DEFAULT NULL,
  `NoOfAdminNominatedReviewers` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`CustomerId`),
  UNIQUE KEY `Customer_name_ukey` (`CustomerName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (1,'Expedia1',2,2),(2,'Expedia',2,2);
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerUserReviewer`
--

DROP TABLE IF EXISTS `CustomerUserReviewer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerUserReviewer`
--

LOCK TABLES `CustomerUserReviewer` WRITE;
/*!40000 ALTER TABLE `CustomerUserReviewer` DISABLE KEYS */;
INSERT INTO `CustomerUserReviewer` VALUES (1,65,64,43,2),(2,66,64,43,2),(3,67,64,43,2),(4,68,64,43,1),(5,66,65,43,2),(6,67,65,43,1),(7,68,65,43,1),(8,69,65,43,1),(9,67,66,43,1),(10,68,66,43,1),(11,69,66,43,1),(12,70,66,43,1),(13,68,67,43,1),(14,69,67,43,1),(15,70,67,43,1),(16,71,67,43,1),(17,69,68,43,1),(18,70,68,43,1),(19,71,68,43,1),(20,72,68,43,1),(21,70,69,43,1),(22,71,69,43,1),(23,72,69,43,1),(24,73,69,43,1),(25,71,70,43,1),(26,72,70,43,1),(27,73,70,43,1),(28,64,70,43,2),(29,72,71,43,1),(30,73,71,43,1),(31,64,71,43,1),(32,65,71,43,1),(33,73,72,43,1),(34,64,72,43,1),(35,65,72,43,1),(36,66,72,43,1),(37,64,73,43,1),(38,65,73,43,1),(39,66,73,43,1),(40,67,73,43,1),(41,64,64,64,2),(42,65,65,65,1),(43,66,66,66,1),(44,67,67,67,1),(45,68,68,68,1),(46,69,69,69,1),(47,70,70,70,1),(48,71,71,71,1);
/*!40000 ALTER TABLE `CustomerUserReviewer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Department` (
  `DepartmentId` int(11) NOT NULL AUTO_INCREMENT,
  `DepartmentName` varchar(45) NOT NULL,
  PRIMARY KEY (`DepartmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
/*!40000 ALTER TABLE `Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Designation`
--

DROP TABLE IF EXISTS `Designation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Designation` (
  `DesignationId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CustomerId` int(10) unsigned NOT NULL,
  `Name` varchar(20) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DesignationId`),
  UNIQUE KEY `customer_designation_ukey` (`CustomerId`,`Name`),
  KEY `employee_role_FKIndex1` (`CustomerId`),
  CONSTRAINT `designation_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Designation`
--

LOCK TABLES `Designation` WRITE;
/*!40000 ALTER TABLE `Designation` DISABLE KEYS */;
INSERT INTO `Designation` VALUES (19,2,'Developer','developer description'),(20,2,'Manager','Manager description'),(21,2,'Director','Director description'),(22,2,'VP','Vice president description');
/*!40000 ALTER TABLE `Designation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EmployeeFeedbackAnswer`
--

DROP TABLE IF EXISTS `EmployeeFeedbackAnswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EmployeeFeedbackAnswer`
--

LOCK TABLES `EmployeeFeedbackAnswer` WRITE;
/*!40000 ALTER TABLE `EmployeeFeedbackAnswer` DISABLE KEYS */;
INSERT INTO `EmployeeFeedbackAnswer` VALUES (3,5,409,'asdff'),(4,5,410,NULL),(5,5,411,NULL),(6,5,414,NULL),(7,5,415,NULL),(8,5,412,NULL),(9,5,413,NULL),(10,5,417,NULL),(11,5,416,NULL),(12,28,409,'aCASC'),(13,28,410,NULL),(14,28,411,NULL),(15,28,414,NULL),(16,28,415,NULL),(17,28,412,NULL),(18,28,413,NULL),(19,28,416,NULL),(20,41,400,'Anand Nigam testing'),(21,41,408,NULL),(22,41,402,NULL),(23,41,403,NULL),(24,41,401,NULL),(25,41,406,NULL),(26,41,407,NULL),(27,41,404,NULL),(28,41,405,NULL),(29,1,400,'werff'),(30,1,408,NULL),(31,1,402,NULL),(32,1,403,NULL),(33,1,401,NULL),(34,1,406,NULL),(35,1,407,NULL),(36,1,404,NULL),(37,1,405,NULL),(38,2,400,'adcxc '),(39,2,408,NULL),(40,2,402,NULL),(41,2,403,NULL),(42,2,401,NULL),(43,2,406,NULL),(44,2,407,NULL),(45,2,404,NULL),(46,2,405,NULL),(47,3,400,'saCSACC'),(48,3,408,NULL),(49,3,402,NULL),(50,3,403,NULL),(51,3,401,NULL),(52,3,406,NULL),(53,3,407,NULL),(54,3,404,NULL),(55,3,405,NULL);
/*!40000 ALTER TABLE `EmployeeFeedbackAnswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MultipleChoice`
--

DROP TABLE IF EXISTS `MultipleChoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MultipleChoice` (
  `MultipleChoiceId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `QuestionId` int(10) unsigned NOT NULL,
  `Answer` varchar(40) NOT NULL,
  `Sequence` int(10) unsigned NOT NULL,
  `RatingScaleId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`MultipleChoiceId`),
  KEY `QuestionId` (`QuestionId`),
  KEY `multiplechoice_ibfk_2` (`RatingScaleId`),
  CONSTRAINT `multiplechoice_ibfk_1` FOREIGN KEY (`QuestionId`) REFERENCES `Question` (`QuestionId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `multiplechoice_ibfk_2` FOREIGN KEY (`RatingScaleId`) REFERENCES `RatingScale` (`RatingScaleId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=699 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MultipleChoice`
--

LOCK TABLES `MultipleChoice` WRITE;
/*!40000 ALTER TABLE `MultipleChoice` DISABLE KEYS */;
INSERT INTO `MultipleChoice` VALUES (539,401,'Poor',1,11),(540,401,'Average',1,12),(541,401,'Good',1,13),(542,401,'Very good',1,14),(543,401,'Excellent',1,15),(544,402,'Poor',1,11),(545,402,'Average',1,12),(546,402,'Good',1,13),(547,402,'Very good',1,14),(548,402,'Excellent',1,15),(549,403,'Poor',1,11),(550,403,'Average',1,12),(551,403,'Good',1,13),(552,403,'Very good',1,14),(553,403,'Excellent',1,15),(554,404,'Poor',1,11),(555,404,'Average',1,12),(556,404,'Good',1,13),(557,404,'Very good',1,14),(558,404,'Excellent',1,15),(559,405,'Poor',1,11),(560,405,'Average',1,12),(561,405,'Good',1,13),(562,405,'Very good',1,14),(563,405,'Excellent',1,15),(564,406,'Poor',1,11),(565,406,'Average',1,12),(566,406,'Good',1,13),(567,406,'Very good',1,14),(568,406,'Excellent',1,15),(569,407,'Poor',1,11),(570,407,'Average',1,12),(571,407,'Good',1,13),(572,407,'Very good',1,14),(573,407,'Excellent',1,15),(574,408,'Poor',1,11),(575,408,'Average',1,12),(576,408,'Good',1,13),(577,408,'Very good',1,14),(578,408,'Excellent',1,15),(579,410,'Poor',1,11),(580,410,'Average',1,12),(581,410,'Good',1,13),(582,410,'Very good',1,14),(583,410,'Excellent',1,15),(584,411,'Poor',1,11),(585,411,'Average',1,12),(586,411,'Good',1,13),(587,411,'Very good',1,14),(588,411,'Excellent',1,15),(589,412,'Poor',1,11),(590,412,'Average',1,12),(591,412,'Good',1,13),(592,412,'Very good',1,14),(593,412,'Excellent',1,15),(594,413,'Poor',1,11),(595,413,'Average',1,12),(596,413,'Good',1,13),(597,413,'Very good',1,14),(598,413,'Excellent',1,15),(599,414,'Poor',1,11),(600,414,'Average',1,12),(601,414,'Good',1,13),(602,414,'Very good',1,14),(603,414,'Excellent',1,15),(604,415,'Poor',1,11),(605,415,'Average',1,12),(606,415,'Good',1,13),(607,415,'Very good',1,14),(608,415,'Excellent',1,15),(609,416,'Poor',1,11),(610,416,'Average',1,12),(611,416,'Good',1,13),(612,416,'Very good',1,14),(613,416,'Excellent',1,15),(614,417,'Poor',1,11),(615,417,'Average',1,12),(616,417,'Good',1,13),(617,417,'Very good',1,14),(618,417,'Excellent',1,15),(619,419,'Poor',1,11),(620,419,'Average',1,12),(621,419,'Good',1,13),(622,419,'Very good',1,14),(623,419,'Excellent',1,15),(624,420,'Poor',1,11),(625,420,'Average',1,12),(626,420,'Good',1,13),(627,420,'Very good',1,14),(628,420,'Excellent',1,15),(629,421,'Poor',1,11),(630,421,'Average',1,12),(631,421,'Good',1,13),(632,421,'Very good',1,14),(633,421,'Excellent',1,15),(634,422,'Poor',1,11),(635,422,'Average',1,12),(636,422,'Good',1,13),(637,422,'Very good',1,14),(638,422,'Excellent',1,15),(639,423,'Poor',1,11),(640,423,'Average',1,12),(641,423,'Good',1,13),(642,423,'Very good',1,14),(643,423,'Excellent',1,15),(644,424,'Poor',1,11),(645,424,'Average',1,12),(646,424,'Good',1,13),(647,424,'Very good',1,14),(648,424,'Excellent',1,15),(649,425,'Poor',1,11),(650,425,'Average',1,12),(651,425,'Good',1,13),(652,425,'Very good',1,14),(653,425,'Excellent',1,15),(654,426,'Poor',1,11),(655,426,'Average',1,12),(656,426,'Good',1,13),(657,426,'Very good',1,14),(658,426,'Excellent',1,15),(659,428,'Poor',1,11),(660,428,'Average',1,12),(661,428,'Good',1,13),(662,428,'Very good',1,14),(663,428,'Excellent',1,15),(664,429,'Poor',1,11),(665,429,'Average',1,12),(666,429,'Good',1,13),(667,429,'Very good',1,14),(668,429,'Excellent',1,15),(669,430,'Poor',1,11),(670,430,'Average',1,12),(671,430,'Good',1,13),(672,430,'Very good',1,14),(673,430,'Excellent',1,15),(674,431,'Poor',1,11),(675,431,'Average',1,12),(676,431,'Good',1,13),(677,431,'Very good',1,14),(678,431,'Excellent',1,15),(679,432,'Poor',1,11),(680,432,'Average',1,12),(681,432,'Good',1,13),(682,432,'Very good',1,14),(683,432,'Excellent',1,15),(684,433,'Poor',1,11),(685,433,'Average',1,12),(686,433,'Good',1,13),(687,433,'Very good',1,14),(688,433,'Excellent',1,15),(689,434,'Poor',1,11),(690,434,'Average',1,12),(691,434,'Good',1,13),(692,434,'Very good',1,14),(693,434,'Excellent',1,15),(694,435,'Poor',1,11),(695,435,'Average',1,12),(696,435,'Good',1,13),(697,435,'Very good',1,14),(698,435,'Excellent',1,15);
/*!40000 ALTER TABLE `MultipleChoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MultipleChoiceAnswer`
--

DROP TABLE IF EXISTS `MultipleChoiceAnswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MultipleChoiceAnswer`
--

LOCK TABLES `MultipleChoiceAnswer` WRITE;
/*!40000 ALTER TABLE `MultipleChoiceAnswer` DISABLE KEYS */;
INSERT INTO `MultipleChoiceAnswer` VALUES (1,4,580),(2,5,587),(3,6,601),(4,7,607),(5,8,591),(6,9,597),(7,10,616),(8,11,612),(9,13,581),(10,14,587),(11,15,601),(12,16,606),(13,17,593),(14,18,597),(15,19,612),(16,21,578),(17,22,546),(18,23,553),(19,24,542),(20,25,567),(21,26,573),(22,27,555),(23,28,561),(24,30,575),(25,31,544),(26,32,552),(27,33,541),(28,34,567),(29,35,571),(30,36,557),(31,37,562),(32,39,577),(33,40,544),(34,41,551),(35,42,541),(36,43,565),(37,44,570),(38,45,554),(39,46,561),(40,48,574),(41,49,548),(42,50,553),(43,51,543),(44,52,567),(45,53,573),(46,54,558),(47,55,562);
/*!40000 ALTER TABLE `MultipleChoiceAnswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Question`
--

DROP TABLE IF EXISTS `Question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Question` (
  `QuestionId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RefQuestionTypeId` int(10) unsigned NOT NULL,
  `CustomerId` int(10) unsigned NOT NULL,
  `Question` varchar(255) NOT NULL,
  `DesignationId` int(10) unsigned NOT NULL,
  `AssessmentAreaId` int(10) unsigned NOT NULL,
  `SerialOrder` int(10) NOT NULL,
  PRIMARY KEY (`QuestionId`),
  UNIQUE KEY `customer_question_assessmentarea_ukey` (`CustomerId`,`Question`,`DesignationId`,`AssessmentAreaId`),
  KEY `feedback_questions_FKIndex2` (`CustomerId`),
  KEY `RefQuestionType_RefQuestionTypeId` (`RefQuestionTypeId`),
  KEY `question_ibfk_3` (`DesignationId`),
  KEY `question_ibfk_4` (`AssessmentAreaId`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`RefQuestionTypeId`) REFERENCES `RefQuestionType` (`RefQuestionTypeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `question_ibfk_2` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `question_ibfk_3` FOREIGN KEY (`DesignationId`) REFERENCES `Designation` (`DesignationId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `question_ibfk_4` FOREIGN KEY (`AssessmentAreaId`) REFERENCES `AssessmentArea` (`AssessmentAreaId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=436 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Question`
--

LOCK TABLES `Question` WRITE;
/*!40000 ALTER TABLE `Question` DISABLE KEYS */;
INSERT INTO `Question` VALUES (400,1,2,'What do you see as 2-3 key strengths?',19,9,1),(401,2,2,'How do you rate his/her development skills. Please select one of the following.',19,9,1),(402,2,2,'How do you rate his/her presentation skills. Please select one of the following.',19,10,1),(403,2,2,'How do you rate his/her technical skills. Please select one of the following.',19,11,1),(404,2,2,'How do you rate his/her management skills. Please select one of the following.',19,12,1),(405,2,2,'How do you rate his/her enterpreneurship skills. Please select one of the following.',19,9,1),(406,2,2,'How do you rate his/her listening skills. Please select one of the following.',19,10,1),(407,2,2,'How do you rate his/her extra curicular skills. Please select one of the following.',19,11,1),(408,2,2,'How do you rate his/her communication skills. Please select one of the following.',19,12,1),(409,1,2,'What do you see as 2-3 key strengths?',20,9,1),(410,2,2,'How do you rate his/her development skills. Please select one of the following.',20,9,1),(411,2,2,'How do you rate his/her presentation skills. Please select one of the following.',20,10,1),(412,2,2,'How do you rate his/her technical skills. Please select one of the following.',20,11,1),(413,2,2,'How do you rate his/her management skills. Please select one of the following.',20,12,1),(414,2,2,'How do you rate his/her enterpreneurship skills. Please select one of the following.',20,9,1),(415,2,2,'How do you rate his/her listening skills. Please select one of the following.',20,10,1),(416,2,2,'How do you rate his/her extra curicular skills. Please select one of the following.',20,11,1),(417,2,2,'How do you rate his/her communication skills. Please select one of the following.',20,12,1),(418,1,2,'What do you see as 2-3 key strengths?',21,9,1),(419,2,2,'How do you rate his/her development skills. Please select one of the following.',21,9,1),(420,2,2,'How do you rate his/her presentation skills. Please select one of the following.',21,10,1),(421,2,2,'How do you rate his/her technical skills. Please select one of the following.',21,11,1),(422,2,2,'How do you rate his/her management skills. Please select one of the following.',21,12,1),(423,2,2,'How do you rate his/her enterpreneurship skills. Please select one of the following.',21,9,1),(424,2,2,'How do you rate his/her listening skills. Please select one of the following.',21,10,1),(425,2,2,'How do you rate his/her extra curicular skills. Please select one of the following.',21,11,1),(426,2,2,'How do you rate his/her communication skills. Please select one of the following.',21,12,1),(427,1,2,'What do you see as 2-3 key strengths?',22,9,1),(428,2,2,'How do you rate his/her development skills. Please select one of the following.',22,9,1),(429,2,2,'How do you rate his/her presentation skills. Please select one of the following.',22,10,1),(430,2,2,'How do you rate his/her technical skills. Please select one of the following.',22,11,1),(431,2,2,'How do you rate his/her management skills. Please select one of the following.',22,12,1),(432,2,2,'How do you rate his/her enterpreneurship skills. Please select one of the following.',22,9,1),(433,2,2,'How do you rate his/her listening skills. Please select one of the following.',22,10,1),(434,2,2,'How do you rate his/her extra curicular skills. Please select one of the following.',22,11,1),(435,2,2,'How do you rate his/her communication skills. Please select one of the following.',22,12,1);
/*!40000 ALTER TABLE `Question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RatingScale`
--

DROP TABLE IF EXISTS `RatingScale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RatingScale` (
  `RatingScaleId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CustomerId` int(10) unsigned NOT NULL,
  `Ranking` int(10) unsigned NOT NULL,
  `Name` varchar(20) NOT NULL,
  PRIMARY KEY (`RatingScaleId`),
  KEY `customer_rating_scale_FKIndex1` (`CustomerId`),
  CONSTRAINT `ratingscale_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `Customer` (`CustomerId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RatingScale`
--

LOCK TABLES `RatingScale` WRITE;
/*!40000 ALTER TABLE `RatingScale` DISABLE KEYS */;
INSERT INTO `RatingScale` VALUES (11,2,1,'poor'),(12,2,2,'average'),(13,2,3,'good'),(14,2,4,'excellent'),(15,2,5,'outstanding');
/*!40000 ALTER TABLE `RatingScale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RefFeedbackStatus`
--

DROP TABLE IF EXISTS `RefFeedbackStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RefFeedbackStatus` (
  `RefFeedbackStatusId` int(10) unsigned NOT NULL,
  `RefFeedbackStatusName` varchar(20) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`RefFeedbackStatusId`),
  UNIQUE KEY `RefFeedbackStatus_index1351` (`RefFeedbackStatusName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RefFeedbackStatus`
--

LOCK TABLES `RefFeedbackStatus` WRITE;
/*!40000 ALTER TABLE `RefFeedbackStatus` DISABLE KEYS */;
INSERT INTO `RefFeedbackStatus` VALUES (1,'New','New'),(2,'Draft','In progress'),(3,'Submitted','Submitted');
/*!40000 ALTER TABLE `RefFeedbackStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RefQuestionType`
--

DROP TABLE IF EXISTS `RefQuestionType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RefQuestionType` (
  `RefQuestionTypeId` int(10) unsigned NOT NULL,
  `QuestionType` varchar(20) NOT NULL,
  PRIMARY KEY (`RefQuestionTypeId`),
  UNIQUE KEY `RefQuestionType_QuestionType_ukey` (`QuestionType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RefQuestionType`
--

LOCK TABLES `RefQuestionType` WRITE;
/*!40000 ALTER TABLE `RefQuestionType` DISABLE KEYS */;
INSERT INTO `RefQuestionType` VALUES (1,'DESCRIPTIVE'),(2,'MULTIPLE_CHOICE');
/*!40000 ALTER TABLE `RefQuestionType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'assess_new'
--
/*!50003 DROP PROCEDURE IF EXISTS `AppUserManagerUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AppUserManagerUpdate`(
	pUserName varchar(20),
	pManagerName varchar(20)
)
BEGIN

	DECLARE AaId, pAaId INT DEFAULT 0;

	Select AppUserId into AaId from AppUser where `name` =  pUserName;
	Select AppUserId into pAaId from AppUser where `name` =  pUserName;
	
	update AppUser  set ManagerId = pAaId where AppUserId  =  AaId;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AssessmentAreaParentUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AssessmentAreaParentUpdate`(
	pAssessmentAreaName varchar(20),
	pParentAssessmentAreaName varchar(20)

)
BEGIN

	DECLARE AaId, pAaId INT DEFAULT 0;
	Select AssessmentAreaId into AaId from AssessmentArea where AssessmentAreaName =  pAssessmentAreaName;
	Select AssessmentAreaId into pAaId from AssessmentArea where AssessmentAreaName =  pParentAssessmentAreaName;

	update AssessmentArea  set ParentAssessmentAreaId = pAaId where AssessmentAreaId =  AaId;




END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CustomerUserReviewerAdd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CustomerUserReviewerAdd`(
	pReviewerEmail varchar(20),
	pRevieweeEmail varchar(20),
	pNominatedByEmail varchar(20),
	FeedbackStatusId int
)
BEGIN

	DECLARE vReviewerUserId, vRevieweeUserId , vNominatedByUserId INT DEFAULT 0;
	select appuserid  into vReviewerUserId from AppUser where email = pReviewerEmail;
	select appuserid  into vRevieweeUserId from AppUser where email = pRevieweeEmail;
	select appuserid  into vNominatedByUserId from AppUser where email = pNominatedByEmail;
	Insert into CustomerUserReviewer ( ReviewerId, RevieweeId, NominatedBy, FeedbackStatusId) values (vReviewerUserId, vRevieweeUserId , vNominatedByUserId ,FeedbackStatusId);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CustomerUserReviewerByIdAdd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CustomerUserReviewerByIdAdd`(
	pReviewerId int,
	pRevieweeId int,
	pNominatedById int,
	FeedbackStatusId int
)
BEGIN

	Insert into CustomerUserReviewer ( ReviewerId, RevieweeId, NominatedBy, FeedbackStatusId) values (pReviewerId, pRevieweeId , pNominatedById ,FeedbackStatusId);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FrequencyReportGetByUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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
	where cur.revieweeId = userId
	and cur.revieweeId = cur.reviewerId
	group by q.questionId,mca.MultipleChoiceId
	) a
	on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
	where a.appuserId = userId
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
	where cur.revieweeId = userId
	group by q.questionId,mca.MultipleChoiceId
	order by q.questionId, mca.MultipleChoiceId, cur.reviewerId
	) a
	on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
	where a.appuserId = userId
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
	where cur.revieweeId = userId
	and cur.revieweeId != cur.reviewerId
	group by q.questionId,mca.MultipleChoiceId
	order by q.questionId, mca.MultipleChoiceId, cur.reviewerId
	) a
	on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
	where a.appuserId = userId
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
	where cur.revieweeId = userId
	group by q.questionId,mca.MultipleChoiceId
	order by q.questionId, mca.MultipleChoiceId, cur.reviewerId
	) a
	on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
	where a.appuserId = userId
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
	where cur.revieweeId = userId
	group by q.questionId,mca.MultipleChoiceId
	order by q.questionId, mca.MultipleChoiceId, cur.reviewerId
	) a
	on a.questionId = mc1.questionId and a.MultipleChoiceId = mc1.MultipleChoiceId
	where a.appuserId =userId
	order by mc1.questionId, mc1.MultipleChoiceId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `IndividualSummaryReportGet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MultipleChoiceAdd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MultipleChoiceAdd`(
	pchoiceA varchar(40),
	pchoiceRatingScaleA varchar(40),
	questionid int,
	sequence int
)
BEGIN

		DECLARE  vRatingScale INT DEFAULT 0;
		if(pchoiceA is not null)
		then
			select 'Debug',questionid,  pchoiceA, pchoiceRatingScaleA;
			select pchoiceRatingScaleA;
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleA;
			INSERT INTO MultipleChoice (questionid, answer, sequence, RatingScaleid) values (vQuestionId,pchoiceA,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceA;

		ELSE
			select  'CHOICE A IS NULL';
		end If;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `QuestionAdd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `QuestionAdd`(
	pdesignation varchar(20),
	pCustomer varchar(20),
	pquestion varchar(255),
	pquestionType varchar(20),
	pAssessmentarea varchar(20),
	pchoiceA varchar(40),
	pchoiceB varchar(40),
	pchoiceC varchar(40),
	pchoiceD varchar(40),
	pchoiceE varchar(40),
	pchoiceF varchar(40),
	pchoiceG varchar(40),
	pchoiceRatingScaleA varchar(40),
	pchoiceRatingScaleB varchar(40),
	pchoiceRatingScaleC varchar(40),
	pchoiceRatingScaleD varchar(40),
	pchoiceRatingScaleE varchar(40),
	pchoiceRatingScaleF varchar(40),
	pchoiceRatingScaleG varchar(40)
	
)
BEGIN

	DECLARE vdesignationId, vCustomerId, vAssessmentAreaid , vRefQuestiontypeId , vQuestionId , vRatingScale INT DEFAULT 0;

	
	select AssessmentAreaId into vAssessmentAreaid from AssessmentArea where assessmentAreaname =  pAssessmentarea;
	select CustomerId into vCustomerId from Customer where CustomerName =  pCustomer;
	select designationId into vdesignationId from Designation where `Name` =  pdesignation;
	select RefQuestionTypeId into vRefQuestiontypeId from RefQuestionType where QuestionType = pquestionType;
	

	select vdesignationId, vCustomerId, vAssessmentAreaid , vRefQuestiontypeId , vQuestionId , vRatingScale;

	INSERT INTO QUESTION (designationId, refQuestionTypeId, CustomerId, Question, AssessmentAreaId, SerialOrder) values (vdesignationId, vRefQuestiontypeId,vCustomerId, pquestion , vAssessmentAreaid, 1);

	select questionId into vQuestionId from Question 
	where question = pquestion 
	and designationId = vdesignationId 
	and customerId = vCustomerId  
	and assessmentAreaId = vAssessmentAreaid 
	and refQuestionTypeId = vRefQuestiontypeId;

	select vQuestionId;
	
	if(vRefQuestiontypeId = 2)
	then
		select 'AAAAA';
		if(pchoiceA is not null)
		then
			select pchoiceRatingScaleA;
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleA;
			INSERT INTO MultipleChoice (questionid, answer, sequence, RatingScaleid) values (vQuestionId,pchoiceA,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceA;

		ELSE
			select  pchoiceA;
		end If;


		if(pchoiceB is not null)
		then
			select 'BBBBB', pchoiceRatingScaleB;
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleB;
			INSERT INTO MultipleChoice (questionid, answer, sequence, RatingScaleid) values (vQuestionId,pchoiceB,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceB;
		ELSE
			select  pchoiceB;
		end If;

		if(pchoiceC is not null)
		then
			select 'CCCCC', pchoiceRatingScaleC;
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleC;
			INSERT INTO MultipleChoice (questionid, answer, sequence, RatingScaleid) values (vQuestionId,pchoiceC,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceC;
		ELSE
			select  pchoiceC;
		end If;

		if(pchoiceD is not null)
		then
			select 'DDDDD', pchoiceRatingScaleD;
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleD;
			INSERT INTO MultipleChoice (questionid, answer, sequence, RatingScaleid) values (vQuestionId,pchoiceD,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceD;
		ELSE
			select  pchoiceD;
		end If;

		if(pchoiceE is not null)
		then
			select 'EEEEE', pchoiceRatingScaleE;
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleE;
			INSERT INTO MultipleChoice (questionid, answer, sequence, RatingScaleid) values (vQuestionId,pchoiceE,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceE;
		ELSE
			select  pchoiceE;
		end If;

		if(pchoiceF is not null)
		then
			select 'FFFFF', pchoiceRatingScaleF;
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleF;
			INSERT INTO MultipleChoice (questionid, answer, sequence, RatingScaleid) values (vQuestionId,pchoiceF,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceF;
		ELSE
			select  pchoiceF;
		end If;

		if(pchoiceG is not null)
		then
			select 'GGGGGG', pchoiceRatingScaleG;
			select RatingScaleid into vRatingScale from RatingScale where `name` = pchoiceRatingScaleG;
			INSERT INTO MultipleChoice (questionid, answer, sequence, RatingScaleid) values (vQuestionId,pchoiceG,1, vRatingScale);
			select MultipleChoiceid from MultipleChoice  where answer = pchoiceG;
		ELSE
			select  pchoiceG;
		end If;
	else
		select 'ERROR';

	end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `QuestionAdd1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `QuestionAdd1`(
	pdesignation varchar(20),
	pCustomer varchar(20),
	pquestion varchar(255),
	pquestionType varchar(20),
	pAssessmentarea varchar(20),
	pchoiceA varchar(40),
	pchoiceB varchar(40),
	pchoiceC varchar(40),
	pchoiceD varchar(40),
	pchoiceE varchar(40),
	pchoiceF varchar(40),
	pchoiceG varchar(40),
	pchoiceRatingScaleA varchar(40),
	pchoiceRatingScaleB varchar(40),
	pchoiceRatingScaleC varchar(40),
	pchoiceRatingScaleD varchar(40),
	pchoiceRatingScaleE varchar(40),
	pchoiceRatingScaleF varchar(40),
	pchoiceRatingScaleG varchar(40)
	
)
BEGIN

	DECLARE vdesignationId, vCustomerId, vAssessmentAreaid , vRefQuestiontypeId , vQuestionId , vRatingScale INT DEFAULT 0;

	
	select AssessmentAreaId into vAssessmentAreaid from AssessmentArea where assessmentAreaname =  pAssessmentarea;
	select CustomerId into vCustomerId from Customer where CustomerName =  pCustomer;
	select designationId into vdesignationId from Designation where `Name` =  pdesignation;
	select RefQuestionTypeId into vRefQuestiontypeId from RefQuestionType where QuestionType = pquestionType;
	

	select vdesignationId, vCustomerId, vAssessmentAreaid , vRefQuestiontypeId , vQuestionId , vRatingScale;

	INSERT INTO QUESTION (designationId, refQuestionTypeId, CustomerId, Question, AssessmentAreaId, SerialOrder) values (vdesignationId, vRefQuestiontypeId,vCustomerId, pquestion , vAssessmentAreaid, 1);

	select questionId into vQuestionId from Question 
	where question = pquestion 
	and designationId = vdesignationId 
	and customerId = vCustomerId  
	and assessmentAreaId = vAssessmentAreaid 
	and refQuestionTypeId = vRefQuestiontypeId;

	select vQuestionId;
	
	if(vRefQuestiontypeId = 2)
	then
		CALL `MultipleChoiceAdd`(pchoiceA,pchoiceRatingScaleA,vQuestionId, 1);
		select questionId into vQuestionId from Question where question = pquestion and designationId = vdesignationId and customerId = vCustomerId  and assessmentAreaId = vAssessmentAreaid and refQuestionTypeId = vRefQuestiontypeId;
		
		select vQuestionId , 'after calling...';
			
	else
		select 'ERROR';

	end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RatingScaleAdd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateManager` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateManager`(
	pUserEmail varchar(20),
	pManagerEmail varchar(20)
)
BEGIN

	DECLARE vUserId, vManagerId INT DEFAULT 0;

	select appuserid into vUserId from AppUser where email  = pUserEmail;

	select appuserid into vManagerId from AppUser where email  = pManagerEmail;

	update AppUser set managerId = vManagerId where appUserId = vUserId; 

	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-09-03  8:18:57
