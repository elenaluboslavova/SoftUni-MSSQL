--01. DDL
CREATE TABLE Users
(
	Id INT PRIMARY KEY IDENTITY,
	Username VARCHAR(30) NOT NULL,
	[Password] VARCHAR(30) NOT NULL,
	Email VARCHAR(50) NOT NULL
)

CREATE TABLE Repositories
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE RepositoriesContributors
(
	RepositoryId INT FOREIGN KEY REFERENCES Repositories(Id) NOT NULL,
	ContributorId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL
	CONSTRAINT PK_Rep_Cont PRIMARY KEY (RepositoryId, ContributorId)
)

CREATE TABLE Issues
(
	Id INT PRIMARY KEY IDENTITY,
	Title VARCHAR(255) NOT NULL,
	IssueStatus CHAR(6) NOT NULL,
	RepositoryId INT FOREIGN KEY REFERENCES Repositories(Id) NOT NULL,
	AssigneeId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL
)

CREATE TABLE Commits
(
	Id INT PRIMARY KEY IDENTITY,
	[Message] VARCHAR(255) NOT NULL,
	IssueId INT FOREIGN KEY REFERENCES Issues(Id),
	RepositoryId INT FOREIGN KEY REFERENCES Repositories(Id) NOT NULL,
	ContributorId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL
)

CREATE TABLE Files
(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(100) NOT NULL,
	Size DECIMAL(15,2) NOT NULL,
	ParentId INT REFERENCES Files(Id),
	CommitId INT FOREIGN KEY REFERENCES Commits(Id) NOT NULL
)

--02. Insert
INSERT INTO Files
VALUES
('Trade.idk', 2598.0, 1, 1),
('menu.net', 9238.31, 2, 2),
('Administrate.soshy', 1246.93, 3, 3),
('Controller.php', 7353.15, 4, 4),
('Find.java', 9957.86, 5, 5),
('Controller.json',	14034.87, 3, 6),
('Operate.xix',	7662.92, 7, 7)

INSERT INTO Issues
VALUES
('Critical Problem with HomeController.cs file', 'open', 1, 4),
('Typo fix in Judge.html', 'open', 4, 3),
('Implement documentation for UsersService.cs', 'closed', 8, 2),
('Unreachable code in Index.cs', 'open', 9, 8)

--03. Update
UPDATE Issues
SET IssueStatus = 'closed'
WHERE AssigneeId = 6

--04. Delete
SELECT * FROM Repositories
SELECT * FROM RepositoriesContributors
SELECT * FROM Issues


DELETE FROM Files
WHERE CommitId IN (SELECT Id FROM Commits WHERE RepositoryId = 3)

DELETE FROM Commits
WHERE RepositoryId = 3

DELETE FROM Issues
WHERE RepositoryId = 3

DELETE FROM RepositoriesContributors
WHERE RepositoryId = 3

--05. Commits
SELECT Id, [Message], RepositoryId, ContributorId FROM Commits
ORDER BY Id ASC, [Message] ASC, RepositoryId ASC, ContributorId ASC

--06. Front-end
SELECT Id, [Name], Size FROM Files
WHERE Size > 1000 AND [Name] LIKE '%html%'
ORDER BY Size DESC, Id ASC, [Name] ASC

--07. Issue Assignment
SELECT i.Id, u.Username + ' : ' + i.Title FROM Issues i
JOIN Users u ON i.AssigneeId = u.Id
ORDER BY i.Id DESC, i.AssigneeId ASC

--08. Single files
--Select all of the files, which are NOT a parent to any other file. Select their size of the file and add "KB" to the end of it. Order them file id (ascending), file name (ascending) and file size (descending).

SELECT parent.Id, parent.[Name], CONVERT(VARCHAR, parent.Size) + 'KB' FROM Files parent
LEFT JOIN Files child ON parent.Id = child.ParentId
WHERE child.Id IS NULL
ORDER BY parent.Id ASC, parent.[Name] ASC, parent.Size DESC

--09. Commits in Repositories
SELECT TOP(5) r.Id, r.[Name], COUNT(*) AS Commits FROM RepositoriesContributors rc
JOIN Repositories r ON rc.RepositoryId = r.Id
JOIN Commits c ON c.RepositoryId = r.Id
GROUP BY r.Id, r.[Name]
ORDER BY Commits DESC, r.Id ASC, r.[Name] ASC

--10. Average Size
SELECT u.Username, AVG(f.Size) FROM Users u
JOIN Commits c ON c.ContributorId = u.Id
JOIN Files f ON f.CommitId = c.Id
GROUP BY u.Username
ORDER BY AVG(f.Size) DESC, u.Username ASC

--11. All User Commits
GO
CREATE FUNCTION udf_AllUserCommits(@username NVARCHAR(30))
RETURNS INT
AS
BEGIN
	DECLARE @Count INT = (SELECT COUNT(*) FROM Commits c
    JOIN Users u ON c.ContributorId = u.Id
	WHERE u.Username = @username
	GROUP BY u.Username)
	IF (@Count IS NOT NULL AND @Count != 0) RETURN @Count
	RETURN 0
END
GO

--12. Search For Files
GO
CREATE PROC usp_SearchForFiles(@fileExtension VARCHAR(MAX))
AS
SELECT Id, [Name], CONVERT(VARCHAR, Size) + 'KB' AS Size FROM Files
WHERE [Name] LIKE '%' + @fileExtension
ORDER BY Id ASC, [Name] ASC, Size DESC