--12
SELECT c.CountryCode, m.MountainRange, p.PeakName, p.Elevation
	FROM Countries c
	JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
	JOIN Mountains m ON mc.MountainId = m.Id
	JOIN Peaks p ON m.Id = p.MountainId
	WHERE c.CountryCode = 'BG' AND p.Elevation > 2835
	ORDER BY p.Elevation DESC

--13
SELECT c.CountryCode, COUNT(mc.CountryCode) AS MountainRanges
	FROM Countries c
	JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
	WHERE c.CountryCode IN ('BG', 'RU', 'US')
	GROUP BY c.CountryCode

--14
SELECT TOP(5) c.CountryName, r.RiverName
	FROM Countries c
	LEFT JOIN CountriesRivers cr ON cr.CountryCode = c.CountryCode
	LEFT JOIN Rivers r ON r.Id = cr.RiverId
	WHERE c.ContinentCode = 'AF'
	ORDER BY c.CountryName ASC

--15
SELECT ContinentCode, CurrencyCode, Total FROM (
SELECT ContinentCode, CurrencyCode, COUNT(CurrencyCode) AS Total, DENSE_RANK() OVER(PARTITION BY ContinentCode ORDER BY COUNT(CurrencyCode) DESC) AS Ranked
	FROM Countries
	GROUP BY ContinentCode, CurrencyCode) AS k
	WHERE Ranked = 1 AND Total > 1
	ORDER BY ContinentCode

--16
SELECT COUNT(*) FROM Countries c
	LEFT JOIN MountainsCountries mc ON mc.CountryCode = c.CountryCode
	WHERE MC.MountainId IS NULL

--17
SELECT TOP(5) c.CountryName,
	MAX(p.Elevation) AS HighestPeakElevation,
	MAX(r.[Length]) AS LongestRiverLength
	FROM Countries c
	LEFT JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
	LEFT JOIN Mountains m ON mc.MountainId = m.Id
	LEFT JOIN Peaks p ON m.Id = p.MountainId
	LEFT JOIN CountriesRivers cr ON cr.CountryCode = c.CountryCode
	LEFT JOIN Rivers r ON r.Id = cr.RiverId
	GROUP BY CountryName
	ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC, c.CountryName

--18
SELECT TOP(5) k.CountryName, k.[Highest Peak Name], k.[Highest Peak Elevation], k.Mountain FROM(
SELECT CountryName,
	ISNULL(p.PeakName, '(no highest peak)') AS [Highest Peak Name],
	ISNULL(MAX(p.Elevation), 0) AS [Highest Peak Elevation],
	ISNULL(m.MountainRange, '(no mountain)') AS Mountain,
	DENSE_RANK() OVER(PARTITION BY CountryName ORDER BY MAX(p.Elevation) DESC) AS Ranked
	FROM Countries c
	LEFT JOIN MountainsCountries mc ON c.CountryCode = mc.CountryCode
	LEFT JOIN Mountains m ON mc.MountainId = m.Id
	LEFT JOIN Peaks p ON m.Id = p.MountainId
	LEFT JOIN CountriesRivers cr ON cr.CountryCode = c.CountryCode
	GROUP BY CountryName, p.PeakName, m.MountainRange) AS k
	WHERE Ranked = 1
	ORDER BY k.CountryName, [Highest Peak Name]