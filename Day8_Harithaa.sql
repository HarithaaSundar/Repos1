USE Training_2024
GO

-- creating table

CREATE TABLE Harithaa.customer_master
(
	CUSTONER_NUMBER			VARCHAR(50) PRIMARY KEY
,	FIRSTNAME				VARCHAR(50)
,	Middlename				VARCHAR(50)
,	Lastname				VARCHAR(50)
,	CUSTOMER_CITY			VARCHAR(50)
,	CUSTOMER_CONTACT_NO		VARCHAR(50)
,	Occupation				VARCHAR(50)
,	CUSTOMER_DATE_OF_BIRTH	DATE
)

CREATE TABLE Harithaa.loan_details
(
	customer_number VARCHAR(50) FOREIGN KEY REFERENCES Harithaa.customer_master(CUSTONER_NUMBER)
,	branch_id		VARCHAR(50) FOREIGN KEY REFERENCES Harithaa.branch_master(branch_id)
,	loan_amount		INT
)

CREATE TABLE Harithaa.branch_master
(
	branch_id	VARCHAR(50) PRIMARY KEY
,	branch_name VARCHAR(50)
,	branch_city VARCHAR(50)
)

CREATE TABLE Harithaa.account_master
(
	account_number		 VARCHAR(50) PRIMARY KEY
,	customer_number		 VARCHAR(50) FOREIGN KEY REFERENCES Harithaa.customer_master(CUSTONER_NUMBER)
,	branch_id			 VARCHAR(50) FOREIGN KEY REFERENCES Harithaa.branch_master(branch_id)
,	opening_balance		 INT
,	account_opening_date DATE
,	account_type		 VARCHAR(50)
,	account_status		 VARCHAR(50)
)

CREATE TABLE Harithaa.transaction_details
(
	transaction_number	  VARCHAR(50) PRIMARY KEY
,	account_number		  VARCHAR(50) FOREIGN KEY REFERENCES Harithaa.account_master(account_number)
,	date_of_transaction	  DATETIME
,	medium_of_transaction VARCHAR(50)
,	transaction_type	  VARCHAR(50)
,	transaction_amount	  INT 
)

GO

-- DROP TABLE


DROP TABLE Harithaa.customer_master
DROP TABLE Harithaa.loan_details
DROP TABLE Harithaa.branch_master
DROP TABLE Harithaa.account_master
DROP TABLE Harithaa.transaction_details

SELECT * FROM Harithaa.customer_master
SELECT * FROM Harithaa.loan_details
SELECT * FROM Harithaa.branch_master
SELECT * FROM Harithaa.account_master
SELECT * FROM Harithaa.transaction_details

--inserting values

INSERT INTO Harithaa.customer_master
(
	CUSTONER_NUMBER 
,	FIRSTNAME 
,	Middlename 
,	Lastname 
,	CUSTOMER_CITY 
,	CUSTOMER_CONTACT_NO 
,	Occupation 
,	CUSTOMER_DATE_OF_BIRTH 
)
VALUES
	('1001','Karl','Cook','D','Chennai','9841235980','Lawyer','1997-08-13')
,	('1002','Ganesh','Ramanathan','A','Mumbai','9835018732','Doctor','1994-10-29')
,	('1003','Ajai','Gupta','K','Delhi','9862872615','IT','1999-08-08')
,	('1004','Albert','Karl','T','Kolkata','9972619065','Service','1986-02-11')
,	('1005','Dhivya','Dharshini','R','Chennai','9836278153','Professor','1972-04-10')
,	('1006','Sasikant','Sharma','D','Chennai','9926820465','Student','2003-03-08')
,	('1007','Ram','Krishna','R','Delhi','9831840320','Student','2000-12-30')
,	('1008','Micheal','Jerson','J','Chennai','9841354093','Professor','1993-05-19')
,	('1009','gokul','Kanna','M','Mumbai','9940171048','Doctor','2005-11-06')
,	('1010','Saravana','Raman','P','Delhi','9846026173','Lawyer','1974-08-02')


INSERT INTO Harithaa.branch_master
(
	branch_id 
,	branch_name 
,	branch_city 
)
VALUES
	('B001','Chennai Main Branch','Chennai')
,	('B002','Anna Nagar','Chennai')
,	('B003','Delhi Main Branch','Delhi')
,	('B004','Mumbai Main Branch','Mumbai')
,	('B005','Shdhipur','Delhi')
,	('B006','C R Avenue','Kolkata')
,	('B007','Ghatkopar','Mumbai')


INSERT INTO Harithaa.loan_details
(
	customer_number 
,	branch_id 
,	loan_amount 
)
VALUES
	('1002','B004',2500000)
,	('1007','B003',500000)
,	('1004','B006',30000000)
,	('1009','B007',800000)
,	('1005','B001',600000)
,	('1001','B002',1600000)

INSERT INTO Harithaa.account_master
(
	account_number 
,	customer_number 
,	branch_id 
,	opening_balance 
,	account_opening_date 
,	account_type 
,	account_status 
)
VALUES
	('2489365708','1001','B001',20000,'2017-02-15','Saving','Active')
,	('2473296326','1002','B007',50000,'2020-08-13','Saving','Active')
,	('2482304618','1003','B005',70000,'2011-03-08','Saving','Active')
,	('2471293527','1004','B006',30000,'2012-09-20','Saving','Active')
,	('2426153982','1005','B002',100000,'2001-10-13','Saving','Terminated')
,	('2497352036','1006','B001',60000,'2006-04-15','Saving','Active')
,	('2462739731','1007','B003',10000,'2021-08-23','Saving','Active')
,	('2493528103','1008','B001',80000,'2018-12-10','Saving','Suspended')
,	('2462730935','1009','B007',13000,'2020-01-05','Saving','Active')
,	('2483251973','1010','B003',40000,'2017-05-19','Saving','Terminated')

INSERT INTO Harithaa.transaction_details
(
	transaction_number 
,	account_number 
,	date_of_transaction 
,	medium_of_transaction 
,	transaction_type 
,	transaction_amount 
)
VALUES
	(10201,'2482304618','2024-01-23 16:00:00.060','Cheque','Loan Credit',700000)
,	(10202,'2462730935','2024-02-23 16:30:00.060','Cheque','Deposit',100000)
,	(10203,'2497352036','2024-02-23 17:00:00.060','Net Banking','Withdrawl',1000)
,	(10204,'2489365708','2024-02-23 15:30:00.060','Debit Card','Withdrawl',8000)
,	(10205,'2462739731','2024-02-23 16:30:00.060','Net Banking','Loan Part Recovery',6000)
,	(10206,'2462739731','2024-02-23 11:25:00.060','Debit Card','Deposit',5000)

GO

-- Query 1

SELECT
	DATEPART(week,account_opening_date) AS [week number]
,	COUNT(customer_number) AS [No of Accounts]
,	branch_id
FROM
	Harithaa.account_master
GROUP BY
	DATEPART(week,account_opening_date)
,	branch_id

-- Query 2

SELECT
	a.account_number			
,	a.customer_number			
,	a.branch_id				
,	a.opening_balance	
,	a.account_opening_date	
,	a.account_type			
,	a.account_status
FROM 
	Harithaa.account_master a
LEFT JOIN
	Harithaa.transaction_details t
ON
	a.account_number = t.account_number
WHERE
	(t.medium_of_transaction = 'Debit Card' OR t.medium_of_transaction = 'Net Banking') 
	AND
	t.date_of_transaction >= DATEADD(HOUR, -3, GETDATE())

-- Query 3

SELECT
	c.CUSTONER_NUMBER
,	c.FIRSTNAME+' '+c.Middlename+' '+c.Lastname [Account Holder]
,	a.account_number
,	t.transaction_amount
FROM
	Harithaa.transaction_details t
JOIN
	Harithaa.account_master a
ON
	t.account_number = a.account_number
JOIN
	Harithaa.loan_details l
ON
	l.customer_number = a.customer_number
JOIN
	Harithaa.customer_master c
ON
	c.CUSTONER_NUMBER = a.customer_number
WHERE
	t.transaction_type = 'Loan Credit' 
	OR
	t.transaction_type = 'Loan Part Recovery'
	AND
	t.date_of_transaction > DATEADD(MONTH, -4, GETDATE())

-- Qurey 4

SELECT *
FROM
	Harithaa.customer_master c
JOIN
	Harithaa.loan_details l
ON
	c.CUSTONER_NUMBER = l.customer_number
JOIN
	Harithaa.account_master a
ON
	a.customer_number = c.CUSTONER_NUMBER
JOIN
	Harithaa.transaction_details t
ON
	t.account_number = a.account_number