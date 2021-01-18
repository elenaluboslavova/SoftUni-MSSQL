CREATE DATABASE SoftUni

USE SoftUni

CREATE TABLE Towns
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(30) NOT NULL
)

INSERT INTO Towns VALUES
('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas')

SELECT * FROM Towns ORDER BY [Name] ASC
SELECT [Name] FROM Towns ORDER BY [Name] ASC

CREATE TABLE Addresses
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	--PersonID int FOREIGN KEY REFERENCES Persons(PersonID)
	AddressText VARCHAR(50) NOT NULL,
	TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL
)

CREATE TABLE Departments
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(30) NOT NULL
)

INSERT INTO Departments VALUES
('Engineering'), ('Sales'), ('Marketing'), ('Software Development'), ('Quality Assurance')

SELECT * FROM Departments ORDER BY [Name] ASC
SELECT [Name] FROM Departments ORDER BY [Name] ASC

CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(20) NOT NULL,
	MiddleName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20) NOT NULL,
	JobTitle VARCHAR(20) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id),
	HireDate DATE NOT NULL,
	Salary DECIMAL(10,2) NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
)

INSERT INTO Employees VALUES
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '02/01/2013', 3500, NULL),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '03/02/2004', 4000, NULL),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '08/28/2016', 525.25, NULL),
('Georgi', 'Teziev', 'Ivanov', 'CEO', 2, '12/09/2007', 3000, NULL),
('Peter', 'Pan', 'Pan', 'Intern', 3, '08/28/2016', 599.88, NULL)

SELECT * FROM Employees ORDER BY Salary DESC
SELECT FirstName, LastName, JobTitle, Salary FROM Employees ORDER BY Salary DESC

UPDATE Employees
	SET Salary = Salary * 1.1
SELECT Salary FROM Employees