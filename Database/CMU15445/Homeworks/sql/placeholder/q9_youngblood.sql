-- Q9 [15 POINTS] (Q9_YOUNGBLOOD):
-- Find the youngest employee serving each Region. If a Region is not served by an employee, ignore it.
-- Details: Print the Region Description, First Name, Last Name, and Birth Date. Order by Region Id.
-- Your first row should look like Eastern|Steven|Buchanan|1987-03-04

SELECT Region.RegionDescription, FirstName, LastName,  BirthDate
    FROM Employee JOIN EmployeeTerritory JOIN Territory JOIN Region
        ON Employee.Id == EmployeeTerritory.EmployeeId
           AND EmployeeTerritory.TerritoryId == Territory.Id
           AND Territory.RegionId == Region.Id
    GROUP BY Region.Id
    HAVING Employee.BirthDate == MAX(Employee.BirthDate)
    ORDER BY BirthDate;