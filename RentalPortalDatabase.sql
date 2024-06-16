CREATE DATABASE RentalPropertyDatabase;

USE RentalPropertyDatabase;

-- For  UsersTable (Converted to 3NF)

-- Table 1: UserDetails
CREATE TABLE UserDetails (
    UserID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Phone VARCHAR(15),
    OtherDetails TEXT
);



-- Table 2: UserCredentials
CREATE TABLE UserCredentials (
    Username VARCHAR(255) UNIQUE PRIMARY KEY,
    UserID INT,
    PasswordHash VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES UserDetails(UserID)
);




-- For  Properties Table (Converted to 3NF)
-- Table 1: PropertyDetails
CREATE TABLE PropertyDetails (
    PropertyID INT PRIMARY KEY,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES UserDetails(UserID),
    PropertyManagerID INT,
    FOREIGN KEY (PropertyManagerID) REFERENCES PropertyManagers(PropertyManagerID),
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    ZIPCode VARCHAR(10),
    PropertyType VARCHAR(50),
    Price INT,
    Status ENUM('For Rent','Occupied')
);


-- Table 2: PropertyFeatures
CREATE TABLE PropertyFeatures (
    PropertyID INT PRIMARY KEY,
    FOREIGN KEY (PropertyID) REFERENCES PropertyDetails(PropertyID),
    NumberOfBedrooms INT,
    NumberOfBathrooms INT,
    PetsAllowed ENUM('Y', 'N') DEFAULT NULL,
	InUnitLaundry ENUM('Y','N'),
    GymAccess ENUM('Y','N') DEFAULT NULL,
    ParkingAccess ENUM('Y','N')
);


-- PropertyManagers Table
CREATE TABLE PropertyManagers (
    PropertyManagerID INT PRIMARY KEY,
    ManagerName VARCHAR(100),
    Email VARCHAR(100),
    PhoneNo VARCHAR(100)
);



--  RatingsAndReviews
CREATE TABLE RatingsAndReviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    PropertyID INT,
    FOREIGN KEY (PropertyID) REFERENCES PropertyDetails(PropertyID),
    Rating INT,
    ReviewText TEXT,
    Timestamp TIMESTAMP
)AUTO_INCREMENT=600;





-- Transactions Table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    ContractID INT,
    FOREIGN KEY (ContractID)
        REFERENCES Contracts (ContractID),
    TransactionType VARCHAR(50),
    TransactionDate DATE,
    Amount INT
)  AUTO_INCREMENT=300;




CREATE TABLE TransactionStatus (
    TransactionID INT PRIMARY KEY,
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID),
    PaymentStatus ENUM('PAID', 'PARTIAL PAYMENT', 'NOT PAID')
);


-- For  Messages Tables

CREATE TABLE Requests (
    RequestID INT PRIMARY KEY AUTO_INCREMENT,
    PropertyID INT,
    FOREIGN KEY (PropertyID) REFERENCES PropertyDetails(PropertyID),
    MessageType ENUM('Maintenance','BillingUpdateResponse','Enquiry'),
    MessageText TEXT,
    Timestamp TIMESTAMP
)AUTO_INCREMENT=400;

CREATE TABLE Response(
	ResponseID INT PRIMARY KEY AUTO_INCREMENT,
    RequestID INT,
    FOREIGN KEY (RequestID) REFERENCES Requests(RequestID),
    ResponseType VARCHAR(100),
    ResponseText TEXT,
    Timestamp TIMESTAMP
)AUTO_INCREMENT=500;


-- Contracts Table
CREATE TABLE Contracts (
    ContractID INT PRIMARY KEY AUTO_INCREMENT,
    PropertyID INT,
    FOREIGN KEY (PropertyID) REFERENCES PropertyDetails(PropertyID),
    StartDate DATE,
    EndDate DATE,
    AmountDeposit INT,
    AmountToBePaid INT,
    ContractStatus VARCHAR(100)
);




INSERT INTO UserDetails (UserID, FirstName, LastName, Email, Phone, OtherDetails)
VALUES 
    (1, 'George', 'Kuncheria', 'george.k@gmail.com', '123456789', 'Details for George'),
    (2, 'Revanth', 'Pedala', 'revanth.p@hotmail.com', '987654321', 'Details for Revanth'),
    (3, 'Sushanth', 'Mahesh', 'sushanth.m@outlook.com', '111222333', 'Details for Sushanth'),
    (4, 'Mike', 'John', 'mike.j@gmail.com', '444555666', 'Details for Mike'),
    (5, 'Kiarash', 'Varlipour', 'kiarash.v@northeastern.edu', '777888999', 'Details for Kiarash');

SELECT * FROM UserDetails;


INSERT INTO UserCredentials (Username, UserID, PasswordHash)
VALUES
    ('george_k', 1, SHA2('george_password', 256)),
    ('revanth_p', 2, SHA2('revanth_password', 256)),
    ('sushanth_m', 3, SHA2('sushanth_password', 256)),
    ('mike_j', 4, SHA2('mike_password', 256)),
    ('kiarash_v', 5, SHA2('kiarash_password', 256));


SELECT * FROM UserCredentials;


INSERT INTO PropertyDetails (PropertyID, UserID, PropertyManagerID, Address, City, State, ZIPCode, PropertyType, Price, Status)
VALUES
    (200, 5, 100, '123 Main St', 'Cityville', 'StateA', '12345', 'Apartment', 1200, 'For Rent'),
    (201, 2, 105, '555 Cedar St', 'Countryside', 'StateE', '98765', 'House', 2500, 'For Rent'),
    (202, 4, 102, '789 Maple St', 'Villagetown', 'StateC', '10111', 'Condo', 1500, 'For Rent'),
    (205, 1, 101, '456 Oak St', 'Townsville', 'StateB', '56789', 'House', 2000, 'For Rent'),
    (206, 3, 103, '101 Pine St', 'Hamletville', 'StateD', '31415', 'Apartment', 1800, 'For Rent');


SELECT * FROM PropertyDetails;


INSERT INTO PropertyFeatures (PropertyID, NumberOfBedrooms, NumberOfBathrooms, PetsAllowed, InUnitLaundry, GymAccess, ParkingAccess)
VALUES
    (200, 2, 1, 'N', 'Y', 'N', 'Y'),
    (201, 4, 3, 'Y', 'Y', 'Y', 'N'),
    (202, 1, 1, 'Y', 'N', 'Y', 'N'),
    (205, 3, 2, 'Y', 'Y', 'N', 'N'),
    (206, 2, 2, 'N', 'Y', 'N', 'Y');


SELECT * FROM PropertyFeatures;


INSERT INTO PropertyManagers (PropertyManagerID, ManagerName, Email, PhoneNo)
VALUES
    (100, 'John Doe', 'john.doe@gmail.com', '1234567890'),
    (101, 'Jane Smith', 'jane.smith@yahoo.com', '9876543210'),
    (102, 'Bob Johnson', 'bob.johnson@gmail.com', '5555555555'),
    (103, 'Alice Brown', 'alice.brown@gmail.com', '1112223333'),
    (105, 'Charlie Wilson', 'charlie.wilson@yahoo.com', '9998887777');

SELECT * FROM PropertyManagers;



CREATE USER 'user1'@'localhost' IDENTIFIED BY 'user1';
CREATE USER 'maintenance'@'localhost' IDENTIFIED BY 'maintenance';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
CREATE USER 'propertymanager'@'localhost' IDENTIFIED BY 'propertymanager';


DELIMITER //
CREATE TRIGGER before_insert_Contracts
BEFORE INSERT ON Contracts
FOR EACH ROW
BEGIN
    -- Check conditions and set ContractStatus accordingly
    IF NEW.AmountDeposit <> NEW.AmountToBePaid AND NEW.StartDate > CURDATE() THEN
        SET NEW.ContractStatus = 'PENDING';
        ELSEIF NEW.AmountDeposit <> NEW.AmountToBePaid OR NEW.StartDate > CURDATE() THEN
        SET NEW.ContractStatus = 'PENDING';
        ELSEIF NEW.AmountDeposit = NEW.AmountToBePaid AND NEW.StartDate <= CURDATE() THEN
        SET NEW.ContractStatus = 'ACTIVE';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER before_update_Contracts
BEFORE UPDATE ON Contracts
FOR EACH ROW
BEGIN
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
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE CreateContract(
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
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE UpdateContractStatus()
BEGIN
    -- Update ContractStatus based on the difference between NOW and EndDate
    UPDATE Contracts
    SET ContractStatus = CASE
        WHEN DATEDIFF(EndDate, NOW()) = 0 THEN 'EXPIRED'
        ELSE 'ACTIVE'
    END;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE CreateTransaction(
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
END //
DELIMITER ;



DELIMITER //
CREATE TRIGGER after_insert_Transactions
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    -- Update the AmountDeposit in Contracts based on the new transaction
    UPDATE Contracts
    SET AmountDeposit = CASE
                          WHEN AmountDeposit + NEW.Amount <= AmountToBePaid 
							THEN AmountDeposit + NEW.Amount
                          ELSE AmountToBePaid
                        END
    WHERE ContractID = NEW.ContractID;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE GetBalance(IN pContractID INT)
BEGIN
    -- Check if ContractID exists in Contracts
    IF (SELECT COUNT(*) FROM Contracts WHERE ContractID = pContractID) > 0 THEN
  
        SELECT AmountToBePaid - AmountDeposit AS Balance
        FROM Contracts
        WHERE ContractID = pContractID;
    ELSE
        -- If ContractID does not exist, return NULL
        SELECT NULL AS Balance;
    END IF;
END //
DELIMITER ;



DELIMITER //
CREATE TRIGGER after_insert_TransactionsStatus
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    DECLARE amountDeposited INT;
    DECLARE amountToBePaid INT;

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
END //
DELIMITER ;



CREATE VIEW LogTableForTransactions AS
SELECT
	C.PropertyID,T.TransactionID,UD.FirstName,UD.LastName,
    T.TransactionType,T.TransactionDate,T.Amount,TS.PaymentStatus

FROM
    Contracts C
JOIN
    Transactions T ON C.ContractID = T.ContractID
JOIN
    TransactionStatus TS ON T.TransactionID = TS.TransactionID
JOIN
    PropertyDetails PD ON C.PropertyID = PD.PropertyID
JOIN
    UserDetails UD ON PD.UserID = UD.UserID
GROUP BY
    C.PropertyID,T.TransactionID,UD.FirstName,
    UD.LastName,T.TransactionType,T.TransactionDate,T.Amount,TS.PaymentStatus;



DELIMITER //
CREATE TRIGGER update_StatusForProperty_trigger
AFTER UPDATE ON Contracts
FOR EACH ROW
BEGIN
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
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE SendRequest(IN pPropertyID INT,IN pMessageType ENUM('Maintenance', 'Billing', 'Enquiry'),IN pMessageText TEXT)
BEGIN

    IF (SELECT COUNT(*) FROM PropertyDetails WHERE PropertyID = pPropertyID) > 0 THEN
        INSERT INTO Requests (PropertyID, MessageType, MessageText, Timestamp)
        VALUES (pPropertyID, pMessageType, pMessageText, CURRENT_TIMESTAMP);

        SELECT 'Request sent successfully' AS Result;
    ELSE
        SELECT 'Property does not exist' AS Result;
    END IF;
END //
DELIMITER ;



DELIMITER //
CREATE TRIGGER after_insert_Requests
AFTER INSERT ON Requests
FOR EACH ROW
BEGIN
     -- Inserts A responseType 'AWAITING' in the Response table initally when A request is called from The Requests table
    INSERT INTO Response (RequestID, ResponseType, ResponseText, Timestamp)
    VALUES (NEW.RequestID, 'AWAITING', NULL, CURRENT_TIMESTAMP);
END //
DELIMITER ;




DELIMITER //
CREATE PROCEDURE UpdateResponse(IN pRequestID INT,IN pResponseType VARCHAR(100),IN pResponseText TEXT)
BEGIN
    IF (SELECT COUNT(*) FROM Requests WHERE RequestID = pRequestID) > 0 THEN
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
END //
DELIMITER ;




DELIMITER //
CREATE PROCEDURE AddRatingAndReview(IN pPropertyID INT,IN pRating INT,IN pReviewText TEXT)
BEGIN
    IF (SELECT COUNT(*) FROM PropertyDetails WHERE PropertyID = pPropertyID) > 0 THEN
        INSERT INTO RatingsAndReviews (PropertyID, Rating, ReviewText, Timestamp)
        VALUES (pPropertyID, pRating, pReviewText, CURRENT_TIMESTAMP);

        SELECT 'Rating and review added successfully' AS Result;
    
    ELSE
        SELECT 'Property does not exist' AS Result;
    END IF;
END //
DELIMITER ;


GRANT EXECUTE ON PROCEDURE RentalPropertyDatabase.CreateContract TO 'propertymanager'@'localhost';
GRANT INSERT, UPDATE, DELETE ON RentalPropertyDatabase.PropertyManagers TO 'propertymanager'@'localhost';
GRANT EXECUTE ON PROCEDURE RentalPropertyDatabase.GetBalance TO 'propertymanager'@'localhost';
GRANT SELECT ON RentalPropertyDatabase.PropertyDetails TO 'propertymanager'@'localhost';
GRANT SELECT ON RentalPropertyDatabase.PropertyFeatures TO 'propertymanager'@'localhost';
GRANT SELECT ON RentalPropertyDatabase.Contracts TO 'propertymanager'@'localhost';
GRANT SELECT ON RentalPropertyDatabase.Transactions TO 'propertymanager'@'localhost';
GRANT SELECT ON RentalPropertyDatabase.TransactionStatus TO 'propertymanager'@'localhost';
SHOW GRANTS FOR 'propertymanager'@'localhost';




GRANT SELECT ON RentalPropertyDatabase.UserDetails TO 'maintenance'@'localhost';
GRANT SELECT ON RentalPropertyDatabase.Response TO 'maintenance'@'localhost';
GRANT EXECUTE ON PROCEDURE RentalPropertyDatabase.UpdateResponse TO 'maintenance'@'localhost';
SHOW GRANTS FOR 'maintenance'@'localhost';


GRANT UPDATE(UserName) ON RentalPropertyDatabase.UserCredentials TO 'user1'@'localhost';
GRANT UPDATE(FirstName,LastName,Phone) ON RentalPropertyDatabase.UserDetails TO 'user1'@'localhost';
GRANT SELECT(UserID,FirstName,LastName) ON RentalPropertyDatabase.UserDetails TO 'user1'@'localhost';
GRANT SELECT ON RentalPropertyDatabase.PropertyDetails TO 'user1'@'localhost';
GRANT EXECUTE ON PROCEDURE RentalPropertyDatabase.GetBalance TO 'user1'@'localhost';
GRANT EXECUTE ON PROCEDURE RentalPropertyDatabase.SendRequest TO 'user1'@'localhost';
GRANT EXECUTE ON PROCEDURE RentalPropertyDatabase.CreateTransaction TO 'user1'@'localhost';
GRANT SELECT ON RentalPropertyDatabase.Contracts TO 'user1'@'localhost';
GRANT SELECT ON RentalPropertyDatabase.RatingsAndReviews TO 'user1'@'localhost';
SHOW GRANTS FOR 'user1'@'localhost';


GRANT SELECT ON RentalPropertyDatabase.logtablefortransactions TO 'admin'@'localhost';
GRANT SELECT ON RentalPropertyDatabase.* TO 'admin'@'localhost';
GRANT EXECUTE ON PROCEDURE RentalPropertyDatabase.UpdateContractStatus TO 'admin'@'localhost';
SHOW GRANTS FOR 'admin'@'localhost';
-- -------------------------------------------------------


CALL CreateContract(202, '2023-10-15', '2023-12-28', 1500);
CALL CreateContract(202, '2023-10-13', '2024-12-26', 1500);
CALL CreateContract(205, '2023-10-13', '2024-12-16', 1000);
CALL CreateContract(206, '2023-10-13', '2024-10-1', 1000);
SELECT * FROM Contracts;
SELECT * FROM Transactions;
CALL CreateTransaction(13, 'Credit', 1500);
CALL CreateTransaction(14, 'Debit', 200);
CALL CreateTransaction(15, 'Credit', 400);
CALL CreateTransaction(16, 'Credit', 1000);
SELECT * FROM Contracts;
SELECT * FROM TransactionStatus;
call getBalance(16);
CALL CreateTransaction(13, 'Credit', 500);
CALL CreateTransaction(14, 'Credit', 500);
CALL CreateTransaction(15, 'Credit', 500);
CALL CreateTransaction(16, 'Credit', 500);
SELECT * FROM Contracts;
SELECT * FROM TransactionStatus;


CALL UpdateContractStatus();

CALL GetBalance(15);
CALL CreateTransaction(15, 'Debit', 600);
SELECT * FROM Contracts;
SELECT * FROM Transactions;
SELECT * FROM TransactionStatus;
SELECT * FROM PropertyDetails;


-- -----------------------------------------
SELECT * FROM logtablefortransactions;

CALL AddRatingAndReview(205,2,'Property Is Average');
SELECT * FROM RatingsAndReviews;

CALL SendRequest(202,'Enquiry','how to lock windows');
SELECT * FROM Requests;
SELECT * FROM Response;
CALL UpdateResponse(402,'COMPLETE','ADJUST THE FRAME PIN IN CLOCKWISE DIRECTIONS');
SELECT * FROM Response;






