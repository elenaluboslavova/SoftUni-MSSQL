CREATE DATABASE Hotel

USE Hotel

CREATE TABLE Employees
(
	Id INT PRIMARY KEY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Title VARCHAR(50) NOT NULL,
	Notes VARCHAR(MAX)
)

INSERT INTO Employees 
(Id, FirstName, LastName, Title, Notes)
VALUES
(1, 'Gosho', 'Goshev', 'CEO', NULL),
(2, 'Petyr', 'Petrov', 'CFO', 'note'),
(3, 'Ivan', 'Ivanov', 'CTO', NULL)


CREATE TABLE Customers
(
	AccountNumber INT PRIMARY KEY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	PhoneNumber CHAR(10) NOT NULL,
	EmergencyName VARCHAR(50) NOT NULL,
	EmergencyNumber CHAR(10) NOT NULL,
	Notes VARCHAR(MAX)
)

INSERT INTO Customers 
(AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber)
VALUES
(1111, 'Gosho', 'Goshev', 0888888888, 'Petyr', 0888999999),
(2222, 'Petyr', 'Petrov', 0888999999, 'Ivan', 0888777777),
(3333, 'Ivan', 'Ivanov', 0888777777, 'Gosho', 0888888888)

CREATE TABLE RoomStatus
(
	RoomStatus BIT NOT NULL,
	Notes VARCHAR(MAX)
)

INSERT INTO RoomStatus 
(RoomStatus)
VALUES
(0),
(1),
(0)

CREATE TABLE RoomTypes
(
	RoomType VARCHAR(20) NOT NULL,
	Notes VARCHAR(MAX)
)

INSERT INTO RoomTypes 
(RoomType)
VALUES
('edinichna'),
('dvoina'),
('apartament')

CREATE TABLE BedTypes
(
	BedType VARCHAR(20) NOT NULL,
	Notes VARCHAR(MAX)
)

INSERT INTO BedTypes 
(BedType)
VALUES
('edinichno'),
('dvoino'),
('spalnq')

CREATE TABLE Rooms
(
	RoomNumber INT PRIMARY KEY,
	RoomType VARCHAR(20) NOT NULL,
	BedType VARCHAR(20) NOT NULL,
	Rate INT,
	RoomStatus BIT NOT NULL,
	Notes VARCHAR(MAX)
)

INSERT INTO Rooms 
(RoomNumber, RoomType, BedType, RoomStatus)
VALUES
(1, 'edinichna', 'edinichno', 0),
(2, 'dvoina', 'dvoino', 0),
(3, 'apartament', 'spalnq', 1)

CREATE TABLE Payments
(
	Id INT PRIMARY KEY,
	EmployeeId INT NOT NULL,
	PaymentDate DATETIME NOT NULL,
	AccountNumber INT NOT NULL,
	FirstDateOccupied DATETIME NOT NULL,
	LastDateOccupied DATETIME NOT NULL,
	TotalDays INT NOT NULL,
	AmountCharged DECIMAL(15,2) NOT NULL,
	TaxRate INT,
	TaxAmount INT,
	PaymentTotal DECIMAL(15,2) NOT NULL,
	Notes VARCHAR(MAX)
)

INSERT INTO Payments
(Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, PaymentTotal)
VALUES
(1, 1, 18/02/2019, 2222, 20/02/2019, 25/02/2019, 5, 200, 200),
(2, 2, 01/02/2019, 1111, 03/02/2019, 05/02/2019, 2, 50, 100),
(3, 3, 10/02/2019, 3333, 12/02/2019, 17/02/2019, 5, 200, 200)

CREATE TABLE Occupancies
(
	Id INT PRIMARY KEY,
	EmployeeId INT NOT NULL,
	DateOccupied DATETIME NOT NULL,
	AccountNumber INT NOT NULL,
	RoomNuber INT NOT NULL,
	RateApplied INT,
	PhoneCharge DECIMAL(15,2),
	Notes VARCHAR(MAX)
)

INSERT INTO Occupancies
(Id, EmployeeId, DateOccupied, AccountNumber,RoomNuber)
VALUES
(1, 1, 20/02/2019, 1111, 1),
(2, 2, 03/02/2019, 2222, 2),
(3, 3, 12/02/2019, 3333, 3)

--23. Decrease Tax Rate
UPDATE Payments
	SET TaxRate = TaxRate * 0.97
SELECT TaxRate FROM Payments

--24. Delete All Records
DELETE FROM Occupancies
SELECT * FROM Occupancies