CREATE TABLE Models
(
	ModelID INT NOT NULL,
	[Name] VARCHAR(40) NOT NULL,
	ManufacturerID INT NOT NULL
)

CREATE TABLE Manufacturers
(
	ManufacturerID INT NOT NULL,
	[Name] VARCHAR(40) NOT NULL,
	EstablishedOn DATE NOT NULL
)

ALTER TABLE Models
	ADD CONSTRAINT PK_ModelID PRIMARY KEY (ModelID)

ALTER TABLE Manufacturers
	ADD CONSTRAINT PK_ManufacturerID PRIMARY KEY (ManufacturerID)

ALTER TABLE Models
	ADD CONSTRAINT FK_ManufacturerID FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers (ManufacturerID)

INSERT INTO Manufacturers
VALUES
(1, 'BMW', '07/03/1916'),
(2, 'Tesla', '01/01/2003'),
(3, 'Lada', '01/05/1996')

INSERT INTO Models
VALUES
(101, 'X1', 1),
(102, 'i6', 1),
(103, 'Model S', 2),
(104, 'Model X', 2),
(105, 'Model 3', 2),
(106, 'Nova', 3)