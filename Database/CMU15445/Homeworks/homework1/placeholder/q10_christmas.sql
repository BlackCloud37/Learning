-- Q10 [15 POINTS] (Q10_CHRISTMAS):
-- Concatenate the ProductNames ordered by the Company 'Queen Cozinha' on 2014-12-25.
-- Details: Order the products by Id (ascending). Print a single string containing all the dup names separated by commas like Mishi Kobe Niku, NuNuCa Nuß-Nougat-Creme... 


WITH ProductNames AS (SELECT ProductName, ProductId
    FROM 'Order' AS o JOIN OrderDetail AS od  ON o.Id == od.OrderId
        JOIN Customer AS c ON c.Id == o.CustomerId
        JOIN Product AS p ON p.Id == ProductId
    WHERE CompanyName == 'Queen Cozinha' AND DATE(OrderDate) == '2014-12-25'
),
ProductNamesRc AS (SELECT ROW_NUMBER() OVER(ORDER BY ProductId ASC) AS Rc, ProductName 
    FROM ProductNames
),
Concatenated AS (
    SELECT Rc, ProductName AS Name
        FROM ProductNamesRc
        WHERE Rc == 1 
    UNION ALL
    SELECT ProductNamesRc.Rc, Concatenated.Name || ', ' || ProductNamesRc.ProductName
        FROM ProductNamesRc JOIN Concatenated ON ProductNamesRc.Rc == Concatenated.Rc + 1
)
SELECT Name FROM Concatenated ORDER BY Rc DESC LIMIT 1;