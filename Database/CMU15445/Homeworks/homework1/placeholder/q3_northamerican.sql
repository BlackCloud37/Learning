-- Q3 [5 POINTS] (Q3_NORTHAMERICAN):
-- Indicate if an order's ShipCountry is in North America. For our purposes, this is 'USA', 'Mexico', 'Canada'
-- Details: You should print the Order Id, ShipCountry, and another column that is either 'NorthAmerica' or 'OtherPlace' depending on the Ship Country.
-- Order by the primary key (Id) ascending and return 20 rows starting from Order Id 15445 Your output should look like 15445|France|OtherPlace or 15454|Canada|NorthAmerica

SELECT Id, ShipCountry, CASE 
       WHEN ShipCountry IS 'USA' OR ShipCountry IS 'Mexico' OR ShipCountry IS 'Canada'
       THEN 'NorthAmerica'
       ELSE 'OtherPlace'
       END
    FROM 'Order'
    WHERE Id >= 15445
    ORDER BY Id ASC
    LIMIT 20;
