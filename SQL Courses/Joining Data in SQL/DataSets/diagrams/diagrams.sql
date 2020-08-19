CREATE TABLE left_table (
  id                    INTEGER   PRIMARY KEY,
  val                   CHARACTER(2)
);

CREATE TABLE right_table (
  id                    INTEGER   PRIMARY KEY,
  val                   CHARACTER(2)
);

CREATE TABLE left_one (
  id                    INTEGER   PRIMARY KEY
);

CREATE TABLE right_one (
  id                    INTEGER   PRIMARY KEY
);

CREATE TABLE right2 (
  id                    INTEGER,
  val                   CHARACTER(2) PRIMARY KEY
);

CREATE TABLE table1 (
  id                    INTEGER   PRIMARY KEY
);

CREATE TABLE table2 (
  id                    CHARACTER(1)   PRIMARY KEY
);


-- Copy over data from CSVs
\copy left_table FROM 'data/diagrams/left_table.csv' DELIMITER ',' CSV HEADER;
\copy right_table FROM 'data/diagrams/right_table.csv' DELIMITER ',' CSV HEADER;
\copy left_one FROM 'data/diagrams/left_one.csv' DELIMITER ',' CSV HEADER;
\copy right_one FROM 'data/diagrams/right_one.csv' DELIMITER ',' CSV HEADER;
\copy right2 FROM 'data/diagrams/right2.csv' DELIMITER ',' CSV HEADER;
\copy table1 FROM 'data/diagrams/table1.csv' DELIMITER ',' CSV HEADER;
\copy table2 FROM 'data/diagrams/table2.csv' DELIMITER ',' CSV HEADER;

/*
createdb diagrams
psql diagrams < data/diagrams/diagrams.sql
*/