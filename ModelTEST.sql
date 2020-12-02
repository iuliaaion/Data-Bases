USE ModelTEST
GO

--if u is null we don t have the table
IF OBJECT_ID('RoutesStations', 'U') IS NOT NULL
	DROP TABLE RoutesStations
IF OBJECT_ID('Stations', 'U') IS NOT NULL
	DROP TABLE Stations
IF OBJECT_ID('Routes', 'U') IS NOT NULL
	DROP TABLE Routes
IF OBJECT_ID('Trains', 'U') IS NOT NULL
	DROP TABLE Trains
IF OBJECT_ID('TrainTypes', 'U') IS NOT NULL
	DROP TABLE TrainTypes
GO

CREATE TABLE TrainTypes
( TTid INT PRIMARY KEY IDENTITY(1,1),
  Description VARCHAR(400))

CREATE TABLE Trains
( Tid INT PRIMARY KEY IDENTITY(1,1),
  TName VARCHAR(100),
  TTid INT REFERENCES TrainTypes(TTid))

CREATE TABLE Routes
( Rid INT PRIMARY KEY IDENTITY(1,1),
  RName VARCHAR(100) UNIQUE,
  Tid INT REFERENCES Trains(TID))

CREATE TABLE Stations
( Sid INT PRIMARY KEY IDENTITY(1,1),
  SName VARCHAR(400))

CREATE TABLE RoutesStations
( Rid INT REFERENCES Routes(Rid),
  Sid INT REFERENCES Stations(Sid),
  Arrival TIME,
  Departures TIME,
  PRIMARY KEY(Rid,Sid))

--use create or alter because it creates the procedure if !exist otherwise change
GO
CREATE OR ALTER PROC uspStationOnRoute
	@SName VARCHAR(100), @RName VARCHAR(100),
	@Arrival TIME, @Departure TIME
AS
	DECLARE @Sid INT = (SELECT Sid
						FROM Stations
						WHERE SName = @SName),
			@Rid INT = (SELECT Rid
						FROM Routes
						WHERE RName = @RName)
IF @Sid IS NULL OR @Rid IS NULL
BEGIN
	RAISERROR('no such station/routes',16,1) 
	RETURN -1
END

IF EXISTS(SELECT * FROM RoutesStations
		  WHERE Rid = @Rid AND Sid = @Sid)
	UPDATE RoutesStations
	SET Arrival = @Arrival, Departures = @Departure
	WHERE Rid = @Rid AND Sid = @Sid
ELSE 
	INSERT RoutesStations(Rid,Sid,Arrival,Departures)
	VALUES (@Rid,@Sid,@Arrival,@Departure)
GO

INSERT TrainTypes
	VALUES ('interregio'),('regio')
INSERT Trains
	VALUES ('t1',1),('t2',1),('t3',1)
INSERT Routes
	VALUES ('r1',1),('r2',2),('r3',3)
INSERT Stations
	VALUES ('s1'),('s2'),('s3')

SELECT * FROM TrainTypes
SELECT * FROM Trains
SELECT * FROM Routes
SELECT * FROM Stations
SELECT * FROM RoutesStations

uspStationOnRoute 's1','r1','6:10','6:20'
EXEC uspStationOnRoute 's2','r1','6:30','6:35'

EXEC uspStationOnRoute 's3','r1','6:40','6:45'
EXEC uspStationOnRoute 's3','r2','7:40','7:45'
EXEC uspStationOnRoute 's3','r3','8:40','8:45'

SELECT * FROM RoutesStations

SELECT RS.Sid
FROM RoutesStations RS
GROUP BY RS.Sid
HAVING COUNT(*) >=3

GO
CREATE OR ALTER FUNCTION ufFilterStations(@R INT)
RETURNS TABLE
RETURN SELECT S.SName
FROM Stations S
WHERE S.Sid IN
	(SELECT RS.Sid
	 FROM RoutesStations RS
	 GROUP BY RS.Sid
	 HAVING COUNT(*) >=@R)
GO

SELECT * FROM RoutesStations

SELECT * 
FROM ufFilterStations(4)


