--19

CREATE TABLE People2
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(30),
	Birthdate DATETIME
)

INSERT INTO People2 VALUES
('Victor', '2000-12-07'),
('Steven', '1992-09-10'),
('Victor', '1910-09-19'),
('Victor', '2010-01-06')

SELECT [Name],
	DATEDIFF(YEAR, Birthdate, GETDATE()) AS [Age in Years],
	DATEDIFF(MONTH, Birthdate, GETDATE()) AS [Age in Months],
	DATEDIFF(DAY, Birthdate, GETDATE()) AS [Age in Days],
	DATEDIFF(MINUTE, Birthdate, GETDATE()) AS [Age in Minutes]
	FROM People2