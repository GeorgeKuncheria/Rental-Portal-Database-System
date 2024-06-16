USE RentalPropertyDatabase;


SHOW GRANTS FOR 'user1'@'localhost';

SELECT * FROM PropertyDetails;
-- ----------------------------------------------
CALL CreateTransaction(18,'Debit',500);
CALL GetBalance(18);
CALL CreateTransaction(17,'Cash',1250);


-- -----------------------------------------------

CALL SendRequest(202,'Enquiry','how to lock windows');


-- ------------------------------------------------
Select * FROM  RatingsAndReviews;
CALL AddRatingAndReview(206,4,'Property Is Great');
Select * FROM  RatingsAndReviews;




