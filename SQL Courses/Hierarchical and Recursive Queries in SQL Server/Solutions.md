A CTE is ... Find the wrong fact!
In this exercise, we want to refresh your knowledge of CTEs (Common Table Expressions). The statements below are about basic characteristics of CTEs and why it is beneficial to use them.

Please find the statement that is NOT true about CTEs.

Answer the question
50 XP
Possible Answers
A CTE could be applied to recursive and non-recursive functions.

A CTE is a temporary result that could be referenced by SELECT, INSERT, UPDATE, or DELETE statements.

A CTE never returns a result set.
press
3
A CTE could be used for substituting a view.



A CTE for IT-positions
To practice writing CTEs, let's start with a simple example. You will use the employee table which is built up of fields such as ID, Name, and Position. The task for you is to create a CTE called ITjobs (keep in mind the syntax WITH CTE_Name As) that finds employees named Andrea whose job titles start with IT. Finally, a new query will retrieve all IT positions and names from the ITJobs CTE.

To search for a pattern, you have to use the LIKE statement and % representing the search direction. For example, using a WHERE statement with LIKE 'N%' will find patterns starting with N.

Instructions
100 XP
Instructions
100 XP
Create the CTE ITjobs.
Define the fields of the CTE as ID, Name, and Position.
Find the positions starting with IT and the name starting with A.

-- Define the CTE ITjobs by the WITH operator
WITH ITjobs (ID, Name, Position) AS (
    SELECT 
  		ID, 
  		Name,
  		Position
    FROM employee
    -- Find IT jobs and names starting with A
    WHERE Position LIKE 'IT%' AND Name LIKE 'A%')  
    
SELECT * 
FROM ITjobs;


A CTE for high-paid IT-positions
In the previous exercise, you created a CTE to find IT positions. Now, you will combine these results with another CTE on the salary table. You will use multiple CTE definitions in a single query. Notice that a comma is used to separate the CTE query definitions. The salary table contains some more information about the ID and salary of employees. Your task is to create a second CTE named ITsalary and JOIN both CTE tables on the employees ID. The JOIN should select only records having matching values in both tables. Finally, the task is to find only employees earning more than 3000.

Instructions
100 XP
Instructions
100 XP
Define the second CTE, ITSalary, with the fields ID and Salary.
Find salaries above 3000.
Combine the two CTEs by using a JOIN of matching IDs and select the name, the salary, and the position of the selected employees.

WITH ITjobs (ID, Name, Position) AS (
    SELECT 
  		ID, 
  		Name,
  		Position
    FROM employee
    WHERE Position like 'IT%'),
    
-- Define the second CTE table ITSalary with the fields ID and Salary
ITsalary (ID, Salary) AS (
    SELECT
        ID,
        Salary
    FROM Salary
  	-- Find salaries above 3000
  	WHERE Salary > 3000)
    
SELECT 
	ITjobs.NAME,
	ITjobs.POSITION,
    ITsalary.Salary
FROM ITjobs
    -- Combine the two CTE tables the correct join variant
    INNER JOIN ITsalary
    -- Execute the join on the ID of the tables
    ON ITjobs.ID = ITsalary.ID;



Facts about recursion.
Recursion is the process in which a function is called within itself. The function is called several times until it meets the termination condition.

In this exercise, your job is to find the wrong fact about recursion.

Answer the question
50 XP
Possible Answers
Complex functions can be simplified with recursion.

Recursively defined functions cannot be solved iteratively
press
2
A termination condition is always necessary.

The execution time can be slow because a recursion function is called many times.



Calculate the factorial of 5
A very important mathematical operation is the calculation of the factorial of a positive integer n. In general, the factorial operation is used in many areas of mathematics, notably in combinatorics, algebra, and mathematical analysis.

The factorial of n is defined by the product of all positive integers less than or equal to n. For example, the factorial of 3 (denoted by n!) is defined as:

3! = 1 x 2 x 3 = 6

To calculate the factorial of n, many different solutions exist. In this exercise, you will determine the factorial of 5 iteratively with SQL.

Remember the syntax of a WHILE loop in SQL:

WHILE condition
BEGIN
   {...statements...}
END;
More information on WHILE can be found in the documentation.

Instructions
100 XP
Instructions
100 XP
Set the @target factorial, which will also serve as the termination condition, to 5.
Initialize the @factorial result.
Calculate the @factorial number by taking the product of the factorial result so far and the current iteration.
Reduce the termination condition by 1 at the end of the iteration.

-- Define the target factorial number
DECLARE @target float = 5
-- Initialization of the factorial result
DECLARE @factorial float = 1

WHILE @target > 0 
BEGIN
	-- Calculate the factorial number
	SET @factorial = @factorial * @target
	-- Reduce the termination condition  
 	SET @target = @target - 1
END

SELECT @factorial;



How to query the factorial of 6 recursively
In the last exercise, you queried the factorial 5! with an iterative solution. Now, you will calculate 6! recursively. We reduce the problem into smaller problems of the same type to define the factorial n! recursively. For this the following definition can be used:

0! = 1 for step = 0
(n+1)! = n! * (step+1) for step > 0
With this simple definition you can calculate the factorial of every number. In this exercise, n! is represented by factorial.

You are going to leverage the definition above with the help of a recursive CTE.

Instructions
100 XP
Initialize the fields factorial and step to 1.
Calculate the recursive part with factorial * (step + 1).
Stop the recursion process when the current iteration value is smaller than the target factorial number.


WITH calculate_factorial AS (
	SELECT 
		-- Initialize step and the factorial number      
      	1 AS step,
        1 AS factorial
	UNION ALL
	SELECT 
      	step + 1,
     	-- Calculate the recursive part by n!*(n+1)
        factorial * (step + 1)
	FROM calculate_factorial        
	-- Stop the recursion reaching the wanted factorial number
	WHERE step < 6)
     
SELECT factorial 
FROM calculate_factorial;



Counting numbers recursively
In this first exercise after the video, we will start with a very simple math function. It is the simple series from 1 to target and in our case we set the target value to 50.

This means the task is to count from 1 to 50 using a recursive query. You have to define:

the CTE with the definition of the anchor and recursive query and
set the appropriate termination condition for the recursion
Instructions
100 XP
Instructions
100 XP
Limit the recursion step to 50 in the recursive query.
Define the CTE with the name counting_numbers.
Initialize number in the anchor query.
Add 1 to number each recursion step.


-- Define the CTE
WITH counting_numbers AS ( 
	SELECT 
  		-- Initialize number
  		1 AS number
  	UNION ALL 
  	SELECT 
  		-- Increment number by 1
  		number + 1 
  	FROM counting_numbers
	-- Set the termination condition
  	WHERE number < 50)
    
SELECT number
FROM counting_numbers;



Calculate the sum of potencies
In this exercise, you will calculate the sum of potencies recursively. This mathematical series is defined as:

result=1 for step = 1
result + step^step for step > 1
The numbers in this series are getting large very quickly and the series does not converge. The task of this exercise is to calculate the sum of potencies for step = 9.

Instructions
100 XP
Define the CTE calculate_potencies with the fields step and result.
Initialize step and result.
Add the next step to the POWER() step + 1 to result.

-- Define the CTE calculate_potencies with the fields step and result
WITH calculate_potencies (step, result) AS (
    SELECT 
  		-- Initialize step and result
  		1,
  		1
    UNION ALL
    SELECT 
  		step + 1,
  		-- Add the POWER calculation to the result  
  		result + POWER(step + 1, step + 1)
    FROM calculate_potencies
    WHERE step < 9)
    
SELECT 
	step, 
    result
FROM calculate_potencies;



Right or wrong?
So far in this chapter, you have learned about using recursive CTEs to solve recursive tasks. In this exercise, you will strengthen your knowledge and understanding, by looking at some statements about recursive queries.

Which of the statements below is true?

Answer the question
50 XP
Possible Answers
A recursive CTE is used to create iterative queries.
press
1
Using a CTE call can improve readability.
press
2
The items GROUP BY, SELECT DISTINCT, and HAVING are allowed in a recursive query.
press
3
A recursive CTE needs an anchor query and a recursive query.
press
4
It is not possible to self-reference a table using a CTE.
press
5

4



Create the alphabet recursively
The task of this exercise is to create the alphabet by using a recursive CTE.

To solve this task, you need to know that you can represent the letters from A to Z by a series of numbers from 65 to 90. Accordingly, A is represented by 65 and C by 67. The function char(number) can be used to convert a number its corresponding letter.

Instructions
100 XP
Instructions
100 XP
Initialize number_of_letter to the number representing the letter A.
Increase the value of number_of_letter by 1 in each step and set the limit to 90, the value of Z.
Select the recursive member from the defined CTE.

WITH alphabet AS (
	SELECT 
  		-- Initialize letter to A
	    65 AS number_of_letter
	-- Statement to combine the anchor and the recursive query
  	UNION ALL
	SELECT 
  		-- Add 1 each iteration
	    number_of_letter + 1
  	-- Select from the defined CTE alphabet
	FROM alphabet
  	-- Limit the alphabet to A-Z
  	WHERE number_of_letter < 90)

SELECT char(number_of_letter)
FROM alphabet;



Create a time series of a year
The goal of this exercise is to create a series of days for a year. For this task you have to use the following two time/date functions:

GETDATE()
DATEADD(datepart, number, date)
With GETDATE() you get the current time (e.g. 2019-03-14 20:09:14) and with DATEADD(month, 1, GETDATE()) you get current date plus one month (e.g. 2019-04-14 20:09:14).

To get a series of days for a year you need 365 recursion steps. Therefore, increase the number of iterations by OPTION (MAXRECURSION n) where n represents the number of iterations.

Instructions
100 XP
Instructions
100 XP
Initialize the current time as time.
Select the CTE recursively and combine the anchor and recursive member with the correct statement.
Limit the number of iterations to days in a year minus 1
Increase the maximum number of iterations to the number of days in a year with OPTION (MAXRECURSION n)

WITH time_series AS (
	SELECT 
  		-- Get the current time
	    GETDATE() AS time
  	UNION ALL
	SELECT 
	    DATEADD(day, 1, time)
  	-- Call the CTE recursively
	FROM time_series
  	-- Limit the time series to 1 year minus 1 (365 days -1)
  	WHERE time < GETDATE() + 364)
    
SELECT time
FROM time_series
-- Increase the number of iterations (365 days)
OPTION(MAXRECURSION 365)


Who is your manager?
In this exercise, we are going to use the dataset of an IT-organization which is provided in the table employee. The table has the fields ID (ID number of the employee), Name (the employee's name), and Supervisor (ID number of the supervisor).

The IT-organization consists of different roles and levels.

A section of the entire hierarchy

The organization has one IT director (ID=1, Heinz Griesser, Supervisor=0) with many subordinate employees. Under the IT director you can find the IT architecture manager (ID=10, Andreas Sternig, Supervisor=1) with three subordinate employees. For Andreas Sternig Supervisor=1 which is the IDof the IT-Director.

First, we want to answer the question: Who are the supervisors for each employee?

We are going to solve this problem by recursively querying the dataset.

Instructions
100 XP
Instructions
100 XP
Create a CTE with the name employee_hierarchy.
Select the information of the IT director as the initial step of the CTE by filtering on his Supervisor ID.
Perform a join with employee to get the name of the manager.

-- Create the CTE employee_hierarchy
WITH employee_hierarchy AS (
	SELECT
		ID, 
  		NAME,
  		Supervisor
	FROM employee 
  	-- Start with the IT Director
  	WHERE Supervisor = 0
	UNION ALL
	SELECT 
  		emp.ID,
  		emp.NAME,
  		emp.Supervisor
	FROM employee emp
  		JOIN employee_hierarchy
  		ON emp.Supervisor = employee_hierarchy.ID)
    
SELECT 
    cte.Name as EmployeeName,
    emp.Name as ManagerName
FROM employee_hierarchy as cte
	JOIN employee as emp
	-- Perform the JOIN on Supervisor and ID
	ON cte.Supervisor = emp.ID;



Get the hierarchy position
An important problem when dealing with recursion is tracking the level of recursion. In the IT organization, this means keeping track of the position in the hierarchy of each employee.

A section of the entire hierarchy

For this, you will use a LEVEL field which keeps track of the current recursion step. You have to introduce the field in the anchor member, and increment this value on each recursion step in the recursion member.

Keep in mind, the first hierarchy level is 0, the second levl is 1 and so on.

Instructions
100 XP
Instructions
100 XP
Initialize the field LEVEL to 1 at the start of the recursion.
Select the information of the IT director as the initial step of the CTE by filtering on Supervisor.
Set LEVEL to the current recursion step.
Perform a JOIN with the defined CTE on the IDs of the supervisor and the employee.

WITH employee_hierarchy AS (
	SELECT
		ID, 
  		NAME,
  		Supervisor,
  		-- Initialize the field LEVEL
  		1 as LEVEL
	FROM employee
  	-- Start with the supervisor ID of the IT Director
	WHERE Supervisor = 0
	UNION ALL
	SELECT 
  		emp.ID,
  		emp.NAME,
  		emp.Supervisor,
  		-- Increment LEVEL by 1 each step
  		LEVEL + 1
	FROM employee emp
		JOIN employee_hierarchy
  		-- JOIN on supervisor and ID
  		ON emp.Supervisor = employee_hierarchy.ID)
    
SELECT 
	cte.Name, cte.Level,
    emp.Name as ManagerID
FROM employee_hierarchy as cte
	JOIN employee as emp
	ON cte.Supervisor = emp.ID 
ORDER BY Level;



Which supervisor do I have?
In this exercise, we want to get the path from the boss at the top of the hierarchy, to the employees at the bottom of the hierarchy. For this task, we have to combine the information obtained in each step into one field. You can to this by combining the IDs using CAST() from number to string. An example is CAST(ID AS VARCHAR(MAX)) to convert ID of type number to type char.

The task is now to find the path for employees Christian Feierabend with ID=18 and Jasmin Mentil with ID=16 all the way to the top of the organization. The output should look like this: boss_first_level -> boss_second_level .... The IDs of the employees and not their names should be selected.

Instructions
100 XP
Instructions
100 XP
Initialize Path to the ID of the supervisor (0) and the start condition of the recursion.
UNION the anchor member and define the recursive member fields (ID, Name, Supervisor).
Add the the ID of the supervisor Supervisor to the Path in each step.
Select the IDs of employees Christian Feierabend and Jasmin Mentil in the CTE.
WITH employee_Hierarchy AS (
	SELECT
		ID, 
  		NAME,
  		Supervisor,
  		-- Initialize the Path with CAST
  		CAST('0' AS VARCHAR(MAX)) as Path
	FROM employee
	WHERE Supervisor = 0
	-- UNION the anchor query
  	UNION ALL
    -- Select the recursive query fields
	SELECT 
  		emp.ID,
  		emp.NAME,
  		emp.Supervisor,
  		-- Add the supervisor in each step. CAST the supervisor.
        Path + '->' + CAST(emp.Supervisor AS VARCHAR(MAX))
	FROM employee emp
		INNER JOIN employee_Hierarchy
  		ON emp.Supervisor = employee_Hierarchy.ID
)

SELECT Path
FROM employee_Hierarchy
-- Select the employees Christian Feierabend and Jasmin Mentil
WHERE ID = 16 OR ID = 18;



Get the number of generations?
In this exercise, we are going to look at a random family tree. The dataset family consists of three columns, the ID, the name, and the ParentID. Your task is to calculate the number of generations. You will do this by counting all generations starting from the person with ParentID = 101.

For this task, you have to calculate the LEVEL of the recursion which represents the current level in the generation hierarchy. After that, you need to count the number of LEVELs by using COUNT().

Instructions
100 XP
Instructions
100 XP
Initialize the recursion start by setting the ParentID to 101.
Set LEVEL to the current recursion step.
Join the anchor member to the CTE on the ID of the parent and the child.
COUNT() the number of generations.

WITH children AS (
    SELECT 
  		ID, 
  		Name,
  		ParentID,
  		0 as LEVEL
  	FROM family 
  	-- Set the targeted parent as recursion start
  	WHERE ParentID = 101
    UNION ALL
    SELECT 
  		child.ID,
  		child.NAME,
  		child.ParentID,
  		-- Increment LEVEL by 1 each step
  		LEVEL + 1
  	FROM family child
  		INNER JOIN children 
		-- Join the anchor query with the CTE   
  		ON child.ParentID = children.ID)
    
SELECT
	-- Count the number of generations
	COUNT(LEVEL) as Generations
FROM children
OPTION(MAXRECURSION 300);


Get all possible parents in one field?
Your final task in this chapter is to find all possible parents starting from one ID and combine the IDs of all found generations into one field.

To do this, you will search recursively for all possible members and add this information to one field. You have to use the CAST() operator to combine IDs into a string. You will search for all family members starting from ID = 290. In total there are 300 entries in the table family.

Instructions
100 XP
Set the ParentID of 290 as starting point.
If Parent.ID = '' in the CASE operation, the Parent field needs to be set to the current ParentID.
If Parent.ID <> '' in the CASE operation, the Parent ID needs to be added to the current Parent for each iteration.
Select the Name and Parent from the defined CTE.


WITH tree AS (
	SELECT 
  		ID,
  		Name, 
  		ParentID, 
  		CAST('0' AS VARCHAR(MAX)) as Parent
	FROM family
  	-- Initialize the ParentID to 290 
  	WHERE ParentId = 290   
    UNION ALL
    SELECT 
  		Next.ID, 
  		Next.Name, 
  		Parent.ID,
    	CAST(CASE WHEN Parent.ID = ''
        	      -- Set the Parent field to the current ParentID
                  THEN(CAST(Next.ParentID AS VARCHAR(MAX)))
        	 -- Add the ParentID to the current Parent in each iteration
             ELSE(Parent.Parent + ' -> ' + CAST(Next.ParentID AS VARCHAR(MAX)))
    		 END AS VARCHAR(MAX))
        FROM family AS Next
        	INNER JOIN tree AS Parent 
  			ON Next.ParentID = Parent.ID)
        
-- Select the Name, Parent from tree
Select Name, Parent
FROM tree;



Creating a table
In this exercise, you will create a new table Person. For this task, you have to

define the table by using CREATE TABLE
define the necessary fields of the desired table
An example for creating a table Employee is shown below:

CREATE TABLE Employee (
    ID INT,
    Name CHAR(32)
);
Your task is to create a new table, Person, with the fields IndividualID,Firstname,Lastname, Address, and City.

Instructions
100 XP
Instructions
100 XP
Define the table Person.
Define a field IndividualID.
Set Firstname and Lastname not to be NULL and of type VARCHAR(255).
Define Birthday as DATE.

-- Define the table Person
CREATE TABLE Person (
  	-- Define the Individual ID with INT
  	IndividualID INT NOT NULL,
	-- Set Firstname and Lastname not to be NULL of type VARCHAR(255)
  	Firstname VARCHAR(255) NOT NULL,
	Lastname VARCHAR(255) NOT NULL,
	Address VARCHAR(255) NOT NULL,
  	City CHAR(32) NOT NULL,
  	-- Define Birthday as DATE
  	Birthday DATE
);

SELECT * 
FROM Person;



Inserting and updating a table
A very important task when working with tables is inserting and updating the values in a database. The syntax for both operations is shown below.

Insert value1 and value2 into the Employee table:

INSERT INTO Employee 
VALUES (value1, value2);
Update field1 from table Employee with value1 for the ID=1:

UPDATE Employee 
SET field1 = value1 
WHERE ID = 1;
Your task is to insert two new values into the Person table and to update the entries of the table.

Instructions 1/2
0 XP
Instructions 1/2
0 XP
Insert the new values for ID = 1 into the Person table.
Insert the values Peter, Jackson, 342 Flushing st, New York, and 1986-12-30 in the corresponding fields of the table.

-- Insert the records for the person with ID=1
INSERT INTO Person 
VALUES ('1','Andrew','Anderson','Union Ave 10','New York','1986-12-30');
-- Insert the records for the person with ID=2
INSERT INTO Person 
VALUES ('2','Peter','Jackson','342 Flushing st','New York','1986-12-30');

SELECT * 
FROM Person;


Change the first name of the person whose ID = 1 to Jones.
Update the birthday of the person with the last name Jackson to 1980-01-05.

INSERT INTO Person 
VALUES ('1','Andrew','Anderson','Union Ave 10','New York','1986-12-30');
INSERT INTO Person 
VALUES ('2','Peter','Jackson','342 Flushing st','New York','1986-12-30');

-- Set the person's first name to Jones for ID = 1
UPDATE Person
SET Firstname = 'Jones'
WHERE ID = 1;

-- Update the birthday of the person with the last name Jackson
UPDATE Person
SET Birthday = '1980-01-05'
WHERE Lastname = 'Jackson';

SELECT * 
FROM Person;


Deleting data and dropping table
Besides being able to CREATE, INSERT, or UPDATE, it is also important to know how to DELETE and DROP a table. With DELETE, it is possible to delete a certain line of the table and with DROP TABLE, it is possible to erase the entire table and its definition.

The syntax for both operators is as follows.

Delete the line where lineID = 1 from the Employee table:

DELETE FROM Employee 
WHERE lineID = 1;
Drop the entire Employee table:

DROP TABLE Employee
Your task is to delete some lines of the previously defined Person table and finally, to drop the entire table.

Instructions 1/2
0 XP
Instructions 1/2
0 XP
Delete the person with an ID equal to 1 in the table.
Delete the person whose last name is Jackson.

INSERT INTO Person 
VALUES ('1','Andrew','Anderson','Adress 1','City 1','1986-12-30');
INSERT INTO Person 
VALUES ('2','Peter','Jackson','Adress 2','City 2','1986-12-30');
INSERT INTO Person 
VALUES ('5','Michaela','James','Adress 3','City 3','1976-03-07');

-- Delete the record for the person with the ID of 1
DELETE FROM Person 
WHERE ID = 1;
-- Delete the record with the name Jackson
DELETE FROM Person 
WHERE Lastname = 'Jackson';

SELECT * 
FROM Person;


Delete the table Person

INSERT INTO Person 
VALUES ( '1', 'Andrew', 'Anderson', 'Address 1', 'City 1', '1986-12-30');
INSERT INTO Person 
VALUES ( '2', 'Peter', 'Jackson', 'Address 2', 'City 2', '1986-12-30');
INSERT INTO Person 
VALUES ( '3', 'Michaela', 'James', 'Address 3', 'City 3', '1976-03-07');

DELETE FROM Person 
WHERE ID = 1;
DELETE FROM Person 
WHERE Lastname = 'Jackson';

-- Drop the table Person
DROP TABLE Person

SELECT * 
FROM Person;

Delete the table Person.

INSERT INTO Person 
VALUES ( '1', 'Andrew', 'Anderson', 'Address 1', 'City 1', '1986-12-30');
INSERT INTO Person 
VALUES ( '2', 'Peter', 'Jackson', 'Address 2', 'City 2', '1986-12-30');
INSERT INTO Person 
VALUES ( '3', 'Michaela', 'James', 'Address 3', 'City 3', '1976-03-07');

DELETE FROM Person 
WHERE ID = 1;
DELETE FROM Person 
WHERE Lastname = 'Jackson';

-- Drop the table Person
DROP TABLE Person

SELECT * 
FROM Person;



Changing a table structure
Another basic SQL operation is to add or delete a column from a table. This can be done using the ALTER TABLE syntax followed by the desired operation. The syntax for these operations is defined as follows.

To add a column named new to the Employee table:

ALTER TABLE Employee 
ADD new;
To delete a column named old from Employee:

ALTER TABLE Employee 
DROP COLUMN old
You have the task to add a new column Email and drop the column Birthday from the Person table.

Instructions
100 XP
Instructions
100 XP
Add the column Email to Person.
Delete the column Birthday from Person.

-- Add the column EMail to Person
ALTER TABLE Person
ADD Email VARCHAR(255);

-- Delete the column Birthday of Person
ALTER TABLE Person
DROP COLUMN Birthday;

-- Check the table definition
SELECT * 
FROM Person;



Defining primary and foreign keys
A very important concept of relational databases is the use of primary and foreign keys. In this exercise, you will define a two new tables. A table Person, with a PRIMARY KEY and another table, History, with a PRIMARY KEY and a FOREIGN KEY referencing the Person table.

Instructions
100 XP
Define the primary key PersonID for Person of type INT.
Define the primary key OrderID for History.
Define the foreign key PersonID referencing the primary key of Person.


CREATE TABLE Person (
  	-- Define the primary key for Person of type INT
  	PersonID INT NOT NULL PRIMARY KEY,
	Firstname VARCHAR(255) NOT NULL,
	Lastname VARCHAR(255) NOT NULL,
);

CREATE TABLE History (   
    -- Define the primary key for History
  	OrderID INT NOT NULL PRIMARY KEY,
    Item VARCHAR(255) NOT NULL,
    Price INT NOT NULL,
  	-- Define the foreign key for History
    PersonID INT FOREIGN KEY REFERENCES Person(PersonID)    
);

SELECT * 
FROM History;



Inserting data to person and order history
Next, you will insert data into the two newly generated tables, Person and History. Enter the following orders:

Andrew Anderson bought an iPhone XS for 1000
Sam Smith bought a MacBook Pro for 1800
When inserting the customers and their orders into the tables make sure that:

the primary key is unique
you use the correct foreign key
Instructions
100 XP
Instructions
100 XP
Insert new data for the person with ID=1, Andrew Anderson.
Insert new data for the second person with ID=2, Sam Smith.
Insert a new order for Andrew Anderson: iPhone XS for 1000.
Insert a new order for Sam Smith: MacBook Pro for 1800.

-- Insert new data into the table Person
INSERT INTO Person 
VALUES ('1','Andrew','Anderson','Union Ave 10','New York','1986-12-30');
INSERT INTO Person 
VALUES ('2','Sam','Smith','Flushing Ave 342','New York','1986-12-30');

-- Insert new data into the table History
INSERT INTO History 
VALUES ('1','IPhone XS','1000','1');
INSERT INTO History 
VALUES ('2','MacBook Pro','1800','2');

SELECT * 
FROM History;


Getting the number of orders & total costs
In this exercise, you will JOIN two tables to get the total number of orders for each person and the sum of prices of all orders. You have to join the Person and History tables on the primary and foreign keys to get all required information.

Instructions
100 XP
COUNT() the number of orders and alias it as Orders.
SUM() the total price of all orders and alias it as Costs.
Join the Person and History tables.
Aggregate the information on ID using GROUP BY.

INSERT INTO Person 
VALUES ('1', 'Andrew', 'Anderson','Union Ave 10','New York','1986-12-30');
INSERT INTO Person 
VALUES ('2', 'Sam', 'Smith','Flushing Ave 342','New York','1986-12-30');

INSERT INTO History VALUES ( '1', 'IPhone XS', '1000', '1');
INSERT INTO History VALUES ( '2', 'MacBook Pro', '1800', '1');
INSERT INTO History VALUES ( '5', 'IPhone XR', '600', '2');
INSERT INTO History VALUES ( '6', 'IWatch 4', '400', '1');

SELECT 
    Person.ID,
    -- Count the number of orders
    COUNT(Item) as Orders,
    -- Add the total price of all orders
    SUM(Price) as Costs
FROM Person
	JOIN History 
	-- Join the tables Person and History on their IDs
	ON Person.ID = History.PersonID
-- Aggregate the information on the ID
GROUP BY Person.ID;


Creating a hierarchical data model
In this exercise, you will construct a simple hierarchical data model by creating the hierarchy of IT assets. An asset can be either Hardware or Software. A Software asset can be split up into Application or Tools and so on. The hierarchy is shown in the following picture.



To model this hierarchy, a suitable data structure is needed. This structure can be accomplished by using a data model that consists of the child record ID and the parent record ParentID. The IDs are consecutive values from 1 to 10.

Your task is to create the corresponding Equipment table and to insert the assets Software, Monitor, and Microsoft Office into the table. Keep in mind that you have to set the correct IDs for each asset to achieve the desired hierarchy of assets.

Instructions
100 XP
Instructions
100 XP
Define the fields ID and ParentID of type INT. ID should not be NULL, ParentID can be NULL.
Insert the equipment Software into the table with the correct IDs. The software is part of Asset.
Insert the equipment Monitor into the table with the correct IDs. The monitor is part of Hardware.
Insert the equipment Microsoft Office into the table with the correct IDs. This software is part of Application.

CREATE TABLE Equipment (   
    -- Define ID and ParentID 
	ID INT NOT NULL,
    Equipment VARCHAR(255) NOT NULL,
    ParentID INT 
);

INSERT INTO Equipment VALUES ('1','Asset', NULL);
INSERT INTO Equipment VALUES ('2','Hardware','1');
-- Insert the type Software 
INSERT INTO Equipment VALUES ('3','Software','1');
INSERT INTO Equipment VALUES ('4','Application','3');
INSERT INTO Equipment VALUES ('5','Tool','3');
INSERT INTO Equipment VALUES ('6','PC','2');
-- Insert the type Monitor 
INSERT INTO Equipment VALUES ('7','Monitor','2');
INSERT INTO Equipment VALUES ('8','Phone','2');
INSERT INTO Equipment VALUES ('9','IPhone','8');
-- Insert the type Microsoft Office 
INSERT INTO Equipment VALUES ('10','Microsoft Office','4');

SELECT * 
FROM Equipment;


Networked and hierarchical models
Hierarchical and networked data models are very similar to each other.

Which statement is not true about networked and hierarchical data models?

Answer the question
50 XP
Possible Answers
In hierarchical data models each child record needs to have only one parent record.
press
1
In networked data models each child record can have only one parent record.
press
2
The hierarchical data model can be represented by a tree.
press
3
A networked data model has at least one parent record.
press
4

2



Creating a networked data model
In this last exercise, you will create a networked data model. A use case for this is finding all possible paths a bus can take from one location to another. Each route has a departure and destination location. A departure and destination location can appear multiple times. In the following image you can see the possible bus locations and routes. For example, you can go from San Francisco to New York, or from New York to Washington.



Your task is to create the Trip table, insert some routes into this table, and finally, select all possible departure locations from the table.

Instructions
100 XP
Instructions
100 XP
Define the fields Departure and Destination, neither of which can be NULL.
Insert the route from San Francisco to New York for Bus 1.
Insert the route from Florida to San Francisco for Bus 9.
Select all possible departure locations.

CREATE TABLE Trip (   
    -- Define the Departure
  	Departure VARCHAR(255) NOT NULL,
    BusName VARCHAR(255) NOT NULL,
    -- Define the Destination
    Destination VARCHAR(255) NOT NULL,
);

-- Insert a route from San Francisco to New York
INSERT INTO Trip VALUES ( 'San Francisco', 'Bus 1','New York');
-- Insert a route from Florida to San Francisco
INSERT INTO Trip VALUES ( 'Florida', 'Bus 9','San Francisco');
INSERT INTO Trip VALUES ( 'San Francisco', 'Bus 2','Texas');
INSERT INTO Trip VALUES ( 'San Francisco', 'Bus 3','Florida');
INSERT INTO Trip VALUES ( 'San Francisco', 'Bus 4','Washington');
INSERT INTO Trip VALUES ( 'New York', 'Bus 5','Texas');
INSERT INTO Trip VALUES ( 'New York', 'Bus 6','Washington');
INSERT INTO Trip VALUES ( 'Florida', 'Bus 7','New York');
INSERT INTO Trip VALUES ( 'Florida', 'Bus 8','Toronto');

-- Get all possible departure locations
SELECT DISTINCT Departure 
FROM Trip;



Get the anchor & recursive member
The flight plan and the corresponding planning of flights from the departure airport to the destination airport is a common task for airline websites and traveling websites such as expedia.com. When planning such trips, it is common to have layovers. This helps make certain flight routes possible and reduces flight costs.

To strengthen your understanding of finding the anchor fields in a recursive CTE, you have to choose the best combination of fields from a typical flight table.

The first element should be the anchor element of the anchor member and the second element should be the connection field of the recursive member (e.g.: for an organization hierarchy the anchor element is the supervisor ID and the connection field is the employee ID).

Please find the correct combination of fields to create a flying route.

Answer the question
50 XP
Possible Answers
Flight number and departure airport
press
1
Destination airport and flight number
press
2
Flight costs and departure airport
press
3
Departure airport and the destination airport
press
4

4



Get all possible airports
The task of the next two exercises is to search for all possible flight routes. This means that, first, you have to find out all possible departure and destination airports from the table flightPlan.

In this exercise, you will create a CTE table named possible_Airports using the UNION syntax which will consist of all possible airports. One query of the UNION element selects the Departure airports and the second query selects the Arrival airports.

Instructions
100 XP
Instructions
100 XP
Define the CTE table possible_Airports with the field Airports.
Select the airports by combining Departure and Arrival airports.
Combine the departure with the destination airports using the correct statement.
Select all possible Airports from possible_Airports.

-- Definition of the CTE table
WITH possible_Airports (Airports) AS(
  	-- Select the departure airports
  	SELECT Departure
  	FROM flightPlan
  	-- Combine the two queries
  	UNION
  	-- Select the destination airports
  	SELECT Arrival
  	FROM flightPlan)

-- Get the airports from the CTE table
SELECT Airports
FROM possible_Airports;



All flight routes from Vienna
Previously, you looked at how the flight data is structured. You have already identified the necessary fields from the flightPlan table. These will be used in this exercise for the anchor and the recursive query.

The task of this exercise is to combine this knowledge to create a recursive query that:

gets all possible flights from Vienna
has a travel cost under 500 Euro
has fewer than 5 stops
You should output only the destinations and the corresponding costs!

Instructions 1/3
1 XP
Initialize the number of stops, increment it in the recursive query, and limit it to less than 5.


WITH flight_route (Departure, Arrival, stops) AS(
	SELECT 
    	f.Departure, f.Arrival, 
  		-- Initialize the number of stops
    	0
  	FROM flightPlan f
  	WHERE Departure = 'Vienna'
  	UNION ALL
  	SELECT 
    	p.Departure, f.Arrival, 
  		-- Increment the number of stops
    	p.stops + 1
  	FROM flightPlan f, flight_route p
  	-- Limit the number of stops
  	WHERE p.Arrival = f.Departure AND
          p.stops < 5)

SELECT 
	DISTINCT Arrival, 
    Departure, 
    stops
FROM flight_route;


Define the field route describing the flight route (Departure to Arrival)
Track each recursion step with the Departure and Arrival airport.

-- Define route 
WITH flight_route (Departure, Arrival, stops, route) AS(
	SELECT 
	  	f.Departure, f.Arrival, 
	  	0,
		-- Define the route of a flight
	  	CAST(Departure + ' -> ' + Arrival AS NVARCHAR(MAX))
	FROM flightPlan f
	WHERE Departure = 'Vienna'
	UNION ALL
	SELECT 
	  	p.Departure, f.Arrival, 
	  	p.stops + 1,
		-- Add the layover airport to the route for each recursion step
	  	p.route + ' -> ' + f.Arrival
	FROM flightPlan f, flight_route p
	WHERE p.Arrival = f.Departure AND 
	      p.stops < 5)
	
SELECT 
	DISTINCT Arrival, 
    Departure, 
    route, 
    stops
FROM flight_route;


Add a totalCost field to the CTE and define it with the flight cost of the first flight.
Add the cost for each layover to the total costs.
Output the destinations where the totalCost is less than 500.

-- Define totalCost
WITH flight_route (Departure, Arrival, stops, totalCost, route) AS(
  	SELECT 
    	f.Departure, f.Arrival, 
    	0,
    	-- Define the totalCost with the flight cost of the first flight
    	Cost,
    	CAST(Departure + ' -> ' + Arrival AS NVARCHAR(MAX))
  	FROM flightPlan f
  	WHERE Departure = 'Vienna'
  	UNION ALL
  	SELECT 
    	p.Departure, f.Arrival, 
    	p.stops + 1,
    	-- Add the cost for each layover to the total costs
    	p.totalCost + f.Cost,
    	p.route + ' -> ' + f.Arrival
  	FROM flightPlan f, flight_route p
  	WHERE p.Arrival = f.Departure AND 
          p.stops < 5)

SELECT 
	DISTINCT Arrival, 
    totalCost
FROM flight_route
-- Limit the total costs to 500
WHERE totalCost < 500;


Create the parts list
The first step in creating a bill of material is to define a hierarchical data model. To do this, you have to create a table BillOfMaterial with the following fields:



The BillOfMaterial table describes the following hierarchy:



Your task is to define the field PartID as primary key, to define the field Cost, and to insert the following to records into the table:

Component: SUV, Title: BMW X1, Vendor: BMW, ProductKey: F48, Cost: 50000, Quantity: 1
Component: Wheels, Title: M-Performance 19/255, Vendor: BMW, ProductKey: MKQ134098URZ, Cost: 400, Quantity: 4
Instructions
100 XP
Define PartID as PRIMARY KEY of type INT.
Define Cost of type INT and not to be NULL.
Insert the root element SUV as described in the context section.
Insert the entry Wheels as described in the context section.

CREATE TABLE Bill_Of_Material (
	-- Define PartID as primary key of type INT
  	PartID INT NOT NULL PRIMARY KEY,
	SubPartID INT,
	Component VARCHAR(255) NOT NULL,
	Title  VARCHAR(255) NOT NULL,
	Vendor VARCHAR(255) NOT NULL,
  	ProductKey CHAR(32) NOT NULL,
  	-- Define Cost of type INT and NOT NULL
  	Cost INT NOT NULL,
	Quantity INT NOT NULL);

-- Insert the root element SUV as described
INSERT INTO Bill_Of_Material
VALUES ('1',NULL,'SUV','BMW X1','BMW','F48',50000,1);
INSERT INTO Bill_Of_Material
VALUES ('2','1','Engine','V6BiTurbro','BMW','EV3891ASF',3000,1);
INSERT INTO Bill_Of_Material
VALUES ('3','1','Body','AL_Race_Body','BMW','BD39281PUO',5000,1);
INSERT INTO Bill_Of_Material
VALUES ('4','1','Interior Decoration','All_Leather_Brown','BMW','ZEU198292',2500,1);
-- Insert the entry Wheels as described
INSERT INTO Bill_Of_Material
VALUES ('5','1','Wheels','M-Performance 19/255','BMW','MKQ134098URZ',400,4);

SELECT * 
FROM Bill_Of_Material;


Create a car's bill of material
In this exercise, you will answer the following question: What are the levels of the different components that build up a car?

For example, an SUV (1st level), is made of an engine (2nd level), and a body (2nd level), and the body is made of a door (3rd level) and a hood (3rd level).

Your task is to create a query to get the hierarchy level of the table partList. You have to create the CTE construction_Plan and should keep track of the position of a component in the hierarchy. Keep track of all components starting at level 1 going up to level 2.

Instructions
100 XP
Instructions
100 XP
Define construction_Plan with the fields: PartID, SubPartID, Title, Component and Level.
Initialize the field Level to 1.
Increase Level by 1 in every recursion step.
Limit the number of steps to Level = 2.

-- Define CTE with the fields: PartID, SubPartID, Title, Component, Level
WITH construction_Plan (PartID, SubPartID,Title, Component, Level) AS (
	SELECT 
  		PartID,
  		SubPartID,
  		Title,
  		Component,
  		-- Initialize the field Level
  		1
	FROM partList
	WHERE PartID = '1'
	UNION ALL
	SELECT 
		CHILD.PartID, 
  		CHILD.SubPartID,
  		CHILD.Title,
  		CHILD.Component,
  		-- Increment the field Level each recursion step
  		PARENT.Level + 1
	FROM construction_Plan PARENT, partList CHILD
  	WHERE CHILD.SubPartID = PARENT.PartID
  	-- Limit the number of iterations to Level < 2
	  AND PARENT.Level < 2)
      
SELECT DISTINCT PartID, SubPartID, Title, Component, Level
FROM construction_Plan
ORDER BY PartID, SubPartID, Level;



Build up a BMW?
In this exercise, you will answer the following question: What is the total required quantity Total of each component to build the car until level 3 in the hierarchy?

Your task is to create the CTE construction_Plan to track the level of components and to calculate the total quantity of components in the field Total. The table is set up by the fields PartID, SubPartID, Level, Component, and Total. You have to consider all components starting from level 1 up to level 3.

Instructions
100 XP
Instructions
100 XP
Define construction_Plan with the necessary fields.
Initialize Total with the Quantity in the anchor element of CTE.
Increase Total with the Quantity of the child element in the recursion element.
Use SUM() to create the sum of Total on the aggregated information on IDs of the hierarchy.

-- Define CTE with the fields: PartID, SubPartID, Level, Component, Total
WITH construction_Plan (PartID, SubPartID, Level, Component, Total) AS (
	SELECT 
  		PartID, SubPartID,
  		0,
  		Component,
  		-- Initialize Total
  		Quantity
	FROM partList
	WHERE PartID = '1'
	UNION ALL
	SELECT 
		CHILD.PartID, 
  		CHILD.SubPartID,
  		PARENT.Level + 1,
  		CHILD.Component,
  		-- Increase Total by the quantity of the child element
  		PARENT.Total + CHILD.Quantity
	FROM construction_Plan PARENT, partList CHILD
  	WHERE CHILD.SubPartID = PARENT.PartID
	  AND PARENT.Level < 3)
      
SELECT 
    PartID, SubPartID,Component,
    -- Calculate the sum of total on the aggregated information
    SUM(Total)
FROM construction_Plan
GROUP BY PartID, SubPartID, Component
ORDER BY PartID, SubPartID;


Create a power grid
In this exercise, you will create the structure table. This table describes how power lines are connected to each other. For this task, three ID values are needed:

EquipmentID: the unique key
EquipmentID_To: the first end of the power line with ID of the connected line
EquipmentID_From: the second end of the power line with ID of the connected line
The other fields to describe a power line, such as VoltageLevel and ConditionAssessment, are already defined.

An example is shown in the following picture:



For the line with EquipmentID = 3 the field EquipmentID_To is 4 and the field EquipmentID_From is 5.

Instructions
100 XP
Instructions
100 XP
CREATE the structure table.
Define the EquipmentID field as a PRIMARY KEY of type INT.
Insert the record for line 1: 1, 2, <no from line>, 'HV', 'Cable', 2000, 2016, 'good'
Insert the record for line 14: - 14, 15, 3, 'MV', 'Cable', 1976, 2002, 'bad'

-- Create the table
CREATE TABLE structure (
    -- Define the field EquipmentID 
  	EquipmentID INT NOT NULL PRIMARY KEY,
    EquipmentID_To INT ,
    EquipmentID_From INT, 
    VoltageLevel TEXT NOT NULL,
    Description TEXT NOT NULL,
    ConstructionYear INT NOT NULL,
    InspectionYear INT NOT NULL,
    ConditionAssessment TEXT NOT NULL
);

-- Insert the record for line 1 as described
INSERT INTO structure
VALUES ( 1, 2, NULL, 'HV', 'Cable', 2000, 2016, 'good');
INSERT INTO structure
VALUES ( 2, 3 , 1, 'HV', 'Overhead Line', 1968, 2016, 'bad');
INSERT INTO structure
VALUES ( 3, 14, 2, 'HV', 'TRANSFORMER', 1972, 2001, 'good');
-- Insert the record for line 14 as described
INSERT INTO Structure
VALUES ( 14, 15, 3, 'MV', 'Cable', 1976, 2002, 'bad');

SELECT * 
FROM structure



Get power lines to maintain
In the provided GridStructure table, the fields that describe the connection between lines (EquipmentID,EquipmentID_To,EquipmentID_From) and the characteristics of the lines (e.g. Description, ConditionAssessment, VoltageLevel) are already defined.

Now, your task is to find the connected lines of the line with EquipmentID = 3 that have bad or repair as ConditionAssessment and have a VoltageLevel equal to HV. By doing this, you can answer the following question:

Which lines have to be replaced or repaired according to their description and their current condition?

You have to create a CTE to find the connected lines and finally, to filter on the desired characteristics.

Instructions
100 XP
Instructions
100 XP
Define the CTE maintenance_List.
Start the evaluation for line 3.
Join GridStructure with maintenance_List on the corresponding endpoints.
Use LIKE to filter the power lines with ConditionAssessment of either exchange or repair, and a VoltageLevel of HV.

-- Define the table CTE 
WITH maintenance_List (Line, Destination, Source, Description, ConditionAssessment, VoltageLevel) AS (
	SELECT 
  		EquipmentID,
  		EquipmentID_To,
  		EquipmentID_From,
  		Description,
  		ConditionAssessment,
  		VoltageLevel
  	FROM GridStructure
 	-- Start the evaluation for line 3
	WHERE EquipmentID = 3
	UNION ALL
	SELECT 
		Child.EquipmentID, 
  		Child.EquipmentID_To,
  		Child.EquipmentID_FROM,
  		Child.Description,
  		Child.ConditionAssessment,
  		Child.VoltageLevel
	FROM GridStructure Child
  		-- Join GridStructure with CTE on the corresponding endpoints
  		JOIN maintenance_List 
    	ON maintenance_List.Line = Child.EquipmentID_FROM)
SELECT Line, Description, ConditionAssessment 
FROM maintenance_List
-- Filter the lines based on ConditionAssessment and VoltageLevel
WHERE 
    (ConditionAssessment LIKE '%exchange%' OR ConditionAssessment LIKE '%repair%') AND 
     VoltageLevel LIKE '%HV%'



