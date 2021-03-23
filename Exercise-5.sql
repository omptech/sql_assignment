USE AdventureWorks2017;


--PROCEDURE
GO
CREATE PROCEDURE Person.up_getNamesByTypes
	@Type nchar(2) = 'EM'
AS
SELECT FirstName FROM Person.Person WHERE PersonType = @Type
GO

--EXEC Person.up_getNamesByType @Type ='SC'