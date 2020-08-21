Formatting - player BMI
In this exercise, you are working with a team on a data analytics project, which has been asked to provide some statistics on NBA players to a health care company. You want to create a query that returns the Body Mass Index (BMI) for each player from North America.

BMI=weight(kg)height(cm)2
A colleague has passed you a query he was working on:

select PlayerName, Country,
round(Weight_kg/SQUARE(Height_cm/100),2) BMI 
from Players Where Country = 'USA' 
Or Country = 'Canada'
order by BMI
To make some sense of the code, you want to structure and format it in a way that is consistent and easy to read.

Instructions
100 XP
Instructions
100 XP
Change all SQL syntax (clauses, operators, and functions) to UPPERCASE.
Make sure all SQL syntax begins on a new line.
Add an indent to the calculated BMI column and OR statement.


select PlayerName, Country,
round(Weight_kg/SQUARE(Height_cm/100),2) BMI
from Players Where Country = 'USA'
Or Country = 'Canada'
order by BMI;



Commenting - player BMI
Adding comments is a good way to convey what the query is about or information about certain parts of the query.

The sample code is a query on the Players table that returns player name, country of origin and a calculated Body Mass Index (BMI). The WHERE condition is filtering for only players from North America.

You will add the following comment.

Returns the Body Mass Index (BMI) for all North American players from the 2017-2018 NBA season

Also, you believe that ORDER BY is unnecessary in this query so it will be commented out and a comment added on the same line indicating it is not required.

Instructions
100 XP
Instructions
100 XP
Create a comment block on lines 1 and 4.
Add the above comment to the block.
Comment out the ORDER BY statement and add Order by not required comment on the same line.
Add ; directly after 'Canada' to indicate the new ending of the query.


SELECT PlayerName, Country,
    ROUND(Weight_kg/SQUARE(Height_cm/100),2) BMI 
FROM Players 
WHERE Country = 'USA'
    OR Country = 'Canada'
ORDER BY BMI;



Commenting - how many Kiwis in the NBA?
You and a friend would like to know how many New Zealanders (affectionately known as Kiwis) play in the NBA. Your friend attempts to write a query, but it is not very well formatted and contains several errors. You re-write the query, but you want to keep his original for comparison and future reference.

This exercise requires you to create line comments and comment out blocks of code

Instructions
100 XP
Instructions
100 XP
Add the line comment First attempt, contains errors and inconsistent formatting on line 2.
Block comment out your friend's query on lines 3 and 11.
Add the line comment Second attempt - errors corrected and formatting fixed on line 14.
Remove the block comment syntax from your query on lines 15 and 23.

-- Your friend's query
-- First attempt, contains errors and inconsistent formatting
/*
select PlayerName, p.Country,sum(ps.TotalPoints) 
AS TotalPoints  
FROM PlayerStats ps inner join Players On ps.PlayerName = p.PlayerName
WHERE p.Country = 'New Zeeland'
Group 
by PlayerName, Country
order by Country;
*/

-- Your query
-- Second attempt - errors corrected and formatting fixed

SELECT p.PlayerName, p.Country,
	   SUM(ps.TotalPoints) AS TotalPoints  
FROM PlayerStats ps 
INNER JOIN Players p
	ON ps.PlayerName = p.PlayerName
WHERE p.Country = 'New Zealand'
GROUP BY p.PlayerName, p.Country;



Ambiguous column names
When joining tables, we use aliases in the SELECT statement to indicate the source tables of the selected columns, with each column name prefixed with the table name alias.

The following query joins the Players and PlayerStats tables to return total points by PlayerName and Country for all players from Australia.

SELECT PlayerName, p.Country,
         SUM(ps.TotalPoints) AS TotalPoints  
FROM PlayerStats ps
INNER JOIN Players p
   ON ps.PlayerName = p.PlayerName
WHERE p.Country = 'Australia'
GROUP BY p.PlayerName, p.Country
Copy and paste the query into the console and select Run Code to view the results. The query returns an error which includes the words ... Ambiguous column name...

Fix the query and run it. What was wrong with the original query?

Instructions
50 XP
Instructions
50 XP
Possible Answers
The INNER JOIN must also reference the Country column.
PlayerName is in both the Players and PlayerStats tables. It requires an alias prefix.
An alias cannot be the same name as the aggregated column, i.e. TotalPoints.
WHERE cannot process Australia because there are no Australians are in the NBA.

2


Aliasing - team BMI
A basketball statistician would like to know the average Body Mass Index (BMI) per NBA team, in particular, any team with an average BMI of 25 or more. To include Team in the query, you will need to join the Players table to the PlayerStats table. The query will require aliasing to:

Easily identify joined tables and associated columns.
Identify sub-queries.
Avoid ambiguity in column names.
Identify new columns.
Instructions
100 XP
Instructions
100 XP
Alias the new average BMI column as AvgTeamBMI.
Alias the PlayerStats table as ps.
Alias the sub-query as p.
The PlayerStats table and sub-query are joining on the column PlayerName. Add the aliases to the joining PlayerName columns.

SELECT Team, 
   ROUND(AVG(BMI),2) AS AvgTeamBMI -- Alias the new column
FROM PlayerStats AS ps -- Alias PlayerStats table
INNER JOIN
		(SELECT PlayerName, Country,
			Weight_kg/SQUARE(Height_cm/100) BMI
		 FROM Players) AS p -- Alias the sub-query    
    -- Alias the joining columns
	ON p.PlayerName = ps.PlayerName 
GROUP BY Team
HAVING AVG(BMI) >= 25;


Processing order
The following query returns earthquakes with a magnitude higher than 8, and at a depth of more than 500km.

SELECT Date, Country, Place, Depth, Magnitude
FROM Earthquakes
WHERE Magnitude > 8
    AND Depth > 500
ORDER BY Depth DESC;
Copy and paste the query into the console and select Run Code to view the results.

In which order is the SQL syntax processed in this query?

Instructions
50 XP
Instructions
50 XP
Possible Answers
SELECT, FROM, WHERE, ORDER BY
FROM, WHERE, SELECT, AND
WHERE, FROM, SELECT, ORDER BY
FROM, WHERE, SELECT, ORDER BY

4



Syntax order - New Zealand earthquakes
When executing a query, the processing order of the main SQL syntax is different from the written order in the query.

You want a simple query that returns all the recorded earthquakes in New Zealand that had a magnitude of 7.5 or higher. You think the query out in a sentence before creating it.

From the Earthquakes table, filter for only rows where Country equals 'NZ' and Magnitude greater than or equal to 7.5. Then, select the columns Date, Place, NearestPop, and Magnitude. Order the final results from the largest Magnitude to the smallest Magnitude.

The sample code is arranged in the order that matches the above sentence, which is the same as the SQL syntax processing order in the database. You will need to reorder it so that it runs without error.

Instructions
100 XP
Instructions
100 XP
Complete the required query using FROM, WHERE, SELECT and ORDER BY.
Rearrange the query so that the syntax is in the order that it will run without error.


/*
Returns earthquakes in New Zealand with a magnitude of 7.5 or more
*/

SELECT Date, Place, NearestPop, Magnitude
FROM Earthquakes
WHERE Country = 'NZ'
	AND Magnitude >= 7.5
ORDER BY Magnitude DESC;


Syntax order - Japan earthquakes
Your friend is impressed by your querying skills. She decides to create a query on her own that shows all earthquakes in Japan that were a magnitude of 8 or higher. She has constructed a query based on how she thought about what she requires. Her query will produce an error because of the incorrect ordering of the syntax. Also, the code requires reformatting to make it easy to read.

FROM Earthquakes WHERE Country = 'JP' AND Magnitude >= 8 SELECT Date, Place ,NearestPop, Magnitude ORDER BY Magnitude DESC;

You will fix the query for her with a better coding format and correct the SQL syntax order.

Instructions
100 XP
Instructions
100 XP
Rearrange the query with the correct syntax order in the format provided.

-- Your query
SELECT Date, 
       Place,
       NearestPop, 
       Magnitude
FROM Earthquakes
WHERE Country = 'JP' 
	AND Magnitude >= 8
ORDER BY Magnitude DESC;


Syntax order - very large earthquakes
When a query is executed it will stop at the first error it encounters and will return an error message. Because a query is processed in a stepped order the first error it stops at will be related to the processing order.

FROM is processed first and checks that the queried table(s) exist in the database.
WHERE is always processed after FROM if a row filtering condition is specified. Column(s) having the filtering condition applied must exist.
SELECT is only processed once the data is ready to be extracted and displayed or returned to the user.
This exercise has three queries—each contains errors. Your job is to find the errors and fix them.

Note that the red text below the query result tab is a description of the error.

Instructions 1/3
1 XP
Instructions 1/3
1 XP
Select Run Code and look at the error produced. Fix the error and select Submit Answer.

Select Run Code and look at the error produced. Fix the error and select Submit Answer.

Select Run Code and look at the error produced. Fix the error and select Submit Answer.


/*
Returns the location of the epicenter of earthquakes with a 9+ magnitude
*/

-- Replace Countries with the correct table name
SELECT n.CountryName AS Country
	,e.NearestPop AS ClosestCity
    ,e.Date
    ,e.Magnitude
FROM Nations AS n
INNER JOIN Earthquakes AS e
	ON n.Code2 = e.Country
WHERE e.Magnitude >= 9
ORDER BY e.Magnitude DESC;


/*
Returns the location of the epicenter of earthquakes with a 9+ magnitude
*/

-- Replace Magnatud with the correct column name
SELECT n.CountryName AS Country
	,e.NearestPop AS ClosestCity
    ,e.Date
    ,e.Magnitude
FROM Nations AS n
INNER JOIN Earthquakes AS e
	ON n.Code2 = e.Country
WHERE e.Magnitude >= 9
ORDER BY e.Magnitude DESC;


/*
Location of the epicenter of earthquakes with a 9+ magnitude
*/

-- Replace City with the correct column name
SELECT n.CountryName AS Country
	,e.NearestPop AS ClosestCity
    ,e.Date
    ,e.Magnitude
FROM Nations AS n
INNER JOIN Earthquakes AS e
	ON n.Code2 = e.Country
WHERE e.Magnitude >= 9
ORDER BY e.Magnitude DESC;



Column does not exist
When using WHERE as a filter condition, it is important to think about the processing order in the query. In this exercise, you want a query that returns NBA players with average total rebounds of 12 or more per game. The following formula calculates average total rebounds from the PlayerStats table;

AverageTotalRebounds=(DefensiveRebounds+OffensiveRebounds)GamesPlayed
The first query in Step 1 returns an error. Select Run Code to view the error. The second query, in Step 2, will give you the results you want, without error, by using a sub-query.

Note that GamesPlayed is CAST AS numeric to ensure we get decimal points in our output, as opposed to whole numbers.

Instructions 1/2
0 XP
Try to understand what the error is telling you when you run the first query, then comment out the query block on lines 2 and 9.

-- First query
/*
SELECT PlayerName, 
    Team, 
    Position,
    (DRebound+ORebound)/CAST(GamesPlayed AS numeric) AS AvgRebounds
FROM PlayerStats
WHERE AvgRebounds >= 12;
*/


Functions in WHERE
You want to know which players from the 2017-2018 NBA season went to college in Louisiana. You ask a friend to make the query for you. It looks like he overcomplicated the WHERE filter condition by unnecessarily applying string functions and, also, it does not give you precisely what you want because he forgot how to spell Louisiana. You will simplify his query to return exactly what you require.

Instructions
100 XP
Instructions
100 XP
Select Run Code to see what your friend's query returns.
Think about why his query is not giving you exactly what you require then comment out his filter on line 7.
Add a new wildcard filter condition - Louisiana%


SELECT PlayerName, 
      Country, 
      College, 
      DraftYear, 
      DraftNumber 
FROM Players
-- WHERE UPPER(LEFT(College,5)) LIKE 'LOU%'
WHERE College LIKE 'Louisiana%'; -- Add the wildcard filter


Test your knowledge of WHERE
Which of the following statements regarding WHERE is FALSE?

Answer the question
50 XP
Possible Answers
Applying functions to columns in the WHERE filter condition could increase query times.
press
1
WHERE is processed before SELECT and FROM.
press
2
Calculations on columns in the WHERE filter condition could increase query times.
press
3
WHERE is processed before SELECT and after FROM.
press
4

2


Row filtering with HAVING
In some cases, using HAVING, instead of WHERE, as a filter condition will produce the same results. If filtering individual or ungrouped rows then it is more efficient to use WHERE.

In this exercise, you want to know the number of players from Latin American countries playing in the 2017-2018 NBA season.

Instructions 1/2
50 XP
Instructions 1/2
50 XP
Question
Copy the following query to the console and select Run Code to view the results. Why should HAVING not be used as a filter condition in this query?
SELECT Country, COUNT(*) CountOfPlayers 
FROM Players
GROUP BY Country
HAVING Country 
    IN ('Argentina','Brazil','Dominican Republic'
        ,'Puerto Rico');
Possible Answers
An aggregate function must enclose the Country column in the HAVING filter.
The filter is on individual rows. Using HAVING here, for filtering, could increase the time a query takes to run.
The query returns an error because HAVING is processed before GROUP BY.
If a query is using HAVING for filtering it must also use WHERE.

2


Add the WHERE filter condition.
Fill in the missing two Latin American countries in the IN statement.

SELECT Country, COUNT(*) CountOfPlayers
FROM Players
-- Add the filter condition
WHERE Country
-- Fill in the missing countries
	IN ('Argentina','Brazil','Dominican Republic'
        ,'Puerto Rico')
GROUP BY Country;



Filtering with WHERE and HAVING
WHERE and HAVING can be used as filters in the same query. But how we use them, where we use them and what we use them for is quite different.

You want a query that returns the total points contribution of a teams Power Forwards where their total points contribution is greater than 3000.

Instructions
100 XP
Apply a filter condition for only rows where position equals Power Forward (PF).
Apply a grouped row filter for total points greater than 3000.

SELECT Team, 
	SUM(TotalPoints) AS TotalPFPoints
FROM PlayerStats
-- Filter for only rows with power forwards
WHERE Position = 'PF'
GROUP BY Team
-- Filter for total points greater than 3000
HAVING SUM(TotalPoints) > 3000;



Test your knowledge of HAVING
The following query from the NBA Season 2017-2018 database returns the total points contribution, of a teams Centers, where total points are greater than 2500.

SELECT Team, 
    SUM(TotalPoints) AS TotalCPoints
FROM PlayerStats
WHERE Position = 'C'
GROUP BY Team
HAVING SUM(TotalPoints) > 2500;
Copy and paste the above query into the query console and select Run Code to check the results.

When using HAVING in a query which one of the following statements is FALSE?

Instructions
50 XP
Instructions
50 XP
Possible Answers
When filtering a numeric column, HAVING must be used with an aggregate function, for example: SUM(), COUNT(), AVG()...
WHERE and HAVING can be used in the same query.
Use HAVING with, and after, GROUP BY.
HAVING and WHERE produce the same output, so it doesn't matter which one you use.

4


SELECT what you need
Your friend is a seismologist, and she is doing a study on earthquakes in South East Asia. She asks you for a query that returns coordinate locations, strength, depth and nearest city of all earthquakes in Papua New Guinea and Indonesia.

All the information you need is in the Earthquakes table, and your initial interrogation of the data tells you that the column for the country code is Country and that the Codes for Papua New Guinea and Indonesia are PG and ID respectively.

Instructions 1/2
0 XP
Instructions 1/2
0 XP
SELECT all rows and columns from the Earthquakes table.
Look at the results of the query to determine which other columns to select.

SELECT *
FROM Earthquakes;


Complete the query to select only the required columns and filter for only the requested countries.

SELECT Latitude, -- Y location coordinate column
       Longitude, -- X location coordinate column
	   Magnitude, -- Earthquake strength column
	   Depth, -- Earthquake depth column
	   NearestPop -- Nearest city column
FROM Earthquakes
WHERE Country = 'PG' -- Papua New Guinea country code
	OR Country = 'ID'; -- Indonesia country code



Limit the rows with TOP
Your seismologist friend that is doing a study on earthquakes in South East Asia has asked you to subset a query that you provided her. She wants two additional queries for earthquakes recorded in Indonesia and Papua New Guinea. The first returning the ten shallowest earthquakes and the second the upper quartile of the strongest earthquakes.

Instructions 1/2
0 XP
Instructions 1/2
0 XP
Limit the number of rows to ten.
Order the results from shallowest to deepest.

SELECT TOP 10 -- Limit the number of rows to ten
      Latitude,
      Longitude,
	  Magnitude,
	  Depth,
	  NearestPop
FROM Earthquakes
WHERE Country = 'PG'
	OR Country = 'ID'
ORDER BY Depth; -- Order results from shallowest to deepest


Limit rows to the upper quartile.
Order the results from strongest to weakest earthquake.

SELECT TOP 25 PERCENT -- Limit rows to the upper quartile
       Latitude,
       Longitude,
	   Magnitude,
	   Depth,
	   NearestPop
FROM Earthquakes
WHERE Country = 'PG'
	OR Country = 'ID'
ORDER BY Magnitude DESC; -- Order the results



Should I use ORDER BY?
Which of the following statements is FALSE, when considering using ORDER BY in a query?

Answer the question
50 XP
Possible Answers
ORDER BY is processed after SELECT.
press
1
ORDER BY is useful for data interrogation and unless there is a good reason to sort the data in a query, try to avoid using it.
press
2
ORDER BY is only supported by Microsoft SQL Server and none of the other major database vendors.
press
3
ORDER BY can be used in conjunction with the TOP operator.
press
4

3



Remove duplicates with DISTINCT()
You want to know the closest city to earthquakes with a magnitude of 8 or higher. You can get this information from the Earthquakes table. However, a simple query returns duplicate rows because some cities have experienced more than one magnitude 8 or higher earthquake.

You can remove duplicates by using the DISTINCT() clause. Once you have your results, you would like to know how many times each city has experienced an earthquake of magnitude 8 or higher.

Note that IS NOT NULL is being used because many earthquakes do not occur near any populated area, thankfully.

Instructions 1/3
1 XP
Instructions 1/3
1 XP
Add the closest city and view the output of the query to confirm duplicated rows.

SELECT NearestPop, -- Add the closest city
        Country 
FROM Earthquakes
WHERE Magnitude >= 8
	AND NearestPop IS NOT NULL
ORDER BY NearestPop;


Add DISTINCT() to the column representing the closest city to remove duplicates.
Add the filtering condition for earthquakes with a magnitude of 8 or more.

SELECT DISTINCT(NearestPop),-- Remove duplicate city
		Country
FROM Earthquakes
WHERE Magnitude >= 8 -- Add filter condition
	AND NearestPop IS NOT NULL
ORDER BY NearestPop;  


Get the number of cities near earthquakes of magnitude 8 or more.
Add column groupings.

SELECT NearestPop, 
       Country, 
       COUNT(NearestPop) NumEarthquakes -- Number of cities
FROM Earthquakes
WHERE Magnitude >= 8
	AND Country IS NOT NULL
GROUP BY NearestPop, Country -- Group columns
ORDER BY NumEarthquakes DESC;



UNION and UNION ALL
You want a query that returns all cities listed in the Earthquakes database. It should be an easy query on the Cities table. However, to be sure you get all cities in the database you will append the query to the Nations table to include capital cities as well. You will use UNION to remove any duplicate rows.

Out of curiosity, you want to know if there were any duplicate rows. If you do the same query but append with UNION ALL instead, and compare the number of rows returned in each query, UNION ALL will return more rows if there are duplicates.

Instructions 1/3
1 XP
Add the city column from the Cities table to the first query.
Append queries using UNION
Add the column for the Nation capital to the second query.
Check how many rows were returned.

SELECT CityName AS NearCityName, -- City name column
	   CountryCode
FROM Cities

UNION -- Append queries

SELECT Capital AS NearCityName, -- Nation capital column
       Code2 AS CountryCode
FROM Nations;


Now append the same queries using UNION ALL.
Add the column for the country code to the second query.

SELECT CityName AS NearCityName,
	   CountryCode
FROM Cities

UNION ALL -- Append queries

SELECT Capital AS NearCityName,
       Code2 AS CountryCode  -- Country code column
FROM Nations;


Question
Which of the following is true concerning using UNION ALL and UNION on the queries in Step 1 and Step 2. Run the code in the console and experiment appending queries with UNION and UNION ALL.

Possible Answers
Using UNION and UNION ALL returns the same number of rows.
From looking at the tables, I would not expect any duplicate rows with UNION ALL.
More rows are returned with UNION ALL therefore, UNION must be removing duplicates.
More rows are returned with UNION therefore, UNION must be adding duplicates.

3



UNION or DISTINCT()?
When deciding whether to use DISTINCT() or UNION in a query to remove duplicate rows, which of the following questions would you NOT ask yourself?

Answer the question
50 XP
Possible Answers
Is there an alternative method to using DISTINCT()?
press
1
Will appending queries produce duplicate rows?
press
2
Is there an aggregate function in the SELECT statement?
press
3
Should I be thinking about duplicate rows because my queries never produce duplicate rows?
press
4


4


Uncorrelated sub-query
A sub-query is another query within a query. The sub-query returns its results to an outer query to be processed.

You want a query that returns the region and countries that have experienced earthquakes centered at a depth of 400km or deeper. Your query will use the Earthquakes table in the sub-query, and Nations table in the outer query.

Instructions 1/2
0 XP
Instructions 1/2
0 XP
Add the country code column to the outer query.
Add the country code column to the sub-query.
Filter for a depth of 400km or more.

SELECT UNStatisticalRegion,
       CountryName 
FROM Nations
WHERE Code2 -- Country code for outer query
         IN (SELECT Country -- Country code for sub-query
             FROM Earthquakes
             WHERE Depth >= 400) -- Depth filter
ORDER BY UNStatisticalRegion;


Question
Why is the query from Step 1 an example of an uncorrelated sub-query?

Possible Answers
The sub-query does not reference the outer query.
The sub-query cannot be run independently of the outer query.
The outer query is referenced in the sub-query.
The sub-query is used as a WHERE filter condition for the outer query. Only uncorrelated sub-queries can be used like this.

1



Correlated sub-query
Sub-queries are used to retrieve information from another table, or query, that is separate to the main query.

A friend is working on a project looking at earthquake hazards around the world. She requires a table that lists all countries, their continent and the average magnitude earthquake by country. This query will need to access data from the Nations and Earthquakes tables.

Instructions 1/2
0 XP
Add the average magnitude column in the sub-query.
Add the Nations country code column reference in the sub-query.

SELECT UNContinentRegion,
       CountryName, 
        (SELECT AVG(Magnitude) -- Add average magnitude
        FROM Earthquakes e 
         	  -- Add country code reference
        WHERE n.Code2 = e.Country) AS AverageMagnitude 
FROM Nations n
ORDER BY UNContinentRegion DESC, 
         AverageMagnitude DESC;

Question
Why is the query from Step 1 an example of a correlated sub-query?

Possible Answers
The sub-query can be run independently of the outer query.
The sub-query does not reference the outer query.
The sub-query references the outer query.
ORDER BY is used to sort the results by a column in the outer query.


3



Sub-query vs INNER JOIN
Often the results from a correlated sub-query can be replicated using an INNER JOIN. Depending on what your requirements are, using an INNER JOIN may be more efficient because it only makes one pass through the data whereas the correlated sub-query must execute for each row in the outer query.

You want to find out the 2017 population of the biggest city for every country in the world. You can get this information from the Earthquakes database with the Nations table as the outer query and Cities table in the sub-query.

You will first create this query as a correlated sub-query then rewrite it using an INNER JOIN.

Instructions 1/2
0 XP
Instructions 1/2
0 XP
Add the 2017 population column from the Cities table.
Add the outer query country code column to the sub-query.
Add the outer query table.

SELECT
	n.CountryName,
	 (SELECT MAX(c.Pop2017) -- Add 2017 population column
	 FROM Cities AS c 
                       -- Outer query country code column
	 WHERE c.CountryCode = n.Code2) AS BiggestCity
FROM Nations AS n; -- Outer query table


Join the Nations table to the sub-query.
Add the joining country code columns from the Nations table and sub-query.


SELECT n.CountryName, 
       c.BiggestCity 
FROM Nations AS n
INNER JOIN -- Join the Nations table and sub-query
    (SELECT CountryCode, 
     MAX(Pop2017) AS BiggestCity 
     FROM Cities
     GROUP BY CountryCode) AS c
ON n.Code2 = c.CountryCode; -- Add the joining columns



INTERSECT
INTERSECT is one of the easier and more intuitive methods used to check if data in one table is present in another.

You want to know which, if any, country capitals are listed as the nearest city to recorded earthquakes. You can get this information by comparing the Nations table with the Earthquakes table.

Instructions
100 XP
Add the table with country capital cities to the left query.
Add the operator that compares the two queries.
Add the city name column from the Earthquakes table.

SELECT Capital
FROM Nations -- Table with capital cities

INTERSECT -- Add the operator to compare the two queries

SELECT NearestPop -- Add the city name column
FROM Earthquakes;


EXCEPT
EXCEPT does the opposite of INTERSECT. It is used to check if data, present in one table, is absent in another.

You want to know which countries have no recorded earthquakes. You can get this information by comparing the Nations table with the Earthquakes table.

Instructions
100 XP
Add the country code column from the Nations table.
Add the operator that compares the two queries.
Add the table with country codes to the right query.

SELECT Code2 -- Add the country code column
FROM Nations

EXCEPT -- Add the operator to compare the two queries

SELECT Country 
FROM Earthquakes; -- Table with capital cities



Interrogating with INTERSECT
INTERSECT and EXCEPT are very useful for data interrogation.

The Earthquakes and NBA Season 2017-2018 databases both contain information on countries and cities. You are interested to know which countries are represented by players in the 2017-2018 NBA season and you believe you can get the results you require by querying the relevant tables across these two databases.

Use the INTERSECT operator between queries, but be careful and think about the results. Although both tables contain a country name column to compare, these are separate databases and the data may be stored differently.

Instructions 1/2
0 XP
Instructions 1/2
0 XP
INTERSECT CountryName from a table in the Earthquakes database and Country from a table in the NBA Season 2017-2018 database.

SELECT CountryName 
FROM Nations -- Table from Earthquakes database

INTERSECT -- Operator for the intersect between tables

SELECT Country
FROM Players; -- Table from NBA Season 2017-2018 database


Question
With one exception, all NBA teams are USA based, so why does USA not appear in the results? Are there no Americans playing in the NBA?

To help get your answer, use the two queries below;

Delete the query in the query console.
Copy and paste one of the queries into the query console.
Select Run Code to view the results.
Repeat steps 1 to 4 for the other query.
SELECT * 
FROM Nations
WHERE CountryName LIKE 'U%'
SELECT *
FROM Players
WHERE Country LIKE 'U%'
Possible Answers
The outer query should be using the Code3 column from the Nations table, not CountryName.
The values do not match. In the Nations table, the value for country name is stored as United States of America, and in the Players table, the value is stored as USA.
The original query contains filters on the Nations and Players tables for countries other than the USA.
INTERSECT is not the correct operator to use. The correct operator to use for this question is EXCEPT.


2



IN and EXISTS
You want to know which, if any, country capitals are listed as the nearest city to recorded earthquakes. You can get this information using INTERSECT and comparing the Nations table with the Earthquakes table. However, INTERSECT requires that the number and order of columns in the SELECT statements must be the same between queries and you would like to include additional columns from the outer query in the results.

You attempt two queries, each with a different operator that gives you the results you require.

Instructions 1/2
0 XP
Instructions 1/2
0 XP
Add the 2017 country population and capital city name columns to the outer query.
Add the operator to compare the outer query with the sub-query.

-- First attempt
SELECT CountryName,
	   Pop2017, -- 2017 country population
	   Capital, -- Capital city
	   WorldBankRegion
FROM Nations
WHERE Capital IN -- Add the operator to compare queries
       (SELECT NearestPop 
	    FROM Earthquakes);


Update the query with the 2016 population instead of the 2017 population.
Add the operator to compare the outer query with the sub-query.
Add the two city name columns, being compared, in the sub-query.


-- Second attempt
SELECT CountryName,   
	   Capital,
       Pop2016, -- 2016 country population
       WorldBankRegion
FROM Nations AS n
WHERE EXISTS -- Add the operator to compare queries
	  (SELECT 1
	   FROM Earthquakes AS e
	   WHERE n.Capital = e.NearestPop); -- Columns being compared



NOT IN and NOT EXISTS
NOT IN and NOT EXISTS do the opposite of IN and EXISTS respectively. They are used to check if the data present in one table is absent in another.

You are interested to know if there are some countries in the Nations table that do not appear in the Cities table. There may be many reasons for this. For example, all the city populations from a country may be too small to be listed, or there may be no city data for a particular country at the time the data was compiled.

You will compare the queries using country codes.

Instructions 1/2
0 XP
Instructions 1/2
0 XP
Add the operator to compare the outer query with the sub-query.
Add the country code column to the sub-query.


SELECT WorldBankRegion,
       CountryName
FROM Nations
WHERE Code2 NOT IN -- Add the operator to compare queries
	(SELECT CountryCode -- Country code column
	 FROM Cities);


Add the country capital column to the outer query.
Add the operator to compare the outer query with the sub-query.
Add the two country code columns being compared in the sub-query.

SELECT WorldBankRegion,
       CountryName,
	   Code2,
       Capital, -- Country capital column
	   Pop2017
FROM Nations AS n
WHERE NOT EXISTS -- Add the operator to compare queries
	(SELECT 1
	 FROM Cities AS c
	 WHERE n.Code2 = c.CountryCode); -- Columns being compared



NOT IN with IS NOT NULL
You want to know which country capitals have never been the closest city to recorded earthquakes. You decide to use NOT IN to compare Capital from the Nations table, in the outer query, with NearestPop, from the Earthquakes table, in a sub-query.

Instructions 1/2
0 XP
Instructions 1/2
0 XP
Add the country capital name column to the outer query.
Add the city name column to the sub-query.
Check how many rows the query returns. Does this mean that earthquakes have been recorded near every capital city in the world?

SELECT WorldBankRegion,
       CountryName,
       Capital -- Capital city name column
FROM Nations
WHERE Capital NOT IN
	(SELECT NearestPop -- City name column
	 FROM Earthquakes);


The column in the SELECT statement of the sub-query contains NULL values and will require a filter to remove the NULL values from the query.

Add the WHERE filter condition to the sub-query to get the query working correctly.

SELECT WorldBankRegion,
       CountryName,
       Capital
FROM Nations
WHERE Capital NOT IN
	(SELECT NearestPop
     FROM Earthquakes
     WHERE NearestPop IS NOT NULL); -- filter condition



INNER JOIN
An insurance company that specializes in sports franchises has asked you to assess the geological hazards of cities hosting NBA teams. You believe you can get this information by querying the Teams and Earthquakes tables across the Earthquakes and NBA Season 2017-2018 databases respectively. Your initial query will use EXISTS to compare tables. The second query will use a more appropriate operator.

Instructions 1/3
1 XP
Add the table for the outer query.
Add the operator to compare the outer query with the sub-query.
Add the table for the sub-query.
Check the results. Only columns from the Teams table are returned.

-- Initial query
SELECT TeamName,
       TeamCode,
	   City
FROM Teams AS t -- Add table
WHERE EXISTS -- Operator to compare queries
      (SELECT 1 
	  FROM Earthquakes AS e -- Add table
	  WHERE t.City = e.NearestPop);


Something doesn't look right. You'll need columns from the Earthquakes and Teams tables to makes sense of the results.

Add the place description and country code where the earthquake occurred.
Add the operator to compare the tables.

-- Second query
SELECT t.TeamName,
       t.TeamCode,
	   t.City,
	   e.Date,
	   e.Place, -- Place description
	   e.Country -- Country code
FROM Teams AS t
INNER JOIN Earthquakes AS e -- Operator to compare tables
	  ON t.City = e.NearestPop


Question
In this exercise, what does the INNER JOIN help you to determine that EXISTS could not?

Possible Answers
Queries that use EXISTS are slower than queries that use INNER JOIN.
The INNER JOIN returned two rows, so there must be duplicate rows in the Teams table.
The NBA team based in San Antonio, USA has a high risk of earthquake hazards.
The earthquakes occurred in San Antonio, Chile, not San Antonio, USA.

Submit Answer
4


Exclusive LEFT OUTER JOIN
An exclusive LEFT OUTER JOIN can be used to check for the presence of data in one table that is absent in another table. To create an exclusive LEFT OUTER JOIN the right query requires an IS NULL filter condition on the joining column.

Your sales manager is concerned that orders from French customers are declining. He wants you to compile a list of French customers that have not placed any orders so he can contact them.

Instructions 1/2
0 XP
Instructions 1/2
0 XP
Add the joining operator between the Customers and Orders tables.
Add the joining columns from the Customers and Orders tables.


-- First attempt
SELECT c.CustomerID,
       c.CompanyName,
	   c.ContactName,
	   c.ContactTitle,
	   c.Phone 
FROM Customers c
LEFT OUTER JOIN Orders o -- Joining operator
	ON c.CustomerID = o.CustomerID -- Joining columns
WHERE c.Country = 'France';

Add the filter condition to turn the query into an exclusive LEFT OUTER JOIN

-- Second attempt
SELECT c.CustomerID,
       c.CompanyName,
	   c.ContactName,
	   c.ContactTitle,
	   c.Phone 
FROM Customers c
LEFT OUTER JOIN Orders o
	ON c.CustomerID = o.CustomerID
WHERE c.Country = 'France'
	AND o.CustomerID IS NULL; -- Filter condition


Test your knowledge
The Venn diagram below describes which method used to check whether the data in one table is present, or absent, in a related table?

The Earthquakes database is available for you to test scenarios in the query console.

Venn Diagram Exclusive Left Outer Join

Instructions
50 XP
Instructions
50 XP
Possible Answers
EXISTS
inclusive LEFT OUTER JOIN
INTERSECT


4



STATISTICS TIME in queries
A friend is writing a training course on how the command STATISTICS TIME can be used to tune query performance and asks for your help to complete a presentation. He requires two queries that return NBA team details where the host city had a 2017 population of more than two million.

NBA team details can be queried from the NBA Season 2017-2018 database and city populations can be queried by adding in tables from the Earthquakes database.

Each query uses a different filter on the Teams table.

Query 1

Filters the Teams table using IN and three sub-queries
Query 2

Filters the Teams table using EXISTS
Instructions 1/4
1 XP
Instructions 1/4
1 XP
Turn on STATISTICS TIME.

SET STATISTICS TIME ON -- Turn the time command on


For Query 1:

Add the filter operator for each sub-query.
Add the table from the Earthquakes database to the first query.

-- Query 1
SELECT * 
FROM Teams
-- Sub-query 1
WHERE City IN -- Sub-query filter operator
      (SELECT CityName 
       FROM Cities) -- Table from Earthquakes database
-- Sub-query 2
   AND City IN -- Sub-query filter operator
	   (SELECT CityName 
	    FROM Cities
		WHERE CountryCode IN ('US','CA'))
-- Sub-query 3
    AND City IN -- Sub-query filter operator
        (SELECT CityName 
         FROM Cities
	     WHERE Pop2017 >2000000);


For Query 2

Add the filter operator for the sub-query.
Add the two city name columns being compared to the sub-query.


-- Query 2
SELECT * 
FROM Teams AS t
WHERE EXISTS -- Sub-query filter operator
	(SELECT 1 
     FROM Cities AS c
     WHERE t.City = c.CityName -- Columns being compared
        AND c.CountryCode IN ('US','CA')
          AND c.Pop2017 > 2000000);


Turn off STATISTICS TIME.

SET STATISTICS TIME OFF -- Turn the time command off



STATISTICS TIME results
In the previous exercise, the STATISTICS TIME command was used on two different queries. The following table summarizes an analysis of the elapsed time statistics for each query.

Query	Details	Average elapsed time (ms)
1	Filters the Teams table using IN and three sub-queries	20
2	Filters the Teams table using EXISTS	3
What conclusion can you make from this summary?

Instructions
50 XP
Instructions
50 XP
Possible Answers
None. CPU time is a better measure to compare queries.
The second query that uses EXISTS is more efficient.
None. Elapsed time should be reported as a minimum, not an average.
The database server processors must be running in parallel.

2



STATISTICS IO: Example 1
Your sales company has just taken on a new regional manager for Western Europe. He has asked you to provide him daily updates on orders shipped to some key Western Europe capital cities. As this data is time sensitive, you want a robust query that is tuned to return the results as quickly as possible.

You initially decide on a query that uses two sub-queries: one in the SELECT statement to get the count of orders and one using a filter condition with an IN operator.

You will turn on the STATISTICS IO command to review the page read statistics.

Instructions 1/3
0 XP
Instructions 1/3
0 XP
Turn on STATISTICS IO.

SET STATISTICS IO ON -- Turn the IO command on


Add the table used to count the number of orders.
Add the filter operator for the second sub-query.

-- Example 1
SELECT CustomerID,
       CompanyName,
       (SELECT COUNT(*) 
	    FROM Orders AS o -- Add table
		WHERE c.CustomerID = o.CustomerID) CountOrders
FROM Customers AS c
WHERE CustomerID IN -- Add filter operator
       (SELECT CustomerID 
	    FROM Orders 
		WHERE ShipCity IN
            ('Berlin','Bern','Bruxelles','Helsinki',
			'Lisboa','Madrid','Paris','London'));



Question
From the STATISTICS IO output below, how many data pages from the Orders table were read from memory to complete the query?

Table 'Customers'. Scan count 1, logical reads 2, physical reads 0,...
Table 'Orders'. Scan count 2, logical reads 32, physical reads 0,...
Possible Answers
Two
Zero
Thirty-two
One


32


STATISTICS IO: Example 2
In the previous exercise, you were asked you to provide a new regional manager daily updates on orders shipped to Western Europe capital cities. You initially created a query that contained two sub-queries. You decide to do a rewrite and use an INNER JOIN.

The STATISTICS IO command is turned on. You will need to turn it off after completing the query.

Instructions 1/3
0 XP
Add the join operator.
Add the shipping destination city column in the filter condition.


-- Example 2
SELECT c.CustomerID,
       c.CompanyName,
       COUNT(o.CustomerID)
FROM Customers AS c
INNER JOIN Orders AS o -- Join operator
    ON c.CustomerID = o.CustomerID
WHERE o.ShipCity IN -- Shipping destination column
     ('Berlin','Bern','Bruxelles','Helsinki',
	 'Lisboa','Madrid','Paris','London')
GROUP BY c.CustomerID,
         c.CompanyName;


Turn off STATISTICS IO.

SET STATISTICS IO OFF -- Turn the IO command off

Question
From the STATISTICS IO output below, how many data pages from the Orders table were read from memory to complete the query?

Table 'Customers'. Scan count 1, logical reads 2, physical reads 0,...
Table 'Orders'. Scan count 2, logical reads 16, physical reads 0,...
Possible Answers
Zero
Sixteen
One
Two

16



STATISTICS IO comparison
Using the STATISTICS IO outputs from the example queries in the previous two exercises, what might you conclude?

Example 1

Table 'Customers'. Scan count 1, logical reads 2, physical reads 0,....
Table 'Orders'. Scan count 2, logical reads 32, physical reads 0,...
Example 2

Table 'Customers'. Scan count 1, logical reads 2, physical reads 0,....
Table 'Orders'. Scan count 2, logical reads 16, physical reads 0,...
Answer the question
50 XP
Possible Answers
Nothing. We should use STATISTICS TIME to compare queries and not STATISTICS IO.
press
1
The Example 1 query will run faster than the Example 2 query.
press
2
The time to return the results from both queries will be the same.
press
3
The Example 2 query will run faster than the Example 1 query.
press
4

4



Test your knowledge of indexes
Which of the following statements about indexes is FALSE?

Answer the question
50 XP
Possible Answers
Clustered and nonclustered indexes are applied to table columns.
press
1
Indexes are used to locate data quickly without having to scan the entire table.
press
2
Clustered and nonclustered indexes are applied to table rows.
press
3
A dictionary is a good analogy for a clustered index.
press
4

3


Clustered index
Clustered indexes can be added to tables to speed up search operations in queries. You have two copies of the Cities table from the Earthquakes database: one copy has a clustered index on the CountryCode column. The other is not indexed.

You have a query on each table with a different filter condition:

Query 1

Returns all rows where the country is either Russia or China.
Query 2

Returns all rows where the country is either Jamaica or New Zealand.
Instructions 1/3
1 XP
Instructions 1/3
1 XP
Add the two country codes to the filter condition for Query 1.

-- Query 1
SELECT *
FROM Cities
WHERE CountryCode = 'RU'  -- Country code
		OR CountryCode = 'CN'  -- Country code


Add the two country codes to the filter condition for Query 2.


-- Query 2
SELECT *
FROM Cities
WHERE CountryCode IN ('JM','NZ')  -- Country codes


Question
For these two queries, what conclusion could you make using the following output from the STATISTICS IO command?

Query 1

4694 results returned
Table 'Cities'. ..., logical reads 274, ... ,
Query 2

212 results returned
Table 'Cities'. ..., logical reads 10, ... ,
Possible Answers
Query 1 accesses a clustered index because proportionally there were fewer logical reads for results returned.
The filter conditions are different; therefore it is not possible to tell which query is accessing a clustered index. The number of rows returned needs to be the same to make the comparison.
Query 2 accesses a clustered index because logical reads indicates fewer data pages were accessed compared to Query 1
Results returned versus logical reads are proportionally similar, so there is no way to tell which query is accessing a clustered index.


3


Sort operator in execution plans
Execution plans can tell us if and where a query used an internal sorting operation. Internal sorting is often required when using an operator in a query that checks for and removes duplicate rows.

You are given an execution plan of a query that returns all cities listed in the Earthquakes database. The query appends queries from the Nations and Cities tables. Use the following execution plan to determine if the appending operator used is UNION or UNION ALL

Execution plan for appending queries exercise

Instructions
100 XP
Instructions
100 XP
Add the operator that the execution plan indicates was used to append the queries.


SELECT CityName AS NearCityName,
	   CountryCode
FROM Cities

UNION -- Append queries

SELECT Capital AS NearCityName,
       Code2 AS CountryCode
FROM Nations;


Test your knowledge of execution plans
Which one of the following is NOT information you can get from an execution plan in SQL Server?

Answer the question
50 XP
Possible Answers
If the query used a table with an index
press
1
The total duration of the query, in milliseconds, from execution to returning the complete results
press
2
The location and relative costs of sorting operations
press
3
The types of joins used
press
4

2






