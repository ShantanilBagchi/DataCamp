# Introduction to Relational Databases in SQL

### Notes 1: Your First Database
A relational database:
  * real-life *entities* becomes *tables*
  * reduced redundancy
  * data integrity by *relationships*

Concepts to know:
  * constraints
  * keywords
  * referential integrity

**'information_schema'** is actually some sort of meta-database that holds information about our current database.

```SQL
SELECT table_scheme, table_name
FROM information_schema.tables;
```

<hr>

#### Attributes of relational databases

In the video, we talked about some basic facts about relational databases. Which of the following statements does not hold true for databases? Relational databases …

- [ ] … store different real-world entities in different tables.
- [ ] … allow to establish relationships between entities.
- [x] … are called "relational" because they store data only about people.
- [ ] … use constraints, keys and referential integrity in order to assure data quality.

<hr>

#### Query information_schema with SELECT

`information_schema` is a meta-database that holds information about your current database. `information_schema` has multiple tables you can query with the known `SELECT * FROM` syntax:

* `tables`: information about all tables in your current database
* `columns`: information about all columns in all of the tables in your current database
* …

In this exercise, you'll only need information from the ``'public'`` schema, which is specified as the column `table_schema` of the `tables` and `columns` tables. The 'public' schema holds information about user-defined tables and databases. The other types of table_schema hold system information – for this course, you're only interested in user-defined stuff.

- [x] Get information on all table names in the current database, while limiting your query to the 'public' table_schema.

```SQL
-- Query the right table in information_schema
SELECT table_name
FROM information_schema.tables
-- Specify the correct table_schema value
WHERE table_schema = 'public';
```

- [x] Now have a look at the columns in university_professors by selecting all entries in information_schema.columns that correspond to that table.

```sql
-- Query the right table in information_schema to get columns
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'university_professors' AND table_schema = 'public';
```

- [x] How many columns does the table university_professors have?


* 12
* 9
* 8
* 5

Answer: 8


- [x] Finally, print the first five rows of the university_professors table.

```sql
-- Query the first five rows of our table
SELECT *
FROM university_professors
LIMIT 5;
```
<hr>

### Notes 2: **Tables**
* Create Tables using `CREATE TABLE` statement

```sql
CREATE TABLE table_name (
 column_a data_type,
 column_b data_type,
 column_c data_type
);
```

<hr>


#### CREATE your first few TABLEs
You'll now start implementing a better database model. For this, you'll create tables for the professors and universities entity types. The other tables will be created for you.

The syntax for creating simple tables is as follows:

CREATE TABLE table_name (
 column_a data_type,
 column_b data_type,
 column_c data_type
);
Attention: Table and columns names, as well as data types, don't need to be surrounded by quotation marks.


- [x] Create a table professors with two text columns: firstname and lastname.

```sql
-- Create a table for the professors entity type
CREATE TABLE professors (
 firstname text,
 lastname text
);

-- Print the contents of this table
SELECT *
FROM professors
```

- [x] Create a table universities with three text columns: university_shortname, university, and university_city.

```sql
-- Create a table for the universities entity type
CREATE TABLE universities (
    university_shortname text,
    university text,
    university_city text
);

-- Print the contents of this table
SELECT *
FROM universities
```
<hr>

#### ADD a COLUMN with ALTER TABLE
Oops! We forgot to add the university_shortname column to the professors table. You've probably already noticed:

In chapter 4 of this course, you'll need this column for connecting the professors table with the universities table.

However, adding columns to existing tables is easy, especially if they're still empty.

To add columns you can use the following SQL query:
```sql
ALTER TABLE table_name
ADD COLUMN column_name data_type;
```

- [x] Alter professors to add the text column university_shortname.

```sql
-- Add the university_shortname column
ALTER TABLE professors
ADD COLUMN university_shortname text;

-- Print the contents of this table
SELECT *
FROM professors
```
<hr>

### Notes 3: Update databases as structure changes

* In order to copy data from an existing table to a new one, we can use the `INSERT INTO SELECT DISTINCT` pattern.

```SQL
INSERT INTO organizations
SELECT DISTINCT organization,
  organization_sector
FROM university_professors;
```

Normally,
```SQL
INSERT INTO table_name (col1, col2)
VALUES ('val1',val2);
```

* Rename a column name
```sql
ALTER TABLE table_name
RENAME COLUMN old_name TO new_name;
```

* Drop a column name
```sql
ALTER TABLE table_name
DROP COLUMN column_name;
```
*Dropping columns is straightforward when the tables are empty*

<hr>

#### RENAME and DROP COLUMNs in affiliations
As mentioned in the video, the still empty affiliations table has some flaws. In this exercise, you'll correct them as outlined in the video.

You'll use the following queries:

To rename columns:
```sql
ALTER TABLE table_name
RENAME COLUMN old_name TO new_name;
```
To delete columns:
```SQL
ALTER TABLE table_name
DROP COLUMN column_name;
```

- [x] Rename the organisation column to organization in affiliations.

```sql
-- Rename the organisation column
ALTER TABLE affiliations
RENAME COLUMN organisation TO organization;
```

- [x] Delete the university_shortname column in affiliations.
```sql
-- Rename the organisation column
ALTER TABLE affiliations
RENAME COLUMN organisation TO organization;

-- Delete the university_shortname column
ALTER TABLE affiliations
DROP COLUMN university_shortname;
```
<hr>

#### Migrate data with INSERT INTO SELECT DISTINCT
Now it's finally time to migrate the data into the new tables. You'll use the following pattern:
```sql
INSERT INTO ...
SELECT DISTINCT ...
FROM ...;
```
It can be broken up into two parts:

First part:
```SQL
SELECT DISTINCT column_name1, column_name2, ...
FROM table_a;
```
This selects all distinct values in table table_a – nothing new for you.

Second part:
```sql
INSERT INTO table_b ...;
```

Take this part and append it to the first, so it inserts all distinct rows from table_a into table_b.

**One last thing**: It is important that you run all of the code at the same time once you have filled out the blanks.


- [x] Insert all DISTINCT professors from university_professors into professors.
- [x] Print all the rows in professors.

```sql
-- Insert unique professors into the new table
INSERT INTO professors
SELECT DISTINCT firstname, lastname, university_shortname
FROM university_professors;

-- Doublecheck the contents of professors
SELECT *
FROM professors;
```

- [x] Insert all DISTINCT affiliations into affiliations from university_professors.

```sql
-- Insert unique affiliations into the new table
INSERT INTO affiliations
SELECT DISTINCT firstname, lastname, function, organization
FROM university_professors;

-- Doublecheck the contents of affiliations
SELECT *
FROM affiliations;
```
<hr>

#### Delete tables with DROP TABLE
Obviously, the university_professors table is now no longer needed and can safely be deleted.

For table deletion, you can use the simple command:
```sql
DROP TABLE table_name;
```

- [x] Delete the university_professors table.

```sql
-- Delete the university_professors table
DROP TABLE university_professors;
```
<hr>

### Notes 4: Better data quality with constraints
The idea of a database is to push data into a certain structure- a pre-defined model, where we enforce data types, relationships and other rules. Generally, these rules are called **integrity constarints** , although different names exist.

**INTEGRITY CONSTRAINTS**
* **Attribute constraints** e.g. data types on columns
* **Key constraints** e.g primary keywords
* **Referential integrity constraints** enforced through foreign keys

Why Constraints?
* Constraints give the data structure e.g. we need to enter birthdates always in the same form.
* Constraints give us consistency, and thus data quality.
* Data quality is a business advantage.

Sometimes, we can `CAST` a column type to different type for calculation use.
```SQL
SELECT temperature * CAST(wind_speed AS integer) AS wind_chill
FROM weather;
```

<hr>

#### Types of database constraints
Which of the following is not used to enforce a database constraint?

- [ ] Foreign keys
- [x] SQL aggregate functions
- [ ] The BIGINT data type
- [ ] Primary keys

<hr>

#### Conforming with data types
For demonstration purposes, I created a fictional database table that only holds three records. The columns have the data types date, integer, and text, respectively.

```sql
CREATE TABLE transactions (
 transaction_date date,
 amount integer,
 fee text
);
```
Have a look at the contents of the transactions table.

The transaction_date accepts date values. According to the PostgreSQL documentation, it accepts values in the form of YYYY-MM-DD, DD/MM/YY, and so forth.

Both columns amount and fee appear to be numeric, however, the latter is modeled as text – which you will account for in the next exercise.

- [x] Execute the given sample code.
- [x] As it doesn't work, have a look at the error message and correct the statement accordingly – then execute it again.

```sql
-- Let's add a record to the table
INSERT INTO transactions (transaction_date, amount, fee)
VALUES ('2018-09-24', 5454, '30');

-- Doublecheck the contents
SELECT *
FROM transactions;
```
<hr>

#### Type CASTs
In the video, you saw that type casts are a possible solution for data type issues. If you know that a certain column stores numbers as text, you can cast the column to a numeric form, i.e. to integer.
```sql
SELECT CAST(some_column AS integer)
FROM table;
```
Now, the some_column column is temporarily represented as integer instead of text, meaning that you can perform numeric calculations on the column.

- [x] Execute the given sample code.
- [x] As it doesn't work, add an integer type cast at the right place and execute it again.

```sql
-- Calculate the net amount as amount + fee
-- SELECT transaction_date, amount + fee AS net_amount
SELECT transaction_date, amount + CAST(fee AS integer) AS net_amount
FROM transactions;
```
<hr>

### Notes 5: Working with data types
* Enforced on columns (i.e. attributes)
* Define the so-called 'domain' of a column
* Define what operations are possible
* Enforce consistent storage of values


The most common Types
* text: character strings of any lengths
* varchar(x): a maximum of n characters
* char (x); a fixed-length string of n characters
* boolean: can only take three states e.g. TRUE, FALSE and NULL
* date, time and timestamp
* numeric(n,m): total n digits with m after .decimal
* integer and bigint

Alter tables after creation with `USING` clause
```SQL
ALTER TABLE table_name
ALTER COLUMN col_name_Avg
TYPE integer
-- Turns 5.54 into 6, not 5, before type conversion
USING ROUND(col_name_Avg);
```

<hr>

#### Change types with ALTER COLUMN
The syntax for changing the data type of a column is straightforward. The following code changes the data type of the column_name column in table_name to varchar(10):

```sql
ALTER TABLE table_name
ALTER COLUMN column_name
TYPE varchar(10)
```
Now it's time to start adding constraints to your database.

- [x] Have a look at the distinct university_shortname values in the professors table and take note of the length of the strings.

```sql
-- Select the university_shortname column
SELECT DISTINCT(university_shortname)
FROM professors;
```

- [x] Now specify a fixed-length character type with the correct length for university_shortname.

```sql
-- Specify the correct fixed-length character type
ALTER TABLE professors
ALTER COLUMN university_shortname
TYPE char(3);
```

- [x] Change the type of the firstname column to varchar(64).

```sql
-- Change the type of firstname
ALTER TABLE professors
ALTER COLUMN firstname
TYPE varchar(64);
```
<hr>

#### Convert types USING a function
If you don't want to reserve too much space for a certain varchar column, you can truncate the values before converting its type.

For this, you can use the following syntax:

```sql
ALTER TABLE table_name
ALTER COLUMN column_name
TYPE varchar(x)
USING SUBSTRING(column_name FROM 1 FOR x)
```

You should read it like this: Because you want to reserve only x characters for column_name, you have to retain a SUBSTRING of every value, i.e. the first x characters of it, and throw away the rest. This way, the values will fit the varchar(x) requirement.

- [x] Run the sample code as is and take note of the error.
- [x] Now use SUBSTRING() to reduce firstname to 16 characters so its type can be altered to varchar(16).

```sql
-- Convert the values in firstname to a max. of 16 characters
ALTER TABLE professors
ALTER COLUMN firstname
TYPE varchar(16)
USING SUBSTRING(firstname FROM 1 FOR 16)
```
<hr>

### Notes 6: NOT NULL and UNIQUE constraints
* NOT NULL constraint disallows NULL values in a certain column. It must hold true for the current state and also for the future state. So we can only specify it on a column that currently doesn't hold `NULL` values.

After creating a table, we can alter column by using
```SQL
ALTER TABLE table_name
ALTER COLUMN col_name
SET NOT NULL; or
(DROP NOT NULL;)
```

* `UNIQUE` constraint disallows duplicate values in a column. Similar to last one, this too must hold true for the current state and also for the future state.

```SQL
ALTER TABLE table_name
ADD CONSTRAINT some_name UNIQUE(col_name);
```
<hr>

#### Disallow NULL values with SET NOT NULL
The professors table is almost ready now. However, it still allows for NULLs to be entered. Although some information might be missing about some professors, there's certainly columns that always need to be specified.

- [x] Add a not-null constraint for the firstname column.

```sql
-- Disallow NULL values in firstname
ALTER TABLE professors
ALTER COLUMN firstname SET NOT NULL;
```

- [x] Add a not-null constraint for the lastname column.

```sql
-- Disallow NULL values in lastname
ALTER TABLE professors
ALTER COLUMN lastname SET NOT NULL
```
<hr>

#### What happens if you try to enter NULLs?
Execute the following statement:

```sql
INSERT INTO professors (firstname, lastname, university_shortname)
VALUES (NULL, 'Miller', 'ETH');
```

Why does this throw an error?

- [ ] Professors without first names do not exist.
- [x] Because a database constraint is violated.
- [ ] Error? This works just fine.
- [ ] NULL is not put in quotes.

<hr>

#### Make your columns UNIQUE with ADD CONSTRAINT
As seen in the video, you add the UNIQUE keyword after the column_name that should be unique. This, of course, only works for new tables:

```sql
CREATE TABLE table_name (
 column_name UNIQUE
);
```

If you want to add a unique constraint to an existing table, you do it like that:
```sql
ALTER TABLE table_name
ADD CONSTRAINT some_name UNIQUE(column_name);
```
Note that this is different from the ALTER COLUMN syntax for the not-null constraint. Also, you have to give the constraint a name some_name.

- [x] Add a unique constraint to the university_shortname column in universities. Give it the name university_shortname_unq.

```sql
-- Make universities.university_shortname unique
ALTER TABLE universities
ADD CONSTRAINT university_shortname_unq UNIQUE(university_shortname);
```

- [x] Add a unique constraint to the organization column in organizations. Give it the name organization_unq.

```sql
-- Make organizations.organization unique
ALTER TABLE organizations
ADD CONSTRAINT organization_unq UNIQUE(organization)
```
<hr>

### Notes 7: Keys and superkeys
* Attribute(s) that identify a record uniquely
* As long as attributes can be removed: **superkey**
* If no more attributes can be removed: minimal superkey or **key**

<hr>

#### Get to know SELECT COUNT DISTINCT
Your database doesn't have any defined keys so far, and you don't know which columns or combinations of columns are suited as keys.

There's a simple way of finding out whether a certain column (or a combination) contains only unique values – and thus identifies the records in the table.

You already know the SELECT DISTINCT query from the first chapter. Now you just have to wrap everything within the COUNT() function and PostgreSQL will return the number of unique rows for the given columns:

SELECT COUNT(DISTINCT(column_a, column_b, ...))
FROM table;

- [x] First, find out the number of rows in universities.

```sql
-- Count the number of rows in universities
SELECT COUNT(*)
FROM universities;
```

- [x] Then, find out how many unique values there are in the university_city column.
```sql
-- Count the number of distinct values in the university_city column
SELECT COUNT(DISTINCT(university_city))
FROM universities;
```
<hr>

#### Identify keys with SELECT COUNT DISTINCT
There's a very basic way of finding out what qualifies for a key in an existing, populated table:

1. Count the distinct records for all possible combinations of columns. If the resulting number x equals the number of all rows in the table for a combination, you have discovered a superkey.

2. Then remove one column after another until you can no longer remove columns without seeing the number x decrease. If that is the case, you have discovered a (candidate) key.

The table professors has 551 rows. It has only one possible candidate key, which is a combination of two attributes. You might want to try different combinations using the "Run code" button. Once you have found the solution, you can submit your answer.

- [x] Using the above steps, identify the candidate key by trying out different combination of columns.

```sql
-- Try out different combinations
SELECT COUNT(DISTINCT(firstname,lastname))
FROM professors;
```
<hr>

### Notes 8: Primary Keys
Every database should have a primary key- chosen very carefully to uniquely identify each row/records.

Primary keys need to be defined on columns that don't accept duplicate or null values.

Alter table after creation
```SQL
ALTER TABLE table_name
ADD CONSTRAINT some_name PRIMARY KEY(col_name);
```
<hr>

#### Identify the primary key
Have a look at the example table from the previous video. As the database designer, you have to make a wise choice as to which column should be the primary key.

|     license_no     | serial_no |    make    |  model  | year |
|--------------------|-----------|------------|---------|------|
| Texas ABC-739      | A69352    | Ford       | Mustang |    2 |
| Florida TVP-347    | B43696    | Oldsmobile | Cutlass |    5 |
| New York MPO-22    | X83554    | Oldsmobile | Delta   |    1 |
| California RSK-629 | Y82935    | Toyota     | Camry   |    4 |
| Texas RSK-629      | U028365   | Jaguar     | XJS     |    4 |

Which of the following column or column combinations could best serve as primary key?

- [ ] PK = {make}
- [ ] PK = {model, year}
- [x] PK = {license_no}
- [ ] PK = {year, make}

<hr>

#### ADD key CONSTRAINTs to the tables
Two of the tables in your database already have well-suited candidate keys consisting of one column each: organizations and universities with the organization and university_shortname columns, respectively.

In this exercise, you'll rename these columns to id using the RENAME COLUMN command and then specify primary key constraints for them. This is as straightforward as adding unique constraints (see the last exercise of Chapter 2):
```sql
ALTER TABLE table_name
ADD CONSTRAINT some_name PRIMARY KEY (column_name)
```
Note that you can also specify more than one column in the brackets.


- [x] Rename the organization column to id in organizations.
- [x] Make id a primary key and name it organization_pk.

```sql
-- Rename the organization column to id
ALTER TABLE organizations
RENAME COLUMN organization TO id;

-- Make id a primary key
ALTER TABLE organizations
ADD CONSTRAINT organization_pk PRIMARY KEY (id);
```
- [x] Rename the university_shortname column to id in universities.
- [x] Make id a primary key and name it university_pk.

```sql
-- Rename the university_shortname column to id
ALTER TABLE universities
RENAME COLUMN university_shortname TO id;

-- Make id a primary key
ALTER TABLE universities
ADD CONSTRAINT university_pk PRIMARY KEY (id);
```
<hr>

### Notes 9: Surrogate keys
Surrogate keys are sort of an artificial primary key, they are not based on a native column in our data but on a column that just exists for the sake of having a primary key.

**Basically, when we aren't able to find any particular column to be a candidate for primary key, we can assign `id` which can have `serial` data type**

```SQL
ALTER TABLE table_name
ADD COLUMN id serial PRIMARY KEY;
```
**Another strategy can be to `CONCAT` two columns to form a new column that works as the primary key**

```SQL
ALTER TABLE table_name
ADD COLUMN col_c varchar(256);

UPDATE table_name
SET col_c= CONCAT(col_a,col_b);

ALTER TABLE table_name
ADD CONSTRAINT pk PRIMAY KEY(col_c);
```
<hr>

#### Add a SERIAL surrogate key
Since there's no single column candidate key in professors (only a composite key candidate consisting of firstname, lastname), you'll add a new column id to that table.

This column has a special data type serial, which turns the column into an auto-incrementing number. This means that, whenever you add a new professor to the table, it will automatically get an id that does not exist yet in the table: a perfect primary key!


- [x] Add a new column id with data type serial to the professors table.

```sql
-- Add the new column to the table
ALTER TABLE professors
ADD COLUMN id serial;
```

- [x] Make id a primary key and name it professors_pkey.

```sql
-- Add the new column to the table
ALTER TABLE professors
ADD COLUMN id serial;

-- Make id a primary key
ALTER TABLE professors
ADD CONSTRAINT professors_pkey PRIMARY KEY (id);
```

- [x] Write a query that returns all the columns and 10 rows from professors.

```sql
-- Add the new column to the table
ALTER TABLE professors
ADD COLUMN id serial;

-- Make id a primary key
ALTER TABLE professors
ADD CONSTRAINT professors_pkey PRIMARY KEY (id);

-- Have a look at the first 10 rows of professors
SELECT * FROM professors LIMIT 10;
```
<hr>

#### CONCATenate columns to a surrogate key
Another strategy to add a surrogate key to an existing table is to concatenate existing columns with the CONCAT() function.

Let's think of the following example table:
```sql
CREATE TABLE cars (
 make varchar(64) NOT NULL,
 model varchar(64) NOT NULL,
 mpg integer NOT NULL
)
```
The table is populated with 10 rows of completely fictional data.

Unfortunately, the table doesn't have a primary key yet. None of the columns consists of only unique values, so some columns can be combined to form a key.

In the course of the following exercises, you will combine make and model into such a surrogate key.

- [x] Count the number of distinct rows with a combination of the make and model columns.

```sql
-- Count the number of distinct rows with columns make, model
SELECT COUNT(DISTINCT(make, model))
FROM cars;
```

- [x] Add a new column id with the data type varchar(128).

```sql
-- Count the number of distinct rows with columns make, model
SELECT COUNT(DISTINCT(make, model))
FROM cars;

-- Add the id column
ALTER TABLE cars
ADD COLUMN id varchar(128);
```

- [x] Concatenate make and model into id using an UPDATE table_name SET column_name = ... query and the CONCAT() function.

```sql
-- Count the number of distinct rows with columns make, model
SELECT COUNT(DISTINCT(make, model))
FROM cars;

-- Add the id column
ALTER TABLE cars
ADD COLUMN id varchar(128);

-- Update id with make + model
UPDATE cars
SET id = CONCAT(make, model);
```

- [x] Make id a primary key and name it id_pk.

```sql
-- Count the number of distinct rows with columns make, model
SELECT COUNT(DISTINCT(make, model))
FROM cars;

-- Add the id column
ALTER TABLE cars
ADD COLUMN id varchar(128);

-- Update id with make + model
UPDATE cars
SET id = CONCAT(make, model);

-- Make id a primary key
ALTER TABLE cars
ADD CONSTRAINT id_pk PRIMARY KEY(id);

-- Have a look at the table
SELECT * FROM cars;
```
<hr>

#### Test your knowledge before advancing
Before you move on to the next chapter, let's quickly review what you've learned so far about attributes and key constraints. If you're unsure about the answer, please quickly review chapters 2 and 3, respectively.

Let's think of an entity type "student". A student has:

* a last name consisting of up to 128 characters (this cannot contain a missing value),
* a unique social security number of length 9, consisting only of integers,
* a phone number of fixed length 12, consisting of numbers and characters (but some students don't have one).

- [x] Given the above description of a student entity, create a table students with the correct column types.
- [x] Add a PRIMARY KEY for the social security number ssn.
*Note that there is no formal length requirement for the integer column. The application would have to make sure it's a correct SSN!*

```sql
-- Create the table
CREATE TABLE students (
  last_name varchar(128) NOT NULL,
  ssn integer PRIMARY KEY,
  phone_no char(12)
);
```
<hr>

### Notes 10: Model 1: N relationships with foreign Keys
* Foreign keys are designated columns that point to a primary key of another table.
* **Foreign can contain duplicates and 'NULL' values.**

Restrictions:
* The domain and the data type must be the same as one of the primary keys.
* Each value of FK must exist in PK of the other table (**referential integrity**)

```SQL
CREATE TABLE table_name(
col_1 varchar(255) PRIMARY KEY,
col_2 integer REFERENCES another_table_name(col_name)
);
```

<hr>

#### REFERENCE a table with a FOREIGN KEY
In your database, you want the professors table to reference the universities table. You can do that by specifying a column in professors table that references a column in the universities table.

As just shown in the video, the syntax for that looks like this:

```sql
ALTER TABLE a
ADD CONSTRAINT a_fkey FOREIGN KEY (b_id) REFERENCES b (id);
```
Table a should now refer to table b, via b_id, which points to id. a_fkey is, as usual, a constraint name you can choose on your own.

Pay attention to the naming convention employed here: Usually, a foreign key referencing another primary key with name id is named x_id, where x is the name of the referencing table in the singular form.

- [x] Rename the university_shortname column to university_id in professors.

```sql
-- Rename the university_shortname column
ALTER TABLE professors
RENAME COLUMN university_shortname TO university_id;
```

- [x] Add a foreign key on university_id column in professors that references the id column in universities.
- [x] Name this foreign key professors_fkey

```sql
-- Rename the university_shortname column
ALTER TABLE professors
RENAME COLUMN university_shortname TO university_id;

-- Add a foreign key on professors referencing universities
-- Add a foreign key on professors referencing universities
ALTER TABLE professors
ADD CONSTRAINT professors_fkey FOREIGN KEY (university_id) REFERENCES universities (id);
```
<hr>

#### Explore foreign key constraints
Foreign key constraints help you to keep order in your database mini-world. In your database, for instance, only professors belonging to Swiss universities should be allowed, as only Swiss universities are part of the universities table.

The foreign key on professors referencing universities you just created thus makes sure that only existing universities can be specified when inserting new data. Let's test this!

- [x] Run the sample code and have a look at the error message.
- [x] What's wrong? Correct the university_id so that it actually reflects where Albert Einstein wrote his dissertation and became a professor – at the University of Zurich (UZH)!

```sql
-- Try to insert a new professor
INSERT INTO professors (firstname, lastname, university_id)
VALUES ('Albert', 'Einstein', 'UZH');
```
<hr>

#### JOIN tables linked by a foreign key
Let's join these two tables to analyze the data further!

You might already know how SQL joins work from the Intro to SQL for Data Science course (last exercise) or from Joining Data in PostgreSQL.

Here's a quick recap on how joins generally work:

```sql
SELECT ...
FROM table_a
JOIN table_b
ON ...
WHERE ...
```

While foreign keys and primary keys are not strictly necessary for join queries, they greatly help by telling you what to expect. For instance, you can be sure that records referenced from table A will always be present in table B – so a join from table A will always find something in table B. If not, the foreign key constraint would be violated.

- [x] JOIN professors with universities on professors.university_id = universities.id, i.e., retain all records where the foreign key of professors is equal to the primary key of universities.
- [x] Filter for university_city = 'Zurich'.

```sql
-- Select all professors working for universities in the city of Zurich
SELECT professors.lastname, universities.id, universities.university_city
FROM professors
JOIN universities
ON professors.university_id = universities.id
WHERE universities.university_city = 'Zurich';
```
<hr>

### Notes 11: Model more complex relationships
When we want to implement a N:M relationships, we need more than one foreign key to point towards separate tables.

```SQL
CREATE TABLE table_name(
col1_id integer REFERENCES another_table_name(id),
col2_id varchar(256) REFERENCES yet_another_table(id)
);
```
<hr>

#### Add foreign keys to the "affiliations" table
At the moment, the affiliations table has the structure {firstname, lastname, function, organization}, as you can see in the preview at the bottom right. In the next three exercises, you're going to turn this table into the form {professor_id, organization_id, function}, with professor_id and organization_id being foreign keys that point to the respective tables.

You're going to transform the affiliations table in-place, i.e., without creating a temporary table to cache your intermediate results.

- [x] Add a professor_id column with integer data type to affiliations, and declare it to be a foreign key that references the id column in professors.

```sql
-- Add a professor_id column
ALTER TABLE affiliations
ADD COLUMN professor_id integer REFERENCES professors (id);
```

- [x] Rename the organization column in affiliations to organization_id.

```sql
-- Add a professor_id column
ALTER TABLE affiliations
ADD COLUMN professor_id integer REFERENCES professors (id);

-- Rename the organization column to organization_id
ALTER TABLE affiliations
RENAME organization TO organization_id
```

- [x] Add a foreign key constraint on organization_id so that it references the id column in organizations.

```sql
-- Add a professor_id column
ALTER TABLE affiliations
ADD COLUMN professor_id integer REFERENCES professors (id);

-- Rename the organization column to organization_id
ALTER TABLE affiliations
RENAME organization TO organization_id;

-- Add a foreign key on organization_id
ALTER TABLE affiliations
ADD CONSTRAINT affiliations_organization_fkey FOREIGN KEY (organization_id) REFERENCES organizations (id);
```
<hr>

#### Populate the "professor_id" column
Now it's time to also populate professors_id. You'll take the ID directly from professors.

Here's a way to update columns of a table based on values in another table:

```sql
UPDATE table_a
SET column_to_update = table_b.column_to_update_from
FROM table_b
WHERE condition1 AND condition2 AND ...;
```
This query does the following:

1. For each row in table_a, find the corresponding row in table_b where condition1, condition2, etc., are met.
2. Set the value of column_to_update to the value of column_to_update_from (from that corresponding row).

The conditions usually compare other columns of both tables, e.g. table_a.some_column = table_b.some_column. Of course, this query only makes sense if there is only one matching row in table_b.


- [x] First, have a look at the current state of affiliations by fetching 10 rows and all columns.
```sql
-- Have a look at the 10 first rows of affiliations
SELECT * FROM affiliations LIMIT 10;
```

- [x] Update the professor_id column with the corresponding value of the id column in professors. "Corresponding" means rows in professors where the firstname and lastname are identical to the ones in affiliations.

```sql
-- Update professor_id to professors.id where firstname, lastname correspond to rows in professors
UPDATE affiliations
SET professor_id = professors.id
FROM professors
WHERE affiliations.firstname = professors.firstname AND affiliations.lastname = professors.lastname;
```

- [x] Check out the first 10 rows and all columns of affiliations again. Have the professor_ids been correctly matched?

```sql
-- Update professor_id to professors.id where firstname, lastname correspond to rows in professors
UPDATE affiliations
SET professor_id = professors.id
FROM professors
WHERE affiliations.firstname = professors.firstname AND affiliations.lastname = professors.lastname;

-- Have a look at the 10 first rows of affiliations again
SELECT * FROM affiliations LIMIT 10;
```
<hr>

#### Drop "firstname" and "lastname"
The firstname and lastname columns of affiliations were used to establish a link to the professors table in the last exercise – so the appropriate professor IDs could be copied over. This only worked because there is exactly one corresponding professor for each row in affiliations. In other words: {firstname, lastname} is a candidate key of professors – a unique combination of columns.

It isn't one in affiliations though, because, as said in the video, professors can have more than one affiliation.

Because professors are referenced by professor_id now, the firstname and lastname columns are no longer needed, so it's time to drop them. After all, one of the goals of a database is to reduce redundancy where possible.

- [x] Drop the firstname and lastname columns from the affiliations table.

```sql
-- Drop the firstname column
ALTER TABLE affiliations
DROP COLUMN firstname;

-- Drop the lastname column
ALTER TABLE affiliations
DROP COLUMN lastname;
```
<hr>

### Notes 12: Referential Integrity
* *A record referencing another table must refer to an existing record in that table*.

A record in table_A cannot point to a record in table_B that doesn't exist. Referential integrity is enforced through foreign keys.

Violations:
* ..if a record in table_B that is referenced from a record in table_A is deleted.
* ..if a record in table_A referencing a non-existing record from table_B is inserted.

However, throwing an error is not the only option. If we specify a foreign key on a column, we can actually tell the database system what should happen if an entry in the referenced table is deleted. By default, the `ON DELETE NO ACTION` keyword is automatically appended.
However, there are other options like `ON DELETE CASCADE` keyword that will first delete the record in table_B and then automatically delete all referencing records in table_A.

* NO ACTION: Throw an error
* CASCADE: Delete all referencing records
* RESTRICT: Throw an error
* SET NULL: Set the referencing column to NULL
* SET DEFAULT: Set the referencing column to its default value.

<hr>

#### Referential integrity violations
Given the current state of your database, what happens if you execute the following SQL statement?

DELETE FROM universities WHERE id = 'EPF';

- [ ] It throws an error because the university with ID "EPF" does not exist.
- [ ] The university with ID "EPF" is deleted.
- [ ] It fails because referential integrity from universities to professors is violated.
- [x] It fails because referential integrity from professors to universities is violated.
<hr>

#### Change the referential integrity behavior of a key
So far, you implemented three foreign key constraints:

1. professors.university_id to universities.id
2. affiliations.organization_id to organizations.id
3. affiliations.professor_id to professors.id

These foreign keys currently have the behavior ON DELETE NO ACTION. Here, you're going to change that behavior for the column referencing organizations from affiliations. If an organization is deleted, all its affiliations (by any professor) should also be deleted.

Altering a key constraint doesn't work with ALTER COLUMN. Instead, you have to delete the key constraint and then add a new one with a different ON DELETE behavior.

For deleting constraints, though, you need to know their name. This information is also stored in information_schema.

- [x] Have a look at the existing foreign key constraints by querying table_constraints in information_schema.

```sql
-- Identify the correct constraint name
SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE constraint_type = 'FOREIGN KEY';
```

- [x] Delete the affiliations_organization_id_fkey foreign key constraint in affiliations.

```sql
-- Identify the correct constraint name
SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE constraint_type = 'FOREIGN KEY';

-- Drop the right foreign key constraint
ALTER TABLE affiliations
DROP CONSTRAINT affiliations_organization_id_fkey;
```

- [x] Add a new foreign key to affiliations that cascades deletion if a referenced record is deleted from organizations. Name it affiliations_organization_id_fkey.

```sql
-- Identify the correct constraint name
SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE constraint_type = 'FOREIGN KEY';

-- Drop the right foreign key constraint
ALTER TABLE affiliations
DROP CONSTRAINT affiliations_organization_id_fkey;

-- Add a new foreign key constraint from affiliations to organizations which cascades deletion
ALTER TABLE affiliations
ADD CONSTRAINT affiliations_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE CASCADE;
```

- [x] Run the DELETE and SELECT queries to double check that the deletion cascade actually works.

```sql
-- Identify the correct constraint name
SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE constraint_type = 'FOREIGN KEY';

-- Drop the right foreign key constraint
ALTER TABLE affiliations
DROP CONSTRAINT affiliations_organization_id_fkey;

-- Add a new foreign key constraint from affiliations to organizations which cascades deletion
ALTER TABLE affiliations
ADD CONSTRAINT affiliations_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE CASCADE;

-- Delete an organization
DELETE FROM organizations
WHERE id = 'CUREM';

-- Check that no more affiliations with this organization exist
SELECT * FROM affiliations
WHERE organization_id = 'CUREM';
```
<hr>

#### Count affiliations per university
Now that your data is ready for analysis, let's run some exemplary SQL queries on the database. You'll now use already known concepts such as grouping by columns and joining tables.

In this exercise, you will find out which university has the most affiliations (through its professors). For that, you need both affiliations and professors tables, as the latter also holds the university_id.

As a quick repetition, remember that joins have the following structure:

```sql
SELECT table_a.column1, table_a.column2, table_b.column1, ...
FROM table_a
JOIN table_b
ON table_a.column = table_b.column
```

This results in a combination of table_a and table_b, but only with rows where table_a.column is equal to table_b.column.

- [x] Count the number of total affiliations by university.
- [x] Sort the result by that count, in descending order.

```sql
-- Count the total number of affiliations per university
SELECT COUNT(*), professors.university_id
FROM affiliations
JOIN professors
ON affiliations.professor_id = professors.id
-- Group by the ids of professors
GROUP BY professors.university_id
ORDER BY COUNT DESC;
```
<hr>

#### Join all the tables together
In this last exercise, you will find the university city of the professor with the most affiliations in the sector "Media & communication".

For this, you need to join all the tables, group by a column, and then use selection criteria to get only the rows in the correct sector.

- [x] Join all tables in the database (starting with affiliations, professors, organizations, and universities) and look at the result.

```sql
-- Join all tables
SELECT *
FROM affiliations
JOIN professors
ON affiliations.professor_id = professors.id
JOIN organizations
ON affiliations.organization_id = organizations.id
JOIN universities
ON professors.university_id = universities.id;
```

- [x] Now group the result by organization sector, professor, and university city.
Count the resulting number of rows.

```sql
-- Group the table by organization sector, professor and university city
SELECT COUNT(*), organizations.organization_sector,
professors.id, universities.university_city
FROM affiliations
JOIN professors
ON affiliations.professor_id = professors.id
JOIN organizations
ON affiliations.organization_id = organizations.id
JOIN universities
ON professors.university_id = universities.id
GROUP BY organizations.organization_sector,
professors.id, universities.university_city;
```

- [x] Only retain rows with "Media & communication" as organization sector, and sort the table by count, in descending order.

```sql
-- Filter the table and sort it
SELECT COUNT(*), organizations.organization_sector,
professors.id, universities.university_city
FROM affiliations
JOIN professors
ON affiliations.professor_id = professors.id
JOIN organizations
ON affiliations.organization_id = organizations.id
JOIN universities
ON professors.university_id = universities.id
WHERE organizations.organization_sector = 'Media & communication'
GROUP BY organizations.organization_sector,
professors.id, universities.university_city
ORDER BY COUNT DESC;
```
<hr>
