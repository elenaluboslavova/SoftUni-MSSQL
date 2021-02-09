--01. DDL
CREATE TABLE Planes
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(30) NOT NULL,
	Seats INT NOT NULL,
	[Range] INT NOT NULL
)

CREATE TABLE Flights
(
	Id INT PRIMARY KEY IDENTITY,
	DepartureTime DATETIME,
	ArrivalTime DATETIME,
	Origin VARCHAR(50) NOT NULL,
	Destination VARCHAR(50) NOT NULL,
	PlaneId INT NOT NULL FOREIGN KEY REFERENCES Planes(Id)
)

CREATE TABLE Passengers
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Age INT NOT NULL,
	[Address] VARCHAR(30) NOT NULL,
	PassportId CHAR(11) NOT NULL
)

CREATE TABLE LuggageTypes
(
	Id INT PRIMARY KEY IDENTITY,
	[Type] VARCHAR(30) NOT NULL,
)

CREATE TABLE Luggages
(
	Id INT PRIMARY KEY IDENTITY,
	LuggageTypeId INT NOT NULL FOREIGN KEY REFERENCES LuggageTypes(Id),
	PassengerId INT NOT NULL FOREIGN KEY REFERENCES Passengers(Id)
)

CREATE TABLE Tickets
(
	Id INT PRIMARY KEY IDENTITY,
	PassengerId INT NOT NULL FOREIGN KEY REFERENCES Passengers(Id),
	FlightId INT NOT NULL FOREIGN KEY REFERENCES Flights(Id),
	LuggageId INT NOT NULL FOREIGN KEY REFERENCES Luggages(Id),
	Price DECIMAL(15,2) NOT NULL
)

--02. Insert
INSERT INTO Planes
VALUES
('Airbus 336', 112, 5132),
('Airbus 330', 432, 5325),
('Boeing 369', 231, 2355),
('Stelt 297', 254, 2143),
('Boeing 338', 165, 5111),
('Airbus 558', 387, 1342),
('Boeing 128', 345, 5541)

INSERT INTO LuggageTypes
VALUES
('Crossbody Bag'),
('School Backpack'),
('Shoulder Bag')

--03. Update
UPDATE Tickets
SET Price *= 1.13
WHERE FlightId = (SELECT TOP(1) Id FROM Flights WHERE Destination = 'Carlsbad')

--04. Delete
DELETE FROM Tickets
WHERE FlightId = (SELECT TOP(1) Id FROM Flights WHERE Destination = 'Ayn Halagim')

DELETE FROM Flights
WHERE Destination = 'Ayn Halagim'

--05. The 'Tr' Planes
SELECT * FROM Planes
	WHERE [Name] LIKE '%tr%'
	ORDER BY Id, [Name], Seats, [Range]

--06. Flight Profits
SELECT FlightId, SUM(Price) FROM Tickets
GROUP BY FlightId
ORDER BY SUM(Price) DESC, FlightId

--07. Passenger Trips
SELECT p.FirstName + ' ' + p.LastName AS [Full Name],
	f.Origin,
	f.Destination
FROM Passengers p
JOIN Tickets t ON t.PassengerId = p.Id
JOIN Flights f ON f.Id = t.FlightId
ORDER BY [Full Name], f.Origin, f.Destination

--08. Non Adventures People
SELECT p.FirstName, p.LastName, p.Age FROM Passengers p
LEFT JOIN Tickets t ON t.PassengerId = p.Id
WHERE t.Id IS NULL
ORDER BY p.Age DESC, FirstName, LastName

--09. Full Info
SELECT p.FirstName + ' ' + P.LastName AS [Full Name],
	pl.[Name] AS [Plane Name],
	f.Origin + ' - ' + f.Destination AS Trip,
	lg.[Type] AS [Luggage Type]
FROM Passengers p
JOIN Tickets t ON t.PassengerId = p.Id
JOIN Flights f ON t.FlightId = f.Id
JOIN Planes pl ON f.PlaneId = pl.Id
JOIN Luggages l ON t.LuggageId = l.Id
JOIN LuggageTypes lg ON l.LuggageTypeId = lg.Id
ORDER BY [Full Name], pl.[Name], f.Origin, f.Destination, lg.[Type]

--10. PSP
SELECT p.[Name], p.Seats, COUNT(t.Id) AS PassengersCount FROM Planes p
LEFT JOIN Flights f ON f.PlaneId = p.Id
LEFT JOIN Tickets t ON t.FlightId = f.Id
GROUP BY p.[Name], p.Seats
ORDER BY PassengersCount DESC, p.[Name], Seats

--11. Vacation
GO
CREATE FUNCTION udf_CalculateTickets(@origin varchar(50), @destination varchar(50), @peopleCount int)
RETURNS VARCHAR(100)
AS
BEGIN

IF (@peopleCount <= 0)
BEGIN
	RETURN 'Invalid people count!'
END

DECLARE @tripId INT = (SELECT f.Id FROM Flights AS f
											  JOIN Tickets AS t ON t.FlightId = f.Id 
											  WHERE Destination = @destination AND Origin = @origin)
IF (@tripId IS NULL)
BEGIN
	RETURN 'Invalid flight!'
END

DECLARE @ticketPrice DECIMAL(15,2) = (SELECT t.Price FROM Flights AS f
											  JOIN Tickets AS t ON t.FlightId = f.Id 
											  WHERE Destination = @destination AND Origin = @origin)

DECLARE @totalPrice DECIMAL(15, 2) = @ticketPrice * @peoplecount;

RETURN 'Total price ' + CAST(@totalPrice as VARCHAR(30));
END

--12. Wrong Data
GO
CREATE PROC usp_CancelFlights
AS
UPDATE Flights
SET ArrivalTime = NULL, DepartureTime = NULL
WHERE ArrivalTime > DepartureTime