USE [2ndLAB]
go

CREATE TABLE Model(
Mid INT PRIMARY KEY IDENTITY(1,1),
MName VARCHAR(50),
MSurname VARCHAR(50),
Height INT,
Weight INT,
Nationality VARCHAR(50));

SET IDENTITY_INSERT Model ON

INSERT INTO Model(Mid, MName, MSurname, Height, Weight, Nationality)
VALUES (1, 'Jenner', 'Kendall', 180, 59, 'american'), 
		(2, 'Banks', 'Tyra', 180, 55, 'american'),
		(3, 'Kerr', 'Miranda', 178, 57, 'australian'),
		(4, 'Lima', 'Adriana', 177, 59, 'brazilian'),
		(5, 'Klum', 'Heidi', 177, 55, 'german'),
		(6, 'Rocha', 'Coco', 177, 57, 'canadian'),
		(7, 'Shayk', 'Irina', 175, 51, 'indian'),
		(8, 'Bündchen', 'Gisele', 170, 48, 'german');

SET IDENTITY_INSERT Model OFF 

SELECT *
FROM Model

CREATE TABLE Contracts(
Cid INT PRIMARY KEY IDENTITY(1,1),
ManagerName VARCHAR(50),
MoneyOfC INT,
DOfC VARCHAR(50));

SET IDENTITY_INSERT Contracts ON

INSERT INTO Contracts(Cid, ManagerName, MoneyOfC, DOfC)
VALUES (1, 'Jenner Kris', 120000, '11.10.2019'),
		(2, 'Hadid Yolanda', 90000, '24.08.2019'),
		(3, 'Hadid Mohamed', 150000, '4.09.2019'),
		(4, 'Jenner Robin', 100000, '26.07.2019'),
		(5, 'Munteanu Maurice', 80000, '12.09.2018'),
		(6, 'Ciobanu Razvan', 120000, '17.03.2019'),
		(7, 'April Emily', 180000, '24.08.2019'),
		(8, 'Anderson Clara', 60000, '24.08.2019');

SET IDENTITY_INSERT Contracts OFF 

SELECT *
FROM Contracts

CREATE TABLE Payments(
Pid INT PRIMARY KEY IDENTITY(1,1),
SumP INT,
Mid INT FOREIGN KEY REFERENCES Model(Mid));

SET IDENTITY_INSERT Payments ON

INSERT INTO Payments(Pid, SumP, Mid)
VALUES (1, 65000, 2),
		(2, 120000, 1),
		(3, 95000, 1),
		(4, 80000, 5),
		(5, 60000, 3),
		(6, 120000, 8),
		(7, 60000, 2),
		(8, 60000, 7);

SET IDENTITY_INSERT Payments OFF 

SELECT *
FROM Payments

CREATE TABLE Travel(
Tid INT PRIMARY KEY IDENTITY(1,1),
Flight VARCHAR(50),
Hotel VARCHAR(50),
Mid INT FOREIGN KEY REFERENCES Model(Mid));

SET IDENTITY_INSERT Travel ON

INSERT INTO Travel(Tid, Flight, Hotel, Mid)
VALUES (1, 'London-Tokyo', 'Maddison Blue Hotel', 2),
		(2, 'Berlin-California', 'Ramada Hotel', 5),
		(3, 'Bucharest-Maldives', 'Ayana Resort', 1),
		(4, 'Milano-Istanbul', 'Glamour Hotel Istanbul', 3),
		(5, 'Berlin-Canda', 'Diamond Hotel', 2),
		(6, 'Milano-Istanbul', 'Kiara Hotel', 8),
		(7, 'Rome-New York', 'Grand Hotel', 4),
		(8, 'Bucharest-Cluj Napoca', 'Golden Tulip', 1);

SET IDENTITY_INSERT Travel OFF 

SELECT *
FROM Travel

CREATE TABLE ModelContract(
Mid INT FOREIGN KEY REFERENCES Model(Mid),
Cid INT FOREIGN KEY REFERENCES Contracts(Cid),
CONSTRAINT pk_ModelContract PRIMARY KEY(Mid,Cid));

INSERT INTO ModelContract(Mid, Cid)
VALUES (1, 2),
		(2, 2),
		(3, 1),
		(5, 6),
		(6, 5),
		(7, 8),
		(8, 2);

SELECT *
FROM ModelContract

CREATE TABLE Manager(
MAid INT PRIMARY KEY,
MAName VARCHAR(50),
MASurname VARCHAR(50),
ContractNo INT,
Email VARCHAR(50),
Cid INT FOREIGN KEY REFERENCES Contracts(Cid));

INSERT INTO Manager(MAid, MAName, MASurname, ContractNo, Email, Cid)
VALUES (1, 'Jenner', 'Kris', 1540, 'kris@mramodels.com', 3),
		(2, 'Hadid', 'Yolanda', 987, 'yolanda@mramodels.com', 2),
		(3, 'Hadid', 'Mohamed', 2009, 'mohamed@mramodels.com', 1),
		(4, 'Tomminson', 'Michael', 1599, 'michael@mramodels.com', 8),
		(5, 'Adams', 'Kinga', 2080, 'kinga@mramodels.com', 1),
		(6, 'Badulescu', 'Raluca', 1540, 'raluca@mramodels.com', 1),
		(7, 'Phillip', 'Angele', 455, 'angele@mramodels.com', 5),
		(8, 'Salim', 'Guigui', 1540, 'guigui@mramodels.com', 6);

SELECT *
FROM Manager

CREATE TABLE Team(
Teamid INT PRIMARY KEY,
Photographer VARCHAR(50),
MakeUpArtist VARCHAR(50),
HairStylist VARCHAR(50),
Designer VARCHAR(50),
Tid INT FOREIGN KEY REFERENCES Travel(Tid));

INSERT INTO Team(Teamid, Photographer, MakeUpArtist, HairStylist, Designer, Tid)
VALUES (1, 'Camila Falquez', 'Ioana Stratulat', 'Sorin Stratulat', 'Dana Budeanu', 4),
		(2, 'Nadine Ijewere', 'Pat McGrath ', 'Amy Baugh', 'Pyer Moss', 1),
		(3, 'Zev Hoover', 'Bobbie Brown', 'Elizabeth Faye', 'Chakshyn', 2),
		(4, 'Tom Johnson', 'Hung Vanngo ', 'David Mallett', 'Maison Valentino', 2),
		(5, 'Alecsandra Raluca Dragoi', 'Patrick Ta’s', 'Ted Gibson', 'Coco Chanel', 8),
		(6, 'Nicholas Scarpinato', 'Hrush Achemyan', 'Serge Normant', 'Phillipe Plain', 5),
		(7, 'Oliver Charles', 'Sir John ', 'Hiro Haraguchi', 'Christian Dior', 3),
		(8, 'Rachel Baran', 'Samia Ahamd', 'Tracey Cunningham', 'Michael Kors', 6);

SELECT *
FROM Team

--updates the surname that starts with K
SELECT *
FROM Model

UPDATE Model
SET MSurname = 'Kylie'
WHERE MSurname LIKE 'K%'

SELECT *
FROM Model

--updates contracts that has the given date 
SELECT * 
FROM Contracts

UPDATE Contracts
SET ManagerName = 'Jenner Robin' 
WHERE DOfC='11.10.2019' AND ManagerName IS NOT NULL

SELECT * 
FROM Contracts

--deletes the contract that has the given date
SELECT * 
FROM Contracts

DELETE FROM Contracts
WHERE DOfC = '26.07.2019'

SELECT *
FROM Contracts

SELECT *
FROM Model

SELECT *
FROM Model
WHERE MName LIKE 'A%'
UNION 
SELECT *
FROM Model 
WHERE Height=177

SELECT *
FROM Payments

SELECT *
FROM Payments
WHERE SumP>100000
UNION
SELECT *
FROM Payments
WHERE Mid=1

SELECT *
FROM Model

SELECT m1.MName
FROM Model m1
WHERE MName LIKE 'K%'
INTERSECT
SELECT m2.MName 
FROM Model m2
WHERE Height =177
ORDER BY m1.MName ASC

SELECT *
FROM Model

SELECT m1.MSurname
FROM Model m1
WHERE MSurname LIKE 'M'
EXCEPT
SELECT m2.MSurname
FROM Model m2
WHERE Weight=57
ORDER BY m1.MSurname DESC

SELECT *
FROM Model

--INNER JOIN
SELECT *
FROM Model m 
INNER JOIN
Payments p ON m.Mid = p.Mid
INNER JOIN
Travel t ON m.Mid = t.Mid

--RIGHT JOIN
SELECT *
FROM Model m
RIGHT OUTER JOIN
Payments p ON m.Mid = p.Mid

--LEFT JOIN
SELECT *
FROM Model m
LEFT OUTER JOIN
Payments P on m.Mid = p.Mid

--FULL JOIN
SELECT *
FROM Model m
FULL OUTER JOIN
Payments p ON m.Mid = p.Mid

SELECT *
FROM Manager

--IN 
--selects the manager id
SELECT 




