USE AdventureWorks2017
GO
CREATE TRIGGER I_U_CheckPriceRise
ON Production.Product
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;

	IF UPDATE(ListPrice)
		BEGIN
			UPDATE Production.Product
			SET ListPrice = IIF((i.ListPrice - d.ListPrice) > d.ListPrice*0.15, d.ListPrice, i.ListPrice)
			FROM deleted AS d, Production.Product AS p
			INNER JOIN inserted AS i ON i.ProductID = p.ProductID
		END
END
GO
--UPDATE Production.Product
--SET ListPrice = 1800
--WHERE ProductID = 680