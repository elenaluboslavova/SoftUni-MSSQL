USE SoftUni

--01
SELECT FirstName, LastName FROM Employees
	WHERE FirstName LIKE ('SA%')

--02
SELECT FirstName, LastName FROM Employees
	WHERE LastName LIKE ('%ei%')

--03
SELECT FirstName FROM Employees
	WHERE DepartmentID IN (3, 10) AND YEAR(HireDate) BETWEEN 1995 AND 2005

--04
SELECT FirstName, LastName FROM Employees
	WHERE JobTitle NOT LIKE ('%engineer%')

--05
SELECT [Name] FROM Towns
	WHERE LEN([Name]) IN (5, 6)
	ORDER BY [Name]

--06
SELECT TownID, [Name] FROM Towns
	WHERE [Name] LIKE ('[M, K, B, E]%')
	ORDER BY [Name]

--07
SELECT TownID, [Name] FROM Towns
	WHERE [Name] NOT LIKE ('[R, B, D]%')
	ORDER BY [Name]

--08
GO
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName FROM Employees
	WHERE YEAR(HireDate) > 2000
GO

--09
SELECT FirstName, LastName FROM Employees
	WHERE LEN(LastName) = 5

--10
SELECT EmployeeID, FirstName, LastName, Salary, 
	DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank] 
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000
	ORDER BY SALARY DESC

--11
SELECT * FROM
(
	SELECT EmployeeID, FirstName, LastName, Salary, 
		DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank] 
		FROM Employees
		WHERE Salary BETWEEN 10000 AND 50000
)AS RESULT
WHERE [Rank] = 2
	ORDER BY Salary DESC