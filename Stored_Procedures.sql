USE ModelAGENCY
go

CREATE TABLE Version
(Vid INT PRIMARY KEY IDENTITY,
[version] INT);

--procedure that adds a column
GO
CREATE PROCEDURE ups_createNewColumn
AS
BEGIN
ALTER TABLE Model
ADD [DofB] VARCHAR(50)
PRINT 'Column reguarding date of birth has been succesfully added to the Model table'
	UPDATE Version
	SET version=1
END

EXEC ups_createNewColumn

--procedure that deletes a column
GO
CREATE PROCEDURE ups_deleteNewColumn
AS 
BEGIN 
	ALTER TABLE Model
	DROP COLUMN [DofB]
	PRINT 'Column reguarding date of birth has been succesfully removed to the Model table'

	UPDATE Version
	SET version=0;
END

EXEC ups_deleteNewColumn

--procedure that creates a new table
GO
CREATE PROCEDURE ups_createNewTable
AS
BEGIN
	CREATE TABLE ElleStyleAward
	(Eid INT NOT NULL,
	NoOfParticipants INT,
	Location VARCHAR(50),
	Date VARCHAR(50))
	PRINT 'Table ElleStyleAward has been succesfully created'

	UPDATE Version
	SET version=2;
END

EXEC ups_createNewTable

--procedure that deletes the new table to the new table created
GO
CREATE PROCEDURE ups_deleteNewTable
AS
BEGIN
	DROP TABLE ElleStyleAward
	PRINT 'Table ElleStyleAward has been succesfully deleted'

	UPDATE Version
	SET version=1;
END

EXEC ups_deleteNewTable

--procedure that adds primary key to the new table created
GO
CREATE PROCEDURE ups_addPrimaryKey
AS
BEGIN
	ALTER TABLE ElleStyleAward
	ADD CONSTRAINT pk_ElleStyleAward PRIMARY KEY(Eid)
	PRINT 'The ElleStyleAward table has now a primary key'

	UPDATE Version
	SET version=3;
END 

EXEC ups_addPrimaryKey

--procedure that deletes primary key to the new table created 
GO
CREATE PROCEDURE ups_deletePrimaryKey
AS
BEGIN
	ALTER TABLE ElleStyleAward
	DROP CONSTRAINT pk_ElleStyleAward
	PRINT 'The primary key of the ElleStyleAward has been deleted'

	UPDATE Version
	SET version=2;
END

EXEC ups_deletePrimaryKey

--procedure that adds foreign key to the new table created
GO
CREATE PROCEDURE ups_addForeignKey
AS
BEGIN
	ALTER TABLE ElleStyleAward
	ADD CONSTRAINT fk_ElleStyleAward FOREIGN KEY(Eid) REFERENCES Model(Mid)
	PRINT 'The ElleStyleAward table has now a foreign key'

	UPDATE Version
	SET version=4;
END 

EXEC ups_addForeignKey

--procedure that deletes foreign key to the new table created
GO
CREATE PROCEDURE ups_deleteForeignKey
AS
BEGIN
	ALTER TABLE ElleStyleAward
	DROP CONSTRAINT fk_ElleStyleAward
	PRINT 'The foreign key of the ElleStyleAward has been deleted'

	UPDATE Version
	SET version=3;
END 

EXEC ups_deleteForeignKey

INSERT INTO Version
(version)
VALUES 
(0);

--drop procedure ups_back 
GO
CREATE PROCEDURE ups_back
(@version INT)
AS
BEGIN
	DECLARE @currentVersion INT=(SELECT [version]
								FROM [Version])
			IF @currentVersion = 4 AND @version = 0
				BEGIN
				EXEC ups_deleteForeignKey
				EXEC ups_deletePrimaryKey
				EXEC ups_deleteNewTable
				EXEC ups_deleteNewColumn
				END;
			ELSE
			IF @currentVersion = 4 AND @version = 1
				BEGIN
				EXEC ups_deleteForeignKey
				EXEC ups_deletePrimaryKey
				EXEC ups_deleteNewTable
				END;
			ELSE
			IF @currentVersion = 4 AND @version = 2
				BEGIN
				EXEC ups_deleteForeignKey
				EXEC ups_deletePrimaryKey
				END;
			ELSE
			IF @currentVersion = 4 AND @version = 3
				BEGIN
				EXEC ups_deleteForeignKey
				END;
			ELSE
			IF @currentVersion = 3 AND @version = 0
				BEGIN
				EXEC ups_deletePrimaryKey
				EXEC ups_deleteNewTable
				EXEC ups_deleteNewColumn
				END;
			ELSE
			IF @currentVersion = 3 AND @version = 1
				BEGIN
				EXEC ups_deletePrimaryKey
				EXEC ups_deleteNewTable
				END;
			ELSE
			IF @currentVersion = 3 AND @version = 2
				BEGIN 
				EXEC ups_deletePrimaryKey
				END;
			ELSE 
			IF @currentVersion = 2 AND @version = 0
				BEGIN 
				EXEC ups_deleteNewTable
				EXEC ups_deleteNewColumn
				END;
			ELSE
			IF @currentVersion = 2 AND @version = 1
				BEGIN
				EXEC ups_deleteNewTable
				END;
			ELSE 
			IF @currentVersion = 1 AND @version = 0
				BEGIN 
				EXEC ups_deleteNewColumn
				END;
			ELSE 
			
			IF @currentVersion = 0 AND @version = 4
				BEGIN
				EXEC ups_createNewColumn
				EXEC ups_createNewTable
				EXEC ups_addPrimaryKey
				EXEC ups_addForeignKey
				END;
			ELSE
			IF @currentVersion = 1 AND @version = 4
				BEGIN
				EXEC ups_createNewTable
				EXEC ups_addPrimaryKey
				EXEC ups_addForeignKey
				END;
			ELSE 
			IF @currentVersion = 2 AND @version = 4
				BEGIN
				EXEC ups_addPrimaryKey
				EXEC ups_addForeignKey
				END;
			ELSE
			IF @currentVersion = 3 AND @version = 4
				BEGIN
				EXEC ups_addForeignKey
				END;
			ELSE 

			IF @currentVersion = 0 AND @version = 3
				BEGIN 
				EXEC ups_createNewColumn
				EXEC ups_createNewTable
				EXEC ups_addPrimaryKey
				END;
			ELSE 
			IF @currentVersion = 1 AND @version = 3
				BEGIN 
				EXEC ups_createNewTable
				EXEC ups_addPrimaryKey
				END;
			ELSE 
			IF @currentVersion = 2 AND @version = 3
				BEGIN
				EXEC ups_addPrimaryKey
				END;
			ELSE 

			IF @currentVersion = 0 AND @version = 2
				BEGIN
				EXEC ups_createNewColumn
				EXEC ups_createNewTable
				END;
			ELSE 
			IF @currentVersion = 1 AND @version = 2
				BEGIN
				EXEC ups_createNewTable
				END;
			ELSE 
			IF @currentVersion = 0 AND @version = 1
				BEGIN
				EXEC ups_createNewColumn
				END;
END;

EXEC ups_back 3;

GO 
CREATE PROCEDURE ups_operate
AS
BEGIN
	EXEC ups_back 0

	EXEC ups_createNewColumn

	EXEC ups_back 0

	EXEC ups_createNewColumn
	EXEC ups_createNewTable

	EXEC ups_back 0

	EXEC ups_createNewColumn
	EXEC ups_createNewTable
	EXEC ups_addPrimaryKey

	EXEC ups_back 0

	EXEC ups_createNewColumn
	EXEC ups_createNewTable
	EXEC ups_addPrimaryKey
	EXEC ups_addForeignKey

	EXEC ups_back 0

END;





				

