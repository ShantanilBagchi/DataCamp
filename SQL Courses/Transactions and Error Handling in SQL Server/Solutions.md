The TRY...CATCH syntax
You want to insert a new product in your products table. You prepare this script, trying to control the execution if an error occurs. You use the TRY...CATCH construct you learned to handle the possible errors.

BEGIN TRY
    INSERT INTO products (product_name, stock, price)
        VALUES ('Trek Powerfly 5 - 2018', 10, 3499.99);
    SELECT 'Product inserted correctly!';

    BEGIN CATCH
        SELECT 'An error occurred! You are in the CATCH block';   
    END CATCH
END TRY
Which of the following is true about the syntax?

Answer the question
50 XP
Possible Answers
This script is correct because the error is handled within the CATCH block, and everything must be enclosed by the TRY block.
press
1
This script isn't correct because the CATCH block must start after the end of the TRY block.
press
2
This script isn't correct because the error should be handled in the TRY block.
press
3

2



Your first error-handling script
You realized your products table doesn't have any constraint to check the data stored in its stock column. It makes sense that stock is always greater than or equal to 0. For some reason, there is a mistake in the following row. The stock is -1!

| product_id | product_name | stock | price |
|------------|--------------|-------|-------|
| 6          | Trek Neko+   | -1    | 2799  |
You want to prepare a script adding a constraint to the products table, so that only stocks greater than or equal to 0 are allowed.

If you add this constraint that only allows stocks greater than or equal to 0, the execution will fail because there is one row where the stock equals -1.

How can you prepare the script?

Instructions
100 XP
Instructions
100 XP
Surround the constraint with a TRY block.
Add the constraint to the products table.
Surround the error message with a CATCH block.

-- Set up the TRY block
BEGIN TRY
	-- Add the constraint
	ALTER TABLE products
		ADD CONSTRAINT CHK_Stock CHECK (stock >= 0);
END TRY
-- Set up the CATCH block
BEGIN CATCH
	SELECT 'An error occurred!';
END CATCH



Nesting TRY...CATCH constructs
You want to register a new buyer in your buyers table. This new buyer is Peter Thomson. His e-mail is peterthomson@mail.com and his phone number is 555000100.

In your database, there is also a table called errors, in which each error is stored.

You prepare a script that controls possible errors in the insertion of this person's data. It also inserts those errors into the errors table.

How do you prepare the script?

Instructions
100 XP
Instructions
100 XP
Surround the INSERT INTO buyers statement with a TRY block.
Surround the error handling with a CATCH block.
Surround the INSERT INTO errors statement with another TRY block.
Surround the nested error handling with another CATCH block.

-- Set up the first TRY block
BEGIN TRY
	INSERT INTO buyers (first_name, last_name, email, phone)
		VALUES ('Peter', 'Thompson', 'peterthomson@mail.com', '555000100');
END TRY
-- Set up the first CATCH block
BEGIN CATCH
	SELECT 'An error occurred inserting the buyer! You are in the first CATCH block';
    -- Set up the nested TRY block
    BEGIN TRY
    	INSERT INTO errors 
        	VALUES ('Error inserting a buyer');
        SELECT 'Error inserted correctly!';
    END TRY    
    -- Set up the nested CATCH block
    BEGIN CATCH
    	SELECT 'An error occurred inserting the error! You are in the nested CATCH block';
    END CATCH    
END CATCH



Anatomy review
When you execute the following script:

INSERT INTO products (product_name, stock, price)
    VALUES ('Trek Powerfly 5 - 2018', 10, 3499.99);
The console of your SQL Server shows this:

Msg 2627, Level 14, State 1, Line 1
Violation of UNIQUE KEY constraint 'unique_name'. 
Cannot insert duplicate key in object 'dbo.products'. 
The duplicate key value is (Trek Powerfly 5 - 2018).
What are the different parts of the error you get, from left to right?

Answer the question
50 XP
Possible Answers
Message level, severity level, state, line, and message text.
press
1
Error number, line, state, severity level, and message text.
press
2
Error number, severity level, state, line, and message text.
press
3

3


Correcting compilation errors
Today, your colleague Bernard has to leave work early. He was preparing a script to insert a new product into the products table, but he couldn't finish it. He asks you for help and gives you the script to finish it.

He wants to insert the 'Sun Bicycles ElectroLite - 2017', with a stock of 10 units and a price of $1559.99. He also wants to insert possible errors in a table called errors. In fact, if you try to insert this bicycle, you will get an error because there is already another product with the same name.

When you execute the script, you realize there are several compilation errors.

Can you correct Bernard's script? The final output must be: An error occurred inserting the product!

Instructions
100 XP
Instructions
100 XP
Note: Error messages in DataCamp have different anatomy than in SQL Server, but as they show the error message, you won't have any problem.

Run the code to verify there are compilation errors.
Correct every compilation error.
Run the code to get the final output: An error occurred inserting the product!


BEGIN TRY
	INSERT INTO products (product_name, stock, price)
		VALUES ('Sun Bicycles ElectroLite - 2017', 10, 1559.99);
END TRY
BEGIN CATCH
	SELECT 'An error occurred inserting the product!';
    BEGIN TRY
    	INSERT INTO errors 
        	VALUES ('Error inserting a product');
    END TRY    
    BEGIN CATCH
    	SELECT 'An error occurred inserting the error!';
    END CATCH    
END CATCH



Error function syntax
Which of the following is true about the functions ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_STATE(), ERROR_PROCEDURE(), ERROR_LINE(), and ERROR_MESSAGE()?

Answer the question
50 XP
Possible Answers
These functions must be placed within the TRY block, just after the statement which may cause an error. If an error occurs, they return information about the error.
press
1
These functions must be placed within the CATCH block. If an error occurs within the TRY block, they return information about the error.
press
2
These functions must be placed within the CATCH block. They will return NULL values if there are no errors.
press
3

2


Using error functions
For every month, you want to know the total amount of money you earned in your bike store. Instead of reviewing every order line, you thought it would be better to prepare a script that computes it and displays the results.

While writing the script, you made a mistake. As you can see, the operation 'Total: ' + SUM(price * quantity) AS total is missing a cast conversion, causing an error.

How can we catch this error? Show the error number, severity, state, line, and message.

Instructions
100 XP
Instructions
100 XP
Surround the operation with a TRY block.
Surround the functions with a CATCH block.
Select the error information.

-- Set up the TRY block
BEGIN TRY	
	SELECT 'Total: ' + SUM(price * quantity) AS total
  	FROM orders 
END TRY
-- Set up the CATCH block
BEGIN CATCH
	-- Show error information.
	SELECT  ERROR_NUMBER() AS number,  
        	ERROR_SEVERITY() AS severity_level,  
        	ERROR_STATE() AS state,
        	ERROR_LINE() AS line,  
        	ERROR_MESSAGE() AS message; 	    
END CATCH 


Using error functions in a nested TRY...CATCH
You received some new electric bikes in your store, so you need to update the stock.

You want to register that you received 2 Trek Powerfly 5 - 2018 bikes with a price of $3499.99 each, and 3 New Power K- 2018 bikes at $1999.99 each.

You try to insert the products in the database because you think they are new models. However, you forgot you already have the first one in stock. Luckily, the products table has a constraint requiring every product name to be unique.

You prepare a script controlling possible errors in the insertions. You also want to insert possible errors in a table called errors, and, if something fails when inserting the error, show the error number and error message.

Instructions
100 XP
Instructions
100 XP
Surround the error handling with a CATCH block.
Insert 'Error inserting a product' in the errors table and surround this insertion with another TRY block.
Surround the nested error handling with another CATCH block.
Select the error line and the error message in the inner CATCH block.

BEGIN TRY
    INSERT INTO products (product_name, stock, price) 
    VALUES	('Trek Powerfly 5 - 2018', 2, 3499.99),   		
    		('New Power K- 2018', 3, 1999.99)		
END TRY
-- Set up the outer CATCH block
BEGIN CATCH
	SELECT 'An error occurred inserting the product!';
    -- Set up the inner TRY block
    BEGIN TRY
    	-- Insert the error
    	INSERT INTO errors 
        	VALUES ('Error inserting a product');
    END TRY    
    -- Set up the inner CATCH block
    BEGIN CATCH
    	-- Show number and message error
    	SELECT 
        	ERROR_LINE() AS line,	   
			ERROR_MESSAGE() AS message; 
    END CATCH    
END CATCH



RAISERROR syntax
Given this RAISERROR statement

RAISERROR('You cannot apply a 50%% discount on %s number %d', 6, 1, 'product', 5);
Which of the following outputs will you get if you execute this code?

Answer the question
50 XP
Possible Answers
"You cannot apply a 6% discount on 1 product number 5"
press
1
"You cannot apply a 50% discount on product number 5"
press
2
"You cannot apply a 50%% discount on product number 5"
press
3
"You cannot apply a 50% discount on 5 number product"
press
4

2


CATCHING the RAISERROR
You need to select a product from the products table using a given product_id.

If the select statement doesn't find any product, you want to raise an error using the RAISERROR statement. You also need to catch possible errors in the execution.

For this exercise, the value of @product_id is 5.

Instructions 1/2
0 XP
Set @product_id to 5.
Use the RAISERROR statement with a severity of 11, a state of 1 and the given @product_id.

-- Set @product_id to 5
DECLARE @product_id INT = 5;

IF NOT EXISTS (SELECT * FROM products WHERE product_id = @product_id)
	-- Invoke RAISERROR with parameters
	RAISERROR('No product with id %d.', 11, 1, @product_id);
ELSE 
	SELECT * FROM products WHERE product_id = @product_id;


-- Set @product_id to 5
DECLARE @product_id INT = 5;

IF NOT EXISTS (SELECT * FROM products WHERE product_id = @product_id)
	-- Invoke RAISERROR with parameters
	RAISERROR('No product with id %d.', 11, 1, @product_id);
ELSE 
	SELECT * FROM products WHERE product_id = @product_id;


Catch the error generated by the RAISERROR statement you coded.
Select the error message using the appropriate function.

BEGIN TRY
    DECLARE @product_id INT = 5;
    IF NOT EXISTS (SELECT * FROM products WHERE product_id = @product_id)
        RAISERROR('No product with id %d.', 11, 1, @product_id);
    ELSE 
        SELECT * FROM products WHERE product_id = @product_id;
END TRY
-- Catch the error
BEGIN CATCH
	-- Select the error message
	SELECT ERROR_MESSAGE();
END CATCH  


THROW with or without parameters
Which of the following is true about the THROW statement?

Answer the question
50 XP
Possible Answers
The THROW statement without parameters should be placed within a CATCH block.
press
1
The THROW statement with parameters can only be placed within a CATCH block.
press
2
The THROW statement without parameters can't re-throw an original error.
press
3

1



THROW without parameters
You want to prepare a stored procedure to insert new products in the database. In that stored procedure, you want to insert the possible errors in a table called errors, and after that, re-throw the original error.

How do you prepare the stored procedure?

Instructions
100 XP
Surround the error handling with a CATCH block.
Insert the error in the errors table.
End the insert statement with a semicolon (;).
Re-throw the original error.

CREATE PROCEDURE insert_product
  @product_name VARCHAR(50),
  @stock INT,
  @price DECIMAL

AS

BEGIN TRY
	INSERT INTO products (product_name, stock, price)
		VALUES (@product_name, @stock, @price);
END TRY
-- Set up the CATCH block
BEGIN CATCH	
	-- Insert the error and end the statement with a semicolon
    INSERT INTO errors VALUES ('Error inserting a product');  
    -- Re-throw the error
	THROW;  
END CATCH


Executing a stored procedure that throws an error
You need to insert a new product using the stored procedure you created in the previous exercise:

CREATE PROCEDURE insert_product
  @product_name VARCHAR(50),
  @stock INT,
  @price DECIMAL

AS

BEGIN TRY
    INSERT INTO products (product_name, stock, price)
        VALUES (@product_name, @stock, @price);
END TRY
BEGIN CATCH    
    INSERT INTO errors VALUES ('Error inserting a product');  
    THROW;  
END CATCH
You want to register that you received 3 Super bike bikes with a price of $499.99. You need to catch the possible errors generated in the execution of the stored procedure, showing the original error message.

How do you prepare the script?

Instructions
100 XP
Instructions
100 XP
Execute the stored procedure called insert_product.
Set the appropriate values for the parameters of the stored procedure.
Surround the error handling with a CATCH block.
Select the error message.

BEGIN TRY
	-- Execute the stored procedure
	EXEC insert_product 
    	-- Set the values for the parameters
    	@product_name = 'Super bike',
        @stock = 3,
        @price = 499.99;
END TRY
-- Set up the CATCH block
BEGIN CATCH
	-- Select the error message
	SELECT ERROR_MESSAGE();
END CATCH



THROW with parameters
You need to prepare a script to select all the information of a member from the staff table using a given staff_id.

If the select statement doesn't find any member, you want to throw an error using the THROW statement. You need to warn there is no staff member with such id.

Instructions
100 XP
Set @staff_id to 4.
Use the THROW statement, with 50001 as the error number, 'No staff member with such id' as the message text, and 1 as the state.

-- Set @staff_id to 4
DECLARE @staff_id INT = 4;

IF NOT EXISTS (SELECT * FROM staff WHERE staff_id = @staff_id)
   	-- Invoke the THROW statement with parameters
	THROW 50001, 'No staff member with such id', 1;
ELSE
   	SELECT * FROM staff WHERE staff_id = @staff_id



Ways of customizing error messages
You want to use the THROW statement to throw an error with a custom message. Which of the following is a possible option to do so?

Answer the question
50 XP
Possible Answers
You use the CONCATMESSAGE function and save the result into a variable that you pass to the THROW statement.
press
1
You use the FORMATMESSAGE function and save the result into a variable that you pass to the THROW statement.
press
2
You use the FORMATMESSAGE function inside the THROW statement.
press
3

2



Concatenating the message
You need to prepare a script to select all the information about the members from the staff table using a given first_name.

If the select statement doesn't find any member, you want to throw an error using the THROW statement. You need to warn there is no staff member with such a name.

Instructions
100 XP
Set the @first_name variable to 'Pedro'.
Assign to the @my_message variable the concatenation of the text 'There is no staff member with ', with the value of the @first_name variable and with the text ' as the first name.'.
Use the THROW statement with 50000 as the error number, @my_message variable as the message parameter, and 1 as the state.

-- Set @first_name to 'Pedro'
DECLARE @first_name NVARCHAR(20) = 'Pedro';
-- Concat the message
DECLARE @my_message NVARCHAR(500) =
	CONCAT('There is no staff member with ', @first_name, ' as the first name.');

IF NOT EXISTS (SELECT * FROM staff WHERE first_name = @first_name)
	-- Throw the error
	THROW 50000, @my_message, 1;



FORMATMESSAGE with message string
Every time you sell a bike in your store, you need to check if there is enough stock. You prepare a script to check it and throw an error if there is not enough stock.

Today, you sold 10 'Trek CrossRip+ - 2018' bikes, so you need to check if you can sell them.

Instructions
100 XP
Instructions
100 XP
Save into the @current_stock variable the value of the stock of the product.
Use the FORMATMESSAGE function with parameter placeholders (%s, %d, ... ) to customize the error message. The message has to be 'There are not enough (the given product name) bikes. You only have (the stock of the product) in stock.'
Pass to the THROW statement the variable of the custom message.

DECLARE @product_name AS NVARCHAR(50) = 'Trek CrossRip+ - 2018';
DECLARE @number_of_sold_bikes AS INT = 10;
DECLARE @current_stock INT;
-- Select the current stock
SELECT @current_stock = stock FROM products WHERE product_name = @product_name;
DECLARE @my_message NVARCHAR(500) =
	-- Customize the message
	FORMATMESSAGE('There are not enough %s bikes. You only have %d in stock.', @product_name, @current_stock);

IF (@current_stock - @number_of_sold_bikes < 0)
	-- Throw the error
	THROW 50000, @my_message, 1;



FORMATMESSAGE with message number
Like in the previous exercise, you need to check if there is enough stock when you sell a product.

This time you want to add your custom error message to the sys.messages catalog, by executing the sp_addmessage stored procedure.

Instructions
100 XP
Instructions
100 XP
Pass to the sp_addmessage stored procedure 50002 as the message id, 16 as the severity, and 'There are not enough %s bikes. You only have %d in stock.' as the message text.
Use FORMATMESSAGE, setting the first parameter (message number) to be 50002. Complete the second and the third parameters to replace the parameter placeholders of the message (%s and %d) with the appropriate variables.
Pass to the THROW statement the custom message.

-- Pass the variables to the stored procedure
EXEC sp_addmessage @msgnum = 50002, @severity = 16, @msgtext = 'There are not enough %s bikes. You only have %d in stock.', @lang = N'us_english';

DECLARE @product_name AS NVARCHAR(50) = 'Trek CrossRip+ - 2018';
DECLARE @number_of_sold_bikes AS INT = 10;
DECLARE @current_stock INT;
SELECT @current_stock = stock FROM products WHERE product_name = @product_name;
DECLARE @my_message NVARCHAR(500) =
	-- Prepare the error message
	FORMATMESSAGE(50002, @product_name, @current_stock);

IF (@current_stock - @number_of_sold_bikes < 0)
	-- Throw the error
	THROW 50000, @my_message, 1;



Transaction statements
Which of the following is not correct about transaction statements?

Answer the question
50 XP
Possible Answers
The BEGIN TRAN|TRANSACTION statement marks the starting point of a transaction.
press
1
The COMMIT TRAN|TRANSACTION statement marks the end of a successful transaction.
press
2
The COMMIT TRAN|TRANSACTION statement reverts a transaction to the beginning or a savepoint inside the transaction.
press
3
The ROLLBACK TRAN|TRANSACTION statement reverts a transaction to the beginning or a savepoint inside the transaction.
press
4

3


Correcting a transaction
Today you have been given a script which is not correct. It was written by a colleague of yours who didn't know how to finish it. Your colleague tried to transfer $100 from account 1 to account 5, and register those movements into the transactions table.

You immediately realize there are several errors. SQL Server doesn't recognize the transaction statements it uses.

Can you correct the script?

Instructions
100 XP
Run the code to verify there are errors.
Correct every error.

BEGIN TRY  
	BEGIN TRAN; 
		UPDATE accounts SET current_balance = current_balance - 100 WHERE account_id = 1;
		INSERT INTO transactions VALUES (1, -100, GETDATE());
        
		UPDATE accounts SET current_balance = current_balance + 100 WHERE account_id = 5;
		INSERT INTO transactions VALUES (5, 100, GETDATE());
	COMMIT TRAN;     
END TRY
BEGIN CATCH  
	ROLLBACK TRAN;
END CATCH



Rolling back a transaction if there is an error
On your first day of work, you were given the task of setting up transactions that record when money is transferred in your bank.

You want to prepare a simple script where $100 transfers from account_id = 1 and goes to account_id = 5. After that, it registers those movements into the transactions table. You think you have written everything correctly, but as a cautious worker, you prefer to check everything!

As a matter of fact, you did make a mistake. Instead of inserting a new transaction for account 5, you did it for account 500, which doesn't exist.

To prevent future errors, the script you create should rollback every change if an error occurs. If everything goes correctly, the transaction should be committed.

Instructions
100 XP
Instructions
100 XP
Begin the transaction.
Correct the mistake in the operation.
Commit the transaction if there are no errors.
Inside the CATCH block, roll back the transaction.

BEGIN TRY  
	-- Begin the transaction
	BEGIN TRAN;
		UPDATE accounts SET current_balance = current_balance - 100 WHERE account_id = 1;
		INSERT INTO transactions VALUES (1, -100, GETDATE());
        
		UPDATE accounts SET current_balance = current_balance + 100 WHERE account_id = 5;
        -- Correct it
		INSERT INTO transactions VALUES (5, 100, GETDATE());
    -- Commit the transaction
	COMMIT TRAN;    
END TRY
BEGIN CATCH  
	SELECT 'Rolling back the transaction';
    -- Rollback the transaction
	ROLLBACK TRAN;
END CATCH



Choosing when to commit or rollback a transaction
The bank where you work has decided to give $100 to those accounts with less than $5,000. However, the bank director only wants to give that money if there aren't more than 200 accounts with less than $5,000.

You prepare a script to give those $100, and of the multiple ways of doing it, you decide to open a transaction and then update every account with a balance of less than $5,000. After that, you check the number of the rows affected by the update, using the @@ROWCOUNT function. If this number is bigger than 200, you rollback the transaction. Otherwise, you commit it.

How do you prepare the script?

Instructions
100 XP
Instructions
100 XP
Begin the transaction.
Check if the number of affected rows is bigger than 200.
Rollback the transaction if the number of affected rows is more than 200.
Commit the transaction if the number of affected rows is less than or equal to 200.

-- Begin the transaction
BEGIN TRAN; 
	UPDATE accounts set current_balance = current_balance + 100
		WHERE current_balance < 5000;
	-- Check number of affected rows
	IF @@ROWCOUNT > 200 
		BEGIN 
        	-- Rollback the transaction
			ROLLBACK TRAN; 
			SELECT 'More accounts than expected. Rolling back'; 
		END
	ELSE
		BEGIN 
        	-- Commit the transaction
			COMMIT TRAN; 
			SELECT 'Updates commited'; 
		END



Modifiers of the @@TRANCOUNT value
Which of the following is false about @@TRANCOUNT?

Answer the question
50 XP
Possible Answers
The COMMIT TRAN|TRANSACTION statement decrements the value of @@TRANCOUNT by 1.
press
1
The COMMIT TRAN|TRANSACTION statement decrements the value of @@TRANCOUNT to 0, except if there is a savepoint.
press
2
The ROLLBACK TRAN|TRANSACTION statement decrements the value of @@TRANCOUNT to 0, except if there is a savepoint.
press
3
The BEGIN TRAN|TRANSACTION statement increments the value of @@TRANCOUNT by 1.
press
4

2



Checking @@TRANCOUNT in a TRY...CATCH construct
The owner of account 10 has won a raffle and will be awarded $200. You prepare a simple script to add those $200 to the current_balance of account 10. You think you have written everything correctly, but you prefer to check your code.

In fact, you made a silly mistake when adding the money: SET current_balance = 'current_balance' + 200. You wrote 'current_balance' as a string, which generates an error.

The script you create should rollback every change if an error occurs, checking if there is an open transaction. If everything goes correctly, the transaction should be committed, also checking if there is an open transaction.

Instructions
100 XP
Instructions
100 XP
Begin the transaction.
Correct the mistake in the operation.
Inside the TRY block, check if there is a transaction and commit it.
Inside the CATCH block, check if there is a transaction and roll it back.


BEGIN TRY
	-- Begin the transaction
	BEGIN TRAN;
    	-- Correct the mistake
		UPDATE accounts SET current_balance = current_balance + 200
			WHERE account_id = 10;
    	-- Check if there is a transaction
		IF @@TRANCOUNT > 0     
    		-- Commit the transaction
			COMMIT TRAN;
     
	SELECT * FROM accounts
    	WHERE account_id = 10;      
END TRY
BEGIN CATCH  
    SELECT 'Rolling back the transaction'; 
    -- Check if there is a transaction
    IF @@TRANCOUNT > 0   	
    	-- Rollback the transaction
        ROLLBACK TRAN;
END CATCH



Using savepoints
Your colleague Anita needs help. She prepared a script that uses savepoints, but it doesn't work. The script marks the first savepoint, savepoint1 and then inserts the data of a customer. Then, the script marks another savepoint, savepoint2, and inserts the data of another customer again. After that, both savepoints are rolled back. Finally, the script marks another savepoint, savepoint3, and inserts the data of another customer.

Anita tells you that her script doesn't work because it has some errors, but she doesn't know how to correct them. Can you help her?

Instructions
100 XP
Run the code to verify there are errors.
Correct every error.

BEGIN TRAN;
	-- Mark savepoint1
	SAVE TRAN savepoint1;
	INSERT INTO customers VALUES ('Mark', 'Davis', 'markdavis@mail.com', '555909090');

	-- Mark savepoint2
    SAVE TRAN savepoint2;
	INSERT INTO customers VALUES ('Zack', 'Roberts', 'zackroberts@mail.com', '555919191');

	-- Rollback savepoint2
	ROLLBACK TRAN savepoint2;
    -- Rollback savepoint1
	ROLLBACK TRAN savepoint1;

	-- Mark savepoint3
	SAVE TRAN savepoint3;
	INSERT INTO customers VALUES ('Jeremy', 'Johnsson', 'jeremyjohnsson@mail.com', '555929292');
-- Commit the transaction
COMMIT TRAN;



XACT_ABORT behavior
If there is an error and XACT_ABORT is set to...

Answer the question
50 XP
Possible Answers
OFF, the transaction will always be rollbacked.
press
1
ON, the transaction will always be rollbacked.
press
2
ON, the transaction can be rollbacked or not, depending on the error.
press
3

2



XACT_ABORT and THROW
The wealthiest customers of the bank where you work have decided to donate the 0.01% of their current_balance to a non-profit organization. You are in charge of preparing the script to update the customer's accounts, but you have to do it only for those accounts with a current_balance with more than $5,000,000. The director of the bank tells you that if there aren't at least 10 wealthy customers, you shouldn't do this operation, because she wants to interview more customers.

You prepare a script, and of the multiple ways of doing it, you decide to use XACT_ABORT in combination with THROW. This way, if the number of affected rows is less than or equal to 10, you can throw an error so that the transaction is rolled back.

Instructions
100 XP
Instructions
100 XP
Use the appropriate setting of XACT_ABORT.
Begin the transaction.
If the number of affected rows is less than or equal to 10, throw the error using the THROW statement, with a number of 55000.
Commit the transaction if the number of affected rows is more than 10.

-- Use the appropriate setting
SET XACT_ABORT ON;
-- Begin the transaction
BEGIN TRAN; 
	UPDATE accounts set current_balance = current_balance - current_balance * 0.01 / 100
		WHERE current_balance > 5000000;
	IF @@ROWCOUNT <= 10	
    	-- Throw the error
		THROW 55000, 'Not enough wealthy customers!', 1;
	ELSE		
    	-- Commit the transaction
		COMMIT TRAN; 



Doomed transactions
You want to insert the data of two new customers into the customer table. You prepare a script controlling that if an error occurs, the transaction rollbacks and you get the message of the error. You want to control it using XACT_ABORT in combination with XACT_STATE.

Instructions
100 XP
Use the appropriate setting of XACT_ABORT.
Check if there is an open transaction.
Rollback the transaction.
Select the error message.

-- Use the appropriate setting
SET XACT_ABORT ON;
BEGIN TRY
	BEGIN TRAN;
		INSERT INTO customers VALUES ('Mark', 'Davis', 'markdavis@mail.com', '555909090');
		INSERT INTO customers VALUES ('Dylan', 'Smith', 'dylansmith@mail.com', '555888999');
	COMMIT TRAN;
END TRY
BEGIN CATCH
	-- Check if there is an open transaction
	IF XACT_STATE() <> 0
    	-- Rollback the transaction
		ROLLBACK TRAN;
    -- Select the message of the error
    SELECT ERROR_MESSAGE() AS Error_message;
END CATCH



Concurrency phenomena
Which of the following is true about these concurrency phenomena?

Answer the question
50 XP
Possible Answers
Non-repeatable reads occur when a transaction reads data that has been modified by another transaction without been yet committed.
press
1
Dirty reads occur when a transaction reads a record twice, but the first result is different from the second result as a consequence of another committed transaction altered this data.
press
2
Phantom reads occur when a transaction reads some records twice, but the first result it gets is different from the second result as a consequence of another committed transaction having inserted a row.
press
3
Non-repeatable reads occur when a transaction reads some records twice, but the first result it gets is different from the second result as a consequence of another committed transaction having inserted a row.
press
4

3


Using the READ UNCOMMITTED isolation level
A new client visits your bank to open an account. You insert her data into your system, causing a script like this one to start running:

BEGIN TRAN

  INSERT INTO customers (first_name, last_name, email, phone)
  VALUES ('Ann', 'Ros', 'aros@mail.com', '555555555')

  DECLARE @cust_id INT = scope_identity()

  INSERT INTO accounts (account_number, customer_id, current_balance)
  VALUES ('55555555555010121212', @cust_id, 150)

COMMIT TRAN
At that moment, your marketing colleague starts to send e-mails to every customer. There is going to be a raffle for a car! The script he executes gets every customer's data, including the last customer you inserted. This script starts running after the first insert occurs but before the COMMIT TRAN.

How can that be?

Instructions
100 XP
Set the READ UNCOMMITTED isolation level.
Select first_name, last_name, email and phone from customers table.

-- Set the appropriate isolation level
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	-- Select first_name, last_name, email and phone
	SELECT
    	first_name, 
        last_name, 
        email, 
        phone
    FROM customers;



Choosing the correct isolation level
Non-repeatable reads occur when a transaction reads a record twice, but the first result is different from the second result as a consequence of another committed transaction altering this data.

From all the isolation levels you have studied so far, which isolation level prevents non-repeatable reads?

Answer the question
50 XP
Possible Answers
The READ UNCOMMITTED isolation level.
press
1
The REPEATABLE READ isolation level.
press
2
The READ COMMITTED isolation level.
press
3

2



Prevent dirty reads
You have to analyze how many accounts have more than $50,000.

As the number of accounts is an important result, you don't want to read data modified by other transactions that haven't committed or rolled back yet. In doing this, you prevent dirty reads. However, you don't need to consider having non-repeatable or phantom reads.

Prepare the script.

Instructions
100 XP
Set the appropriate isolation level to prevent dirty reads.
Select the count of accounts that match the criteria.

-- Set the appropriate isolation level
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

-- Count the accounts
SELECT COUNT(*) AS number_of_accounts
FROM accounts
WHERE current_balance >= 50000;



Preventing non-repeatable reads
You are in charge of analyzing data about your bank customers.

You prepare a script that first selects the data of every customer. After that, your script needs to process some mathematical operations based on the result. (We won't focus on these operations for this exercise.) After that, you want to select the same data again, ensuring nothing has changed.

As this is critical, you think it is better if nobody can change anything in the customers table until you finish your analysis. In doing this, you prevent non-repeatable reads.

Instructions
100 XP
Set the appropriate isolation level to prevent non-repeatable reads.
Begin a transaction.
Commit the transaction.

-- Set the appropriate isolation level
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

-- Begin a transaction
BEGIN TRAN

SELECT * FROM customers;

-- some mathematical operations, don't care about them...

SELECT * FROM customers;

-- Commit the transaction
COMMIT TRAN



Prevent phantom reads in a table
Today you have to analyze the data of every customer of your bank. As this information is very important, you think about locking the complete customers table, so that nobody will be able to change anything in this table. In doing this, you prevent phantom reads.

You prepare a script to select that information, and with the result of this selection, you need to process some mathematical operations. (We won't focus on these operations for this exercise.) After that, you want to select the same data again, ensuring nothing has changed.

Instructions
100 XP
Instructions
100 XP
Set the appropriate isolation level to prevent phantom reads.
Begin the transaction.
Commit the transaction.

-- Set the appropriate isolation level
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

-- Begin a transaction
BEGIN TRAN

SELECT * FROM customers;

-- After some mathematical operations, we selected information from the customers table.
SELECT * FROM customers;

-- Commit the transaction
COMMIT TRAN



Prevent phantom reads just in some rows
You need to analyze some data about your bank customers with the customer_id between 1 and 10. You only want to lock the rows of the customers table with the customer_id between 1 and 10. In doing this, you guarantee nobody will be able to change these rows, and you allow other transactions to work with the rest of the table.

You need to select the customers and execute some mathematical operations again. (We won't focus either on these operations for this exercise.) After that, you want to select the customers with the customer_id between 1 and 10 again, ensuring nothing has changed.

How can you prepare the script?

Instructions
100 XP
Set the appropriate isolation level to prevent phantom reads.
Begin a transaction.
Select those customers you want to lock.
Commit the transaction.

-- Set the appropriate isolation level
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

-- Begin a transaction
BEGIN TRAN

-- Select customer_id between 1 and 10
SELECT * 
FROM customers
WHERE customer_id BETWEEN 1 AND 10;

-- After completing some mathematical operation, select customer_id between 1 and 10
SELECT * 
FROM customers
WHERE customer_id BETWEEN 1 AND 10;

-- Commit the transaction
COMMIT TRAN



Setting READ COMMITTED SNAPSHOT to ON
The default isolation level of your database is READ COMMITTED. You made some scripts that were supposed to be run under the READ COMMITTED isolation level.

Now, you want every script you already made to be run with the READ COMMITTED SNAPSHOT option set to ON. In doing this, each statement under the READ COMMITTED isolation level will see the committed changes that occur before the start of each statement.

Which options do you need to set in your database?

Answer the question
50 XP
Possible Answers
ALTER DATABASE myDatabaseName SET ALLOW_SNAPSHOT_ISOLATION ON and ALTER DATABASE myDatabaseName SET READ_COMMITTED_SNAPSHOT ON.
press
1
ALTER DATABASE myDatabaseName SET ALLOW_SNAPSHOT_ISOLATION OFF and ALTER DATABASE myDatabaseName SET READ_COMMITTED_SNAPSHOT ON.
press
2
ALTER DATABASE myDatabaseName SET TRANSACTION ISOLATION LEVEL SNAPSHOT and ALTER DATABASE myDatabaseName SET READ_COMMITTED_SNAPSHOT ON.
press
3
ALTER DATABASE myDatabaseName SET ALLOW_SNAPSHOT_ISOLATION ON, ALTER DATABASE myDatabaseName SET TRANSACTION ISOLATION LEVEL SNAPSHOT,and ALTER DATABASE myDatabaseName SET READ_COMMITTED_SNAPSHOT ON.
press
4

1


Comparing WITH (NOLOCK) & READ UNCOMMITTED
Your colleague needs to read some uncommitted data within a transaction. He has to decide whether to use WITH (NOLOCK) option or the READ UNCOMMITTED isolation level, but he is not sure about the differences between both options.

Can you help him to clarify the differences between using WITH (NOLOCK) option and the READ UNCOMMITTED isolation level?

Answer the question
50 XP
Possible Answers
The WITH (NOLOCK) option behaves like the READ UNCOMMITTED isolation level. But, whereas the isolation level applies to a specific table, the WITH (NOLOCK) option applies for the entire connection.
press
1
The WITH (NOLOCK) option doesn't behave like the READ UNCOMMITTED isolation level because the first one can't read dirty reads.
press
2
The WITH (NOLOCK) option behaves like the READ UNCOMMITTED isolation level. But whereas the isolation level applies for the entire connection, WITH NOLOCK applies to a specific table.
press
3
The WITH (NOLOCK) option behaves like the READ UNCOMMITTED isolation level, because the first one can't read dirty reads.
press
4

3


Avoid being blocked
You are trying to select every movement of account 1 from the transactions table. When selecting that information, you are blocked by another transaction, and the result doesn't output. Your database is configured under the READ COMMITTED isolation level.

Can you change your select query to get the information right now without changing the isolation level? In doing this you can read the uncommitted data from the transactions table.

Instructions
100 XP
Change your script to avoid being blocked.

SELECT *
	-- Avoid being blocked
	FROM transactions WITH (NOLOCK)
WHERE account_id = 1




