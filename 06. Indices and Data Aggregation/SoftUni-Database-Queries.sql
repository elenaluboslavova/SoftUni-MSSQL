--13
SELECT DepartmentID, SUM(Salary)
	FROM Employees
	GROUP BY DepartmentID
	ORDER BY DepartmentID

--14
SELECT DepartmentID, MIN(Salary)
	FROM Employees
	WHERE DepartmentID IN (2, 5, 7) AND HireDate > '2000-01-01'
	GROUP BY DepartmentID

--15
SELECT * INTO MyNewTable
	FROM Employees
	WHERE Salary > 30000

DELETE FROM MyNewTable WHERE ManagerID = 42

UPDATE MyNewTable
	SET Salary += 5000
	WHERE DepartmentID = 1

SELECT DepartmentID, AVG(Salary)
	FROM MyNewTable
	GROUP BY DepartmentID

--16
SELECT DepartmentID, MAX(Salary) AS MaxSalary
	FROM Employees
	GROUP BY DepartmentID
	HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000

--17
SELECT COUNT(*)
	FROM Employees
	WHERE ManagerID IS NULL
	GROUP BY ManagerID

--18
SELECT DISTINCT k.DepartmentID, k.Salary AS ThirdHighestSalary FROM (
	SELECT DepartmentID, Salary,
		DENSE_RANK() OVER(PARTITION BY DepartmentID ORDER BY Salary DESC) AS [Ranked]
	FROM Employees) AS k
	WHERE Ranked = 3

--19
SELECT TOP(10) FirstName, LastName, DepartmentID
	FROM Employees AS emp
	WHERE Salary > (SELECT AVG(Salary)
		FROM Employees
		WHERE DepartmentID = emp.DepartmentID)
	ORDER BY DepartmentID

