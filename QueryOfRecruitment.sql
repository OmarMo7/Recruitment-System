Create Database RecruitmentSystem
--DROP TABLE Employers
--DROP TABLE JobSeekers
--DROP TABLE Vacancy

Create Table Employers
(
EmployerId INT IDENTITY PRIMARY KEY,
Name nvarchar(100),
Industry nVarchar(50) ,
Location nVarchar(50),
Is_Available BIT 
)


Create Table JobSeekers(
JobSeekersId INT IDENTITY PRIMARY KEY , 
Name nvarchar(100),
Industry nVarchar(50),
Location nVarchar(50),
Experience nVarchar(50),
)

Create Table Vacancy
(
VacancyId INT PRIMARY KEY,
EmployerId INT FOREIGN KEY REFERENCES Employers,
Industry nVarchar(50),
Location nVarchar(50),
ExperienceRequired nVarchar(50),
IsVisible BIT
)
SET IDENTITY_INSERT Vacancy ON
SET IDENTITY_INSERT JobSeekers ON
----------------------
ALTER TABLE Employers DROP COLUMN Industry

INSERT INTO Employers (Name,Industry,Location,Is_Available) values 
('Amr','Mechanic','Zaghloul',1);
INSERT INTO Employers (Name,Industry,Location,Is_Available) values 
('Bahaa','Drug Dealer','Sinai',1);
INSERT INTO Employers (Name,Industry,Location,Is_Available) values 
('Sameh','Farmer','Meet Bezzo',1);
INSERT INTO Employers (Name,Industry,Location,Is_Available) values 
('Khalid','Scenarist','Matrouh',1);
INSERT INTO Employers (Name,Industry,Location,Is_Available) values 
('Bahaa','Weapon Seller','Sinai',1);
INSERT INTO JobSeekers (Name,Industry,Location,Experience) values 
('Omar','Drug Dealer','Nasr City', 'Elite');
INSERT INTO JobSeekers (Name,Industry,Location,Experience) values 
('Nabil','Scenarist','Tawabik', 'Amateur');
INSERT INTO JobSeekers (Name,Industry,Location,Experience) values 
('Mohammed','Mechanic','El-Manshya', 'Professional')
INSERT INTO JobSeekers (Name,Industry,Location,Experience) values 
('Ali','Painter','Giza','Professional')
INSERT INTO Vacancy (VacancyId,EmployerId,Industry,Location,ExperienceRequired,IsVisible) values 
(1,4,'Painter','Shobra','Professional',1)
INSERT INTO Vacancy (VacancyId,EmployerId,Industry,Location,ExperienceRequired,IsVisible) values 
(2,1,'Mechanic','El-Zamalek', 'Professional',1)
INSERT INTO Vacancy (VacancyId,EmployerId,Industry,Location,ExperienceRequired,IsVisible) values 
(3,4,'Painter','El-Zamalek', 'Professional',1)
INSERT INTO Vacancy (VacancyId,EmployerId,Industry,Location,ExperienceRequired,IsVisible) values 
(4,5,'Drug Dealer','Shobra', 'Skilled',0)
INSERT INTO Vacancy (VacancyId,EmployerId,Industry,Location,ExperienceRequired,IsVisible) values 
(5,2,'Director','Shobra', 'Elite',1)
---------------------
SELECT * FROM Employers
SELECT * FROM JobSeekers
SELECT * FROM Vacancy
---------------------
DELETE FROM Employers
DELETE FROM JobSeekers
DELETE FROM Vacancy
---------------------
SELECT * FROM Vacancy WHERE Vacancy.IsVisible = 0

--Cannot get the max of this query
--Table JobSeekers could be changed to another kind of table

SELECT MAX (Industry) as numOfApps FROM JobSeekers Group by Industry
--SELECT e.Industry FROM Employers e , Vacancy v where e.Is_Available = 1 and e.Industry = v.Industry

SELECT v.Industry FROM Vacancy v  where NOT EXISTS 
(SELECT j.Industry FROM JobSeekers j)
SELECT * FROM JobSeekers
SELECT * FROM Vacancy