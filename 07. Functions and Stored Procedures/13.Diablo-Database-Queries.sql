--13
CREATE FUNCTION ufn_CashInUsersGames (@GameName VARCHAR(100))
RETURNS TABLE
AS
	RETURN (SELECT SUM(k.TotalCash) AS SumCash FROM (
	SELECT Cash AS TotalCash,
		ROW_NUMBER() OVER (ORDER BY Cash DESC) AS RowNumber
		FROM UsersGames ug
		JOIN Games g ON ug.GameId = g.Id
		WHERE [Name] = @GameName) AS k
	WHERE k.RowNumber % 2 = 1)