# Database Design

## OLAP vs. OLTP
You should now be familiar with the differences between OLTP and OLAP. In this exercise, you are given a list of cards describing a specific approach which you will categorize between OLAP and OLTP.

- [x] Categorize the cards into the approach that they describe best.

OLAP- 
* Queries a larger amount of data
* Help businesses with decision making and problem solving
* Typically uses a data warehouse

OLTP- 
* Data is inserted and updated more often
* Most likely to have data from past hour
* Typically uses an operational database


## Which is better?
The city of Chicago receives many 311 service requests throughout the day. 311 service requests are non-urgent community requests, ranging from graffiti removal to street light outages. Chicago maintains a data repository of all these services organized by type of requests. In this exercise, Potholes has been loaded as an example of a table in this repository. It contains pothole reports made by Chicago residents from the past week.

Explore the dataset. What data processing approach is this larger repository most likely using?

Possible Answers
- [ ] OLTP because this table could not be used for any analysis.
- [ ] OLAP because each record has a unique service request number.
- [x] OLTP because this table's structure appears to require frequent updates.
- [ ] OLAP because this table focuses on pothole requests only.

OLTP because this table's structure appears to require frequent updates.


## Ordering ETL Tasks
You have been hired to manage data at a small online clothing store. Their system is quite outdated because their only data repository is a traditional database to record transactions.

You decide to upgrade their system to a data warehouse after hearing that different departments would like to run their own business analytics. You reason that an ELT approach is unnecessary because there is relatively little data (< 50 GB).

- [x] In the ETL flow you design, different steps will take place. Place the steps in the most appropriate order.

eCommerce API outputs real time data of transactions
Python script drops null rows and clean data into pre determined columns
Resulting dataframe is written into AWS Redshift Warehouse

## Recommend a storage solution
When should you choose a data warehouse over a data lake?

Possible Answers
- [ ] To train a machine learning model with a 150 GB of raw image data.

- [ ] To store real-time social media posts that may be used for future analysis

- [ ] To store customer data that needs to be updated regularly

- [x] To create accessible and isolated data repositories for other analysts



## Deciding fact and dimension tables
Imagine that you love running and data. It's only natural that you begin collecting data on your weekly running routine. You're most concerned with tracking how long you are running each week. You also record the route and the distances of your runs. You gather this data and put it into one table called Runs with the following schema: 

After learning about dimensional modeling, you decide to restructure the schema for the database. Runs has been pre-loaded for you.

Question
Out of these possible answers, what would be the best way to organize the fact table and dimensional tables?

Possible Answers
- [x] A fact table holding duration_mins and foreign keys to dimension tables holding route details and week details, respectively.
- [ ] A fact table holding week,month, year and foreign keys to dimension tables holding route details and duration details, respectively.
- [ ] A fact table holding route_name,park_name, distance_km,city_name, and foreign keys to dimension tables holding week details and duration details, respectively.


- [x] Create a dimension table called route that will hold the route information.
- [x] Create a dimension table called week that will hold the week information

```sql
-- Create a route dimension table
CREATE TABLE route (
	route_id INTEGER PRIMARY KEY,
    park_name VARCHAR(160) NOT NULL,
    city_name VARCHAR(160) NOT NULL,
    distance_km FLOAT NOT NULL,
    route_name VARCHAR(160) NOT NULL
);
-- Create a week dimension table
CREATE TABLE week(
	week_id INTEGER PRIMARY KEY,
    week INTEGER NOT NULL,
    month VARCHAR(160) NOT NULL,
    year INTEGER NOT NULL
);
```

## Querying the dimensional model
Here it is! The schema reorganized using the dimensional model: 

Let's try to run a query based on this schema. How about we try to find the number of minutes we ran in July, 2019? We'll break this up in two steps. First, we'll get the total number of minutes recorded in the database. Second, we'll narrow down that query to week_id's from July, 2019.

- [x] Calculate the sum of the duration_mins column.

```sql
SELECT 
	-- Get the total duration of all runs
	SUM(duration_mins)
FROM 
	runs_fact;
```

- [x] Join week_dim and runs_fact.
- [x] Get all the week_id's from July, 2019.

```sql
SELECT 
	-- Get the total duration of all runs
	SUM(duration_mins)
FROM 
	runs_fact
-- Get all the week_id's that are from July, 2019
INNER JOIN week_dim ON week_dim.week_id = runs_fact.week_id
WHERE month = 'July' and year = '2019';
```

## Running from star to snowflake
Remember your running database from last chapter? 

After learning about the snowflake schema, you convert the current star schema into a snowflake schema. To do this, you normalize route_dim and week_dim. Which option best describes the resulting new tables after doing this?

The tables runs_fact, route_dim, and week_dim have been loaded.

Possible Answers
- [ ] week_dim is extended two dimensions with new tables for month and year. route_dim is extended one dimension with a new table for city.
- [x] week_dim is extended two dimensions with new tables for month and year. route_dim is extended two dimensions with new tables for city and park.
- [ ] week_dim is extended three dimensions with new tables for week, month and year. route_dim is extended one dimension with new tables for city and park.



## Adding foreign keys
Foreign key references are essential to both the snowflake and star schema. When creating either of these schemas, correctly setting up the foreign keys is vital because they connect dimensions to the fact table. They also enforce a one-to-many relationship, because unless otherwise specified, a foreign key can appear more than once in a table and primary key can appear only once.

The fact_booksales table has three foreign keys: book_id, time_id, and store_id. In this exercise, the four tables that make up the star schema below have been loaded. However, the foreign keys still need to be added. 

- [x] In the constraint called sales_book, set book_id as a foreign key.
- [x] In the constraint called sales_time, set time_id as a foreign key.
- [x] In the constraint called sales_store, set store_id as a foreign key.

```sql
-- Add the book_id foreign key
ALTER TABLE fact_booksales ADD CONSTRAINT sales_book
    FOREIGN KEY (book_id) REFERENCES dim_book_star (book_id);
    
-- Add the time_id foreign key
ALTER TABLE fact_booksales ADD CONSTRAINT sales_time
   FOREIGN KEY (time_id) REFERENCES dim_time_star (time_id);
    
-- Add the store_id foreign key
ALTER TABLE fact_booksales ADD CONSTRAINT sales_store
   FOREIGN KEY (store_id) REFERENCES dim_store_star (store_id);
```

## Extending the book dimension
In the video, we saw how the book dimension differed between the star and snowflake schema. The star schema's dimension table for books, dim_book_star, has been loaded and below is the snowflake schema of the book dimension. 

In this exercise, you are going to extend the star schema to meet part of the snowflake schema's criteria. Specifically, you will create dim_author from the data provided in dim_book_star.

- [x] Create dim_author with a column for author.
- [x] Insert all the distinct authors from dim_book_star into dim_author.

```sql
-- Create a new table for dim_author with an author column
CREATE TABLE dim_author (
    author varchar(256)  NOT NULL
);

-- Insert authors 
INSERT INTO dim_author
SELECT DISTINCT author FROM dim_book_star;
```

- [x] Alter dim_author to have a primary key called author_id.
- [x] Output all the columns of dim_author.

```sql
-- Create a new table for dim_author with an author column
CREATE TABLE dim_author (
    author varchar(256)  NOT NULL
);

-- Insert authors 
INSERT INTO dim_author
SELECT DISTINCT author FROM dim_book_star;

-- Add a primary key 
ALTER TABLE dim_author ADD COLUMN author_id SERIAL PRIMARY KEY;

-- Output the new table
SELECT * FROM dim_author;
```

## Querying the star schema
The novel genre hasn't been selling as well as your company predicted. To help remedy this, you've been tasked to run some analytics on the novel genre to find which areas the Sales team should target. To begin, you want to look at the total amount of sales made in each state from books in the novel genre.

Luckily, you've just finished setting up a data warehouse with the following star schema:

The tables from this schema have been loaded.

- [x] Select state from the appropriate table and the total sales_amount.
- [x] Complete the JOIN on book_id.
- [x] Complete the JOIN to connect the dim_store_star table
- [x] Conditionally select for books with the genre novel.
- [x] Group the results by state.

```sql
-- Output each state and their total sales_amount
SELECT dim_store_star.state, sum(sales_amount)
FROM fact_booksales
	-- Join to get book information
    JOIN dim_book_star on fact_booksales.book_id = dim_book_star.book_id
	-- Join to get store information
    JOIN dim_store_star on fact_booksales.store_id = dim_store_star.store_id
-- Get all books with in the novel genre
WHERE  
    dim_book_star.genre = 'novel'
-- Group results by state
GROUP BY
    dim_store_star.state;
```

## Querying the snowflake schema
Imagine that you didn't have the data warehouse set up. Instead, you'll have to run this query on the company's operational database, which means you'll have to rewrite the previous query with the following snowflake schema:

The tables in this schema have been loaded. Remember, our goal is to find the amount of money made from the novel genre in each state.

- [x] Select state from the appropriate table and the total sales_amount.
- [x] Complete the two JOINS to get the genre_id's.
- [x] Complete the three JOINS to get the state_id's.
- [x] Conditionally select for books with the genre novel.
- [x] Group the results by state.

```sql
-- Output each state and their total sales_amount
SELECT dim_state_sf.state, sum(sales_amount)
FROM fact_booksales
    -- Joins for the genre
    JOIN dim_book_sf on fact_booksales.book_id = dim_book_sf.book_id
    JOIN dim_genre_sf on dim_book_sf.genre_id = dim_genre_sf.genre_id
    -- Joins for the state 
    JOIN dim_store_sf on fact_booksales.store_id = dim_store_sf.store_id 
    JOIN dim_city_sf on dim_store_sf.city_id = dim_city_sf.city_id
	JOIN dim_state_sf on  dim_city_sf.state_id = dim_state_sf.state_id
-- Get all books with in the novel genre and group the results by state
WHERE  
    dim_genre_sf.genre = 'novel'
GROUP BY
   dim_state_sf.state;
```

## Updating countries
Going through the company data, you notice there are some inconsistencies in the store addresses. These probably occurred during data entry, where people fill in fields using different naming conventions. This can be especially seen in the country field, and you decide that countries should be represented by their abbreviations. The only countries in the database are Canada and the United States, which should be represented as USA and CA.

In this exercise, you will compare the records that need to be updated in order to do this task on the star and snowflake schema. dim_store_star and dim_country_sf have been loaded.


- [x] Output all the records that need to be updated in the star schema so that countries are represented by their abbreviations.

```sql
-- Output records that need to be updated in the star schema
SELECT * FROM dim_store_star
WHERE country != 'USA' AND country !='CA';
```

Question
How many records would need to be updated in the snowflake schema?

Possible Answers
- [ ] 18 records
- [ ] 2 records
- [x] 1 record
- [ ] 0 records


## Extending the snowflake schema
The company is thinking about extending their business beyond bookstores in Canada and the US. Particularly, they want to expand to a new continent. In preparation, you decide a continent field is needed when storing the addresses of stores.

Luckily, you have a snowflake schema in this scenario. As we discussed in the video, the snowflake schema is typically faster to extend while ensuring data consistency. Along with dim_country_sf, a table called dim_continent_sf has been loaded. It contains the only continent currently needed, North America, and a primary key. In this exercise, you'll need to extend dim_country_sf to reference dim_continent_sf.

- [x] Add a continent_id column to dim_country_sf with a default value of 1. Note thatNOT NULL DEFAULT(1) constrains a value from being null and defaults its value to 1.
- [x] Make that new column a foreign key reference to dim_continent_sf's continent_id.

```sql
-- Add a continent_id column with default value of 1
ALTER TABLE dim_country_sf
ADD continent_id int NOT NULL DEFAULT(1);

-- Add the foreign key constraint
ALTER TABLE dim_country_sf ADD CONSTRAINT country_continent
   FOREIGN KEY (continent_id) REFERENCES dim_continent_sf(continent_id);
   
-- Output updated table
SELECT * FROM dim_country_sf;
```

## Converting to 1NF
In the next three exercises, you'll be working through different tables belonging to a car rental company. Your job is to explore different schemas and gradually increase the normalization of these schemas through the different normal forms. At this stage, we're not worried about relocating the data, but rearranging the tables.

A table called customers has been loaded, which holds information about customers and the cars they have rented.

Question
Does the customers table meet 1NF criteria?

Possible Answers
- [ ] Yes, all the records are unique.
- [x] No, because there are multiple values in cars_rented and invoice_id
- [ ] No, because the non-key columns such as don't depend on customer_id, the primary key.


- [x] cars_rented holds one or more car_ids and invoice_id holds multiple values. Create a new table to hold individual car_ids and invoice_ids of the customer_ids who've rented those cars.
- [x] Drop two columns from customers table to satisfy 1NF

```sql
-- Create a new table to hold the cars rented by customers
CREATE TABLE cust_rentals (
  customer_id INT NOT NULL,
  car_id VARCHAR(128) NULL,
  invoice_id VARCHAR(128) NULL
);

-- Drop a column from customers table to satisfy 1NF
ALTER TABLE customers
DROP COLUMN cars_rented,
DROP COLUMN invoice_id;
```

## Converting to 2NF
Let's try normalizing a bit more. In the last exercise, you created a table holding customer_ids and car_ids. This has been expanded upon and the resulting table, customer_rentals, has been loaded for you. Since you've got 1NF down, it's time for 2NF.

Question
Why doesn't customer_rentals meet 2NF criteria?

Possible Answers
- [ ] Because the end_date doesn't depend on all the primary keys.
- [ ] Because there can only be at most two primary keys.
- [x] Because there are non-key attributes describing the car that only depend on one primary key, car_id.


- [x] Create a new table for the non-key columns that were conflicting with 2NF criteria.
- [x] Drop those non-key columns from customer_rentals.

```sql
-- Create a new table to satisfy 2NF
CREATE TABLE cars (
  car_id VARCHAR(256) NULL,
  model VARCHAR(128),
  manufacturer VARCHAR(128),
  type_car VARCHAR(128),
  condition VARCHAR(128),
  color VARCHAR(128)
);

-- Drop columns in customer_rentals to satisfy 2NF
ALTER TABLE customer_rentals
DROP COLUMN model,
DROP COLUMN manufacturer, 
DROP COLUMN type_car,
DROP COLUMN condition,
DROP COLUMN color;
```

## Converting to 3NF
Last, but not least, we are at 3NF. In the last exercise, you created a table holding car_idss and car attributes. This has been expanded upon. For example, car_id is now a primary key. The resulting table, rental_cars, has been loaded for you.

Question
Why doesn't rental_cars meet 3NF criteria?

Possible Answers
- [x] Because there are two columns that depend on the non-key column, model.
- [ ] Because there are two columns that depend on the non-key column, color.
- [ ] Because 2NF criteria isn't satisfied.


- [x] Create a new table for the non-key columns that were conflicting with 3NF criteria.
- [x] Drop those non-key columns from rental_cars.

```sql
-- Create a new table to satisfy 3NF
CREATE TABLE car_model(
  model VARCHAR(128),
  manufacturer VARCHAR(128),
  type_car VARCHAR(128)
);

-- Drop columns in rental_cars to satisfy 3NF
ALTER TABLE rental_cars
DROP COLUMN manufacturer, 
DROP COLUMN type_car;
```

## Viewing views
Because views are very useful, it's common to end up with many of them in your database. It's important to keep track of them so that database users know what is available to them.

The goal of this exercise is to get familiar with viewing views within a database and interpreting their purpose. This is a skill needed when writing database documentation or organizing views.

- [x] Query the information schema to get views.
- [x] Exclude system views in the results.

```sql
-- Get all non-systems views
SELECT * FROM information_schema.views
WHERE table_schema NOT IN ('pg_catalog', 'information_schema');
```

Question
What does view1 do?

Possible Answers
- [ ] Returns the content records with reviewids that have been viewed more than 4000 times.
- [x] Returns the content records that have reviews of more than 4000 characters.
- [ ] Returns the first 4000 records in content.

Question
What does view2 do?

Possible Answers
- [ ] Returns 10 random reviews published in 2017.
- [ ] Returns the top 10 lowest scored reviews published in 2017.
- [x] Returns the top 10 highest scored reviews published in 2017.


## Creating and querying a view
Have you ever found yourself running the same query over and over again? Maybe, you used to keep a text copy of the query in your desktop notes app, but that was all before you knew about views!

In these Pitchfork reviews, we're particularly interested in high-scoring reviews and if there's a common thread between the works that get high scores. In this exercise, you'll make a view to help with this analysis so that we don't have to type out the same query often to get these high-scoring reviews.

- [x] Create a view called high_scores that holds reviews with scores above a 9.

```sql
-- Create a view for reviews with a score above 9
CREATE VIEW high_scores AS
SELECT * FROM REVIEWS
WHERE score > 9;
```

- [x] Count the number of records in high_scores that are self-released in the label field of the labels table.

```sql
-- Create a view for reviews with a score above 9
CREATE VIEW high_scores AS
SELECT * FROM REVIEWS
WHERE score > 9;

-- Count the number of self-released works in high_scores
SELECT COUNT(*) FROM high_scores
INNER JOIN labels ON high_scores.reviewid = labels.reviewid
WHERE label = 'self-released';
```

## Creating a view from other views
Views can be created from queries that include other views. This is useful when you have a complex schema, potentially due to normalization, because it helps reduce the JOINS needed. The biggest concern is keeping track of dependencies, specifically how any modifying or dropping of a view may affect other views.

In the next few exercises, we'll continue using the Pitchfork reviews data. There are two views of interest in this exercise. top_15_2017 holds the top 15 highest scored reviews published in 2017 with columns reviewid,title, and score. artist_title returns a list of all reviewed titles and their respective artists with columns reviewid, title, and artist. From these views, we want to create a new view that gets the highest scoring artists of 2017.

- [x] Create a view called top_artists_2017 with one column artist holding the top artists in 2017.
- [x] Join the views top_15_2017 and artist_title.
- [x] Output top_artists_2017.

```sql
-- Create a view with the top artists in 2017
CREATE VIEW top_artists_2017 AS
-- with only one column holding the artist field
SELECT artist_title.artist FROM artist_title
INNER JOIN top_15_2017
ON artist_title.reviewid = top_15_2017.reviewid;

-- Output the new view
SELECT * FROM top_artists_2017;
```

Question
Which is the DROP command that would drop both top_15_2017 and top_artists_2017?

Possible Answers
- [x] DROP VIEW top_15_2017 CASCADE;
- [ ] DROP VIEW top_15_2017 RESTRICT;
- [ ] DROP VIEW top_artists_2017 RESTRICT;
- [ ] DROP VIEW top_artists_2017 CASCADE;


## Granting and revoking access
Access control is a key aspect of database management. Not all database users have the same needs and goals, from analysts, clerks, data scientists, to data engineers. As a general rule of thumb, write access should never be the default and only be given when necessary.

In the case of our Pitchfork reviews, we don't want all database users to be able to write into the long_reviews view. Instead, the editor should be the only user able to edit this view.

- [x] Revoke all database users' update and insert privileges on the long_reviews view.
- [x] Grant the editor user update and insert privileges on the long_reviews view.

```sql
-- Revoke everyone's update and insert privileges
REVOKE UPDATE, INSERT ON long_reviews FROM PUBLIC; 

-- Grant editor update and insert privileges 
GRANT UPDATE, INSERT ON long_reviews TO editor; 
```

## Updatable views
In a previous exercise, we've used the information_schema.views to get all the views in a database. If you take a closer look at this table, you will notice a column that indicates whether the view is updatable.

Which views are updatable?

Possible Answers
- [ ] long_reviews and top_25_2017
- [ ] top_25_2017
- [x] long_reviews
- [ ] top_25_2017 and artist_title


## Redefining a view
Unlike inserting and updating, redefining a view doesn't mean modifying the actual data a view holds. Rather, it means modifying the underlying query that makes the view. In the last video, we learned of two ways to redefine a view: (1) CREATE OR REPLACE and (2) DROP then CREATE. CREATE OR REPLACE can only be used under certain conditions.

The artist_title view needs to be appended to include a column for the label field from the labels table.

Question
Can the CREATE OR REPLACE statement be used to redefine the artist_title view?

Possible Answers
- [x] Yes, as long as the label column comes at the end.
- [ ] No, because the new query requires a JOIN with the labels table.
- [ ] No, because a new column that did not exist previously is being added to the view.
- [ ] Yes, as long as the label column has the same data type as the other columns in artist_title


- [x] Redefine the artist_title view to include a column for the label field from the labels table.
```sql
-- Redefine the artist_title view to have a label column
CREATE OR REPLACE VIEW artist_title AS
SELECT reviews.reviewid, reviews.title, artists.artist, labels.label
FROM reviews
INNER JOIN artists
ON artists.reviewid = reviews.reviewid
INNER JOIN labels
ON labels.reviewid = reviews.reviewid;

SELECT * FROM artist_title;
```

## Creating and refreshing a materialized view
The syntax for creating materialized and non-materialized views are quite similar because they are both defined by a query. One key difference is that we can refresh materialized views, while no such concept exists for non-materialized views. It's important to know how to refresh a materialized view, otherwise the view will remain a snapshot of the time the view was created.

In this exercise, you will create a materialized view from the table genres. A new record will then be inserted into genres. To make sure the view has the latest data, it will have to be refreshed.

- [x] Create a materialized view called genre_count that holds the number of reviews for each genre.
- [x] Refresh genre_count so that the view is up-to-date.

```sql
-- Create a materialized view called genre_count 
CREATE MATERIALIZED VIEW genre_count AS
SELECT genre, COUNT(*) 
FROM genres
GROUP BY genre;

INSERT INTO genres
VALUES (50000, 'classical');

-- Refresh genre_count
REFRESH MATERIALIZED VIEW genre_count;

SELECT * FROM genre_count;
```

## Managing materialized views
Why do companies use pipeline schedulers, such as Airflow and Luigi, to manage materialized views?

Possible Answers
- [ ] To set up a data warehouse and make sure tables have the most up-to-date data.

- [x] To refresh materialized views with consideration to dependences between views.

- [ ] To convert non-materialized views to materialized views.

- [ ] To prevent the creation of new materialized views when there are too many dependencies.


## Create a role
A database role is an entity that contains information that define the role's privileges and interact with the client authentication system. Roles allow you to give different people (and often groups of people) that interact with your data different levels of access.

Imagine you founded a startup. You are about to hire a group of data scientists. You also hired someone named Marta who needs to be able to login to your database. You're also about to hire a database administrator. In this exercise, you will create these roles.

- [x] Create a role called data_scientist.
```sql
-- Create a data scientist role
CREATE ROLE data_scientist;
```

- [x] Create a role called marta that has one attribute: the ability to login (LOGIN).

```sql
-- Create a role for Marta
CREATE ROLE marta LOGIN;
```

- [x] Create a role called admin with the ability to create databases (CREATEDB) and to create roles (CREATEROLE).

```sql
-- Create an admin role
CREATE ROLE admin WITH CREATEDB CREATEROLE;
```

## GRANT privileges and ALTER attributes
Once roles are created, you grant them specific access control privileges on objects, like tables and views. Common privileges being SELECT, INSERT, UPDATE, etc.

Imagine you're a cofounder of that startup and you want all of your data scientists to be able to update and insert data in the long_reviews view. In this exercise, you will enable those soon-to-be-hired data scientists by granting their role (data_scientist) those privileges. Also, you'll give Marta's role a password.

- [x] Grant the data_scientist role update and insert privileges on the long_reviews view.
- [x] Alter Marta's role to give her the provided password.

```sql
-- Grant data_scientist update and insert privileges
GRANT UPDATE, INSERT ON long_reviews TO data_scientist;

-- Give Marta's role a password
ALTER ROLE marta WITH PASSWORD 's3cur3p@ssw0rd';
```

## Add a user role to a group role
There are two types of roles: user roles and group roles. By assigning a user role to a group role, a database administrator can add complicated levels of access to their databases with one simple command.

For your startup, your search for data scientist hires is taking longer than expected. Fortunately, it turns out that Marta, your recent hire, has previous data science experience and she's willing to chip in the interim. In this exercise, you'll add Marta's user role to the data scientist group role. You'll then remove her after you complete your hiring process.

- [x] Add Marta's user role to the data scientist group role.
- [x] Celebrate! You hired multiple data scientists.
- [x] Remove Marta's user role from the data scientist group role.

```sql
-- Add Marta to the data scientist group
GRANT data_scientist TO marta;

-- Celebrate! You hired data scientists.

-- Remove Marta from the data scientist group
REVOKE data_scientist FROM marta;
```

## Reasons to partition
In the video, you saw some very good reasons to use partitioning. However, can you find which one wouldn't be a good reason to use partitioning?

Possible Answers
- [x] Improve data integrity

- [ ] Save records from 2017 or earlier on a slower medium

- [ ] Easily extend partitioning to sharding, and thus making use of parallelization


## Creating vertical partitions
In the video, you learned about vertical partitioning and saw an example.

For vertical partitioning, there is no specific syntax in PostgreSQL. You have to create a new table with particular columns and copy the data there. Afterward, you can drop the columns you want in the separate partition. If you need to access the full table, you can do so by using a JOIN clause.

In this exercise and the next one, you'll be working with the example database called pagila. It's a database that is often used to showcase PostgreSQL features. The database contains several tables. We'll be working with the film table. In this exercise, we'll use the following columns:

film_id: the unique identifier of the film
long_description: a lengthy description of the film

- [x] Create a new table film_descriptions containing 2 fields: film_id, which is of type INT, and long_description, which is of type TEXT.
- [x] Occupy the new table with values from the film table.

```sql
-- Create a new table called film_descriptions
CREATE TABLE film_descriptions (
    film_id INT,
    long_description TEXT
);

-- Copy the descriptions from the film table
INSERT INTO film_descriptions
SELECT film_id, long_description FROM film;
```

- [x] Drop the field long_description from the film table.
- [x] Join the two resulting tables to view the original table.

```sql
-- Create a new table called film_descriptions
CREATE TABLE film_descriptions (
    film_id INT,
    long_description TEXT
);

-- Copy the descriptions from the film table
INSERT INTO film_descriptions
SELECT film_id, long_description FROM film;
    
-- Drop the column in the original table
ALTER TABLE film DROP COLUMN long_description;

-- Join to create the original table
SELECT * FROM film 
JOIN film_descriptions USING(film_id);
```

## Creating horizontal partitions
In the video, you also learned about horizontal partitioning.

The example of horizontal partitioning showed the syntax necessary to create horizontal partitions in PostgreSQL. If you need a reminder, you can have a look at the slides.

In this exercise, however, you'll be using a list partition instead of a range partition. For list partitions, you form partitions by checking whether the partition key is in a list of values or not.

To do this, we partition by LIST instead of RANGE. When creating the partitions, you should check if the values are IN a list of values.

We'll be using the following columns in this exercise:

film_id: the unique identifier of the film
title: the title of the film
release_year: the year it's released

- [x] Create the table film_partitioned, partitioned on the field release_year.
```sql
-- Create a new table called film_partitioned
CREATE TABLE film_partitioned (
  film_id INT,
  title TEXT NOT NULL,
  release_year TEXT
)
PARTITION BY LIST (release_year);
```

- [x] Create three partitions: one for each release year: 2017, 2018, and 2019. Call the partition for 2019 film_2019, etc.
```sql
-- Create a new table called film_partitioned
CREATE TABLE film_partitioned (
  film_id INT,
  title TEXT NOT NULL,
  release_year TEXT
)
PARTITION BY LIST (release_year);

-- Create the partitions for 2019, 2018, and 2017
CREATE TABLE film_2019
	PARTITION OF film_partitioned FOR VALUES IN ('2019');

CREATE TABLE film_2018
	PARTITION OF film_partitioned FOR VALUES IN ('2018');

CREATE TABLE film_2017
	PARTITION OF film_partitioned FOR VALUES IN ('2017');
```

- [x] Occupy the new table the three fields required from the film table.
```sql
-- Create a new table called film_partitioned
CREATE TABLE film_partitioned (
  film_id INT,
  title TEXT NOT NULL,
  release_year TEXT
)
PARTITION BY LIST (release_year);

-- Create the partitions for 2019, 2018, and 2017
CREATE TABLE film_2019
	PARTITION OF film_partitioned FOR VALUES IN ('2019');

CREATE TABLE film_2018
	PARTITION OF film_partitioned FOR VALUES IN ('2018');

CREATE TABLE film_2017
	PARTITION OF film_partitioned FOR VALUES IN ('2017');

-- Insert the data into film_partitioned
INSERT INTO film_partitioned
SELECT film_id, title, release_year FROM film;

-- View film_partitioned
SELECT * FROM film_partitioned;
```

## Analyzing a data integration plan
You're a data analyst in a hospital that wants to make sure there is enough cough medicine should an epidemic break out. For this, you need to combine the historical health records with the upcoming appointments to see if you can detect a pattern similar to the last cold epidemic. Then, you need to make sure there is sufficient stock available or if the stock should be increased. To help tackle this problem, you created a data integration plan.

Which risk is not clearly indicated on the data integration plan?

Data integration diagram

Possible Answers
- [ ] It is unclear if you took data governance into account.

- [ ] You didn't clearly show where your data originated from.

- [x] You should indicate that you plan to anonymize patient health records.

- [ ] If data is lost during ETL you will not find out.


## SQL versus NoSQL
Deciding when to use a SQL versus NoSQL DBMS depends on the kind of information you’re storing and the best way to store it. Both types store data, they just store data differently.

When is it better to use a SQL DBMS?

Possible Answers
- [ ] You are dealing with rapidly evolving features, functions, data types, and it’s difficult to predict how the application will grow over time.

- [ ] You have a lot of data, many different data types, and your data needs will only grow over time.

- [x] You are concerned about data consistency and 100% data integrity is your top goal.

- [ ] Your data needs scale up, out, and down.
