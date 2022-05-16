-- Q5 [10 POINTS] (Q5_AGGREGATES):
-- Compute some statistics about categories of products
-- Details: Get the number of products, average unit price (rounded to 2 decimal places), minimum unit price, maximum unit price, and total units on order for categories containing greater than 10 products. 
-- Order by Category Id. Your output should look like Beverages|12|37.98|4.5|263.5|60

SELECT CategoryName, 
       COUNT(*),
       ROUND(AVG(UnitPrice), 2) AS AvgUnitPrice,
       MIN(UnitPrice), 
       MAX(UnitPrice),
       SUM(UnitsOnOrder)
    FROM Category JOIN Product ON CategoryId == Category.Id
    GROUP BY CategoryId
    HAVING COUNT(*) > 10
    ORDER BY CategoryId;