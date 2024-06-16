# Property Rental System Database Design

## Aim of the Project
To create a robust and efficient portal system where users can rent and occupy a property. This involves designing a comprehensive database capable of handling various functionalities such as user management, transaction handling, and property management. Inspired by platforms like Zillow and Trulia, the project aims to facilitate seamless interactions and data management for property rentals.

## Outcomes

### Real World Relevance
The project simulates a real-world property rental system, providing practical experience in database design and management.

### Complex and Challenging
The project involves complex database operations, ensuring a deep understanding of relational databases.

### Transaction Handling
Efficient management of financial transactions related to property rentals.

### User Management
Comprehensive system for managing user information and credentials.

### Improving Upon the Usage of MySQL
Utilizing advanced MySQL features like triggers, stored procedures, and views to enhance database functionality.

## Relevant Entities

### UserDetails
Stores detailed information about users.

### PropertyDetails
Contains information about properties available for rent.

### Transactions
Manages financial transactions related to property rentals.

### Requests
Logs requests from users, such as maintenance or billing inquiries.

### Contracts
Manages rental contracts between users and property managers.

### RatingsAndReviews
Stores user ratings and reviews for properties.

## Triggers
Triggers are automated actions that the database performs in response to certain events on a particular table or view. They help maintain data integrity and enforce business rules at the database level.

### before_insert_Contracts
Ensures contract status is set based on the deposit and start date conditions.

### before_update_Contracts
Updates contract status based on conditions during updates.

### after_insert_Transactions
Adjusts the amount deposited in the contracts table when a new transaction is recorded.

### after_insert_TransactionsStatus
Updates transaction status based on payment conditions.

### update_StatusForProperty_trigger
Updates the property status in the PropertyDetails table based on contract status.

### after_insert_Requests
Automatically inserts an initial awaiting response when a new request is logged.

## Stored Procedures
Stored Procedures are precompiled collections of SQL statements that can be executed as a single unit. They enhance performance and provide reusability and maintainability of code.

### CreateContract
Inserts a new contract if the property exists in PropertyDetails.

### UpdateContractStatus
Updates the contract status based on the current date and contract end date.

### CreateTransaction
Adds a new transaction record if the contract exists.

### GetBalance
Returns the balance amount to be paid for a specific contract.

### SendRequest
Logs a new request for property-related issues.

### UpdateResponse
Updates the response for a specific request.

### AddRatingAndReview
Adds a new rating and review for a property.

## Views
Views are virtual tables created by a query joining one or more tables. They provide a way to simplify complex queries and present data in a specific format without duplicating the data.

### LogTableForTransactions
A view to log and present transaction details, including property, user, and payment status information.
