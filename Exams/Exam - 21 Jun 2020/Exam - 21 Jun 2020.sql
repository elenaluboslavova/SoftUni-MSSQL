--01. DDL
CREATE TABLE Cities
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(20) NOT NULL,
	CountryCode CHAR(2) NOT NULL
)

CREATE TABLE Hotels
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL,
	CityId INT FOREIGN KEY REFERENCES Cities(Id) NOT NULL,
	EmployeeCount INT NOT NULL,
	BaseRate DECIMAL(18,2)
)

CREATE TABLE Rooms
(
	Id INT PRIMARY KEY IDENTITY,
	Price DECIMAL(18,2) NOT NULL,
	[Type] NVARCHAR(20) NOT NULL,
	Beds INT NOT NULL,
	HotelId INT FOREIGN KEY REFERENCES Hotels(Id) NOT NULL,
)

CREATE TABLE Trips
(
	Id INT PRIMARY KEY IDENTITY,
	RoomId INT FOREIGN KEY REFERENCES Rooms(Id) NOT NULL,
	BookDate DATE NOT NULL,
	ArrivalDate DATE NOT NULL,
	ReturnDate DATE NOT NULL,
	CHECK(ArrivalDate < ReturnDate),
	CHECK(BookDate < ArrivalDate),
	CancelDate DATE
)

CREATE TABLE Accounts
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(20),
	LastName NVARCHAR(50) NOT NULL,
	CityId INT FOREIGN KEY REFERENCES Cities(Id) NOT NULL,
	BirthDate DATE NOT NULL,
	Email VARCHAR(100) UNIQUE NOT NULL
)

CREATE TABLE AccountsTrips
(
	AccountId INT FOREIGN KEY REFERENCES Accounts(Id) NOT NULL,
	TripId INT FOREIGN KEY REFERENCES Trips(Id) NOT NULL,
	PRIMARY KEY(AccountId, tripId),
	Luggage INT CHECK(Luggage >= 0) NOT NULL
)

--02. Insert
INSERT INTO Accounts
VALUES
('John', 'Smith', 'Smith', 34 ,'1975-07-21', 'j_smith@gmail.com'),
('Gosho', NULL, 'Petrov', 11, '1978-05-16', 'g_petrov@gmail.com'),
('Ivan', 'Petrovich', 'Pavlov',	59,	'1849-09-26', 'i_pavlov@softuni.bg'),
('Friedrich', 'Wilhelm', 'Nietzsche', 2, '1844-10-15', 'f_nietzsche@softuni.bg')

INSERT INTO Trips
VALUES
(101, '2015-04-12', '2015-04-14', '2015-04-20', '2015-02-02'),
(102, '2015-07-07', '2015-07-15', '2015-07-22', '2015-04-29'),
(103, '2013-07-17', '2013-07-23', '2013-07-24',	NULL),
(104, '2012-03-17', '2012-03-31', '2012-04-01', '2012-01-10'),
(109, '2017-08-07', '2017-08-28', '2017-08-29',	NULL)

--03. Update
UPDATE Rooms
SET Price *= 1.14
WHERE HotelId IN (5, 7, 9)

--04. Delete
DELETE FROM AccountsTrips
WHERE AccountId = 47

--05. EEE-Mails
SELECT a.FirstName, a.LastName, FORMAT(a.BirthDate, 'MM-dd-yyyy') AS BirthDate, c.[Name] AS HomeTown, a.Email
FROM Accounts a
JOIN Cities c ON c.Id = a.CityId
WHERE a.Email LIKE 'e%'
ORDER BY c.[Name] ASC

--06. City Statistics
SELECT c.[Name], COUNT(*) AS Hotels FROM Hotels h
JOIN Cities c ON h.CityId = c.Id
GROUP BY c.[Name]
HAVING COUNT(*) > 0
ORDER BY Hotels DESC, c.[Name] ASC

--07. Longest and Shortest Trips
SELECT a.Id,
	CONCAT(a.FirstName,' ', a.LastName) AS FullName,
	MAX(DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate)) AS LongestTrip,
	MIN(DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate)) AS ShortestTrip
FROM Accounts a
JOIN AccountsTrips [at] ON a.Id = [at].AccountId
JOIN Trips t ON t.Id = [at].TripId
WHERE t.CancelDate IS NULL AND a.MiddleName IS NULL
GROUP BY a.Id, a.FirstName, a.LastName
ORDER BY LongestTrip DESC, ShortestTrip ASC

--08. Metropolis
SELECT TOP(10) c.Id, c.[Name] AS City, c.CountryCode AS Country, COUNT(*) AS Accounts FROM Accounts a
JOIN Cities c ON a.CityId = c.Id
GROUP BY c.Id, c.[Name], c.CountryCode
ORDER BY Accounts DESC

--09. Romantic Getaways
SELECT a.Id, a.Email, c.[Name] AS City, COUNT(*) AS Trips FROM Accounts a
JOIN Cities c ON a.CityId = c.Id
JOIN AccountsTrips [at] ON [at].AccountId = a.Id
JOIN Trips t ON t.Id = [at].TripId
JOIN Rooms r ON r.Id = t.RoomId
JOIN Hotels h ON h.Id = r.HotelId
WHERE a.CityId = h.CityId
GROUP BY a.Id, a.Email, c.[Name]
ORDER BY Trips DESC, a.Id

--10. GDPR Violation
SELECT t.Id,
	a.FirstName + ' ' + IIF(a.MiddleName IS NULL, '', a.MiddleName + ' ') + a.LastName AS [Full Name],
	ac.[Name] AS [From],
	hc.[Name] AS [To],
	CASE
		WHEN t.CancelDate IS NULL THEN CONVERT(VARCHAR, ABS(DATEDIFF(DAY, t.ReturnDate, t.ArrivalDate))) + ' days'
		ELSE 'Canceled'
	END AS Duration
FROM Accounts a
JOIN AccountsTrips [at] ON a.Id = [at].AccountId
JOIN Trips t ON [at].TripId = t.Id
JOIN Cities ac ON a.CityId = ac.Id
JOIN Rooms r ON t.RoomId = r.Id
JOIN Hotels h ON r.HotelId = h.Id
JOIN Cities hc ON h.CityId = hc.Id
ORDER BY [Full Name], t.Id

--11. Available Room	
GO
CREATE FUNCTION udf_GetAvailableRoom(@HotelId INT, @Date DATE, @People INT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @RoomInfo VARCHAR(MAX) = (
	SELECT TOP(1) 'Room ' + CONVERT(VARCHAR, r.Id) + ': ' + r.Type +  ' (' + CONVERT(VARCHAR, r.Beds) + ' beds) - $' + CONVERT(VARCHAR, (h.BaseRate + r.Price) * @People)
	FROM Rooms r
	JOIN Hotels h ON h.Id = r.HotelId
	WHERE Beds >= @People AND HotelId = @HotelId AND 
		NOT EXISTS(SELECT * FROM Trips t WHERE t.RoomId = r.Id
		AND CancelDate IS NULL 
		AND @Date BETWEEN ArrivalDate AND ReturnDate)
	ORDER BY (h.BaseRate + r.Price) * @People DESC)
	IF @RoomInfo IS NULL RETURN 'No rooms available'
	RETURN @RoomInfo;
END
GO

--12. Switch Room
--Create a user defined stored procedure, named usp_SwitchRoom(@TripId, @TargetRoomId), that receives a trip and a target room, and attempts to move the trip to the target room. A room will only be switched if all of these conditions are true:
--If the target room ID is in a different hotel, than the trip is in, raise an exception with the message “Target room is in another hotel!”.
--If the target room doesn’t have enough beds for all the trip’s accounts, raise an exception with the message “Not enough beds in target room!”.
--If all the above conditions pass, change the trip’s room ID to the target room ID.

CREATE PROC usp_SwitchRoom (@TripId INT, @TargetRoomId INT)
AS
DECLARE @TargetTripId INT = (SELECT Id FROM Trips WHERE Id = @TripId)
DECLARE @Room INT = (SELECT RoomId FROM Trips t
	JOIN Rooms r ON t.RoomId = r.Id
	WHERE @TargetRoomId = RoomId AND r.