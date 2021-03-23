USE AdventureWorks2017

/*Write separate queries using a join, a subquery, a CTE, and then an EXISTS to list all AdventureWorks 
customers who have not placed an order*/

--JOINS

SELECT c.CustomerID FROM Sales.SalesOrderHeader soh 
       RIGHT JOIN Sales.Customer c ON soh.CustomerID=c.CustomerID
       Where SalesOrderID IS NULL

--Subquery
SELECT c.CustomerID 
FROM Sales.Customer c
WHERE c.CustomerID NOT IN (SELECT CustomerID FROM Sales.SalesOrderHeader)

--CTE
WITH Customerwithoutorder(CustomerID)
AS
(
        SELECT c.CustomerID
		FROM Sales.SalesOrderHeader soh
		RIGHT JOIN Sales.Customer c ON soh.CustomerID=c.CustomerID
		WHERE SalesOrderID IS NUll
)
SELECT * FROM Customerwithoutorder

--EXIST
SELECT c.CustomerID
FROM Sales.Customer c
WHERE NOT EXISTS (SELECT s.CustomerID FROM Sales.SalesOrderHeader AS s 
                                      WHERE s.CustomerID=c.CustomerID)

