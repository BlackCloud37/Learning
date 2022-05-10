-- Q4 [10 POINTS] (Q4_DELAYPERCENT):
-- For each Shipper, find the percentage of orders which are late.
-- Details: An order is considered late if ShippedDate > RequiredDate. Print the following format, order by descending precentage, rounded to the nearest hundredths, like United Package|23.44

WITH OrderShipper AS (
    SELECT o.ShippedDate  AS ShippedDate, 
           o.RequiredDate AS RequiredDate, 
           s.CompanyName  AS CompanyName
        FROM 'Order' as o JOIN Shipper as s ON o.ShipVia == s.Id
),
ShipperOrderCount AS (
    SELECT CompanyName,
           SUM(IIF(ShippedDate > RequiredDate, 1, 0)) AS DelayCount,
           COUNT(*) AS OrderCount
    FROM OrderShipper GROUP BY CompanyName
)
SELECT CompanyName, PRINTF('%.2f', 100.0 * DelayCount / OrderCount) AS DelayPercent 
    FROM ShipperOrderCount
    ORDER BY DelayPercent DESC;