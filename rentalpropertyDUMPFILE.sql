-- MySQL dump 10.13  Distrib 8.1.0, for macos13 (x86_64)
--
-- Host: localhost    Database: RentalPropertyDatabase
-- ------------------------------------------------------
-- Server version	8.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Contracts`
--

DROP TABLE IF EXISTS `Contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Contracts` (
  `ContractID` int NOT NULL AUTO_INCREMENT,
  `PropertyID` int DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `AmountDeposit` int DEFAULT NULL,
  `AmountToBePaid` int DEFAULT NULL,
  `ContractStatus` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ContractID`),
  KEY `PropertyID` (`PropertyID`),
  CONSTRAINT `contracts_ibfk_1` FOREIGN KEY (`PropertyID`) REFERENCES `PropertyDetails` (`PropertyID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contracts`
--

LOCK TABLES `Contracts` WRITE;
/*!40000 ALTER TABLE `Contracts` DISABLE KEYS */;
INSERT INTO `Contracts` VALUES (13,200,'2023-10-13','2023-12-28',1500,2000,'PENDING'),(15,205,'2023-10-13','2024-12-16',400,1000,'PENDING'),(16,206,'2023-10-13','2024-10-01',1000,1000,'ACTIVE'),(17,201,'2023-10-13','2023-12-19',2500,2500,'ACTIVE'),(18,202,'2023-12-15','2023-12-28',1500,1500,'ACTIVE');
/*!40000 ALTER TABLE `Contracts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_Contracts` BEFORE INSERT ON `contracts` FOR EACH ROW BEGIN
    -- Check conditions and set ContractStatus accordingly
    IF NEW.AmountDeposit <> NEW.AmountToBePaid AND NEW.StartDate > CURDATE() THEN
        SET NEW.ContractStatus = 'PENDING';
        ELSEIF NEW.AmountDeposit <> NEW.AmountToBePaid OR NEW.StartDate > CURDATE() THEN
        SET NEW.ContractStatus = 'PENDING';
        ELSEIF NEW.AmountDeposit = NEW.AmountToBePaid AND NEW.StartDate <= CURDATE() THEN
        SET NEW.ContractStatus = 'ACTIVE';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_update_Contracts` BEFORE UPDATE ON `contracts` FOR EACH ROW BEGIN
    -- Check conditions and set ContractStatus accordingly
    IF NEW.AmountDeposit <> NEW.AmountToBePaid AND NEW.StartDate > CURDATE() THEN
        SET NEW.ContractStatus = 'PENDING';
    ELSEIF NEW.AmountDeposit <> NEW.AmountToBePaid OR NEW.StartDate > CURDATE() THEN
        SET NEW.ContractStatus = 'PENDING';
    ELSEIF NEW.AmountDeposit = NEW.AmountToBePaid AND NEW.StartDate <= CURDATE()  AND NEW.EndDate > CURDATE() THEN
        SET NEW.ContractStatus = 'ACTIVE';
    ELSEIF NEW.EndDate <= CURDATE() THEN
        SET NEW.ContractStatus = 'EXPIRED';
        SET NEW.AmountDeposit = 0;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_StatusForProperty_trigger` AFTER UPDATE ON `contracts` FOR EACH ROW BEGIN
    DECLARE property_status VARCHAR(50);

    -- Set property_status based on ContractStatus
    IF NEW.ContractStatus = 'ACTIVE' THEN
        SET property_status = 'Occupied';
    ELSE
        SET property_status = 'For Rent';
    END IF;

    -- Update Status in PropertyDetails
    UPDATE PropertyDetails
    SET Status = property_status
    WHERE PropertyID = NEW.PropertyID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `logtablefortransactions`
--

DROP TABLE IF EXISTS `logtablefortransactions`;
/*!50001 DROP VIEW IF EXISTS `logtablefortransactions`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `logtablefortransactions` AS SELECT 
 1 AS `PropertyID`,
 1 AS `TransactionID`,
 1 AS `FirstName`,
 1 AS `LastName`,
 1 AS `TransactionType`,
 1 AS `TransactionDate`,
 1 AS `Amount`,
 1 AS `PaymentStatus`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `PropertyDetails`
--

DROP TABLE IF EXISTS `PropertyDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PropertyDetails` (
  `PropertyID` int NOT NULL,
  `UserID` int DEFAULT NULL,
  `PropertyManagerID` int DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `ZIPCode` varchar(10) DEFAULT NULL,
  `PropertyType` varchar(50) DEFAULT NULL,
  `Price` int DEFAULT NULL,
  `Status` enum('For Rent','Occupied') DEFAULT NULL,
  PRIMARY KEY (`PropertyID`),
  KEY `UserID` (`UserID`),
  KEY `PropertyManagerID` (`PropertyManagerID`),
  CONSTRAINT `propertydetails_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `UserDetails` (`UserID`),
  CONSTRAINT `propertydetails_ibfk_2` FOREIGN KEY (`PropertyManagerID`) REFERENCES `PropertyManagers` (`PropertyManagerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PropertyDetails`
--

LOCK TABLES `PropertyDetails` WRITE;
/*!40000 ALTER TABLE `PropertyDetails` DISABLE KEYS */;
INSERT INTO `PropertyDetails` VALUES (200,5,100,'123 Main St','Cityville','StateA','12345','Apartment',1200,'For Rent'),(201,2,105,'555 Cedar St','Countryside','StateE','98765','House',2500,'Occupied'),(202,4,102,'789 Maple St','Villagetown','StateC','10111','Condo',1500,'Occupied'),(205,1,101,'456 Oak St','Townsville','StateB','56789','House',2000,'For Rent'),(206,3,103,'101 Pine St','Hamletville','StateD','31415','Apartment',1800,'Occupied');
/*!40000 ALTER TABLE `PropertyDetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PropertyFeatures`
--

DROP TABLE IF EXISTS `PropertyFeatures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PropertyFeatures` (
  `PropertyID` int NOT NULL,
  `NumberOfBedrooms` int DEFAULT NULL,
  `NumberOfBathrooms` int DEFAULT NULL,
  `PetsAllowed` enum('Y','N') DEFAULT NULL,
  `InUnitLaundry` enum('Y','N') DEFAULT NULL,
  `GymAccess` enum('Y','N') DEFAULT NULL,
  `ParkingAccess` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`PropertyID`),
  CONSTRAINT `propertyfeatures_ibfk_1` FOREIGN KEY (`PropertyID`) REFERENCES `PropertyDetails` (`PropertyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PropertyFeatures`
--

LOCK TABLES `PropertyFeatures` WRITE;
/*!40000 ALTER TABLE `PropertyFeatures` DISABLE KEYS */;
INSERT INTO `PropertyFeatures` VALUES (200,2,1,'N','Y','N','Y'),(201,4,3,'Y','Y','Y','N'),(202,1,1,'Y','N','Y','N'),(205,3,2,'Y','Y','N','N'),(206,2,2,'N','Y','N','Y');
/*!40000 ALTER TABLE `PropertyFeatures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PropertyManagers`
--

DROP TABLE IF EXISTS `PropertyManagers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PropertyManagers` (
  `PropertyManagerID` int NOT NULL,
  `ManagerName` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `PhoneNo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PropertyManagerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PropertyManagers`
--

LOCK TABLES `PropertyManagers` WRITE;
/*!40000 ALTER TABLE `PropertyManagers` DISABLE KEYS */;
INSERT INTO `PropertyManagers` VALUES (100,'John Doe','john.doe@gmail.com','1234567890'),(101,'Jane Smith','jane.smith@yahoo.com','9876543210'),(102,'Bob Johnson','bob.johnson@gmail.com','5555555555'),(103,'Alice Brown','alice.brown@gmail.com','1112223333'),(105,'Charlie Wilson','charlie.wilson@yahoo.com','9998887777');
/*!40000 ALTER TABLE `PropertyManagers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RatingsAndReviews`
--

DROP TABLE IF EXISTS `RatingsAndReviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RatingsAndReviews` (
  `ReviewID` int NOT NULL AUTO_INCREMENT,
  `PropertyID` int DEFAULT NULL,
  `Rating` int DEFAULT NULL,
  `ReviewText` text,
  `Timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ReviewID`),
  KEY `PropertyID` (`PropertyID`),
  CONSTRAINT `ratingsandreviews_ibfk_1` FOREIGN KEY (`PropertyID`) REFERENCES `PropertyDetails` (`PropertyID`)
) ENGINE=InnoDB AUTO_INCREMENT=602 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RatingsAndReviews`
--

LOCK TABLES `RatingsAndReviews` WRITE;
/*!40000 ALTER TABLE `RatingsAndReviews` DISABLE KEYS */;
INSERT INTO `RatingsAndReviews` VALUES (600,201,4,'Great Place with Amazing entities','2023-12-15 14:39:57'),(601,205,2,'Property Is Average','2023-12-15 14:40:46');
/*!40000 ALTER TABLE `RatingsAndReviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Requests`
--

DROP TABLE IF EXISTS `Requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Requests` (
  `RequestID` int NOT NULL AUTO_INCREMENT,
  `PropertyID` int DEFAULT NULL,
  `MessageType` enum('Maintenance','Billing','Enquiry') DEFAULT NULL,
  `MessageText` text,
  `Timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`RequestID`),
  KEY `PropertyID` (`PropertyID`),
  CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`PropertyID`) REFERENCES `PropertyDetails` (`PropertyID`)
) ENGINE=InnoDB AUTO_INCREMENT=403 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Requests`
--

LOCK TABLES `Requests` WRITE;
/*!40000 ALTER TABLE `Requests` DISABLE KEYS */;
INSERT INTO `Requests` VALUES (400,201,'Maintenance','Need fixing for pipe','2023-12-15 08:31:29'),(401,201,'Billing','Error with my transaction','2023-12-15 20:05:05'),(402,202,'Enquiry','how to lock windows','2023-12-16 15:44:10');
/*!40000 ALTER TABLE `Requests` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_Requests` AFTER INSERT ON `requests` FOR EACH ROW BEGIN
    -- Insert a corresponding record into the Response table
    INSERT INTO Response (RequestID, ResponseType, ResponseText, Timestamp)
    VALUES (NEW.RequestID, 'AWAITING', NULL, CURRENT_TIMESTAMP);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Response`
--

DROP TABLE IF EXISTS `Response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Response` (
  `ResponseID` int NOT NULL AUTO_INCREMENT,
  `RequestID` int DEFAULT NULL,
  `ResponseType` varchar(100) DEFAULT NULL,
  `ResponseText` text,
  `Timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ResponseID`),
  KEY `RequestID` (`RequestID`),
  CONSTRAINT `response_ibfk_1` FOREIGN KEY (`RequestID`) REFERENCES `Requests` (`RequestID`)
) ENGINE=InnoDB AUTO_INCREMENT=503 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Response`
--

LOCK TABLES `Response` WRITE;
/*!40000 ALTER TABLE `Response` DISABLE KEYS */;
INSERT INTO `Response` VALUES (500,400,'Completed','All maintenace work done','2023-12-15 15:20:10'),(501,401,'IN PROGRESS','Working on a solut','2023-12-15 20:07:16'),(502,402,'COMPLETE','ADJUST THE FRAME PIN IN CLOCKWISE DIRECTIONS','2023-12-16 15:48:10');
/*!40000 ALTER TABLE `Response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transactions`
--

DROP TABLE IF EXISTS `Transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transactions` (
  `TransactionID` int NOT NULL AUTO_INCREMENT,
  `ContractID` int DEFAULT NULL,
  `TransactionType` varchar(50) DEFAULT NULL,
  `TransactionDate` date DEFAULT NULL,
  `Amount` int DEFAULT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `ContractID` (`ContractID`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`ContractID`) REFERENCES `Contracts` (`ContractID`)
) ENGINE=InnoDB AUTO_INCREMENT=323 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transactions`
--

LOCK TABLES `Transactions` WRITE;
/*!40000 ALTER TABLE `Transactions` DISABLE KEYS */;
INSERT INTO `Transactions` VALUES (315,13,'Credit','2023-12-15',1500),(317,15,'Credit','2023-12-15',400),(318,16,'Credit','2023-12-15',1000),(319,17,'Debit','2023-12-15',1250),(320,17,'Cash','2023-12-15',1250),(321,18,'Debit','2023-12-16',1000),(322,18,'Debit','2023-12-16',500);
/*!40000 ALTER TABLE `Transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_Transactions` AFTER INSERT ON `transactions` FOR EACH ROW BEGIN
    -- Update the AmountDeposit in Contracts based on the new transaction
    UPDATE Contracts
    SET AmountDeposit = CASE
                          WHEN AmountDeposit + NEW.Amount <= AmountToBePaid 
							THEN AmountDeposit + NEW.Amount
                          ELSE AmountToBePaid
                        END
    WHERE ContractID = NEW.ContractID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_TransactionsStatus` AFTER INSERT ON `transactions` FOR EACH ROW BEGIN
    DECLARE amountDeposited INT;
    DECLARE amountToBePaid INT;
-- 	DECLARE transactionIDValue INT;

-- Get the amountDeposited and amountToBePaid for the current TransactionID
		SELECT c.AmountDeposit, c.AmountToBePaid
		INTO amountDeposited, amountToBePaid
		FROM Contracts c
		JOIN Transactions t ON c.ContractID = t.ContractID
		WHERE t.TransactionID = NEW.transactionID;

    -- Insert or update TransactionStatus based on payment status conditions
     IF amountDeposited = amountToBePaid THEN
        INSERT INTO TransactionStatus (TransactionID, PaymentStatus)
        VALUES (NEW.TransactionID, 'PAID');
    ELSEIF amountDeposited > 0 THEN
        INSERT INTO TransactionStatus (TransactionID, PaymentStatus)
        VALUES (NEW.TransactionID, 'PARTIAL PAYMENT');
    ELSE
        INSERT INTO TransactionStatus (TransactionID, PaymentStatus)
        VALUES (NEW.TransactionID, 'NOT PAID');
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `TransactionStatus`
--

DROP TABLE IF EXISTS `TransactionStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TransactionStatus` (
  `TransactionID` int NOT NULL,
  `PaymentStatus` enum('PAID','PARTIAL PAYMENT','NOT PAID') DEFAULT NULL,
  PRIMARY KEY (`TransactionID`),
  CONSTRAINT `transactionstatus_ibfk_1` FOREIGN KEY (`TransactionID`) REFERENCES `Transactions` (`TransactionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TransactionStatus`
--

LOCK TABLES `TransactionStatus` WRITE;
/*!40000 ALTER TABLE `TransactionStatus` DISABLE KEYS */;
INSERT INTO `TransactionStatus` VALUES (315,'PARTIAL PAYMENT'),(317,'PARTIAL PAYMENT'),(318,'PAID'),(319,'PARTIAL PAYMENT'),(320,'PAID'),(321,'PARTIAL PAYMENT'),(322,'PAID');
/*!40000 ALTER TABLE `TransactionStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserCredentials`
--

DROP TABLE IF EXISTS `UserCredentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserCredentials` (
  `Username` varchar(255) NOT NULL,
  `UserID` int DEFAULT NULL,
  `PasswordHash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Username`),
  UNIQUE KEY `Username` (`Username`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `usercredentials_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `UserDetails` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserCredentials`
--

LOCK TABLES `UserCredentials` WRITE;
/*!40000 ALTER TABLE `UserCredentials` DISABLE KEYS */;
INSERT INTO `UserCredentials` VALUES ('George_Kuncheria',1,'0428e81b075de74037dac500bb60ece646be8d5d96598d63b3bc86f140584f08'),('Kiarash_Varlipour',5,'ee4e6f459962004ebe31668ef95c2c3cc4992469bba63277f7e85fe01baaef7b'),('Mike_John',4,'a54a8eb3b3797915f4a01430ca53fdbf577a39163db22bcd71c68882872557ac'),('Revanth_Pedala',2,'fac95f9ced07eab85d3f651f0a7905ccf420a03faf2136cd5551d612bef55b57'),('Sushanth_Mahesh',3,'0ad5a9861c8f49e6edacf18a94900bfa6f8263e85b839826263de6de80e792d1');
/*!40000 ALTER TABLE `UserCredentials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserDetails`
--

DROP TABLE IF EXISTS `UserDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserDetails` (
  `UserID` int NOT NULL,
  `FirstName` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `OtherDetails` text,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserDetails`
--

LOCK TABLES `UserDetails` WRITE;
/*!40000 ALTER TABLE `UserDetails` DISABLE KEYS */;
INSERT INTO `UserDetails` VALUES (1,'George','Kuncheria','george.k@gmail.com','123456789','Details for George'),(2,'Revanth','Pedala','revanth.p@hotmail.com','987654321','Details for Revanth'),(3,'Sushanth','Mahesh','sushanth.m@outlook.com','111222333','Details for Sushanth'),(4,'Mike','John','mike.j@gmail.com','444555666','Details for Mike'),(5,'Kiarash','Varlipour','kiarash.v@northeastern.edu','777888999','Details for Kiarash');
/*!40000 ALTER TABLE `UserDetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'RentalPropertyDatabase'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddRatingAndReview` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddRatingAndReview`(IN pPropertyID INT,IN pRating INT,IN pReviewText TEXT)
BEGIN
    IF (SELECT COUNT(*) FROM PropertyDetails WHERE PropertyID = pPropertyID) > 0 THEN
        INSERT INTO RatingsAndReviews (PropertyID, Rating, ReviewText, Timestamp)
        VALUES (pPropertyID, pRating, pReviewText, CURRENT_TIMESTAMP);

        SELECT 'Rating and review added successfully' AS Result;
    
    ELSE
        SELECT 'Property does not exist' AS Result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateContract` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateContract`(
    IN pPropertyID INT,
    IN pStartDate DATE,
    IN pEndDate DATE,
    IN pAmountToBePaid INT
)
BEGIN
    -- Check if PropertyID exists in PropertyDetails
		IF (SELECT COUNT(*) FROM PropertyDetails WHERE PropertyID = pPropertyID) > 0 THEN
        -- Insert a new contract with auto-incremented ContractID
        INSERT INTO Contracts (PropertyID, StartDate, EndDate, AmountDeposit, AmountToBePaid, ContractStatus)
        VALUES (pPropertyID, pStartDate, pEndDate,0, pAmountToBePaid, 'PENDING');
    ELSE
        -- If PropertyID does not exist, return a message
        SELECT 'PropertyID does not exist in PropertyDetails' AS ErrorMessage;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateTransaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateTransaction`(
    IN pContractID INT,
    IN pTransactionType VARCHAR(50),
    IN pAmount INT
)
BEGIN
    -- Check if ContractID exists in Contracts
    IF (SELECT COUNT(*) FROM Contracts WHERE ContractID = pContractID) > 0 THEN
        -- Insert a new transaction with auto-incremented TransactionID
        INSERT INTO Transactions (ContractID, TransactionType, TransactionDate, Amount)
        VALUES (pContractID, pTransactionType, CURDATE(), pAmount);
    ELSE
        -- If ContractID does not exist, return a message
        SELECT 'ContractID does not exist in Contracts' AS ErrorMessage;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetBalance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBalance`(IN pContractID INT)
BEGIN
    -- Check if ContractID exists in Contracts
    IF (SELECT COUNT(*) FROM Contracts WHERE ContractID = pContractID) > 0 THEN
        -- Calculate the balance and return the result
        SELECT AmountToBePaid - AmountDeposit AS Balance
        FROM Contracts
        WHERE ContractID = pContractID;
    ELSE
        -- If ContractID does not exist, return NULL
        SELECT NULL AS Balance;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SendRequest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SendRequest`(
    IN pPropertyID INT,
    IN pMessageType ENUM('Maintenance', 'Billing', 'Enquiry'),
    IN pMessageText TEXT
)
BEGIN
    -- Check if the property exists
    IF (SELECT COUNT(*) FROM PropertyDetails WHERE PropertyID = pPropertyID) > 0 THEN
        -- Insert the request into the Requests table
        INSERT INTO Requests (PropertyID, MessageType, MessageText, Timestamp)
        VALUES (pPropertyID, pMessageType, pMessageText, CURRENT_TIMESTAMP);

        SELECT 'Request sent successfully' AS Result;
    ELSE
        SELECT 'Property does not exist' AS Result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateContractStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateContractStatus`()
BEGIN
    -- Update ContractStatus based on the difference between NOW and EndDate
    UPDATE Contracts
    SET ContractStatus = CASE
        WHEN DATEDIFF(EndDate, NOW()) = 0 THEN 'EXPIRED'
        ELSE 'ACTIVE'
    END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateResponse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateResponse`(
    IN pRequestID INT,
    IN pResponseType VARCHAR(100),
    IN pResponseText TEXT
)
BEGIN
    -- Check if the request exists
    IF (SELECT COUNT(*) FROM Requests WHERE RequestID = pRequestID) > 0 THEN
        -- Update the corresponding record in the Response table
        UPDATE Response
        SET
            ResponseType = pResponseType,
            ResponseText = pResponseText,
            Timestamp = CURRENT_TIMESTAMP
        WHERE RequestID = pRequestID;

        SELECT 'Response updated successfully' AS Result;
    ELSE
        SELECT 'Request does not exist' AS Result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `logtablefortransactions`
--

/*!50001 DROP VIEW IF EXISTS `logtablefortransactions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `logtablefortransactions` AS select `C`.`PropertyID` AS `PropertyID`,`T`.`TransactionID` AS `TransactionID`,`UD`.`FirstName` AS `FirstName`,`UD`.`LastName` AS `LastName`,`T`.`TransactionType` AS `TransactionType`,`T`.`TransactionDate` AS `TransactionDate`,`T`.`Amount` AS `Amount`,`TS`.`PaymentStatus` AS `PaymentStatus` from ((((`contracts` `C` join `transactions` `T` on((`C`.`ContractID` = `T`.`ContractID`))) join `transactionstatus` `TS` on((`T`.`TransactionID` = `TS`.`TransactionID`))) join `propertydetails` `PD` on((`C`.`PropertyID` = `PD`.`PropertyID`))) join `userdetails` `UD` on((`PD`.`UserID` = `UD`.`UserID`))) group by `C`.`PropertyID`,`T`.`TransactionID`,`UD`.`FirstName`,`UD`.`LastName`,`T`.`TransactionType`,`T`.`TransactionDate`,`T`.`Amount`,`TS`.`PaymentStatus` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-16 11:17:43
