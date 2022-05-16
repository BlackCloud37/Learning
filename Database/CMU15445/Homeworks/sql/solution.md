# Homework1

[Homework specification](https://15445.courses.cs.cmu.edu/fall2021/homework1/)

### Q2

#### Answer
```sqlite
SELECT DISTINCT ShipName, SUBSTR(ShipName, 0, INSTR(ShipName, '-'))
    FROM 'Order' 
    WHERE ShipName LIKE '%-%'
    ORDER BY ShipName ASC;
```
- `DISTINCT`: 去重
- `LIKE '%-%'`: 字符串匹配
- `SUBSTR(X, Y, Z)`: 取子字符串`X[Y:Y+Z]`
- `INSTR(X, Y)`: 返回`(index of first Y in X) + 1`
#### Result
```
Bottom-Dollar Markets|Bottom
Chop-suey Chinese|Chop
GROSELLA-Restaurante|GROSELLA
HILARION-Abastos|HILARION
Hungry Owl All-Night Grocers|Hungry Owl All
LILA-Supermercado|LILA
LINO-Delicateses|LINO
QUICK-Stop|QUICK
Save-a-lot Markets|Save
```

### Q3

#### Answer

```sqlite
SELECT Id, ShipCountry, (CASE 
       WHEN ShipCountry IS 'USA' OR ShipCountry IS 'Mexico' OR ShipCountry IS 'Canada'
       THEN 'NorthAmerica'
       ELSE 'OtherPlace'
       END)
    FROM 'Order'
    WHERE Id >= 15445
    ORDER BY Id ASC
    LIMIT 20;
```

- `CASE WHEN ELSE END`

#### Result

```
15445|France|OtherPlace
15446|Italy|OtherPlace
15447|Portugal|OtherPlace
15448|Argentina|OtherPlace
15449|Portugal|OtherPlace
15450|Venezuela|OtherPlace
15451|Brazil|OtherPlace
15452|France|OtherPlace
15453|France|OtherPlace
15454|Canada|NorthAmerica
15455|USA|NorthAmerica
15456|France|OtherPlace
15457|Mexico|NorthAmerica
15458|USA|NorthAmerica
15459|Germany|OtherPlace
15460|Argentina|OtherPlace
15461|Austria|OtherPlace
15462|Austria|OtherPlace
15463|Finland|OtherPlace
15464|Brazil|OtherPlace
```

### Q4

#### Answer

```sqlite
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
```

- `PRINTF` 格式化输出
- `IIF` 为三元表达式语义

#### Result

```
Federal Shipping|23.61
Speedy Express|23.46
United Package|23.44
```

### Q5

#### Answer

```sqlite
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
```

- `ROUND` 取约
- `HAVING` 对聚合函数作filter

#### Result

```
Beverages|12|37.98|4.5|263.5|60
Condiments|12|23.06|10|43.9|170
Confections|13|25.16|9.2|81|180
Seafood|12|20.68|6|62.5|120
```

### Q6

#### Answer

```sqlite
SELECT ProductName, CompanyName, ContactName
    FROM Product AS p JOIN 'Order' AS o JOIN OrderDetail AS od JOIN Customer AS c
        ON OrderId == o.Id AND p.Id == od.ProductId AND c.Id == CustomerId
    WHERE Discontinued == 1 
    GROUP BY p.Id
    HAVING OrderDate == MIN(OrderDate)
    ORDER BY ProductName;
```

- `HAVING`来选取`GROUP BY`后组内的最小行

#### Result

```
Alice Mutton|Consolidated Holdings|Elizabeth Brown
Chef Anton's Gumbo Mix|Piccolo und mehr|Georg Pipps
Guaraná Fantástica|Piccolo und mehr|Georg Pipps
Mishi Kobe Niku|Old World Delicatessen|Rene Phillips
Perth Pasties|Piccolo und mehr|Georg Pipps
Rössle Sauerkraut|Piccolo und mehr|Georg Pipps
Singaporean Hokkien Fried Mee|Vins et alcools Chevalier|Paul Henriot
Thüringer Rostbratwurst|Piccolo und mehr|Georg Pipps
```

### Q7

#### Answer

```sqlite
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
```

- `JULIANDAY`做日期计算
- `LAG`和`OVER`取行偏移

#### Result

```
16766|2012-07-22 23:11:15|2012-07-22 23:11:15|0.0
10265|2012-07-25|2012-07-22 23:11:15|2.03
12594|2012-08-16 12:35:15|2012-07-25|22.52
20249|2012-08-16 16:52:23|2012-08-16 12:35:15|0.18
20882|2012-08-18 19:11:48|2012-08-16 16:52:23|2.1
18443|2012-08-28 05:34:03|2012-08-18 19:11:48|9.43
10297|2012-09-04|2012-08-28 05:34:03|6.77
11694|2012-09-17 00:27:14|2012-09-04|13.02
25613|2012-09-18 22:37:15|2012-09-17 00:27:14|1.92
17361|2012-09-19 12:13:21|2012-09-18 22:37:15|0.57
```

### Q8

#### Answer

```sqlite
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

```

- `IFNULL`
- `NTILE` 把数据按数目分组，此处计算四分位数
- `OUTER JOIN`

#### Result

```
MISSING_NAME||42817.55
Trail's Head Gourmet Provisioners|TRAIH|3874502.02
Blondesddsl père et fils|BLONP|3879728.69
Around the Horn|AROUT|4395636.28
Hungry Owl All-Night Grocers|HUNGO|4431457.1
Bon app|BONAP|4485708.49
Bólido Comidas preparadas|BOLID|4520121.88
Galería del gastrónomo|GALED|4533089.9
FISSA Fabrica Inter. Salchichas S.A.|FISSA|4554591.02
Maison Dewey|MAISD|4555931.37
Cactus Comidas para llevar|CACTU|4559046.87
Spécialités du monde|SPECD|4571764.89
Magazzini Alimentari Riuniti|MAGAA|4572382.35
Toms Spezialitäten|TOMSP|4628403.36
Split Rail Beer & Ale|SPLIR|4641383.53
Santé Gourmet|SANTG|4647668.15
Morgenstern Gesundkost|MORGK|4676234.2
White Clover Markets|WHITC|4681531.74
La corne d'abondance|LACOR|4724494.22
Victuailles en stock|VICTE|4726476.33
Lonesome Pine Restaurant|LONEP|4735780.66
Bottom-Dollar Markets|BOTTM|4738375.12
Tortuga Restaurante|TORTU|4742734.16
```

### Q9

#### Answer

```sqlite
SELECT Region.RegionDescription, FirstName, LastName,  BirthDate
    FROM Employee JOIN EmployeeTerritory JOIN Territory JOIN Region
        ON Employee.Id == EmployeeTerritory.EmployeeId
           AND EmployeeTerritory.TerritoryId == Territory.Id
           AND Territory.RegionId == Region.Id
    GROUP BY Region.Id
    HAVING Employee.BirthDate == MAX(Employee.BirthDate)
    ORDER BY BirthDate;
```

#### Result

```
Eastern|Steven|Buchanan|1987-03-04
Western|Michael|Suyama|1995-07-02
Southern|Janet|Leverling|1995-08-30
Northern|Anne|Dodsworth|1998-01-27
```

### Q10

#### Answer

```sqlite
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
```

- [Recursive CTEs](https://sqlite.org/lang_with.html)

#### Result

```
Mishi Kobe Niku, NuNuCa Nuß-Nougat-Creme, Schoggi Schokolade, Mascarpone Fabioli, Sasquatch Ale, Boston Crab Meat, Manjimup Dried Apples, Longlife Tofu, Lakkalikööri
```

