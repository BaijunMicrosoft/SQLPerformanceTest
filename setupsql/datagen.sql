------------------------------------------------------------
-- Params
------------------------------------------------------------
DECLARE @CustomerCount INT = 50000;
DECLARE @ProductCount  INT = 500;
DECLARE @OrderCount    INT = 10000000;  -- Example: 10M
DECLARE @ItemsPerOrder INT = 2;

------------------------------------------------------------
-- Clear old data
------------------------------------------------------------
Truncate table AuditLogs;
Truncate table OrderItems;
Truncate table Orders;
Truncate table Products;
Truncate table Customers;

------------------------------------------------------------
-- Build #Numbers table (big enough for all inserts)
-- No CROSS APPLY, no sys.objects dependency
------------------------------------------------------------
IF OBJECT_ID('tempdb..#Numbers') IS NOT NULL DROP TABLE #Numbers;

WITH L0 AS (SELECT 1 AS n UNION ALL SELECT 1),
     L1 AS (SELECT 1 AS n FROM L0 AS A CROSS JOIN L0 AS B),  -- 4
     L2 AS (SELECT 1 AS n FROM L1 AS A CROSS JOIN L1 AS B),  -- 16
     L3 AS (SELECT 1 AS n FROM L2 AS A CROSS JOIN L2 AS B),  -- 256
     L4 AS (SELECT 1 AS n FROM L3 AS A CROSS JOIN L3 AS B),  -- 65536
     L5 AS (SELECT 1 AS n FROM L4 AS A CROSS JOIN L4 AS B)   -- 4B+
SELECT TOP (@OrderCount * @ItemsPerOrder) 
       ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS num
INTO #Numbers
FROM L5;

CREATE UNIQUE CLUSTERED INDEX IX_Num ON #Numbers(num);

------------------------------------------------------------
-- Customers
------------------------------------------------------------
INSERT INTO Customers (CustomerName, Email)
SELECT CONCAT('Customer ', num),
       CONCAT('customer', num, '@example.com')
FROM #Numbers
WHERE num <= @CustomerCount;

------------------------------------------------------------
-- Products
------------------------------------------------------------
INSERT INTO Products (ProductName, Price)
SELECT CONCAT('Product ', num),
       CAST((ABS(CHECKSUM(NEWID()) % 10000) + 100) / 100.00 AS DECIMAL(18,2))
FROM #Numbers
WHERE num <= @ProductCount;

------------------------------------------------------------
-- Orders
-- Map each Order to an existing CustomerID using modulo
------------------------------------------------------------
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
SELECT ((num - 1) % @CustomerCount) + 1 AS CustomerID,
       DATEADD(DAY, - (ABS(CHECKSUM(NEWID()) % 365)), GETDATE()),
       CAST((ABS(CHECKSUM(NEWID()) % 50000) + 1000) / 100.00 AS DECIMAL(18,2))
FROM #Numbers
WHERE num <= @OrderCount;

------------------------------------------------------------
-- OrderItems
-- Map each OrderItem to valid OrderID & ProductID
------------------------------------------------------------
INSERT INTO OrderItems (OrderID, ProductID, Quantity, LineTotal)
SELECT ((num - 1) / @ItemsPerOrder) + 1 AS OrderID,
       ((num - 1) % @ProductCount) + 1  AS ProductID,
       ABS(CHECKSUM(NEWID()) % 5) + 1 AS Quantity,
       CAST((ABS(CHECKSUM(NEWID()) % 10000) + 100) / 100.00 AS DECIMAL(18,2))
FROM #Numbers
WHERE num <= @OrderCount * @ItemsPerOrder;

------------------------------------------------------------
-- AuditLogs
-- Spread times randomly across the day
------------------------------------------------------------
INSERT INTO AuditLogs (OrderID, ActionType, Create_Date)
SELECT num AS OrderID,
       CASE WHEN num % 2 = 0 THEN 'CREATE' ELSE 'UPDATE' END,
       DATEADD(SECOND, 
               CAST(RAND(CHECKSUM(NEWID())) * 86400 AS INT),
               DATEADD(DAY, - (ABS(CHECKSUM(NEWID()) % 365)),
                       CAST(CAST(GETDATE() AS date) AS datetime)))
FROM #Numbers
WHERE num <= @OrderCount;
