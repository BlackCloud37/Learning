-- Q6 [10 POINTS] (Q6_DISCONTINUED):
-- For each of the 8 discontinued products in the database, which customer made the first ever order for the product? Output the customer's CompanyName and ContactName
-- Details: Print the following format, order by ProductName alphabetically: Alice Mutton|Consolidated Holdings|Elizabeth Brown

SELECT ProductName, CompanyName, ContactName
    FROM Product AS p JOIN 'Order' AS o JOIN OrderDetail AS od JOIN Customer AS c
        ON OrderId == o.Id AND p.Id == od.ProductId AND c.Id == CustomerId
    WHERE Discontinued == 1 
    GROUP BY p.Id
    HAVING OrderDate == MIN(OrderDate)
    ORDER BY ProductName;