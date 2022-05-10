-- Q8 [15 POINTS] (Q8_TOTAL_COST_QUARTILES):
-- For each Customer, get the CompanyName, CustomerId, and "total expenditures". Output the bottom quartile of Customers, as measured by total expenditures.
-- Details: Calculate expenditure using UnitPrice and Quantity (ignore Discount). Compute the quartiles for each company's total expenditures using NTILE. The bottom quartile is the 1st quartile, order them by increasing expenditure.
-- Make sure your output is formatted as follows (round expenditure to nearest hundredths): Bon app|BONAP|4485708.49

-- Note: There are orders for CustomerIds that don't appear in the Customer table. You should still consider these "Customers" and output them. If the CompanyName is missing, override the NULL to 'MISSING_NAME' using IFNULL.

WITH CompanyExpenditure AS (SELECT IFNULL(CompanyName, 'MISSING_NAME') AS CompanyName, 
            Customer.Id, 
            ROUND(SUM(Quantity * UnitPrice), 2) AS TotalExpenditure,
            NTILE(4) OVER(ORDER BY ROUND(SUM(Quantity * UnitPrice), 2) ASC) AS Bucket
        FROM ('Order' AS o JOIN OrderDetail ON OrderDetail.OrderId == o.Id) 
            LEFT OUTER JOIN Customer 
            ON o.CustomerId == Customer.Id
        GROUP BY Customer.Id)
SELECT CompanyName, Id,  TotalExpenditure
    FROM CompanyExpenditure
    WHERE Bucket == 1;
