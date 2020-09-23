# Introduction to SQL Server

### Notes 1:
* SQL stands for `Structured Query Language` which is used to work with databases.
* `SQL Server` and `T-SQL` (Transact-SQL) are both `RDMS` (Relational Database Management System) with the later having additional functionality.
* SQL-Server stores data in the form of tables and connections. We can't directly access the whole data so we use `queries` to fetch the appropriate data.
* `SELECT` statement specifies what we want to retrieve from the table.
* `FROM` specifies the location of the source table.
* Always end a query with a `;`.
* Use `TOP` to limit the number of rows returned. We can also specify percentage of rows using `TOP (5) PERCENT`.
* Use `SELECT DISTINCT` to return a list of unique values from a column.
* Use `SELECT *` to return all the rows of a column. (Not recommended for large tables).
* Use rename or Alias to make results more meaningful. `SELECT ___ AS ___`.

**Note**- Try to reserve Upper Case for the inbuilt keywords and Lower Case for table and column names. That makes it easier to read.
<hr>

## Simple selections

It's time to begin writing your own queries! In this first coding exercise, you will use `SELECT` statements to retrieve columns from a database table.
You'll be working with the `eurovision` table, which contains data relating to individual country performance at the Eurovision Song Contest from 1998 to 2012.

After selecting columns, you'll also practice renaming columns, and limiting the number of rows returned.

- [x] `SELECT` the country column `FROM` the eurovision table.

```sql
-- SELECT the country column FROM the eurovision table.
SELECT
    country
FROM
    eurovision;
```

- [x] Amend your query to return the points column instead of the country column.

```sql
-- Select the points column
SELECT
  points
FROM
  eurovision;
```  

- [x] Use `TOP` to change the existing query so that only the first 50 rows are returned.

```sql
-- Limit the number of rows returned
SELECT
  TOP (50) points
FROM
  eurovision;
```

- [x] Return a list of unique countries using `DISTINCT`. Give the results an alias of unique_country.

```sql
-- Return unique countries and use an alias
SELECT
  DISTINCT country AS unique_country
FROM
  eurovision;
```
<hr>

## More selections
Now that you've practiced how to select one column at a time, it's time to practice selecting more than one column. You'll continue working with the eurovision table.

- [x] SELECT the country and event_year columns from the eurovision table.

```sql
-- Select country and event_year from eurovision
SELECT
  country,
  event_year
FROM
  eurovision;
```

- [x] Use a shortcut to amend the current query, returning ALL rows from ALL columns in the table.

```sql
-- Amend the code to select all rows and columns
SELECT
*
FROM
  eurovision;
```

- [x] Return all columns, but only include the top half of the table - in other words, return 50 percent of the rows.

```sql
-- Return all columns, restricting the percent of rows returned
SELECT
  TOP (50) PERCENT *
FROM
  eurovision;
```
<hr>

### Notes 2:
* Queries return sets or subsets from the table but sets have no inherent order. So there's no guarantee that it will return the same query every time. However, we can make it happen using `ORDER BY`. Add `DESC` for showing a particular column in descending order. Default behavior is Ascending.

* If we only wanted to return rows that meet certain criteria, we can use `WHERE` to query specific result. We can use `BETWEEN` to return value in a range. Use `<>` for 'not equals to'.

* `NULL` indicates there is no value for that record. It is useful to know how to retrieve NULLS using `IS NULL` and `IS NOT NULL`.

**Note-** We can order by columns that don't appear in the SELECT part of the query too.

<hr>

## Order by
In this exercise, you'll practice the use of ORDER BY using the grid dataset. It's loaded and waiting for you!
It contains a subset of wider publicly available information on US power outages.

Some of the main columns include:

* `description`: The reason/ cause of the outage.
* `nerc_region`: The North American Electricity Reliability Corporation was formed to ensure the reliability of the grid and comprises several regional entities).
* `demand_loss_mw`: How much energy was not transmitted/consumed during the outage.

- [x] Select description and event_date from grid. Your query should return the first 5 rows, ordered by event_date.

```sql
-- Select the first 5 rows from the specified columns
SELECT
  TOP (5) description,
  event_date
FROM
  grid
  -- Order your results by the event_date column
ORDER BY
  event_date;
```

- [x] Modify your code based on the comments provided on the right.

```sql
-- Select the top 20 rows from description, nerc_region and event_date
SELECT
  TOP (20) description,
  nerc_region,
  event_date
FROM
  grid
  -- Order by nerc_region, affected_customers & event_date
  -- Event_date should be in descending order
ORDER BY
  nerc_region,
  affected_customers,
  event_date DESC;
```
<hr>

## Where
You won't usually want to retrieve every row in your database. You'll have specific information you need in order to answer questions from your boss or colleagues.

The WHERE clause is essential for selecting, updating (and deleting!) data from your tables. You'll continue working with the grid dataset for this exercise.

- [x] Select the description and event_year columns.
- [x] Return rows WHERE the description is 'Vandalism'.

```sql
-- Select description and event_year
SELECT
  description,
  event_year
FROM
  grid
  -- Filter the results
WHERE
  description = 'Vandalism';
```
<hr>

## Where again
When filtering strings, you need to wrap your value in 'single quotes', as you did in the previous exercise. You don't need to do this for numeric values, but you DO need to use single quotes for date columns.

In this course, dates are always represented in the YYYY-MM-DD format (Year-Month-Day), which is the default in Microsoft SQL Server.

- [x] Select the nerc_region and demand_loss_mw columns, limiting the results to those where affected_customers is greater than or equal to 500000.

```sql
-- Select nerc_region and demand_loss_mw
SELECT
  nerc_region,
  demand_loss_mw
FROM
  grid
-- Retrieve rows where affected_customers is >= 500000  
WHERE
  affected_customers>=500000;
```

- [x] Update your code to select description and affected_customers, returning records where the event_date was the 22nd December, 2013.

```sql
-- Select description and affected customers
SELECT
  description,
  affected_customers
FROM
  grid
  -- Retrieve rows where the event_date was the 22nd December, 2013    
WHERE
  event_date='2013-12-22';
```

- [x] Limit the results to those where the affected_customers is BETWEEN 50000 and 150000, and order in descending order of event_date.

```sql
-- Select description, affected_customers and event date
SELECT
  description,
  affected_customers,
  event_date
FROM
  grid
  -- The affected_customers column should be >= 50000 and <=150000   
WHERE
  affected_customers BETWEEN 50000
  AND 150000
   -- Define the order   
ORDER by
  event_date DESC;
```
<hr>

## Working with NULL values
A NULL value could mean 'zero' - if something doesn't happen, it can't be logged in a table. However, NULL can also mean 'unknown' or 'missing'. So consider if it is appropriate to replace them in your results. NULL values provide feedback on data quality. If you have NULL values, and you didn't expect to have any, then you have an issue with either how data is captured or how it's entered in the database.

In this exercise, you'll practice filtering for NULL values, excluding them from results, and replacing them with alternative values.

- [x] Use a shortcut to select all columns from grid. Then filter the results to only include rows where demand_loss_mw is unknown or missing.

```sql
-- Retrieve all columns
SELECT
  *
FROM
  grid
  -- Return only rows where demand_loss_mw is missing or unknown  
WHERE
  demand_loss_mw is NULL;
```

- [x] Adapt your code to return rows where demand_loss_mw is not unknown or missing

```sql
-- Retrieve all columns
SELECT
  *
FROM
  grid
  -- Return rows where demand_loss_mw is not missing or unknown   
WHERE
  demand_loss_mw IS NOT NULL;
```
<hr>

### Notes 3:
* We can use `AND` and `OR` along with `WHERE` to improve the results and use multiple clauses for querying.
* We have seen `BETWEEN` to find values between some range. If the values that we want are not in order or range, we can use `IN` to specify the items to search over.
`WHERE ____ IN (__,__,__,__)`.
* We can also use `LIKE` to specify wildcard searches like `WHERE ___ LIKE 'a%'`.

<hr>

## Exploring classic rock songs
It's time to rock and roll! In this set of exercises, you'll use the songlist table, which contains songs featured on the playlists of 25 classic rock radio stations.

First, let's get familiar with the data.

- [x] Retrieve the song, artist, and release_year columns from the songlist table.

```sql
-- Retrieve the song, artist and release_year columns
SELECT
    song,
    artist,
    release_year
FROM
    songlist;
```

- [x] Make sure there are no NULL values in the release_year column.

```sql
-- Retrieve the song, artist and release_year columns
SELECT
  song,
  artist,
  release_year
FROM
  songlist
  -- Ensure there are no missing or unknown values in the release_year column
WHERE
  release_year IS NOT NULL;
```

- [x] Order the results by artist and release_year.

```sql
-- Retrieve the song,artist and release_year columns
SELECT
  song,
  artist,
  release_year
FROM
  songlist
  -- Ensure there are no missing or unknown values in the release_year column
WHERE
  release_year IS NOT NULL
  -- Arrange the results by the artist and release_year columns
ORDER BY
  artist,
  release_year;
```

<hr>

## Exploring classic rock songs - AND/OR
Having familiarized yourself with the songlist table, you'll now extend your WHERE clause from the previous exercise.

- [x] Extend the WHERE clause so that the results are those with a release_year greater than or equal to 1980 and less than or equal to 1990.

```sql
SELECT
  song,
  artist,
  release_year
FROM
  songlist
WHERE
  -- Retrieve records greater than and including 1980
  release_year >= 1980
  -- Also retrieve records up to and including 1990
  AND release_year <=1990
ORDER BY
  artist,
  release_year;
```

- [x] Update your query to use an OR instead of an AND.

```sql
SELECT
  song,
  artist,
  release_year
FROM
  songlist
WHERE
  -- Retrieve records greater than and including 1980
  release_year >= 1980
  -- Replace AND with OR
  OR release_year <= 1990
ORDER BY
  artist,
  release_year;
```
<hr>

## Using parentheses in your queries
You can use parentheses to make the intention of your code clearer. This becomes very important when using AND and OR clauses, to ensure your queries return the exact subsets you need.

- [x] Select all artists beginning with B who released tracks in 1986, but also retrieve any records where the release_year is greater than 1990.

```sql
SELECT
  artist,
  release_year,
  song
FROM
  songlist
  -- Choose the correct artist and specify the release year
WHERE
  (
    artist LIKE 'B%'
    AND release_year = 1986
  )
  -- Or return all songs released after 1990
  OR release_year > 1990
  -- Order the results
ORDER BY
  release_year,
  artist,
  song;
```

<hr>

### Notes 4:
* Calculate the total amount of a column value with `SUM()`. Use a useful alias else it will be returned with ***no column name***.
* When using aggregating functions like `SUM`, we need to have all the statements below `SELECT` to be aggregating types or it needs to be used as a grouping column(*later discussed*), else we will get an **error message**.
* `COUNT` query returns the number of rows in the particular column. using `DISTINCT` along with `COUNT` may be more useful in finding total number of distinct values.
* Other aggregating functions are `MAX`, `MIN` and `AVG`.

<hr>

## Summing
Summing and counting are key ways of aggregating data, regardless of whether you are using a database, manipulating a spreadsheet, or using a programming language such as Python or R. Let's see how to do it in T-SQL using the grid table from Chapter 1.

You'll start by obtaining overall sums, focusing specifically on the 'MRO' region.

- [x] Obtain a grand total of the demand_loss_mw column by using the SUM function, and alias the result as MRO_demand_loss.
- [x] Only retrieve rows WHERE demand_loss_mw is not NULL and nerc_region is 'MRO'.

```sql
-- Sum the demand_loss_mw column
SELECT
  SUM(demand_loss_mw) AS MRO_demand_loss
FROM
  grid
WHERE
  -- demand_loss_mw should not contain NULL values
  demand_loss_mw is not null
  -- and nerc_region should be 'MRO';
  and nerc_region = 'mro';
```

<hr>

## Counting
Having explored the 'MRO' region, let's now explore the 'RFC' region in more detail while learning how to use the COUNT aggregate function.

- [x] Return the COUNT of the grid_id column, aliasing the result as grid_total.
```sql
-- Obtain a count of 'grid_id'
SELECT
  COUNT(grid_id) as grid_total
FROM
  grid;
```

- [x] Make the count more meaningful by restricting it to records where the nerc_region is 'RFC'. Name the result RFC_count.

```sql
-- Obtain a count of 'grid_id'
SELECT
  COUNT(grid_id) AS RFC_count
FROM
  grid
-- Restrict to rows where the nerc_region is 'RFC'
WHERE
  nerc_region = 'RFC';
```

<hr>

## MIN, MAX and AVG
Along with summing and counting, you'll frequently need to find the minimum, maximum, and average of column values. Thankfully, T-SQL has functions you can use to make the task easier!

- [x] Find the minimum value from the affected_customers column, but only for rows where demand_loss_mw has a value. Name the result min_affected_customers.

```sql
-- Find the minimum number of affected customers
SELECT
  MIN(affected_customers) AS min_affected_customers
FROM
  grid
-- Only retrieve rows where demand_loss_mw has a value
WHERE
  demand_loss_mw is not NULL;
```

- [x] Amend the query to return the maximum value from the same column, this time aliasing as max_affected_customers.

```sql
-- Find the maximum number of affected customers
SELECT
  MAX(affected_customers) AS max_affected_customers
FROM
  grid
-- Only retrieve rows where demand_loss_mw has a value
WHERE
  demand_loss_mw IS NOT NULL;
```

- [x] Return the average value from the affected_customers column, this time aliasing as avg_affected_customers

```sql
-- Find the average number of affected customers
SELECT
  AVG(affected_customers) AS avg_affected_customers
FROM
  grid
-- Only retrieve rows where demand_loss_mw has a value
WHERE
  demand_loss_mw IS NOT NULL;
```

<hr>

### Notes 5: **STRINGS**
* We can use `LEN` to find the number of characters, including spaces of a string.
* We use `LEFT (string, number_of_characters)` to extract number of characters from the beginning of a string. `RIGHT` works similarly starting at the end of a string.
* `CHARINDEX ('character', string)` function helps us find a specific character within a string i.e. it will return the string from start till the point where the character has been found.
* We use `SUBSTRING (string, start_pos, end_pos)` to select a portion of the string.
* We use `REPLACE (string, 'character_to_replace', 'new_character')` to replace a certain character/s from a string.

<hr>


## LEN'gth of a string
Knowing the length of a string is key to being able to manipulate it further using other functions, so what better way to start the lesson?

- [x] Retrieve the length of the description column, returning the results as description_length.

```sql
-- Calculate the length of the description column
SELECT
  len (description) AS description_length
FROM
  grid;
```

<hr>

## Left and right
We can retrieve portions of a string from either the start of the string, using LEFT, or working back from the end of the string, using RIGHT.

- [x] Retrieve the first 25 characters from the description column in the grid table. Name the results first_25_left.

```sql
-- Select the first 25 characters from the left of the description column
SELECT
  LEFT(description, 25) AS first_25_left
FROM
  grid;
```

- [x] Amend the query to retrieve the last 25 characters from the description. Name the results last_25_right.

```sql
-- Amend the query to select 25 characters from the  right of the description column
SELECT
  RIGHT(description, 25) AS last_25_right
FROM
  grid;
```

<hr>

## Stuck in the middle with you
You might be fortunate, and find that the interesting parts of your strings are at either end. However, chances are, you'll want to retrieve characters from
somewhere around the middle. Let's see how to use RIGHT, LEN, CHARINDEX AND SUBSTRING to extract the interior portion of a text string.
The description column can contain multiple reasons for power outages in each row. We want to extract any additional causes of outage whenever Weather appears in the description column.

- [x] You can use CHARINDEX to find a specific character or pattern within a column. Edit the query to return the CHARINDEX of the string 'Weather' whenever it appears within the description column.

```sql
-- Complete the query to find `Weather` within the description column
SELECT
  description,
  CHARINDEX('weather', description)
FROM
  grid
WHERE description LIKE '%Weather%';
```

- [x] We now know where 'Weather' begins in the description column. But where does it end? We could manually count the number of characters, but, for longer strings, this is more work, especially when we can also find the length with LEN.

```sql
-- Complete the query to find the length of `Weather`
SELECT
  description,
  CHARINDEX('Weather', description) AS start_of_string,
  LEN('Weather') AS length_of_string
FROM
  grid
WHERE description LIKE '%Weather%';
```

- [x] Now we use SUBSTRING to return everything after Weather for the first ten rows. The start index here is 15, because the CHARINDEX for each row is 8, and the LEN of Weather is 7.

```sql
-- Complete the substring function to begin extracting from the correct character in the description column
SELECT TOP (10)
  description,
  CHARINDEX('Weather', description) AS start_of_string,
  LEN ('Weather') AS length_of_string,
  SUBSTRING(
    description,
    15,
    LEN(description)
  ) AS additional_description
FROM
  grid
WHERE description LIKE '%Weather%';
```

<hr>

### Notes 6: **GROUPING and HAVING**
* We use `GROUP BY column_name` to perform aggregate functions on the unique entries of the *column_name*.
* *When we use the `WHERE` clause, the filtering takes place on the row level i.e. within the data.* But, if we want to filter the aggregate values after using `GROUP BY`, we can use `HAVING` clause.

<hr>


## GROUP BY
In an earlier exercise, you wrote a separate WHERE query to determine the amount of demand lost for a specific region. We wouldn't want to have to write individual queries for every region. Fortunately, you don't have to write individual queries for every region. With GROUP BY, you can obtain a sum of all the unique values for your chosen column, all at once.

You'll return to the grid table here and calculate the total lost demand for all regions.

- [x] Select nerc_region and the sum of demand_loss_mw for each region.
- [x] Exclude values where demand_loss_mw is NULL.
- [x] Group the results by nerc_region.
- [x] Arrange in descending order of demand_loss.

```sql
-- Select the region column
SELECT
  nerc_region,
  -- Sum the demand_loss_mw column
  SUM(demand_loss_mw) AS demand_loss
FROM
  grid
  -- Exclude NULL values of demand_loss
WHERE
  demand_loss_mw is not null
  -- Group the results by nerc_region
group by
  nerc_region
  -- Order the results in descending order of demand_loss
ORDER BY
  demand_loss desc;
```

<hr>

## Having
WHERE is used to filter rows before any grouping occurs. Once you have performed a grouping operation, you may want to further restrict the number of rows returned. This is a job for HAVING. In this exercise, you will modify an existing query to use HAVING, so that only those results with a sum of over 10000 are returned.

- [x] Modify the provided query to remove the WHERE clause.
- [x] Replace it with a HAVING clause so that only results with a total demand_loss_mw of greater than 10000 are returned.

```sql
SELECT
  nerc_region,
  SUM (demand_loss_mw) AS demand_loss
FROM
  grid
  -- Remove the WHERE clause

GROUP BY
  nerc_region
  -- Enter a new HAVING clause so that the sum of demand_loss_mw is greater than 10000
HAVING
  SUM(demand_loss_mw) > 10000
ORDER BY
  demand_loss DESC;
```

<hr>

## Grouping together
In this final exercise, you will combine GROUP BY with aggregate functions such as MIN that you've seen earlier in this chapter.

To conclude this chapter, we'll return to the eurovision table from the first chapter.

- [x] Use MIN and MAX to retrieve the minimum and maximum values for the place and points columns respectively.

```sql
-- Retrieve the minimum and maximum place values
SELECT
  MIN(place) AS min_place,
  MAX(place) AS max_place,
  -- Retrieve the minimum and maximum points values
  MIN(points) AS min_points,
  MAX(points) AS max_points
FROM
  eurovision;
```

- [x] Let's obtain more insight from our results by adding a GROUP BY clause. Group the results by country.

```sql
-- Retrieve the minimum and maximum place values
SELECT
  MIN(place) AS min_place,
  MAX(place) AS max_place,
  -- Retrieve the minimum and maximum points values
  MIN(points) AS min_points,
  MAX(points) AS max_points
FROM
  eurovision
  -- Group by country
GROUP BY
  country;
```

- [x] The previous query results did not identify the country. Let's amend the query, returning the count of entries per country and the country column.
Complete the aggregate section by finding the average place for each country.

```sql
-- Obtain a count for each country
SELECT
  COUNT(country) AS country_count,
  -- Retrieve the country column
  country,
  -- Return the average of the Place column
  AVG(place) AS average_place,
  AVG(points) AS avg_points,
  MIN(points) AS min_points,
  MAX(points) AS max_points
FROM
  eurovision
GROUP BY
  country;
```

- [x] Finally, our results are skewed by countries who only have one entry. Apply a filter so we only return rows where the country_count is greater than 5.
Then arrange by avg_place in ascending order, and avg_points in descending order.

```sql
SELECT
  country,
  COUNT (country) AS country_count,
  AVG (place) AS avg_place,
  AVG (points) AS avg_points,
  MIN (points) AS min_points,
  MAX (points) AS max_points
FROM
  eurovision
GROUP BY
  country
  -- The country column should only contain those with a count greater than 5
HAVING
  count(country) > 5
  -- Arrange columns in the correct order
ORDER BY
  avg_place,
  avg_points;
```

<hr>

### Notes 7: **JOINING TABLES**
One of the key principles of RDMS is that data is stored across multiple tables. In order to extract the required data, tables need to be joined. We use **PRIMARY KEY** and **FOREIGN KEY** to join tables.
* A primary key is a column that is used to uniquely identify each row in a table.
* `INNER JOIN` is used to select common data from both the tables involved i.e. all the rows that are common in both the tables.
```sql
SELECT
  table_A.columnX,
  table_A.columnY,
  table_B.columnZ,
  table_C.columnW
FROM table_A
INNER JOIN table_B ON table_B.foreign_key = table_A.primary_key
INNER JOIN table_C ON table_C.foreign_key = table_B.primary_key;
```

<hr>

## Inner Joins - a perfect match
Let's use the Chinook database, which consists of tables related to an online store, to understand how inner joins work. The album table lists albums by multiple artists. The track table lists individual songs, each with a unique identifier, but also, an album_id column that links each track to an album.

Let's find the tracks that belong to each album.

- [x] Perform an inner join between album and track using the album_id column.

```sql
SELECT
  track_id,
  name AS track_name,
  title AS album_title
FROM track
  -- Complete the join type and the common joining column
INNER JOIN album on album.album_id = track.album_id;
```

<hr>

## Inner Joins (II)
Here, you'll continue to practice your INNER JOIN skills. We'll use the album table as last time, but will join it to a new table - artist - which consists of two columns: artist_id and name.

- [x] Select the album_id and title columns from album (the main source table name).
- [x] Select the name column from artist and alias it as artist.
- [x] Identify a common column between the album and artist tables and perform an inner join.

```sql
-- Select album_id and title from album, and name from artist
SELECT
  album_id,
  title,
  name AS artist
  -- Enter the main source table name
FROM album
  -- Perform the inner join
INNER JOIN artist on artist.artist_id = album.artist_id;
```

<hr>

## Inner Join (III) - Join 3 tables
We've seen how to join 2 tables together - album with track, and album with artist. In this exercise, you'll join all three tables to pull together a more complete result set. You'll continue using INNER JOIN, but you need to specify more than one.

Here, note that because both track and artist contain a name column, you need to qualify where you are selecting the columns by prefixing the column name with the table name.

- [x] Qualify the name column by specifying the correct table prefix in both cases.
- [x] Complete both INNER JOIN clauses to join album with track, and artist with album.

```sql
SELECT track_id,
-- Enter the correct table name prefix when retrieving the name column from the track table
  track.name AS track_name,
  title as album_title,
  -- Enter the correct table name prefix when retrieving the name column from the artist table
  artist.name AS artist_name
FROM track
  -- Complete the matching columns to join album with track, and artist with album
INNER JOIN album on album.album_id = track.album_id
INNER JOIN artist on artist.artist_id = album.artist_id;
```

<hr>

### Notes 8: **LEFT & RIGHT joins**
These kind of joins are helpful in cases when one table may not have an exact match in another but we need to see all the data from this table. Foe non matching rows, a `NULL` is returned.

<hr>

## LEFT join
An INNER JOIN shows you exact matches. What about when you want to compare all the values in one table with another, to see which rows match? That's when you can use a LEFT JOIN.

A LEFT JOIN will return ALL rows in the first table, and any matching rows in the right table. If there aren't any matches in the right table for a particular row, then a NULL is returned. This quickly lets you assess the gaps in your data, and how many you have.

- [x] Complete the LEFT JOIN, returning all rows from the specified columns from invoiceline and any matches from invoice.

```sql
SELECT
  invoiceline_id,
  unit_price,
  quantity,
  billing_state
  -- Specify the source table
FROM invoiceline
  -- Complete the join to the invoice table
LEFT JOIN invoice
ON invoiceline.invoice_id = invoice.invoice_id;
```

<hr>

## RIGHT JOIN
Let's now try some RIGHT joins. A RIGHT join will return all rows from the right hand table, plus any matches from the left hand side table.

In addition to performing a RIGHT join, you'll also learn how to avoid problems when different tables have the same column names, by fully qualifying the column in your select statement. Remember, we do this by prefixing the column name with the table name.

For this exercise, we'll return to the Chinook database from earlier in the chapter.

- [x] SELECT the fully qualified column names album_id from album and name from artist. Then, join the tables so that only matching rows are returned (non-matches should be discarded).

```sql
-- SELECT the fully qualified album_id column from the album table
SELECT
  album_id,
  title,
  album.artist_id,
  -- SELECT the fully qualified name column from the artist table
  name as artist
FROM album
-- Perform a join to return only rows that match from both tables
INNER JOIN artist ON album.artist_id = artist.artist_id
WHERE album.album_id IN (213,214)
```

- [x] To complete the query, join the album table to the track table using the relevant fully qualified album_id column. The album table is on the left-hand side of the join, and the additional join should return all matches or NULLs.

```sql
SELECT
  album.album_id,
  title,
  album.artist_id,
  artist.name as artist
FROM album
INNER JOIN artist ON album.artist_id = artist.artist_id
-- Perform the correct join type to return matches or NULLS from the track table
LEFT JOIN track on album.album_id = track.album_id
WHERE album.album_id IN (213,214)
```
<hr>

### Notes 9: **UNION and UNION ALL**
Combine results of multiple queries.
* When we have same structure of multiple query result i.e. same number of columns, columns listed in the same order and have similar data types, then we can join or merge the results into one output table using `UNION`.
* The only difference between the two clauses is that `UNION ALL` returns all rows including duplicate rows whereas `UNION` returns only unique rows. `UNION` is generally slower to run as it takes time to discard the duplicates.

<hr>
## UNION ALL Check
Which of the following options correctly describes what happens when 2 queries are combined with UNION ALL?

Possible Answers
- [x] All rows from the first query are returned, along with any non-duplicated rows from the second query.

- [ ] Only rows that exist in both queries are returned, with duplicate rows discarded.

- [ ] All rows from both queries are returned, including duplicates.

- [ ] All rows from the second query are returned, along with non-duplicated rows from the first query.

<hr>

## Join the UNION
You can write 2 or more SELECT statements and combine the results using UNION. For example, you may have two different tables with similar column types. If you wanted to combine these into one set of results, you'd use UNION. You'll see how to do this using the artist and album tables. In this exercise, you'll SELECT two common columns, and then add a description column so you can tell which table the columns originated from.

- [x] Make the first selection from the album table. Then join the results by providing the relevant keyword and selecting from the artist table.

```sql
SELECT
  album_id AS ID,
  title AS description,
  'Album' AS Source
  -- Complete the FROM statement
FROM album
 -- Combine the result set using the relevant keyword
UNION
SELECT
  artist_id AS ID,
  name AS description,
  'Artist'  AS Source
  -- Complete the FROM statement
from artist;
```
<hr>

### Notes 10: **CRUD**
The acronym CRUD describes the 4 main type of operations we can carry out on a database:
* CREATE- tables, views and in addition, DBA can create users, permissions and security groups.
* READ- read using `SELECT` statement.
* UPDATE- Amend existing database records.
* DELETE- Need sufficient access to delete records, database etc.


Various DataTypes for creating a table:
  * Dates:
    * date(`YYYY-MM-DD`), datetime(`YYYY-MM-DD hh:mm:ss`)
    * time
  * Numeric:
    * integer, decimal, float
    * bit (`1 = TRUE`,`0 = FALSE`). Also accepts `NULL`.
  * Strings:
    * `char`,`varchar`,`nvarchar`
and others

<hr>

## CRUD operations
When we talk about 'CRUD' operations on the records of a database, what do we mean - what do those letters stand for?

- [ ] Create, Review, Update, Destroy.

- [x] Create, Read, Update, Delete.

- [ ] Create, Record, Update, Destroy.

- [ ] Create, Read, Upsert, Delete.

<hr>

## Create tables
Say you want to create a table to consolidate some useful track information into one table. This will consist of the track name, the artist,
and the album the track came from. You also want to store the track length in a different format to how it is currently stored in the track table.
How can you go about doing this? Using CREATE TABLE. Recall the example from the video:
```sql
CREATE TABLE test_table(
  test_date DATE,
  test_name VARCHAR(20),
  test_int INT
)
```
Let's get started!

- [x] Create a table named 'results' with 3 VARCHAR columns called track, artist, and album, with lengths 200, 120, and 160, respectively.

```sql
-- Create the table
CREATE TABLE results (
	-- Create track column
	track varchar(200),
    -- Create artist column
	artist varchar(120),
    -- Create album column
	album varchar(160),
	);
```

- [x] Create one integer column called track_length_mins.

```sql
-- Create the table
CREATE TABLE results (
	-- Create track column
	track VARCHAR(200),
    -- Create artist column
	artist VARCHAR(120),
    -- Create album column
	album VARCHAR(160),
	-- Create track_length_mins
	track_length_mins INT,
	);
```

- [x] SELECT all the columns from your new table. No rows will be returned, but you can confirm that the table has been created.

```sql
-- Create the table
CREATE TABLE results (
	-- Create track column
	track VARCHAR(200),
    -- Create artist column
	artist VARCHAR(120),
    -- Create album column
	album VARCHAR(160),
	-- Create track_length_mins
	track_length_mins INT,
	);

-- Select all columns from the table
SELECT
  track,
  artist,
  album,
  track_length_mins
FROM
  results;
```
<hr>

### Notes 11: **INSERT, UPDATE & DELETE**
```SQL
INSERT INTO table_name (col1, col2, col3)
VALUES ('value1','value2',value3)
```

```SQL
UPDATE table_name
SET
  column1=value1,
  column2=value2
WHERE
  -Condition(s);
```
**Don't forget `WHERE` clause else all values will be updated**

```SQL
DELETE
FROM table
WHERE
- Conditions
```

**OR**

```SQL
TRUNCATE TABLE table_name
```

<hr>

## Insert
This exercise consists of two parts: In the first, you'll create a new table very similar to the one you created in the previous interactive exercise. After that, you'll insert some data and retrieve it.

You'll continue working with the Chinook database here.

- [x] Create a table called tracks with 2 VARCHAR columns named track and album, and one integer column named track_length_mins. Then, select all columns from the new table using the * notation.

```sql
-- Create the table
CREATE TABLE tracks(
	-- Create track column
	track varchar(200),
    -- Create album column
  	album varchar(160),
	-- Create track_length_mins column
	track_length_mins INT
);
-- Select all columns from the new table
SELECT
  *
FROM
  tracks;
```

- [x] Insert the track 'Basket Case', from the album 'Dookie', with a track length of 3, into the appropriate columns.

```sql
-- Create the table
CREATE TABLE tracks(
  -- Create track column
  track VARCHAR(200),
  -- Create album column
  album VARCHAR(160),
  -- Create track_length_mins column
  track_length_mins INT
);
-- Complete the statement to enter the data to the table         
INSERT INTO tracks
-- Specify the destination columns
(track,album,track_length_mins)
-- Insert the appropriate values for track, album and track length
VALUES
  ('Basket Case', 'Dookie', 3);
-- Select all columns from the new table
SELECT
  *
FROM
  tracks;
```

<hr>

## Update
You may sometimes have to update the rows in a table. For example, in the album table, there is a row with a very long album title, and you may want to shorten it.

You don't want to delete the record - you just want to update it in place. To do this, you need to specify the album_id to ensure that only the desired row is updated and all others are not modified.

- [x] Select the title column from the album table where the album_id is 213.

```sql
-- Select the album
SELECT
  title
FROM
  album
WHERE
  album_id = 213;
```

- [x] That's a very long album title, isn't it? Use an UPDATE statement to modify the title to 'Pure Cult: The Best Of The Cult'.

```sql
-- Run the query
SELECT
  title
FROM
  album
WHERE
  album_id = 213;
-- UPDATE the album table
UPDATE
  album
-- SET the new title    
SET
  title = 'Pure Cult: The Best Of The Cult'
WHERE album_id = 213;
```

- [x] Hit 'Submit Answer' to see whether or not the album title was shortened!

```sql
-- Select the album
SELECT
  title
FROM
  album
WHERE
  album_id = 213;
-- UPDATE the title of the album
UPDATE
  album
SET
  title = 'Pure Cult: The Best Of The Cult'
WHERE
  album_id = 213;
-- Run the query again
SELECT
  title
FROM
  album ;
```

<hr>

## Delete
You may not have permissions to delete from your database, but it is safe to practice it here in this course!

Remember - there is no confirmation before deleting. When you execute the statement, the record(s) are deleted immediately. Always ensure you test with a SELECT and WHERE in a separate query to ensure you are selecting and deleting the correct records. If you forget so specify a WHERE condition, you will delete ALL rows from the table.

- [x] Hit 'Submit Answer' to run the query and view the existing data.

- [x] DELETE the record from album where album_id is 1 and then hit 'Submit Answer'.

```sql
-- Run the query
SELECT
  *
FROM
  album
  -- DELETE the record
DELETE FROM
  album
WHERE
  album_id = 1;
  -- Run the query again
SELECT
  *
FROM
  album;
```

<hr>

### Notes 12: **DECLARE**
Use of **variables**- why they are useful, how to create them and assign values to them.<br>
Also create temporary tables, when we don't have access or permissions to other tables.

* Variable- Placeholder for a specific value, of a specific data type. It means we write less repetitive code.

`DECLARE @var_name DATA_TYPE`<br>
`SET @var_name = value`

* Temporary tables: these table will exist until connection or session ends or we manually remove it with `DROP TABLE` statement.
```SQL
SELECT
  col1,
  col2
INTO
  #my_temp_table
FROM existing_table
WHERE
  -Condition(s)
```

<hr>

## DECLARE and SET a variable
Using variables makes it easy to run a query multiple times, with different values, without having to scroll down and amend the WHERE clause each time. You can quickly update the variable at the top of the query instead. This also helps provide greater security, but that is out of scope of this course.

Let's go back to the now very familiar grid table for this exercise, and use it to practice extracting data according to your newly defined variable.

- [x] DECLARE the variable @region, which has a data type of VARCHAR and length of 10.
```sql
-- Declare the variable @region, and specify the data type of the variable
DECLARE @region VARCHAR(10)
```

- [x] SET your newly defined variable to 'RFC'.
```sql
-- Declare the variable @region
DECLARE @region VARCHAR(10)

-- Update the variable value
SET @region='RFC'
```

- [x] Hit 'Submit Answer' to see the results!
```sql
-- Declare the variable @region
DECLARE @region VARCHAR(10)

-- Update the variable value
SET @region = 'RFC'

SELECT description,
       nerc_region,
       demand_loss_mw,
       affected_customers
FROM grid
WHERE nerc_region = @region;
```

<hr>

## Declare multiple variables
You've seen how to DECLARE and SET set 1 variable. Now, you'll DECLARE and SET multiple variables. There is already one variable declared, however you need to overwrite this and declare 3 new ones. The WHERE clause will also need to be modified to return results between a range of dates.

- [x] Declare a new variable called @start of type DATE.
```sql
-- Declare @start
DECLARE @start DATE

-- SET @start to '2014-01-24'
SET @start='2014-01-24'
```

- [x] Declare a new variable called @stop of type DATE
```sql
-- Declare @start
DECLARE @start DATE

-- Declare @stop
DECLARE @stop DATE

-- SET @start to '2014-01-24'
SET @start = '2014-01-24'

-- SET @stop to '2014-07-02'
SET @stop = '2014-07-02'
```

- [x] Declare a new variable called @affected of type INT
```sql
-- Declare @start
DECLARE @start DATE

-- Declare @stop
DECLARE @stop DATE

-- Declare @affected
DECLARE @affected INT

-- SET @start to '2014-01-24'
SET @start = '2014-01-24'

-- SET @stop to '2014-07-02'
SET @stop  = '2014-07-02'

-- Set @affected to 5000
SET @affected =5000
```

- [x] Retrieve all rows where event_date is BETWEEN @start and @stop and affected_customers is greater than or equal to @affected.

```sql
-- Declare your variables
DECLARE @start DATE
DECLARE @stop DATE
DECLARE @affected INT;
-- SET the relevant values for each variable
SET @start = '2014-01-24'
SET @stop  = '2014-07-02'
SET @affected =  5000 ;

SELECT
  description,
  nerc_region,
  demand_loss_mw,
  affected_customers
FROM
  grid
-- Specify the date range of the event_date and the value for @affected
WHERE event_date BETWEEN @start AND @stop
AND affected_customers >= @affected;
```
<hr>

## Ultimate Power
Sometimes you might want to 'save' the results of a query so you can do some more work with the data. You can do that by creating a temporary table that remains in the database until SQL Server is restarted. In this final exercise, you'll select the longest track from every album and add that into a temporary table which you'll create as part of the query.

- [x] Create a temporary table called maxtracks. Make sure the table name starts with #.
- [x] Join album to artist using artist_id, and track to album using album_id.
- [x] Run the final SELECT statement to retrieve all the columns from your new table.

```sql
SELECT  album.title AS album_title,
  artist.name as artist,
  MAX(track.milliseconds / (1000 * 60) % 60 ) AS max_track_length_mins
-- Name the temp table #maxtracks
INTO #maxtracks
FROM album
-- Join album to artist using artist_id
INNER JOIN artist ON album.artist_id = artist.artist_id
-- Join track to album using album_id
INNER JOIN track ON track.album_id=album.album_id
GROUP BY artist.artist_id, album.title, artist.name,album.album_id
-- Run the final SELECT query to retrieve the results from the temporary table
SELECT album_title, artist, max_track_length_mins
FROM  #maxtracks
ORDER BY max_track_length_mins DESC, artist;
```
