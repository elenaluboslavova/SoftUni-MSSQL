CREATE DATABASE CarRental

USE CarRental

CREATE TABLE Categories
(
	Id INT PRIMARY KEY,
	CategoryName VARCHAR(30) NOT NULL,
	DailyRate DECIMAL(3,1),
	WeeklyRate DECIMAL(3,1),
	MonthlyRate DECIMAL(3,1),
	WeekendRate DECIMAL(3,1)
)

INSERT INTO Categories (Id, CategoryName)
VALUES
(1, 'Category1'),
(2, 'Category2'),
(3, 'Category3')

CREATE TABLE Cars
(
	Id INT PRIMARY KEY,
	PlateNumber VARCHAR(10) NOT NULL,
	Manufacturer VARCHAR(30) NOT NULL,
	Model VARCHAR(30) NOT NULL,
	CarYear INT NOT NULL,
	CategoryId INT NOT NULL,
	Doors INT NOT NULL,
	Picture VARCHAR(50),
	Condition VARCHAR(30) NOT NULL,
	Available BIT NOT NULL
)

INSERT INTO Cars VALUES
(1, '1111', 'Manufacturer', 'Model', 2015, 1, 4, NULL, 'New', 1),
(2, '2222', 'Manufacturer', 'Model', 2015, 1, 4, NULL, 'New', 1),
(3, '3333', 'Manufacturer', 'Model', 2015, 1, 4, NULL, 'New', 1)

CREATE TABLE Employees
(
	Id INT PRIMARY KEY,
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Title VARCHAR(30) NOT NULL,
	Notes VARCHAR(50)
)

INSERT INTO Employees VALUES
(1, 'Ivan', 'Ivanov', 'Title', NULL),
(2, 'Petyr', 'Petrov', 'Title', NULL),
(3, 'Gosho', 'Goshev', 'Title', NULL)

CREATE TABLE Customers
(
	Id INT PRIMARY KEY,
	DriverLicenceNumber VARCHAR(20) NOT NULL,
	FullName VARCHAR(50) NOT NULL,
	[Address] VARCHAR(50) NOT NULL,
	City VARCHAR(20) NOT NULL,
	ZIPCode INT NOT NULL,
	Notes VARCHAR(50)
)

INSERT INTO Customers VALUES
(1, '1111', 'Ivan Ivanov', 'Address1', 'Sofia', 0000, NULL),
(2, '2222', 'Ivan Ivanov', 'Address1', 'Sofia', 0000, NULL),
(3, '3333', 'Ivan Ivanov', 'Address1', 'Sofia', 0000, NULL)

CREATE TABLE RentalOrders
(
	Id INT PRIMARY KEY,
	EmployeeId INT NOT NULL,
	CustomerId INT NOT NULL,
	CarId INT NOT NULL,
	TankLevel DECIMAL(10,2) NOT NULL,
	KilometrageStart DECIMAL(10,1) NOT NULL,
	KilometrageEnd DECIMAL(10,1) NOT NULL,
	TotalKilometrage DECIMAL(10,1) NOT NULL,
	StartDate DATE NOT NULL,
	EndDate DATE NOT NULL,
	TotalDays INT NOT NULL,
	RateApplied DECIMAL(3,1),
	TaxRate DECIMAL(3,1),
	OrderStatus VARCHAR(30),
	Notes VARCHAR(30)
)

INSERT INTO RentalOrders VALUES
(1, 1, 1, 1, 20, 50, 100, 50, '8/12/2020', '8/20/2020', 8, NULL, NULL, NULL, NULL),
(2, 2, 2, 2, 20, 50, 100, 50, '8/12/2020', '8/20/2020', 8, NULL, NULL, NULL, NULL),
(3, 3, 3, 3, 20, 50, 100, 50, '8/12/2020', '8/20/2020', 8, NULL, NULL, NULL, NULL)
