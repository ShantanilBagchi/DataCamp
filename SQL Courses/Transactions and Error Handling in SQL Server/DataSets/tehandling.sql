CREATE DATABASE tehandling;
GO
USE tehandling;
GO

/* ELECTRIC BIKES ORDER DATASET */
DROP TABLE IF EXISTS buyers;
GO
CREATE TABLE buyers (
    buyer_id int IDENTITY(1,1) PRIMARY KEY,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    phone varchar(25) NULL);
GO

DROP TABLE IF EXISTS products;
GO
CREATE TABLE products (
    product_id int IDENTITY(1,1) PRIMARY KEY,
    product_name varchar(255) NOT NULL,
    stock int NOT NULL,
    price decimal(10, 2) NOT NULL);
GO

ALTER TABLE products   
ADD CONSTRAINT unique_product_name UNIQUE (product_name);   
GO  

DROP TABLE IF EXISTS staff;
GO
CREATE TABLE staff (
    staff_id int IDENTITY(1,1) PRIMARY KEY,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    email varchar(255) NOT NULL,
    phone varchar(25) NULL);
GO

DROP TABLE IF EXISTS orders;
GO
CREATE TABLE orders(
    order_id int IDENTITY(1,1) PRIMARY KEY,
    product_id int NOT NULL,
    buyer_id int NULL,
    staff_id int NOT NULL,
    quantity int NOT NULL,
    price decimal(10, 2) NOT NULL,
    order_date date NOT NULL,
    FOREIGN KEY (buyer_id) REFERENCES buyers(buyer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id));
GO

INSERT INTO buyers (
    first_name,
    last_name,
    email,
    phone )
VALUES 
('Dylan', 'Smith', 'dylansmith@mail.com', '555888999'),
('John', 'Antona', 'johnantona@mail.com', '555111222'),
('Astrid', 'Harper', 'astridharper@mail.com', '555000999'),
('Angus', 'Brown', 'angusbrown@mail.com', '555222012'),
('David', 'Elcano', 'davidelcano@mail.com', '555602314'),
('Yamir', 'Baker', 'yamirbaker@mail.com', '555804110'),
('Anne', 'Johnson', 'annejohnson@mail.com', '555900010'),
('Roberto', 'Flores', 'robertoflores@mail.com', '555004447'),
('Bryan', 'Page', 'bryanpage@mail.com', '555333111'),
('Carol', 'York', 'carolyork@mail.com', '555441001');
GO

INSERT INTO products (
    product_name,
    stock,
    price) 
VALUES 
('Trek Conduit+ - 2016', 50, 2999.99),
('Sun Bicycles ElectroLite - 2017', 47, 1559.99),
('Trek Powerfly 8 FS Plus - 2017', 41, 4999.99),
('Trek Conduit+', 10, 2799),
('Trek CrossRip+ - 2018', 12, 4499.99),
('Trek Neko+ - 2018',	8, 2799.99),
('Trek XM700+ Lowstep - 2018', 26, 3499.99),
('Trek Lift+ Lowstep - 2018',	10, 2799.99),
('Trek Dual Sport+ - 2018', 15, 2799.99),
('Electra Loft Go! 8i - 2018', 10, 2799.99),
('Electra Townie Go! 8i - 2017/2018',	25, 2599.99),
('Trek Lift+ - 2018',	30, 2799.99),
('Trek XM700+ - 2018', 27, 3499.99),
('Electra Townie Go! 8i Ladies'' - 2018', 14, 2599.99),
('Trek Verve+ - 2018', 16, 2299.99),
('Trek Verve+ Lowstep - 2018', 18, 2299.99),
('Electra Townie Commute Go! - 2018',	19, 2999.99),
('Electra Townie Commute Go! Ladies'' - 2018', 40, 2999.99),
('Trek Powerfly 5 - 2018', 15, 3499.99),
('Trek Powerfly 5 FS - 2018', 19, 4499.99),
('Trek Powerfly 5 Women''s - 2018', 14, 3499.99),
('Trek Powerfly 7 FS - 2018',	15, 4999.99),
('Trek Super Commuter+ 7 - 2018', 12,	3599.99),
('Trek Super Commuter+ 8S - 2018', 18, 4999.99);
GO

INSERT INTO staff (
    first_name,
    last_name,
    email,
    phone
) 
VALUES 
('Mohammed', 'Ferrec', 'mohammedferrec@mail.com', '555888111'),
('Dimitri', 'Brown', 'dimitribrown@mail.com', '555012012'),
('Leila', 'Merheg', 'leilamerheg@mail.com', '555999133'),
('Mateo', 'Casanovas', 'mateocasanovas@mail.com', '555110996'),
('Carl', 'York', 'carlyork@mail.com', '555010011'),
('Robert', 'Berkeley', 'robertberkeley@mail.com', '555447441'),
('Nicholas', 'Kent', 'nicholaskent@mail.com', '555111111'),
('Fabrice', 'Fave', 'fabricefave@mail.com', '555001000'),
('Karima', 'Sfeir', 'karimasfeir@mail.com', '555123888'),
('Pedro', 'Romero', 'pedroromero@mail.com', '555314111');
GO

INSERT INTO orders (
    product_id,
    buyer_id,
    staff_id,
    quantity,
    price,
    order_date)
VALUES
(2, 1, 5, 1, 1559.99, '20190101'),
(2, 5, 5, 2, 1559.99, '20190105'),
(5, 10, 1, 1, 4499.99, '20190115'),
(10, 3, 3, 1, 2799.99, '20190117'),
(15, 2, 7, 2, 2299.99, '20190120');
GO

/* BANK TRANSACTIONS DATA SET */
DROP TABLE IF EXISTS customers;
GO
CREATE TABLE customers (
    customer_id int IDENTITY(1,1) PRIMARY KEY,
    first_name nvarchar(50) NOT NULL,
    last_name nvarchar(50) NOT NULL,
    email nvarchar(50) NOT NULL,
    phone nvarchar(50) NULL);
GO

ALTER TABLE customers   
ADD CONSTRAINT unique_email UNIQUE (email);   
GO  

DROP TABLE IF EXISTS accounts;
GO
CREATE TABLE accounts	(
    account_id int IDENTITY(1,1) PRIMARY KEY,
    account_number varchar(20) NOT NULL,
    customer_id int NOT NULL,
    current_balance money NOT NULL
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id));
GO

DROP TABLE IF EXISTS transactions;
GO
CREATE TABLE transactions (
    transaction_id int IDENTITY(1,1) PRIMARY KEY,
    account_id int NOT NULL,
    amount money NOT NULL,
    transaction_date datetime2(2) NOT NULL,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id));
GO

INSERT INTO customers (
    first_name,
    last_name,
    email,
    phone) 
VALUES 
('Dylan', 'Smith', 'dylansmith@mail.com', '555888999'),
('John', 'Antona', 'johnantona@mail.com', '555111222'),
('Astrid', 'Harper', 'astridharper@mail.com', '555000999'),
('Angus', 'Brown', 'angusbrown@mail.com', '555222012'),
('David', 'Elcano', 'davidelcano@mail.com', '555602314'),
('Yamir', 'Baker', 'yamirbaker@mail.com', '555804110'),
('Anne', 'Johnson', 'annejohnson@mail.com', '555900010'),
('Roberto', 'Flores', 'robertoflores@mail.com', '555004447'),
('Bryan', 'Page', 'bryanpage@mail.com', '555333111'),
('Carol', 'York', 'carolyork@mail.com', '555441001');
GO

INSERT INTO accounts (
    account_number,
    customer_id,
    current_balance)
VALUES 
(55555555551234567890, 1, 25000),
(55555555559876543210, 1, 200),
(55555555557070700707, 2, 1000),
(55555555558080808080, 2, 90000),
(55555555559090909090, 3, 35000),
(55555555551010101010, 4, 14000),
(55555555552020202020, 5, 50000),
(55555555553030303030, 6, 6500),
(55555555554040404040, 7, 150000),
(55555555555050505050, 8, 9000),
(55555555556060606060, 9, 5800),
(55555555551212121212, 10, 15000);
GO

INSERT INTO transactions (
    account_id,
    amount,
    transaction_date)
VALUES 
(1, -100, '2019-03-18 19:12:36.807'),
(2, 100, '2019-01-18 19:12:36.907'),
(1, -9000, '2019-02-18 20:20:36.407'),
(3, 9000, '2019-02-18 20:20:36.507'),
(4, -50, '2019-02-20 08:02:06.201'),
(5, 50, '2019-02-20 08:02:06.203'),
(6, -700, '2019-02-21 21:12:14.807'),
(10, 700, '2019-02-21 21:12:14.807');
GO


DROP TABLE IF EXISTS errors;
GO 
CREATE TABLE errors(
	error_id int IDENTITY(1,1) PRIMARY KEY,
    error VARCHAR(MAX));
GO

INSERT INTO errors VALUES ('Error inserting a product');
GO