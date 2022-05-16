-- Q7 [15 POINTS] (Q7_ORDER_LAGS):
-- For the first 10 orders by CutomerId BLONP: get the Order's Id, OrderDate, previous OrderDate, and difference between the previous and current. Return results ordered by OrderDate (ascending)
-- Details: The "previous" OrderDate for the first order should default to itself (lag time = 0). Use the julianday() function for date arithmetic (example). 
-- Use lag(expr, offset, default) for grabbing previous dates. 
-- Please round the lag time to the nearest hundredth, formatted like 17361|2012-09-19 12:13:21|2012-09-18 22:37:15|0.57

SELECT Id, 
       OrderDate, 
       PreviousOrderDate,
       ROUND(JULIANDAY(OrderDate) - JULIANDAY(PreviousOrderDate), 2) AS LagTime
    FROM
    (SELECT Id, 
            OrderDate, 
            LAG(OrderDate, 1, OrderDate) OVER(ORDER BY OrderDate) AS PreviousOrderDate
        FROM 'Order'
        WHERE CustomerId == 'BLONP' 
        ORDER BY OrderDate ASC
        LIMIT 10);