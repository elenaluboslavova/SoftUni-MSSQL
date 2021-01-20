CREATE TABLE Persons
(
	PersonID INT NOT NULL,
	FirstName VARCHAR(20) NOT NULL,
	Salary DECIMAL(8,2) NOT NULL,
	PassportID INT NOT NULL
)

CREATE TABLE Passports
(
	PassportID INT NOT NULL,
	PassportNumber VARCHAR(50) NOT NULL
)

ALTER TABLE Persons
	ADD CONSTRAINT PK_PersonID PRIMARY KEY (PersonID)

ALTER TABLE Passports
	ADD CONSTRAINT PK_PassportID PRIMARY KEY (PassportID)

ALTER TABLE Persons
	ADD CONSTRAINT FK_PassportID FOREIGN KEY (PassportID) REFERENCES Passports (PassportID)



INSERT INTO Passports
VALUES
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2')

INSERT INTO Persons
VALUES
(1, 'Roberto', 43300, 102),
(2, 'Tom', 56100, 103),
(3, 'Yana', 60200, 101)