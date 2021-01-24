USE Diablo

--14
SELECT TOP(50) [Name], FORMAT([Start], 'yyyy-MM-dd') AS [Start]
	FROM Games
	WHERE DATEPART(YEAR, [Start]) BETWEEN 2011 AND 2012
	ORDER BY [Start], [Name]

--15
SELECT Username, 
	SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)) AS EmailProvider
	FROM Users
	ORDER BY EmailProvider, Username

--16
SELECT Username, IpAddress FROM Users
	WHERE IpAddress LIKE ('___.1%.%.___')
	ORDER BY Username

--17
SELECT [Name],
	CASE
		WHEN DATEPART(HOUR, [Start]) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 18 AND 23 THEN 'Evening'
	END AS [Part of the Day],
	CASE
		WHEN Duration <= 3 THEN 'Extra Short'
		WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
		WHEN Duration > 6 THEN 'Long'
		ELSE 'Extra Long'
	END AS [Duration]
	FROM Games
	ORDER BY [Name], [Duration], [Part of the Day]