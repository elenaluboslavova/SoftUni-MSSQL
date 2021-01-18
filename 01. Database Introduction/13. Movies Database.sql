CREATE DATABASE Movies

USE Movies

CREATE TABLE Directors
(
	Id INT PRIMARY KEY,
	DirectorName NVARCHAR(30) NOT NULL,
	Notes VARCHAR(50)
)

INSERT INTO Directors
VALUES
(1, 'Director1', NULL),
(2, 'Director2', NULL),
(3, 'Director3', NULL),
(4, 'Director4', NULL),
(5, 'Director5', NULL)

CREATE TABLE Genres
(
	Id INT PRIMARY KEY,
	GenreName NVARCHAR(30) NOT NULL,
	Notes VARCHAR(50)
)

INSERT INTO Genres
VALUES
(1, 'Genre1', NULL),
(2, 'Genre2', NULL),
(3, 'Genre3', NULL),
(4, 'Genre4', NULL),
(5, 'Genre5', NULL)

CREATE TABLE Categories
(
	Id INT PRIMARY KEY,
	CategoryName NVARCHAR(30) NOT NULL,
	Notes VARCHAR(50)
)

INSERT INTO Categories
VALUES
(1, 'Category1', NULL),
(2, 'Category2', NULL),
(3, 'Category3', NULL),
(4, 'Category4', NULL),
(5, 'Category5', NULL)

CREATE TABLE Movies
(
	Id INT PRIMARY KEY,
	Title NVARCHAR(50) NOT NULL,
	DirectorId INT NOT NULL,
	CopyrightYear INT NOT NULL,
	[Length] INT NOT NULL,
	GenreId INT NOT NULL,
	CategoryId INT NOT NULL,
	Rating DECIMAL(3,1),
	Notes VARCHAR(50)
)

INSERT INTO Movies
VALUES
(1, 'Title1', 1, 2015, 126, 1, 1, NULL, NULL),
(2, 'Title2', 2, 2015, 126, 2, 2, NULL, NULL),
(3, 'Title3', 3, 2015, 126, 3, 3, NULL, NULL),
(4, 'Title4', 4, 2015, 126, 4, 4, NULL, NULL),
(5, 'Title5', 5, 2015, 126, 5, 5, NULL, NULL)