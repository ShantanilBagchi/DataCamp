CREATE DATABASE Chinook;
GO
USE Chinook;
GO
CREATE TABLE album (album_id int IDENTITY(1,1), title nvarchar(160), artist_id int);
GO
BULK INSERT album FROM '/home/repl/Album-pipe.csv' WITH(FIELDTERMINATOR = ',', ROWTERMINATOR = '|', FIRSTROW = 1);
GO
CREATE TABLE artist (artist_id int IDENTITY(1,1), name nvarchar(120));
GO
BULK INSERT artist FROM '/home/repl/Artist-pipe.csv' WITH(FIELDTERMINATOR =',', ROWTERMINATOR = '|', FIRSTROW = 1);
GO

CREATE TABLE genre(genre_id int IDENTITY(1,1), name nvarchar(120));
GO
BULK INSERT genre FROM '/home/repl/Genre-pipe.csv' WITH(FIELDTERMINATOR =',', ROWTERMINATOR = '|', FIRSTROW = 1);
GO
CREATE TABLE invoice(invoice_Id int IDENTITY(1,1), customer_id int, invoice_Date datetime, billing_address nvarchar(70), billing_city nvarchar(40), billing_state nvarchar(40), billing_country nvarchar(40), billing_postalcode nvarchar(10), total numeric(10, 2));
GO
BULK INSERT invoice FROM '/home/repl/Invoice-pipe.csv' WITH(FIELDTERMINATOR =',', ROWTERMINATOR = '|', FIRSTROW = 1);
GO
CREATE TABLE invoiceline(invoiceline_id int IDENTITY(1,1), invoice_id int, track_id int, unit_price numeric(10, 2), quantity int);
GO
BULK INSERT invoiceline FROM '/home/repl/InvoiceLine-pipe.csv' WITH(FIELDTERMINATOR =',', ROWTERMINATOR = '|', FIRSTROW = 1);
GO
CREATE TABLE mediatype(mediatype_id int IDENTITY(1,1), name nvarchar(120));
GO
BULK INSERT mediatype FROM '/home/repl/MediaType-pipe.csv' WITH(FIELDTERMINATOR =',', ROWTERMINATOR = '|', FIRSTROW = 1);
GO

CREATE TABLE track(track_id int IDENTITY(1,1), name nvarchar(200), album_id int, mediatype_id  int, genre_id int, composer nvarchar(220), milliseconds int, bytes int, unit_price numeric(10, 2));
GO
BULK INSERT track FROM '/home/repl/Track-pipe.csv' WITH(FIELDTERMINATOR =',', ROWTERMINATOR = '|');
GO

CREATE TABLE rock_tracks (track_id int IDENTITY(1,1), track_title nvarchar(200), album_title nvarchar(160),track_length_mins int);
GO