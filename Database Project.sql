CREATE DATABASE FinalAssessment
CREATE TABLE [employer] (
  [id] int PRIMARY KEY ,
  [employer_name] nvarchar(255)
)
GO

CREATE TABLE [job_seekers] (
  [id] int PRIMARY KEY ,
  [seeker_name] nvarchar(255),
  [industry] nvarchar(255),
  [location] nvarchar(255),
  [experience] nvarchar(255)
)

GO

CREATE TABLE [vacancy] (
  [id] int PRIMARY KEY ,
  [industry] nvarchar(255),
  [location] nvarchar(255),
  [experience] nvarchar(255),
  [created_at] datetime,
  [vacancy_name] nvarchar(255),
  [is_vacancy_hidden] BIT,
  [employerID] int
)


GO

CREATE TABLE [job_application] (
  [id] int PRIMARY KEY ,
  [seekerID] int default null FOREIGN KEY REFERENCES job_seekers ,
  [vacancyID] int FOREIGN KEY REFERENCES vacancy,
  [date] date
)
GO


CREATE TABLE [saved_vacancy] (
  [id] int PRIMARY KEY ,
  [seekerID] int,
  [vacancyID] int
)
GO



ALTER TABLE [vacancy] ADD FOREIGN KEY ([employerID]) REFERENCES [employer] ([id])
GO



ALTER TABLE [job_application] ADD FOREIGN KEY ([seekerID]) REFERENCES [job_seekers] ([id])
GO

ALTER TABLE [job_application] ADD FOREIGN KEY ([vacancyID]) REFERENCES [vacancy] ([id])
GO


ALTER TABLE [saved_vacancy] ADD FOREIGN KEY ([vacancyID]) REFERENCES [vacancy] ([id])
GO

ALTER TABLE [saved_vacancy] ADD FOREIGN KEY ([seekerID]) REFERENCES [job_seekers] ([id])
GO

INSERT INTO employer (id,employer_name) values 
(1,'Amr');
INSERT INTO employer (id,employer_name) values 
(2,'Mohamed');
INSERT INTO employer (id,employer_name) values 
(3,'Omar');
INSERT INTO employer (id,employer_name) values 
(4,'Nabil');
INSERT INTO employer (id,employer_name) values 
(5,'Ahmed');


INSERT INTO job_seekers (id,seeker_name, industry, experience, location) values 
(1,'Samir', 'WEB Development', 'Professional', 'Matarya');
INSERT INTO job_seekers (id,seeker_name, industry, experience, location) values 
(2,'Fathi', 'Genetics Analysis', 'Amateur', 'Shobra');
INSERT INTO job_seekers (id,seeker_name, industry, experience, location) values 
(3,'Khalid', 'Wordpress Editing', 'Entry', 'Fayuom');
INSERT INTO job_seekers (id,seeker_name, industry, experience, location) values 
(4,'Saad', 'Game Development', 'Elite', 'Haram');
INSERT INTO job_seekers (id,seeker_name, industry, experience, location) values 
(5,'Youssef', 'Wordpress Editing', 'Elite', 'Madenty');



INSERT INTO vacancy(id,Industry,Location,experience,created_at,vacancy_name,is_vacancy_hidden,employerID) values 
(1,'WEB','Talbia','Profissional','2020/4/05','Front-End Developer',0,1);
INSERT INTO vacancy(id,Industry,Location,experience,created_at,vacancy_name,is_vacancy_hidden,employerID) values 
(2,'Data Analysis','Tawabik','Beginner','2020/4/15','Analyst',0,3);
INSERT INTO vacancy(id,Industry,Location,experience,created_at,vacancy_name,is_vacancy_hidden,employerID) values 
(3,'Software Engineering','Nasr City','Amateur','2020/3/25','Software Engineer',0,2);
INSERT INTO vacancy(id,Industry,Location,experience,created_at,vacancy_name,is_vacancy_hidden,employerID) values 
(4,'Wordpress Editing','Talbia','Elite','2020/4/05','Editing',0,4);
INSERT INTO vacancy(id,Industry,Location,experience,created_at,vacancy_name,is_vacancy_hidden,employerID) values 
(5,'Game Development','Nasr City','Entry','2020/4/25','Developer',0,2);
INSERT INTO vacancy(id,Industry,Location,experience,created_at,vacancy_name,is_vacancy_hidden,employerID) values 
(6,'Game Development','Nasr City','Entry','2020/4/25','Developer',0,2);

INSERT INTO job_application (id,seekerID,vacancyID,date) values 
(1,3,4,'2020/5/15');
INSERT INTO job_application (id,seekerID,vacancyID,date) values 
(2,4,5,'2020/5/12');
--INSERT INTO job_application (seekerID,vacancyID,date) values 
--(5,4,'2020/5/11');
INSERT INTO job_application (id,seekerID,vacancyID,date) values 
(3,3,3,'2020/5/18');

---------------------
SELECT * FROM employer
SELECT * FROM job_seekers
SELECT * FROM vacancy
SELECT * FROM job_application
---------------------
DELETE FROM employer
DELETE FROM job_seekers
DELETE FROM job_application
DELETE FROM vacancy
------------------------------------------------
--Query1 
--The most intersting job "title" that had maximum number of applicants
SELECT TOP 1 vacancy_name, count (job_application.id) AS numOfOccur
FROM vacancy, job_application
WHERE vacancy.id = job_application.vacancyID
GROUP BY vacancy_name
ORDER BY numOfOccur DESC
------------------------------------------------
--Query2
--The announced job "title" that had not any applicants last month
SELECT Industry FROM vacancy where NOT EXISTS 
(SELECT job_application.vacancyID FROM job_application 
WHERE job_application.vacancyID = vacancy.id and 
created_at > '2020/4/1')
------------------------------------------------
--Query3
--The employer with the maximum announcements last month
SELECT TOP 1 employer.id, employer.employer_name, MAX(occur.numOfJobs) AS numOfVacancies FROM employer, 
(
	SELECT employerID , COUNT (vacancy.employerID) AS numOfJobs
	FROM vacancy
	GROUP BY employerID
) occur
WHERE employer.id = occur.employerID
GROUP BY employer.id,employer.employer_name ,occur.numOfJobs
ORDER BY occur.numOfJobs DESC
------------------------------------------------
--Query4
--The employers who did not announce any job last month
SELECT employer_name FROM employer WHERE NOT EXISTS (
SELECT vacancy.employerID FROM vacancy 
WHERE vacancy.employerID = employer.id and created_at > '2020/1/1' and created_at < '2020/6/1'
)
------------------------------------------------
--Query5
--The available positions set by each employer last month
SELECT DISTINCT employer_name , vacancy_name FROM employer , vacancy 
WHERE is_vacancy_hidden = 0 and vacancy.employerID = employer.id and created_at > '2020/1/1' and created_at < '2020/6/1'
------------------------------------------------
--Query6
--Retrieving all seekers info and the number of jobs he/she applied for
SELECT seeker_name, Industry, experience , location, 
count (job_application.seekerID) AS NumOfJobs
FROM job_application
RIGHT JOIN job_seekers ON job_seekers.id = job_application.seekerID
GROUP BY  seeker_name , industry , experience , location
-----------------------------------------------------------------------------------------