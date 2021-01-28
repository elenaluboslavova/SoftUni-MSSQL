--01
SELECT TOP(5) e.EmployeeID, e.JobTitle, a.AddressID, a.AddressText
	FROM Employees e
	JOIN Addresses a ON e.AddressID = a.AddressID
	ORDER BY a.AddressID

--02
SELECT TOP(50) e.FirstName, e.LastName, t.[Name] AS [Town], a.AddressText
	FROM Employees e
	JOIN Addresses a ON e.AddressID = a.AddressID
	JOIN Towns t ON t.TownID = a.TownID
	ORDER BY e.FirstName, e.LastName

--03
SELECT e.EmployeeID, e.FirstName, e.LastName, d.[Name] AS[DepartmentName] 
	FROM Employees e
	JOIN Departments d ON e.DepartmentID = d.DepartmentID
	WHERE d.[Name] = 'Sales'
	ORDER BY EmployeeID

--04
SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.[Name] AS[DepartmentName] 
	FROM Employees e
	JOIN Departments d ON e.DepartmentID = d.DepartmentID
	WHERE e.Salary > 15000
	ORDER BY d.DepartmentID

--05
SELECT TOP(3) e.EmployeeID, e.FirstName 
	FROM Employees e
	LEFT JOIN EmployeesProjects ep ON ep.EmployeeID = e.EmployeeID
	WHERE ep.ProjectID IS NULL
	ORDER BY e.EmployeeID

--06
SELECT e.FirstName, e.LastName, e.HireDate, d.[Name] AS [DeptName]
	FROM Employees e
	JOIN Departments d ON e.DepartmentID = d.DepartmentID
	WHERE e.HireDate > '1999-01-01' AND d.[Name] IN ('Sales', 'Finance')
	ORDER  BY e.HireDate ASC

--07
SELECT TOP(5) e.EmployeeID, e.FirstName, p.[Name] AS [ProjectName]
	FROM Employees e
	JOIN EmployeesProjects ep ON e.EmployeeID = ep.EmployeeID
	JOIN Projects p ON ep.ProjectID = p.ProjectID
	WHERE p.StartDate > '2002-08-13' AND p.EndDate IS NULL
	ORDER BY e.EmployeeID ASC

--08
SELECT e.EmployeeID, e.FirstName,
	CASE
		WHEN p.StartDate > '2005-01-01' THEN NULL
		ELSE p.[Name]
	END AS [ProjectName]
	FROM Employees e
	JOIN EmployeesProjects ep ON e.EmployeeID = ep.EmployeeID
	JOIN Projects p ON ep.ProjectID = p.ProjectID
	WHERE e.EmployeeID = 24
	ORDER BY e.EmployeeID ASC

--09
SELECT emp.EmployeeID, emp.FirstName, emp.ManagerID, mng.FirstName AS ManagerName
	FROM Employees emp
	JOIN Employees mng ON mng.EmployeeID = emp.ManagerID
	WHERE mng.EmployeeID IN (3, 7)
	ORDER BY emp.EmployeeID ASC

--10
SELECT TOP(50) emp.EmployeeID,
	emp.FirstName + ' ' + emp.LastName AS EmployeeName,
	mng.FirstName + ' ' + mng.LastName AS ManagerName,
	d.[Name] AS DepartmentName
	FROM Employees emp
	JOIN Employees mng ON mng.EmployeeID = emp.ManagerID
	JOIN Departments d ON d.DepartmentID = emp.DepartmentID
	ORDER BY emp.EmployeeID

--11
SELECT TOP(1) AVG(Salary) AS AvgSalary
	FROM Employees e
	JOIN Departments d ON d.DepartmentID = e.DepartmentID
	GROUP BY e.DepartmentID
	ORDER BY AvgSalary ASC