USE AdventureWorks2017
  
SELECT TOP 5 OrderDate
FROM Sales.SalesOrderHeader
WHERE AccountNumber
IN (SELECT AccountNumber
    FROM Sales.SalesOrderHeader
	GROUP BY AccountNumber
	Having SUM(SubTotal)>70000)
ORDER BY OrderDate DESC