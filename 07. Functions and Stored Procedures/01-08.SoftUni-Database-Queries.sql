--01
CREATE PROC usp_GetEmployeesSalaryAbove35000
AS
SELECT FirstName, LastName
	FROM Employees
	WHERE Salary > 35000
GO

--02
CREATE PROC usp_GetEmployeesSalaryAboveNumber (@Number DECIMAL(18, 4))
AS
SELECT FirstName, LastName
	FROM Employees
	WHERE Salary >= @Number
GO

--03
CREATE PROC usp_GetTownsStartingWith (@String VARCHAR(MAX))
AS
SELECT [Name] AS [Town]
	FROM Towns
	WHERE [Name] LIKE @String + '%'
GO

--04
CREATE PROC usp_GetEmployeesFromTown (@TownName VARCHAR(MAX))
AS
SELECT FirstName AS [First Name],
	   LastName AS [Last Name]
	FROM Employees e
	JOIN Addresses a ON e.AddressID = a.AddressID
	JOIN Towns t ON a.TownID = t.TownID
	WHERE t.[Name] = @TownName
GO

--05
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4))
	RETURNS VARCHAR(MAX)
AS
BEGIN
	IF (@salary < 30000)
		RETURN 'Low'
	ELSE IF (@salary BETWEEN 30000 AND 50000)
		RETURN 'Average'
	ELSE
		RETURN 'High'
	RETURN NULL
END
GO

--06
CREATE PROC usp_EmployeesBySalaryLevel @Level VARCHAR(MAX)
AS
SELECT FirstName, LastName
	FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @Level
GO

--07
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(MAX), @word VARCHAR(MAX))
RETURNS BIT
BEGIN
DECLARE @Count INT = 1;
WHILE(@Count <= LEN(@word))
BEGIN
	DECLARE @CurrentLetter CHAR(1) = SUBSTRING(@word, @Count, 1);
	IF(CHARINDEX(@CurrentLetter, @setOfLetters) = 0)
		RETURN 0
	SET @Count += 1;
END
RETURN 1
END
GO

--08
CREATE PROC usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS
ALTER TABLE Departments
	ALTER COLUMN ManagerID INT NULL

DELETE FROM EmployeesProjects
	WHERE EmployeeID IN (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)

UPDATE Employees
	SET ManagerID = NULL
	WHERE EmployeeID IN (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)

UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)

UPDATE Departments
	SET ManagerID = NULL
	WHERE ManagerID IN (SELECT EmployeeID FROM Employees WHERE DepartmentID = @departmentId)

DELETE FROM Employees
	WHERE DepartmentID = @departmentId

DELETE FROM Departments
	WHERE DepartmentID = @departmentId

SELECT COUNT(*) FROM Employees WHERE DepartmentID = @departmentId

GO