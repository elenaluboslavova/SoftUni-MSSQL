--09
CREATE PROC usp_GetHoldersFullName
AS
SELECT FirstName + ' ' + LastName AS [Full Name]
	FROM AccountHolders
GO

--10
CREATE PROC usp_GetHoldersWithBalanceHigherThan @Money MONEY
AS
SELECT ah.FirstName, ah.LastName
	FROM AccountHolders ah
	JOIN Accounts a ON a.AccountHolderId = ah.Id
	GROUP BY FirstName, LastName
	HAVING SUM(Balance) > @Money
	ORDER BY FirstName, LastName
GO

--11
CREATE OR ALTER FUNCTION ufn_CalculateFutureValue (@Sum MONEY, @YearlyInterestRate FLOAT, @NumberOfYears INT)
RETURNS MONEY
BEGIN
	RETURN @Sum * (POWER(1 + @YearlyInterestRate, @NumberOfYears))
END
GO

--12
CREATE OR ALTER PROC usp_CalculateFutureValueForAccount @AccountId INT, @YearlyInterestRate FLOAT
AS
SELECT a.Id AS [Account Id],
	   ah.FirstName AS [First Name],
	   ah.LastName AS [Last Name],
	   a.Balance AS [Current Balance],
	   FORMAT(dbo.ufn_CalculateFutureValue(a.Balance, @YearlyInterestRate, 5), 'N4') AS [Balance in 5 years]
	FROM AccountHolders ah
	JOIN Accounts a ON ah.Id = a.AccountHolderId
	WHERE a.Id = @AccountId
GO