set statistics time,io on

-- Expensive query WITHOUT indexes
SELECT 
    c.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.OrderDate,
    p.ProductName,
    oi.Quantity,
    COALESCE(al.ActionType, 'NO LOG') AS ActionType,
    al.Create_Date
FROM Customers c
INNER JOIN Orders o      ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Products p    ON oi.ProductID = p.ProductID
INNER JOIN AuditLogs al  ON o.OrderID = al.OrderID
where al.Create_Date >= '2025-06-04 10:00:00'
  AND al.Create_Date <  '2025-06-05 00:00:00';

select o.*, al.ActionType,al.Create_Date from AuditLogs al --WITH (INDEX(IX_AuditLogs_CreateDate_OrderID), FORCESEEK)
join Orders o on al.OrderID = o.OrderID
where al.Create_Date >= '2025-06-04 22:00:00'
  AND al.Create_Date <  '2025-06-05 00:00:00' ;

select top 1000 * from AuditLogs


SELECT 
    c.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.OrderDate,
    p.ProductName,
    oi.Quantity,
    COALESCE(al.ActionType, 'NO LOG') AS ActionType,
    al.Create_Date
FROM AuditLogs al
    INNER JOIN Orders o      ON al.OrderID = o.OrderID
    INNER JOIN Customers c   ON o.CustomerID = c.CustomerID
    INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
    INNER JOIN Products p    ON oi.ProductID = p.ProductID
WHERE al.Create_Date >= '2025-06-04'
  AND al.Create_Date <  '2025-06-05'
OPTION (FORCE ORDER,LOOP JOIN);

