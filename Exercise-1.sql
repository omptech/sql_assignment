USE AdventureWorks2017

/*Display the number of records in the [SalesPerson] table. 
(Schema(s) involved: Sales)*/

SELECT count(*) AS "No of Records"
FROM Sales.SalesPerson

/*Select both the FirstName and LastName of records from the Person table 
where the FirstName begins with the letter ‘B’. 
(Schema(s) involved: Person)*/

SELECT FirstName,LastName 
FROM Person.Person 
WHERE FirstName LIKE 'B%'


/*Select a list of FirstName and LastName for employees where Title is one of Design Engineer, 
Tool Designer or Marketing Assistant. (Schema(s) involved: HumanResources, Person)*/

SELECT p.FirstName,p.LastName 
FROM Person.Person AS p, 
HumanResources.Employee AS e
WHERE e.BusinessEntityID=p.BusinessEntityID AND e.JobTitle 
IN ('Design Engineer','Tool Designer','Marketing Assistant')

/*Display the Name and Color of the Product with the maximum weight. 
(Schema(s) involved: Production)*/

SELECT Name,Color 
FROM Production.Product 
WHERE [Weight]=(SELECT MAX([Weight]) FROM Production.Product)

/*Display Description and MaxQty fields from the SpecialOffer table. 
Some of the MaxQty values are NULL, in this case display the value 0.00 instead. 
(Schema(s) involved: Sales)*/

SELECT Description,COALESCE(MaxQty,0.00) 
FROM Sales.SpecialOffer

/*Display the overall Average of the [CurrencyRate].[AverageRate] values for the exchange rate ‘USD’ to ‘GBP’ 
for the year 2005 i.e. FromCurrencyCode = ‘USD’ and ToCurrencyCode = ‘GBP’. Note: The field [CurrencyRate].
[AverageRate] is defined as 'Average exchange rate for the day.' (Schema(s) involved: Sales)*/

SELECT AVG(AverageRate) AS 'Average exchange rate for the day' 
FROM Sales.CurrencyRate 
WHERE FromCurrencyCode='USD' AND ToCurrencyCode='GBP' AND YEAR(CurrencyRateDate)=2005

/*Display the FirstName and LastName of records from the Person table where 
FirstName contains the letters ‘ss’. Display an additional column with sequential 
numbers for each row returned beginning at integer 1. (Schema(s) involved: Person)*/

SELECT ROW_NUMBER() OVER(ORDER BY FirstName, LastName) AS 'Sr. No.',FirstName, Lastname
FROM  Person.Person
WHERE FirstName LIKE '%ss%'

/*Sales people receive various commission rates that belong to 1 of 4 bands. (Schema(s) involved: Sales)
Display the [SalesPersonID] with an additional column entitled ‘Commission Band’ indicating the appropriate band as above.*/

SELECT BusinessEntityID AS 'SalesPersonID', 
CASE 
       WHEN CommissionPct=0.0 THEN 'Band 0'
	   WHEN CommissionPct=0.0 AND CommissionPct<=0.01 then 'BAND 1'
	   WHEN CommissionPct=0.0 AND CommissionPct<=0.015 then 'BAND 2'
	   WHEN CommissionPct>0.015 then 'BAND 3'
	   END AS 'Commission Band'
FROM Sales.SalesPerson;

/*Display the managerial hierarchy from Ruth Ellerbrock (person type – EM) up to CEO Ken Sanchez. 
Hint: use [uspGetEmployeeManagers] (Schema(s) involved: [Person], [HumanResources]) */

DECLARE @ID INT;
SELECT @ID = BusinessEntityID
FROM Person.Person
WHERE FirstName='Ruth'
      AND LastName='Ellerbrock'
	  AND PersonType='EM'
EXEC dbo.uspGetEmployeeManagers @BusinessEntityID=@ID;

/*Display the ProductId of the product with the largest stock level. 
Hint: Use the Scalar-valued function [dbo]. [UfnGetStock]. (Schema(s) involved: Production)*/

SELECT MAX(dbo.ufnGetStock(ProductID)) FROM Production.Product;



