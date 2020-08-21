Working with different types of data
The examples in this course are based on a data set about chocolate ratings (one of the most commonly consumed candies in the world).

This data set contains

The ratings table: information about chocolate bars: the origin of the beans, percentage of cocoa and the rating of each bar.
The voters table: details about the people who participate in the voting process. It contains personal information of a voter: first and last name, email address, gender, country, the first time they voted and the total number of votes.
In this exercise, you will take a look at different types of data.

Instructions 1/2
50 XP
Instructions 1/2
50 XP
Select information from the ratings table for the Belgian companies that received a rating higher than 3.5.

Query the voters table where birthdate is greater than '1990-01-01' and the total_votes is between 100 and 200.

SELECT 
	company, 
	company_location, 
	bean_origin, 
	cocoa_percent, 
	rating
FROM ratings
-- Location should be Belgium and the rating should exceed 3.5
WHERE company_location = 'Belgium'
	AND rating > 3.5;

SELECT 
	first_name,
	last_name,
	birthdate,
	gender,
	email,
	country,
	total_votes
FROM voters
-- Birthdate > 1990-01-01, total_votes > 100 but < 200
WHERE Birthdate > '1990-01-01'
  AND total_votes > 100
  AND total_votes < 200;


Storing dates in a database
In this exercise, you will practice your knowledge of the different data types you can use in SQL Server. You will add more columns to the voters table and decide which is the most appropriate data type for each of them.

The syntax for adding a new column in a table is the following:

ALTER TABLE table_name
ADD column_name data_type
Remember, the most common date/time data types are:

date
time
datetime
datetime2
smalldatetime.
Instructions 1/3
1 XP
Instructions 1/3
1 XP
Add a new column with the correct data type, for storing the last date a person voted ("2018-01-17").

Add a new column called last_vote_time, to keep track of the most recent time when a person voted ("16:55:00").

Add a new column,last_login, storing the most recent time a person accessed the application ("2019-02-02 13:44:00").

ALTER TABLE voters
ADD last_vote_date date;

ALTER TABLE voters
ADD last_vote_time time;

ALTER TABLE voters
ADD last_login datetime2;


Types of character strings
To what data category does the nvarchar type belong?

Answer the question
50 XP
Possible Answers
Exact numerics

Date and time

Unicode character strings
press
3
Other data types


Implicit conversion between data types
This is what you need to remember about implicit conversion:

For comparing two values in SQL Server, they need to have the same data type.
If the data types are different, SQL Server implicitly converts one type to another, based on data type precedence.
The data type with the lower precedence is converted to the data type with the higher precedence.
In this exercise, you are going to test if explicit conversion works between a numeric type and a character. use information from the conversion table, where the implicit and explicit conversions between all data types are presented. You are going to try an implicit conversion between two different data types.

For this, you will use the voters table and will compare the total_votes numeric column with a character.

Instructions 1/2
50 XP
Instructions 1/2
50 XP
Restrict the query to show only the rows where total_votes is higher than the character string '120

SELECT 
	first_name,
	last_name,     
	total_votes
FROM voters
WHERE total_votes>120

Question
What kind of implicit conversion is performed by SQL Server to make this query execute successfully?
Possible Answers
The values from the total_votes column are converted to a character type.
The values from the total_votes column and the character '120' are converted to an intermediary data type, because comparing data works only when the data types are identical.
The character '120' is converted to a numeric type.

The character '120' is converted to a numeric type.


Data type precedence
In this exercise, you will evaluate the rating information from the ratings table and you will see what happens when a decimal value is compared to an integer. Remember: in SQL Server, data is implicitly converted behind the scenes from one type to another, in such a way that no data loss occurs.

Instructions 1/2
50 XP
Select information about all the ratings that were higher than 3.

SELECT 
	bean_type,
	rating
FROM ratings
WHERE rating>3;

Question
Taking into account that the rating column is a decimal, which statement is true about the execution of this query?
Possible Answers
The values from the rating column are converted to int, because int has higher precedence than decimal.
The integer value is converted to decimal because decimal has higher precedence than int.
No conversion is performed because decimal and integer numbers can be compared as they are.

The integer value is converted to decimal because decimal has higher precedence than int.


CASTing data
It happens often to need data in a certain type or format and to find that it's stored differently. For example:

Integrating data from multiple sources, having different data types, into a single one
Abstract data should be more readable (i.e. True/False instead of 1/0) Luckily, you don't need to make any changes in the data itself. You can use functions for explicitly converting to the data type you need (using CAST() and CONVERT()).
You are now going to explicitly convert data using the CAST() function. Remember the syntax:

CAST(expression AS data_type [(length)])
Instructions 1/3
25 XP
Instructions 1/3
25 XP
Write a query that will show a message like the following, for each voter: Carol Rai was born in 1989.

Divide the total votes by 5.5. Transform the result to an integer.

Select the voters whose total number of votes starts with 5.


SELECT 
	-- Transform the year part from the birthdate to a string
	first_name + ' ' + last_name + ' was born in ' + CAST(YEAR(birthdate) AS nvarchar) + '.' 
FROM voters;

SELECT
    -- Transform to int the division of total_votes to 5.5
	CAST(total_votes/5.5 AS int) AS DividedVotes
FROM voters;

SELECT 
	first_name,
	last_name,
	total_votes
FROM voters
-- Transform the total_votes to char of length 10
WHERE CAST(total_votes AS char(10)) LIKE '5%';


CONVERTing data
Another important function similar to CAST() is CONVERT(). They are very similar in functionality, with the exception that with CONVERT() you can use a style parameter for changing the aspect of a date. Also, CONVERT() is SQL Server specific, so its performance is slightly better than CAST(). Nonetheless, it's important to know how to use both of them.

In this exercise, you are going to enhance your knowledge of the CONVERT() function.

Instructions 1/3
0 XP
Instructions 1/3
0 XP
Retrieve the birth date from voters, in this format: Mon dd,yyyy.

Select the company, bean origin and the rating from the ratings table. The rating should be converted to a whole number.

Select the company, bean origin and the rating from the ratings table where the whole part of the rating equals 3.

SELECT 
	email,
    -- Convert birthdate to varchar show it as follows: "Mon dd,yyyy" 
    CONVERT(varchar, birthdate, 107) AS birthdate
FROM voters;

SELECT 
	company,
    bean_origin,
    -- Convert the rating column to an integer
    CONVERT(int, rating) AS rating
FROM ratings;

SELECT 
	company,
    bean_origin,
    rating
FROM ratings
-- Convert the rating to an integer before comparison
WHERE CONVERT(int, rating) = 3;


Working with the correct data types
It’s now time to practice your understanding of various data types in SQL Server and how to convert them from one type to another. In this exercise, you will query the voters table. Remember that this table holds information about the people who provided ratings for the different chocolate flavors.

You are going to write a query that returns information (first name, last name, gender, country, number of times they voted) about the female voters from Belgium, who voted more than 20 times.

You will work with columns of different data types and perform both implicit and explicit conversions between different types of data (using CAST() and CONVERT() functions).

It sounds like a big query, but we will take it step-by-step and you will see the results in no time!

Instructions 1/3
35 XP
Instructions 1/3
35 XP
Restrict the query to retrieve only the female voters who voted more than 20 times.

SELECT 
	first_name,
	last_name,
	gender,
	country
FROM voters
WHERE country = 'Belgium'
	-- Select only the female voters
	AND gender='F'
    -- Select only people who voted more than 20 times   
    AND total_votes>20;

Now that we have the data set prepared, let’s make it more user-friendly. Perform an explicit conversion from datetime to varchar(10), to show the dates as yy/mm/dd.

SELECT 
	first_name,
    last_name,
	-- Convert birthdate to varchar(10) and show it as yy/mm/dd. This format corresponds to value 11 of the "style" parameter.
	CONVERT(varchar(10), birthdate, 11) AS birthdate,
    gender,
    country
FROM voters
WHERE country = 'Belgium' 
    -- Select only the female voters
	AND gender = 'F'
    -- Select only people who voted more than 20 times   
    AND total_votes > 20;

Let’s now create a comments column that will show the number of votes performed by each person, in the following form: “Voted "x" times.”

SELECT
	first_name,
    last_name,
	-- Convert birthdate to varchar(10) to show it as yy/mm/dd
	CONVERT(varchar(10), birthdate, 11) AS birthdate,
    gender,
    country,
    -- Convert the total_votes number to nvarchar
    'Voted ' + CAST(total_votes AS nvarchar) + ' times.' AS comments
FROM voters
WHERE country = 'Belgium'
    -- Select only the female voters
	AND gender = 'F'
    -- Select only people who voted more than 20 times
    AND total_votes > 20;


Get the know the system date and time functions
The purpose of this exercise is for you to work with the system date and time functions and see how you can use them in SQL Server. Whether you just want to discover what day it is or you are performing complex time analysis, these functions will prove to be very helpful in many situations.

In this exercise, you will familiarize yourself with the most commonly used system date and time functions. These are:

Higher Precision

SYSDATETIME()
SYSUTCDATETIME()
SYSDATETIMEOFFSET()
Lower Precision

GETDATE()
GETUTCDATE()
CURRENT_TIMESTAMP
Instructions 1/3
35 XP
Instructions 1/3
35 XP
Use the most common date function for retrieving the current date.

Select the current date in UTC time (Universal Time Coordinate) using two different functions.

Select the local system's date, including the timezone information.

SELECT 
	GETDATE() AS CurrentDate;

SELECT 
	SYSUTCDATETIME() AS UTC_HighPrecision,
	GETUTCDATE() AS UTC_LowPrecision;

SELECT 
	GETUTCDATE() AS Timezone;


Selecting parts of the system's date and time
In this exercise, you will retrieve only parts of the system's date and time, focusing on only the date or only the time. You will use the same date and time functions, but you will use CAST() and CONVERT() to transform the results to a different data type.

Instructions 1/2
0 XP
Use two functions to query the system's local date, without timezone information. Show the dates in different formats.

SELECT 
	CONVERT(VARCHAR(24), SYSDATETIME(), 107) AS HighPrecision,
	CONVERT(VARCHAR(24), GETDATE(), 102) AS LowPrecision;

Use two functions to retrieve the current time, in Universal Time Coordinate.

SELECT 
	CAST(SYSUTCDATETIME() AS time) AS HighPrecision,
	CAST(GETUTCDATE() AS time) AS LowPrecision;


Extracting parts from a date
In this exercise, you will practice extracting date parts from a date, using SQL Server built-in functions. These functions are easy to apply and you can also use them in the WHERE clause, to restrict the results returned by the query.

You will start by querying the voters table and create new columns by extracting the year, month, and day from the first_vote_date.

Instructions 1/3
1 XP
Instructions 1/3
1 XP
Extract the year, month and day of the first vote.

SELECT 
	first_name,
	last_name,
   	-- Extract the year of the first vote
	YEAR(first_vote_date)  AS first_vote_year,
    -- Extract the month of the first vote
	MONTH(first_vote_date) AS first_vote_month,
    -- Extract the day of the first vote
	DAY(first_vote_date)   AS first_vote_day
FROM voters;

Restrict the query to show only the voters who started to vote after 2015.

SELECT 
	first_name,
	last_name,
   	-- Extract the year of the first vote
	YEAR(first_vote_date)  AS first_vote_year,
    -- Extract the month of the first vote
	MONTH(first_vote_date) AS first_vote_month,
    -- Extract the day of the first vote
	DAY(first_vote_date)   AS first_vote_day
FROM voters
-- The year of the first vote should be greater than 2015
WHERE YEAR(first_vote_date) > 2015;

Restrict the query to show only the voters did not vote on the first day of the month.

SELECT 
	first_name,
	last_name,
   	-- Extract the year of the first vote
	YEAR(first_vote_date)  AS first_vote_year,
    -- Extract the month of the first vote
	MONTH(first_vote_date) AS first_vote_month,
    -- Extract the day of the first vote
	DAY(first_vote_date)   AS first_vote_day
FROM voters
-- The year of the first vote should be greater than 2015
WHERE YEAR(first_vote_date) > 2015
-- The day should not be the first day of the month
  AND DAY(first_vote_date) <> 1;


Generating descriptive date parts
DATENAME() is an interesting and easy to use function. When you create reports, for example, you may want to show parts of a date in a more understandable manner (i.e. January instead of 1). This is when the DATENAME() function proves its value. This function will return a string value with a description of the date part you are interested in.

In this exercise, you will become familiar with DATENAME(), by using it to retrieve different date parts. You will work with the first_vote_date column from the voters table.

Instructions 1/3
1 XP
Select information from the voters table, including the name of the month when they first voted.

Select information from the voters table, including the day of the year when they first voted.

Select information from the voters table, including the day of the week when they first voted.

SELECT 
	first_name,
	last_name,
	first_vote_date,
    -- Select the name of the month of the first vote
	DATENAME(MONTH, first_vote_date) AS first_vote_month
FROM voters;

SELECT 
	first_name,
	last_name,
	first_vote_date,
    -- Select the number of the day within the year
	DATENAME(DAYOFYEAR, first_vote_date) AS first_vote_dayofyear
FROM voters;

SELECT 
	first_name,
	last_name,
	first_vote_date,
    -- Select day of the week from the first vote date
	DATENAME(weekday, first_vote_date) AS first_vote_dayofweek
FROM voters;


Presenting parts of a date
DATENAME() and DATEPART() are two similar functions. The difference between them is that while the former understandably shows some date parts, as strings of characters, the latter returns only integer values.

In this exercise, you will use both of these functions to select the month and weekday of the first_vote_date in different forms.

Instructions
100 XP
Instructions
100 XP
Extract the month number of the first vote.
Extract the month name of the first vote.
Extract the weekday number of the first vote.
Extract the weekday name of the first vote.

SELECT 
	first_name,
	last_name,
   	-- Extract the month number of the first vote
	DATEPART(MONTH, first_vote_date) AS first_vote_month1,
	-- Extract the month name of the first vote
    DATENAME(MONTH, first_vote_date) AS first_vote_month2,
	-- Extract the weekday number of the first vote
	DATEPART(WEEKDAY, first_vote_date) AS first_vote_weekday1,
    -- Extract the weekday name of the first vote
	DATENAME(WEEKDAY, first_vote_date) AS first_vote_weekday2
FROM voters;


Creating a date from parts
While most functions you worked with so far extract parts from a date, DATEFROMPARTS() does exactly the opposite: it creates a date from three numbers, representing the year, month and the day.

The syntax is: DATEFROMPARTS(year, month, day)

You can also use expressions that return numeric values as parameters for this function, like this: DATEFROMPARTS(YEAR(date_expression), MONTH(date_expression), 2)

In this exercise, you will select information from the voters table, including the year and the month of the first_vote_date. Then, you will create a new date column representing the first day in the month of the first vote.

Instructions
100 XP
Instructions
100 XP
Select the year of the first vote.
Select the month of the first vote date.
Create a date as the start of the month of the first vote.

SELECT 
	first_name,
	last_name,
    -- Select the year of the first vote
   	YEAR(first_vote_date) AS first_vote_year, 
    -- Select the month of the first vote
	MONTH(first_vote_date) AS first_vote_month,
    -- Create a date as the start of the month of the first vote
	DATEFROMPARTS(YEAR(first_vote_date), MONTH(first_vote_date), 1) AS first_vote_starting_month
FROM voters;


Arithmetic operations with dates
In this exercise, you will perform arithmetic operations on dates in two different ways: using the arithmetic operators ("+" and "-") and also using the DATEDIFF() function. You will use these variables:

DECLARE @date1 datetime = '2018-12-01';
DECLARE @date2 datetime = '2030-03-03';
Create a SELECT statement, in which to perform the following operations:

Subtract @date1 from @date2.
Add @date1 to @date2.
Using DATEDIFF(), calculate the difference in years between the results of the subtraction and the addition above.
What is the result returned by the DATEDIFF() function?

Instructions
50 XP
Instructions
50 XP
Possible Answers
0 years
238 years
261 years
23 years

238 years


Modifying the value of a date
Adding different date parts to a date expression proves to be useful in many scenarios. You can calculate, for example:

The delivery date of an order, by adding 3 days to the order date
The dates when a bonus is received, knowing that they are received every 3 months, starting with a certain date.
In SQL Server, you can use DATEADD() for adding date parts to a date. In this exercise, you will get familiar with this function.

Instructions 1/3
1 XP
Retrieve the date when each voter had their 18th birthday.

Add five days to the first_vote_date, to calculate the date when the vote was processed.

Calculate what day it was 476 days ago.

SELECT 
	first_name,
	birthdate,
    -- Add 18 years to the birthdate
	DATEADD(YEAR, 18, birthdate) AS eighteenth_birthday
  FROM voters;

SELECT 
	first_name,
	first_vote_date,
    -- Add 5 days to the first voting date
	DATEADD(DAY, 5, first_vote_date) AS processing_vote_date
  FROM voters;

SELECT
	-- Subtract 476 days from the current date
	DATEADD(DAY, -476, GETDATE()) AS date_476days_ago;


Calculating the difference between dates
DATEDIFF() is one of the most commonly-known functions for manipulating dates. It is used for retrieving the number of time units between two dates. This function is useful for calculating, for example:

How many years have passed since a specific event.
The age of a person at a point in time.
How many minutes it takes to process an order in a restaurant.
In almost all business scenarios you can find an example for which using this function proves to be useful.

In this exercise, you will use DATEDIFF() to perform calculations with the dates stored in the voters table.

Instructions 1/2
0 XP
Instructions 1/2
0 XP
Calculate the number of years since a participant celebrated their 18th birthday until the first time they voted.

How many weeks have passed since the beginning of 2019 until now?

SELECT
	first_name,
	birthdate,
	first_vote_date,
    -- Select the diff between the 18th birthday and first vote
	DATEDIFF(YEAR, DATEADD(YEAR, 18, birthdate), first_vote_date) AS adult_years_until_vote
FROM voters;

SELECT 
	-- Get the difference in weeks from 2019-01-01 until now
	DATEDIFF(WEEK, '2019-01-01', GETDATE()) AS weeks_passed;


Changing the date format
Remember that SQL Server can interpret character strings that look like dates in a different way than you would expect. Depending on your settings, the string "29-04-2019" could be interpreted as the 29th of April, or an error can be thrown that the conversion to a date was not possible. In the first situation, SQL Server expects a day-month-year format, while in the second, it probably expects a month-day-year and the 29th month does not exist.

In this exercise, you will instruct SQL Server what kind of date format you want to use.

Instructions 1/4
1 XP
Instructions 1/4
1 XP
Set the correct date format so that the variable @date1 is interpreted as a valid date.

Set the correct date format so that the variable @date1 is interpreted as a valid date.

Set the correct date format so that the variable @date1 is interpreted as a valid date.

Set the correct date format so that the variable @date1 is interpreted as a valid date.

DECLARE @date1 NVARCHAR(20) = '2018-30-12';

-- Set the date format and check if the variable is a date
SET DATEFORMAT ydm;
SELECT ISDATE(@date1) AS result;

DECLARE @date1 NVARCHAR(20) = '15/2019/4';

-- Set the date format and check if the variable is a date
SET DATEFORMAT dym;
SELECT ISDATE(@date1) AS result;

DECLARE @date1 NVARCHAR(20) = '10.13.2019';

-- Set the date format and check if the variable is a date
SET DATEFORMAT mdy;
SELECT ISDATE(@date1) AS result;

DECLARE @date1 NVARCHAR(20) = '18.4.2019';

-- Set the date format and check if the variable is a date
SET DATEFORMAT dmy;
SELECT ISDATE(@date1) AS result;


Changing the default language
The language set in SQL Server can influence the way character strings are interpreted as dates. Changing the language automatically updates the date format. In this exercise, you will analyze the impact of the SET LANGUAGE command on some practical examples. You will select between the English, Croatian, and Dutch language, taking into account that they use the following formats:

Language	Date format
English	mdy
Croatian	ymd
Dutch	dmy
Instructions 1/3
1 XP
Instructions 1/3
1 XP
Change the language, so that '30.03.2019' is considered a valid date. Select the name of the month.

Change the language, so that '32/12/13' is interpreted as a valid date. Select the name of the month. Select the year.

Change the language, so that '12/18/55' is interpreted as a valid date. Select the day of week. Select the year.

DECLARE @date1 NVARCHAR(20) = '30.03.2019';

-- Set the correct language
SET LANGUAGE Dutch;
SELECT
	@date1 AS initial_date,
    -- Check that the date is valid
	ISDATE(@date1) AS is_valid,
    -- Select the name of the month
	DATENAME(MONTH, @date1) AS month_name;

DECLARE @date1 NVARCHAR(20) = '32/12/13';

-- Set the correct language
SET LANGUAGE Croatian;
SELECT
	@date1 AS initial_date,
    -- Check that the date is valid
	ISDATE(@date1) AS is_valid,
    -- Select the name of the month
	DATENAME(MONTH, @date1) AS month_name,
	-- Extract the year from the date
	YEAR(@date1) AS year_name;

DECLARE @date1 NVARCHAR(20) = '12/18/55';

-- Set the correct language
SET LANGUAGE English;
SELECT
	@date1 AS initial_date,
    -- Check that the date is valid
	ISDATE(@date1) AS is_valid,
    -- Select the week day name
	DATENAME(WEEKDAY, @date1) AS week_day,
	-- Extract the year from the date
	YEAR(@date1) AS year_name;


Correctly applying different date functions
It's time to combine your knowledge on date functions!

In this exercise, you are going to extract information about each voter and the first time they voted. In the voters table, the date of the first vote is stored in the first_vote_date column.

You will use several date functions, like: DATENAME(), DATEDIFF(), YEAR(), GETDATE().

Instructions 1/4
1 XP
Extract the weekday from the first_vote_date.

SELECT
	first_name,
    last_name,
    birthdate,
	first_vote_date,
	-- Find out on which day of the week each participant voted 
	DATENAME(weekday, first_vote_date) AS first_vote_weekday
FROM voters;

Find out the year when each person voted for the first time.

SELECT
	first_name,
    last_name,
    birthdate,
	first_vote_date,
	-- Find out on which day of the week each participant voted 
	DATENAME(weekday, first_vote_date) AS first_vote_weekday,
	-- Find out the year of the first vote
	YEAR(first_vote_date) AS first_vote_year	
FROM voters;

Calculate the age of each participant when they first joined the voting contest.

SELECT
	first_name,
    last_name,
    birthdate,
	first_vote_date,
	-- Find out on which day of the week each participant voted 
	DATENAME(weekday, first_vote_date) AS first_vote_weekday,
	-- Find out the year of the first vote
	YEAR(first_vote_date) AS first_vote_year,
	-- Find out the age of each participant when they joined the contest
	DATEDIFF(YEAR, birthdate, first_vote_date) AS age_at_first_vote	
FROM voters;

Calculate the current age of each participant. Remember that you can use functions as parameters for other functions.

SELECT
	first_name,
    last_name,
    birthdate,
	first_vote_date,
	-- Find out on which day of the week each participant voted 
	DATENAME(weekday, first_vote_date) AS first_vote_weekday,
	-- Find out the year of the first vote
	YEAR(first_vote_date) AS first_vote_year,
	-- Discover the participants' age when they joined the contest
	DATEDIFF(YEAR, birthdate, first_vote_date) AS age_at_first_vote,	
	-- Calculate the current age of each voter
	DATEDIFF(YEAR, birthdate, GETDATE()) AS current_age
FROM voters;


Calculating the length of a string
It is important to know how to calculate the length of the strings stored in a database. You may need to calculate the product with the shortest name or the person with the longest email address.

Calculating the length of a string also proves to be useful in data cleansing and validation tasks. For example, if a business rule is that all product codes must have at least 6 characters, you can easily find the ones that are shorter.

In SQL Server, you can use the LEN() function for calculating the length of a string of characters.

You will use it in this exercise to calculate the location with the longest name from where cocoa beans are used (column broad_bean_origin, from the ratings table).

Instructions
100 XP
Instructions
100 XP
Calculate the length of each broad_bean_origin.
Order the results from the longest to shortest.

SELECT TOP 10 
	company, 
	broad_bean_origin,
	-- Calculate the length of the broad_bean_origin column
	LEN(broad_bean_origin) AS length
FROM ratings
--Order the results based on the new column, descending
ORDER BY Length DESC;


Looking for a string within a string
If you need to check whether an expression exists within a string, you can use the CHARINDEX() function. This function returns the position of the expression you are searching within the string.

The syntax is: CHARINDEX(expression_to_find, expression_to_search [, start_location])

In this exercise, you are going to use the voters table to search for information about the voters whose names meet several conditions.

Instructions 1/3
1 XP
Instructions 1/3
1 XP
Restrict the query to select only the voters whose first name contains the expression "dan".

Restrict the query to select the voters with "dan" in the first_name and "z" in the last_name.

Restrict the query to select the voters with "dan" in the first_name and DO NOT have the letter "z" in the last_name.

SELECT 
	first_name,
	last_name,
	email 
FROM voters
-- Look for the "dan" expression in the first_name
WHERE CHARINDEX('dan', first_name) > 0;

SELECT 
	first_name,
	last_name,
	email 
FROM voters
-- Look for the "dan" expression in the first_name
WHERE CHARINDEX('dan', first_name) > 0 
    -- Look for last_names that contain the letter "z"
	AND CHARINDEX('z', last_name) > 0;

SELECT 
	first_name,
	last_name,
	email 
FROM voters
-- Look for the "dan" expression in the first_name
WHERE CHARINDEX('dan', first_name) > 0 
    -- Look for last_names that do not contain the letter "z"
	AND CHARINDEX('z', last_name) = 0;


Looking for a pattern within a string
If you want to search for a pattern in a string, PATINDEX() is the function you are looking for. This function returns the starting position of the first occurrence of the pattern within the string.

The syntax is: PATINDEX('%pattern%', expression)

pattern	match
%	any string of zero or more characters
_	any single character
[]	any single character within the range specified in brackets
In this exercise, you are going to use the voters table to look at information about the voters whose names follow a specified pattern.

Instructions 1/4
1 XP
Instructions 1/4
1 XP
Write a query to select the voters whose first name contains the letters "rr".

Write a query to select the voters whose first name starts with "C" and has "r" as the third letter.

Select the voters whose first name contains an "a" followed by other letters, then a "w", followed by other letters.

Write a query to select the voters whose first name contains one of these letters: "x", "w" or "q".

SELECT 
	first_name,
	last_name,
	email 
FROM voters
-- Look for first names that contain "rr" in the middle
WHERE PATINDEX('%rr%', first_name) > 0;

SELECT 
	first_name,
	last_name,
	email 
FROM voters
-- Look for first names that start with C and the 3rd letter is r
WHERE PATINDEX('C_r%', first_name) > 0;

SELECT 
	first_name,
	last_name,
	email 
FROM voters
-- Look for first names that have an "a" followed by 0 or more letters and then have a "w"
WHERE PATINDEX('%a%w%', first_name) > 0;

SELECT 
	first_name,
	last_name,
	email 
FROM voters
-- Look for first names that contain one of the letters: "x", "w", "q"
WHERE PATINDEX('%[xwq]%', first_name) > 0;


Changing to lowercase and uppercase
Most of the time, you can't make changes directly to the data from the database to make it look more user-friendly. However, when you query the data, you can control the aspect of the results, and you can make them easier to read.

Working with functions that manipulate string values is easy and gives great results. In this exercise, you will see how easy it is to work with the functions that transform the characters from a string to lowercase or uppercase. The purpose is to create a message mentioning the types of cocoa beans used by each company and their country of origin: The company BONNAT uses beans of type "Criollo", originating from VENEZUELA .

Instructions 1/3
1 XP
Select information from the ratings table, excluding the unknown broad_bean_origins.
Convert the broad_bean_origins to lowercase when comparing it to the '%unknown%' expression.

SELECT 
	company,
	bean_type,
	broad_bean_origin,
	'The company ' +  company + ' uses beans of type "' + bean_type + '", originating from ' + broad_bean_origin + '.'
FROM ratings
WHERE 
    -- The 'broad_bean_origin' should not be unknown
	LOWER(broad_bean_origin) NOT LIKE '%unknown%';


Restrict the query to make sure that the bean_type is not unknown.
Convert the bean_type to lowercase and compare it with an expression that contains the '%unknown%' word.

SELECT 
	company,
	bean_type,
	broad_bean_origin,
	'The company ' +  company + ' uses beans of type "' + bean_type + '", originating from ' + broad_bean_origin + '.'
FROM ratings
WHERE 
    -- The 'broad_bean_origin' should not be unknown
	LOWER(broad_bean_origin) NOT LIKE '%unknown%'
     -- The 'bean_type' should not be unknown
    AND LOWER(bean_type) NOT LIKE '%unknown%';

Format the message so that company and broad_bean_origin are uppercase.

SELECT 
	company,
	bean_type,
	broad_bean_origin,
    -- 'company' and 'broad_bean_origin' should be in uppercase
	'The company ' +  UPPER(company) + ' uses beans of type "' + bean_type + '", originating from ' + UPPER(broad_bean_origin) + '.'
FROM ratings
WHERE 
    -- The 'broad_bean_origin' should not be unknown
	LOWER(broad_bean_origin) NOT LIKE '%unknown%'
     -- The 'bean_type' should not be unknown
    AND LOWER(bean_type) NOT LIKE '%unknown%';


Using the beginning or end of a string
Sometimes you may need to take only certain parts of a string. If you know that those parts can be found at the beginning or the end of the string, remember that there are built-in functions that can help you with this task.

You will use these functions in this exercise. The purpose is to create an alias for each voter from the voters table, as a combination of the first 3 letters from the first name, the last 3 letters from the last name, and the last 2 digits from the birthday.

Instructions 1/4
1 XP
Instructions 1/4
1 XP
Select information from the voters table, including a new column called part1, containing only the first 3 letters from the first name.

SELECT 
	first_name,
	last_name,
	country,
    -- Select only the first 3 characters from the first name
	LEFT(first_name, 3) AS part1
FROM voters;

Add a new column to the previous query, containing the last 3 letters from the last name.

SELECT 
	first_name,
	last_name,
	country,
    -- Select only the first 3 characters from the first name
	LEFT(first_name, 3) AS part1,
    -- Select only the last 3 characters from the last name
    RIGHT(last_name, 3) AS part2
FROM voters;

Add another column to the previous query, containing the last 2 digits from the birth date.

SELECT 
	first_name,
	last_name,
	country,
    -- Select only the first 3 characters from the first name
	LEFT(first_name, 3) AS part1,
    -- Select only the last 3 characters from the last name
    RIGHT(last_name, 3) AS part2,
    -- Select only the last 2 digits from the birth date
    RIGHT(birthdate, 2) AS part3
FROM voters;

Create an alias for each voter with the following parts: the first 3 letters from the first name concatenated with the last 3 letters from the last name, followed by the _ character and the last 2 digits from the birth date.

SELECT 
	first_name,
	last_name,
	country,
    -- Select only the first 3 characters from the first name
	LEFT(first_name, 3) AS part1,
    -- Select only the last 3 characters from the last name
    RIGHT(last_name, 3) AS part2,
    -- Select only the last 2 digits from the birth date
    RIGHT(birthdate, 2) AS part3,
    -- Create the alias for each voter
    LEFT(first_name, 3) + RIGHT(last_name, 3) + '_' +  RIGHT(birthdate, 2) 
FROM voters;


Extracting a substring
In this exercise, you will extract parts of a string. You will work with data from the voters table.

There is a built-in function that can help you with this task. The parameters required by this function are:

the expression from which the substring is extracted;
the starting position of the substring
and its length.
Keep in mind that the position of the first character in a string is 1, not 0. This will help you to correctly calculate the starting position of the substring.

Instructions 1/2
0 XP
Instructions 1/2
0 XP
Select 5 characters from the email address, starting with position 3.

Extract the fruit names from the following sentence: "Apples are neither oranges nor potatoes".

SELECT 
	email,
    -- Extract 5 characters from email, starting at position 3
	SUBSTRING(email, 3, 5) AS some_letters
FROM voters;

DECLARE @sentence NVARCHAR(200) = 'Apples are neither oranges nor potatoes.'
SELECT
	-- Extract the word "Apples" 
	SUBSTRING(@sentence, 1, 6) AS fruit1,
    -- Extract the word "oranges"
	SUBSTRING(@sentence, 20, 7) AS fruit2;


Replacing parts of a string
Sometimes, you need to replace characters from a string with something else.

For example, if a name was inserted in a table with an extra character, you may want to fix the mistake.

If a company was acquired and changed its name, you need to replace the old company name with the new name in all documents stored in the database.

In this exercise, you will use a built-in function that replaces a part of a string with something else. For using the function correctly, you need to supply the following parameters:

the expression
the string to be found
the replacement string.
Instructions 1/3
1 XP
Instructions 1/3
1 XP
Add a new column in the query in which you replace the "yahoo.com" in all email addresses with "live.com".

Replace the character "&" from the company name with "and".

Remove the string "(Valrhona)" from the company name "La Maison du Chocolat (Valrhona)".

SELECT 
	first_name,
	last_name,
	email,
	-- Replace "yahoo.com" with "live.com"
	REPLACE(email, 'yahoo.com', 'live.com') AS new_email
FROM voters;

SELECT 
	company AS initial_name,
    -- Replace '&' with 'and'
	REPLACE(company, '&', 'and') AS new_name 
FROM ratings
WHERE CHARINDEX('&', company) > 0;

SELECT 
	company AS old_company,
    -- Remove the text '(Valrhona)' from the name
	REPLACE(company, '(Valrhona)', '') AS new_company,
	bean_type,
	broad_bean_origin
FROM ratings
WHERE company = 'La Maison du Chocolat (Valrhona)';


Concatenating data
Assembling a string from parts is done quite often in SQL Server. You may need to put together information from different columns and send the result as a whole to different applications. In this exercise, you will get familiar with the different options for concatenating data.

You will create a message similar to this one: "Chocolate with beans from Belize has a cocoa percentage of 0.6400".

The sentence is created by concatenating two string variables with data from the columns bean_origin and cocoa_percent, from the ratings table.

For restricting the number of results, the query will select only values for the company called "Ambrosia" and bean_type is not unknown.

Instructions 1/3
1 XP
Instructions 1/3
1 XP
Create a message similar to this one: "Chocolate with beans from Belize has a cocoa percentage of 0.6400" for each result of the query.
Use the + operator to concatenate data and the ' ' character as a separator

DECLARE @string1 NVARCHAR(100) = 'Chocolate with beans from';
DECLARE @string2 NVARCHAR(100) = 'has a cocoa percentage of';

SELECT 
	bean_type,
	bean_origin,
	cocoa_percent,
	-- Create a message by concatenating values with "+"
	@string1 + ' ' + bean_origin + ' ' + @string2 + ' ' + CAST(cocoa_percent AS nvarchar) AS message1
FROM ratings
WHERE 
	company = 'Ambrosia' 
	AND bean_type <> 'Unknown';

Create the same message, using the CONCAT() function.

DECLARE @string1 NVARCHAR(100) = 'Chocolate with beans from';
DECLARE @string2 NVARCHAR(100) = 'has a cocoa percentage of';

SELECT 
	bean_type,
	bean_origin,
	cocoa_percent,
	-- Create a message by concatenating values with "+"
	@string1 + ' ' + bean_origin + ' ' + @string2 + ' ' + CAST(cocoa_percent AS nvarchar) AS message1,
	-- Create a message by concatenating values with "CONCAT()"
	CONCAT(@string1, ' ', bean_origin, ' ', @string2, ' ', cocoa_percent) AS message2
FROM ratings
WHERE 
	company = 'Ambrosia' 
	AND bean_type <> 'Unknown';

Create the same message, using the CONCAT_WS() function. Evaluate the difference between this method and the previous ones.

DECLARE @string1 NVARCHAR(100) = 'Chocolate with beans from';
DECLARE @string2 NVARCHAR(100) = 'has a cocoa percentage of';

SELECT 
	bean_type,
	bean_origin,
	cocoa_percent,
	-- Create a message by concatenating values with "+"
	@string1 + ' ' + bean_origin + ' ' + @string2 + ' ' + CAST(cocoa_percent AS nvarchar) AS message1,
	-- Create a message by concatenating values with "CONCAT()"
	CONCAT(@string1, ' ', bean_origin, ' ', @string2, ' ', cocoa_percent) AS message2,
	-- Create a message by concatenating values with "CONCAT_WS()"
	CONCAT_WS(' ', @string1, bean_origin, @string2, cocoa_percent) AS message3
FROM ratings
WHERE 
	company = 'Ambrosia' 
	AND bean_type <> 'Unknown';


Aggregating strings
Usually, when we talk about concatenation, we mean putting together values from different columns. A common challenge for database developers is also to concatenate values from multiple rows. This was a task that required writing many lines of code and each developer had a personal implementation.

You can now achieve the same results using the STRING_AGG() function.

The syntax is: STRING_AGG(expression, separator) [WITHIN GROUP (ORDER BY expression)]

In this exercise, you will create a list with the origins of the beans for each of the following companies: 'Bar Au Chocolat', 'Chocolate Con Amor', 'East Van Roasters'.

Remember, for STRING_AGG() to work, you need to find a rule for grouping your data and use it in the GROUP BY clause.

Instructions 1/3
1 XP
Instructions 1/3
1 XP
Create a list with all the values found in the bean_origin column for the companies: 'Bar Au Chocolat', 'Chocolate Con Amor', 'East Van Roasters'. The values should be separated by commas (,).

SELECT
	-- Create a list with all bean origins, delimited by comma
	STRING_AGG(bean_origin, ',') AS bean_origins
FROM ratings
WHERE company IN ('Bar Au Chocolat', 'Chocolate Con Amor', 'East Van Roasters');

Create a list with the values found in the bean_origin column for each of the companies: 'Bar Au Chocolat', 'Chocolate Con Amor', 'East Van Roasters'. The values should be separated by commas (,).

SELECT 
	company,
    -- Create a list with all bean origins
	STRING_AGG(bean_origin, ',') AS bean_origins
FROM ratings
WHERE company IN ('Bar Au Chocolat', 'Chocolate Con Amor', 'East Van Roasters')
-- Specify the columns used for grouping your data
GROUP BY company;

Arrange the values from the list in alphabetical order.

SELECT 
	company,
    -- Create a list with all bean origins ordered alplabetically
	STRING_AGG(bean_origin, ',') WITHIN GROUP (ORDER BY bean_origin) AS bean_origins
FROM ratings
WHERE company IN ('Bar Au Chocolat', 'Chocolate Con Amor', 'East Van Roasters')
-- Specify the columns used for grouping your data
GROUP BY company;


Splitting a string into pieces
Besides concatenating multiple row values, a common task is to split a string into pieces.

Starting with SQL Server 2016, there is a built-in function for achieving this task: STRING_SPLIT(string, separator).

This function splits the string into substrings based on the separator and returns a table, each row containing a part of the original string.

Remember: because the result of the function is a table, it cannot be used as a column in the SELECT clause; you can only use it in the FROM clause, just like a normal table.

In this exercise, you will get familiar with this function.

Instructions 1/2
0 XP
Split the phrase declared in the variable @phrase into sentences (using the . separator).

Split the phrase declared in the variable @phrase into individual words.

DECLARE @phrase NVARCHAR(MAX) = 'In the morning I brush my teeth. In the afternoon I take a nap. In the evening I watch TV.'

SELECT value
FROM STRING_SPLIT(@phrase, '.');

DECLARE @phrase NVARCHAR(MAX) = 'In the morning I brush my teeth. In the afternoon I take a nap. In the evening I watch TV.'

SELECT value
FROM STRING_SPLIT(@phrase, ' ');


Applying various string functions on data
As you may have noticed, string functions are really useful for manipulating data. SQL Server offers a lot of built-in functions for string manipulation and some of them are quite fun to use. In this exercise, you are going to apply several string functions to the data from the voters table, to show it in a more presentable manner.

You will get the chance to use functions like: LEN(), UPPER(), PATINDEX(), CONCAT(), REPLACE() and SUBSTRING().

Remember: when searching for patterns within a string, these are the most helpful:

pattern	match
%	any string of zero or more characters
_	any single character
[]	any single character within the range specified in brackets
Instructions 1/3
1 XP
Instructions 1/3
1 XP
Select only the voters whose first name has fewer than 5 characters and email address meets these conditions in the same time: (1) starts with the letter “j”, (2) the third letter is “a” and (3) is created at yahoo.com.

SELECT
	first_name,
    last_name,
	birthdate,
	email,
	country
FROM voters
   -- Select only voters with a first name less than 5 characters
WHERE LEN(first_name) < 5
   -- Look for the desired pattern in the email address
	AND PATINDEX('j_a%@yahoo.com', email) > 0;

Concatenate the first name and last name in the same column and present it in this format: " *** Firstname LASTNAME *** ".

SELECT
    -- Concatenate the first and last name
	CONCAT('***' , first_name, ' ', UPPER(last_name), '***') AS name,
    last_name,
	birthdate,
	email,
	country
FROM voters
   -- Select only voters with a first name less than 5 characters
WHERE LEN(first_name) < 5
   -- Look for this pattern in the email address: "j%[0-9]@yahoo.com"
	AND PATINDEX('j_a%@yahoo.com', email) > 0;   

Mask the year part from the birthdate column, by replacing the last two digits with "XX" (1986-03-26 becomes 19XX-03-26).

SELECT
    -- Concatenate the first and last name
	CONCAT('***' , first_name, ' ', UPPER(last_name), '***') AS name,
    -- Mask the last two digits of the year
    REPLACE(birthdate, SUBSTRING(CAST(birthdate AS varchar), 3, 2), 'XX') AS birthdate,
	email,
	country
FROM voters
   -- Select only voters with a first name less than 5 characters
WHERE LEN(first_name) < 5
   -- Look for this pattern in the email address: "j%[0-9]@yahoo.com"
	AND PATINDEX('j_a%@yahoo.com', email) > 0;    


Learning how to count and add
In this exercise, you will get familiar with the function used for counting rows and the one that sums up values.

You will select information from the voters table and will calculate the number of female and male voters and the total number of votes for these groups.

Remember, for applying aggregate functions on groups of data, you need to use the GROUP BY statement.

Instructions
100 XP
Count the number of voters for each group.
Calculate the total number of votes per group.

SELECT 
	gender, 
	-- Count the number of voters for each group
	COUNT(*) AS voters,
	-- Calculate the total number of votes per group
	SUM(total_votes) AS total_votes
FROM voters
GROUP BY gender;


MINimizing and MAXimizing some results
Calculating the minimum, maximum or average value from a data set are common tasks when working with databases. You may need to calculate the maximum or minimum salary within a department or the average weight of some people going to the gym.

In this exercise, you will find out the average cocoa percentage used by each company in their chocolate bars.

You will also calculate the minimum and maximum score received by each company during the voting process.

Instructions 1/4
1 XP
Instructions 1/4
1 XP
Calculate the average percentage of cocoa used by each company.

SELECT 
	company,
	-- Calculate the average cocoa percent
	AVG(cocoa_percent) AS avg_cocoa
FROM ratings
GROUP BY company;

Calculate the minimum rating received by each company.

SELECT 
	company,
	-- Calculate the average cocoa percent
	AVG(cocoa_percent) AS avg_cocoa,
	-- Calculate the minimum rating received by each company
	MIN(rating) AS min_rating	
FROM ratings
GROUP BY company;

Calculate the maximum rating received by each company.

SELECT 
	company,
	-- Calculate the average cocoa percent
	AVG(cocoa_percent) AS avg_cocoa,
	-- Calculate the minimum rating received by each company
	MIN(rating) AS min_rating,
	-- Calculate the maximum rating received by each company
	MAX(rating) AS max_rating
FROM ratings
GROUP BY company;

Use an aggregate function to order the results of the query by the maximum rating, in descending order.

SELECT 
	company,
	-- Calculate the average cocoa percent
	AVG(cocoa_percent) AS avg_cocoa,
	-- Calculate the minimum rating received by each company
	MIN(rating) AS min_rating,
	-- Calculate the maximum rating received by each company
	MAX(rating) AS max_rating
FROM ratings
GROUP BY company
-- Order the values by the maximum rating
ORDER BY MAX(rating) DESC;


Accessing values from the next row
With the LEAD() function, you can access data from a subsequent row in the same query, without using the GROUP BY statement. This way, you can easily compare values from an ordered list.

This is the syntax: LEAD(numeric_expression) OVER ([PARTITION BY column] ORDER BY column)

In this exercise, you will get familiar with comparing values from the current row with values from the following row.

You will select information about the voters from France and arrange the results by total votes, in ascending order. The purpose is to analyze how the number of votes from each voter compares to the number of votes recorded for the next person in the list.

Instructions
100 XP
Instructions
100 XP
Create a new column, showing the number of votes recorded for the next person in the list.
Create a new column with the difference between the current voter's total_votes and the votes of the next person.

SELECT 
	first_name,
	last_name,
	total_votes AS votes,
    -- Select the number of votes of the next voter
	LEAD(total_votes) OVER (ORDER BY total_votes) AS votes_next_voter,
    -- Calculate the difference between the number of votes
	LEAD(total_votes) OVER (ORDER BY total_votes) - total_votes AS votes_diff
FROM voters
WHERE country = 'France'
ORDER BY total_votes;


Accessing values from the previous row
By using the LAG() function in a query, you can access rows previous to the current one.

This is the syntax: LAG(numeric_expression) OVER ([PARTITION BY column] ORDER BY column)

In this exercise, you will use this function in your query. You will analyze the ratings of the chocolate bars produced by a company called "Fruition".

This company produces chocolate with cocoa coming from different areas of the world.

You want to check if there is a correlation between the percentage of cocoa and the score received, for the bars coming from the same location. For this, you will compare the cocoa percentage of each bar with the percentage of the bar that received the previous rating. Then, you will calculate the difference between these values and interpret the results.

Instructions
100 XP
Instructions
100 XP
Create a new column, showing the cocoa percentage of the chocolate bar that received a lower score, with cocoa coming from the same location (broad_bean_origin is the same).
Create a new column with the difference between the current bar's cocoa percentage and the percentage of the previous bar.

SELECT 
	broad_bean_origin AS bean_origin,
	rating,
	cocoa_percent,
    -- Retrieve the cocoa % of the bar with the previous rating
	LAG(cocoa_percent) 
		OVER(PARTITION BY broad_bean_origin ORDER BY rating ) AS percent_lower_rating
FROM ratings
WHERE company = 'Fruition'
ORDER BY broad_bean_origin, rating ASC;


Getting the first and last value
The analytical functions that return the first or last value from an ordered list prove to be very helpful in queries. In this exercise, you will get familiar with them. The syntax is:

FIRST_VALUE(numeric_expression) OVER ([PARTITION BY column] ORDER BY column ROW_or_RANGE frame)

LAST_VALUE(numeric_expression) OVER ([PARTITION BY column] ORDER BY column ROW_or_RANGE frame)

You will write a query to retrieve all the voters from Spain and the USA. Then, you will add in your query some commands for retrieving the birth date of the youngest and the oldest voter from each country. You want to see these values on each row, to be able to compare them with the birth date of each voter.

Instructions
100 XP
Instructions
100 XP
Retrieve the birth date of the oldest voter from each country.
Retrieve the birth date of the youngest voter from each country.

SELECT 
	first_name + ' ' + last_name AS name,
	country,
	birthdate,
	-- Retrieve the birthdate of the oldest voter per country
	FIRST_VALUE(birthdate) 
	OVER (PARTITION BY country ORDER BY birthdate) AS oldest_voter,
	-- Retrieve the birthdate of the youngest voter per country
	LAST_VALUE(birthdate) 
		OVER (PARTITION BY country ORDER BY birthdate ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
				) AS youngest_voter
FROM voters
WHERE country IN ('Spain', 'USA');


Extracting the sign and the absolute value
In some situations, you may need to use mathematical functions in your database development. After complex calculations, you may need to check the sign of an expression or its absolute value. The functions provided by SQL Server for these tasks are:

ABS(expression)
SIGN(expression)
In this exercise, you will work with the following variables:

DECLARE @number1 DECIMAL(18,2) = -5.4;
DECLARE @number2 DECIMAL(18,2) = 7.89;
DECLARE @number3 DECIMAL(18,2) = 13.2;
DECLARE @number4 DECIMAL(18,2) = 0.003;
The @result variable stores the result of the following calculation: @number1 * @number2 - @number3 - @number4.

You will calculate the absolute value and the sign of this expression.

Instructions 1/2
0 XP
Instructions 1/2
0 XP
Calculate the absolute value of the result of the expression.

DECLARE @number1 DECIMAL(18,2) = -5.4;
DECLARE @number2 DECIMAL(18,2) = 7.89;
DECLARE @number3 DECIMAL(18,2) = 13.2;
DECLARE @number4 DECIMAL(18,2) = 0.003;

DECLARE @result DECIMAL(18,2) = @number1 * @number2 - @number3 - @number4;
SELECT 
	@result AS result,
    -- Show the absolute value of the result
	ABS(@result) AS abs_result;

Find out the sign of the result (positive or negative).

DECLARE @number1 DECIMAL(18,2) = -5.4;
DECLARE @number2 DECIMAL(18,2) = 7.89;
DECLARE @number3 DECIMAL(18,2) = 13.2;
DECLARE @number4 DECIMAL(18,2) = 0.003;

DECLARE @result DECIMAL(18,2) = @number1 * @number2 - @number3 - @number4;
SELECT 
	@result AS result,
	-- Show the absolute value of the result
	ABS(@result) AS abs_result,
	-- Find the sign of the result
	SIGN(@result) AS sign_result;


Rounding numbers
Sometimes in your database development, you may need to round the results of a calculation. There are three functions you can use for this:

CEILING(expression): rounds-up to the nearest integer value
FLOOR(expression): rounds-down to the nearest integer value
ROUND(expression, length): rounds the expression to the specified length.
In this exercise, you will get familiar with the rounding functions, by applying them on a query based on the ratings table.

Instructions 1/4
1 XP
Round up the ratings to the nearest integer value.

SELECT
	rating,
	-- Round-up the rating to an integer value
	CEILING(rating) AS round_up
FROM ratings;

Round down the ratings to the nearest integer value.

SELECT
	rating,
	-- Round-up the rating to an integer value
	CEILING(rating) AS round_up,
	-- Round-down the rating to an integer value
	FLOOR(rating) AS round_down
FROM ratings;

Round the ratings to a decimal number with only 1 decimal.

SELECT
	rating,
	-- Round-up the rating to an integer value
	CEILING(rating) AS round_up,
	-- Round-down the rating to an integer value
	FLOOR(rating) AS round_down,
	-- Round the rating value to one decimal
	ROUND(rating, 1) AS round_onedec
FROM ratings;

Round the ratings to a decimal number with 2 decimals.

SELECT
	rating,
	-- Round-up the rating to an integer value
	CEILING(rating) AS round_up,
	-- Round-down the rating to an integer value
	FLOOR(rating) AS round_down,
	-- Round the rating value to one decimal
	ROUND(rating, 1) AS round_onedec,
	-- Round the rating value to two decimals
	ROUND(rating, 2) AS round_twodec
FROM ratings;


Working with exponential functions
The exponential functions are useful when you need to perform calculations in the database. For databases storing real estate information, for example, you may need to calculate areas. In this case, these functions may come in handy:

POWER(number, power): raises the number to the specified power
SQUARE(number): raises the number to the power of 2
Or, if you need to calculate the distance between two cities, whose coordinates are known, you could use this function:

SQRT(number): calculates the square root of a positive number.
In this exercise, you will play with the exponential functions and analyze the values they return.

Instructions
100 XP
Instructions
100 XP
Raise the number stored in the @number variable to the power from the @power variable.
Calculate the square of the @number variable (square means the power of 2).
Calculate the square root of the number stored in the @number variable.

DECLARE @number DECIMAL(4, 2) = 4.5;
DECLARE @power INT = 4;

SELECT
	@number AS number,
	@power AS power,
	-- Raise the @number to the @power
	POWER(@number, @power) AS number_to_power,
	-- Calculate the square of the @number
	SQUARE(@number) num_squared,
	-- Calculate the square root of the @number
	SQRT(@number) num_square_root;


Manipulating numeric data
In this exercise, you are going to use some common SQL Server functions to manipulate numeric data.

You are going to use the ratings table, which stores information about each company that has been rated, their different cocoa beans and the rating per bean.

You are going to find out information like the highest, lowest, average score received by each company (using functions like MAX(), MIN(), AVG()). Then, you will use some rounding functions to present this data with fewer decimals (ROUND(), CEILING(), FLOOR()).

Instructions 1/3
1 XP
Instructions 1/3
1 XP
Select the number of cocoa flavors the company was rated on.
Select the lowest, highest and the average rating that each company received.

SELECT 
	company, 
    -- Select the number of cocoa flavors for each company
	COUNT(*) AS flavors,
    -- Select the minimum, maximum and average rating
	MIN(rating) AS lowest_score,
   	MAX(rating) AS highest_score,
    AVG(rating) AS avg_score	  
FROM ratings
GROUP BY company
ORDER BY flavors DESC;

Round the average rating to 1 decimal and show it as a different column.

SELECT 
	company, 
    -- Select the number of cocoa flavors for each company
	COUNT(*) AS flavors,
    -- Select the minimum, maximum and average rating
	MIN(rating) AS lowest_score,   
	MAX(rating) AS highest_score,   
	AVG(rating) AS avg_score,
    -- Round the average rating to 1 decimal
    ROUND(AVG(rating), 1) AS round_avg_score	
FROM ratings
GROUP BY company
ORDER BY flavors DESC;

Calculate the average rating received by each company and perform the following approximations:
a. round-up to the next integer value
b. round-down to the previous integer value.

SELECT 
	company, 
    -- Select the number of cocoa flavors for each company
	COUNT(*) AS flavors,
    -- Select the minimum, maximum and average rating
	MIN(rating) AS lowest_score,    
	MAX(rating) AS highest_score,   
	AVG(rating) AS avg_score,
    -- Round the average rating to 1 decimal
    ROUND(AVG(rating), 1) AS round_avg_score,
    -- Round up and then down the aveg. rating to the next integer 
    CEILING(AVG(rating)) AS round_up_avg_score,    
	FLOOR(AVG(rating)) AS round_down_avg_score
FROM ratings
GROUP BY company
ORDER BY flavors DESC;




