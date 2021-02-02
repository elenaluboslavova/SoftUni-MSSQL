--01
SELECT COUNT(*) FROM WizzardDeposits

--02
SELECT MAX(MagicWandSize) AS LongestMagicWand FROM WizzardDeposits

--03
SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand
	FROM WizzardDeposits
	GROUP BY DepositGroup

--04
SELECT TOP(2) DepositGroup
	FROM WizzardDeposits
	GROUP BY DepositGroup
	ORDER BY AVG(MagicWandSize) ASC

--05
SELECT DepositGroup, SUM(DepositAmount) FROM WizzardDeposits
	GROUP BY DepositGroup

--06
SELECT DepositGroup, SUM(DepositAmount) FROM WizzardDeposits
	WHERE MagicWandCreator = 'Ollivander family'
	GROUP BY DepositGroup

--07
SELECT DepositGroup, SUM(DepositAmount) FROM WizzardDeposits
	WHERE MagicWandCreator = 'Ollivander family'
	GROUP BY DepositGroup
	HAVING SUM(DepositAmount) < 150000
	ORDER BY SUM(DepositAmount) DESC

--08
SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge)
	FROM WizzardDeposits
	GROUP BY DepositGroup, MagicWandCreator
	ORDER BY MagicWandCreator, DepositGroup

--09
SELECT Result.AgeGroup, COUNT(Result.AgeGroup) FROM (
	SELECT
		CASE
			WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
			WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
			WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
			WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
			WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
			WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
			WHEN Age >= 61 THEN '[61+]'
		END AS AgeGroup
		FROM WizzardDeposits) AS Result
	GROUP BY Result.AgeGroup

--10
SELECT DISTINCT LEFT(FirstName, 1) FROM WizzardDeposits
	WHERE DepositGroup = 'Troll Chest'
	GROUP BY FirstName
	ORDER BY LEFT(FirstName, 1)

--11
SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest) FROM WizzardDeposits
	WHERE DepositStartDate > '1985-01-01'
	GROUP BY DepositGroup, IsDepositExpired
	ORDER BY DepositGroup DESC, IsDepositExpired ASC

--12
SELECT SUM(Guest.DepositAmount - Host.DepositAmount) AS [Difference]
	FROM WizzardDeposits Host
	JOIN WizzardDeposits Guest ON Host.Id = Guest.Id + 1