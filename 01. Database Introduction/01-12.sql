--01. Create Database
CREATE DATABASE Minions

USE Minions

--02. Create Tables
CREATE TABLE Minions
(
	Id INT PRIMARY KEY,
	[Name] NVARCHAR(30),
	Age INT
)

CREATE TABLE Towns
(
	Id INT PRIMARY KEY,
	[Name] NVARCHAR(50),
)

--03. Alter Minions Table
ALTER TABLE Minions
ADD TownId INT

ALTER TABLE Minions
ADD FOREIGN KEY (TownId) REFERENCES Towns(Id)

--04. Insert Records in Both Tables
INSERT INTO Towns (Id, Name) VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO Minions (Id, Name, Age, TownId) VALUES
(1, 'Kevin', 22, 1)

INSERT INTO Minions (Id, Name, Age, TownId) VALUES
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)

--05. Truncate Table Minions
DELETE FROM Minions

--06. Drop All Tables
DROP TABLE Minions

DROP TABLE Towns

--07. Create Table People
CREATE TABLE People
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(200) NOT NULL,
	Picture VARCHAR(MAX),
	Height FLOAT(2),
	[Weight] FLOAT(2),
	Gender CHAR(1) CHECK (Gender IN('m', 'f')) NOT NULL,
	Birthdate DATETIME NOT NULL,
	Biography NVARCHAR(MAX)
)

INSERT INTO People
([Name], Gender, Birthdate)
VALUES
('Stoyan', 'm', '5/12/1970'),
('Pesho', 'm', '6/12/1970'),
('Ivan', 'm', '7/12/1970'),
('Vasil', 'm', '8/12/1970'),
('Gosho', 'm', '9/12/1970')

--08. Create Table Users
CREATE TABLE Users
(
	Id BIGINT PRIMARY KEY IDENTITY,
	Username VARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARCHAR(MAX),
	LastLoginTime DATETIME,
	IsDeleted BIT
)

INSERT INTO Users 
(Username, [Password], ProfilePicture, LastLoginTime, IsDeleted)
VALUES
('Stoyan', 'stoyan123', 'https://github.com/icoric.png?size=32', '1/12/2021', 0),
('Pesho', 'pesho123', 'https://github.com/icoric.png?size=32', '5/12/2021', 0),
('Ivan', 'ivan123', 'https://github.com/icoric.png?size=32', '6/12/2021', 0),
('Gosho', 'gosho123', 'https://github.com/icoric.png?size=32', '10/12/2021', 0),
('Vasil', 'vasil123', 'https://github.com/icoric.png?size=32', '7/12/2021', 0)

SELECT * FROM Users

--09. Change Primary Key
ALTER TABLE Users
DROP CONSTRAINT PK__Users__3214EC07E39A4E63

ALTER TABLE Users
ADD CONSTRAINT PK_IdUsername PRIMARY KEY (Id, Username)

--10. Add Check Constraint
ALTER TABLE Users
ADD CONSTRAINT CH_PasswordIsAtLeast5Symbols CHECK (LEN([Password]) > 5)

--11. Set Default Value of a Field
ALTER TABLE Users
ADD CONSTRAINT DF_LastLoginTime DEFAULT GETDATE() FOR LastLoginTime

--12. Set Unique Field
ALTER TABLE Users
DROP CONSTRAINT PK_IdUsername

ALTER TABLE Users
ADD CONSTRAINT PK_Id PRIMARY KEY (Id)

ALTER TABLE Users
ADD CONSTRAINT CH_UsernameIsAtLeast3Symbols CHECK (LEN(Username) > 3)