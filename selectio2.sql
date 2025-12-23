DBCC DROPCLEANBUFFERS; 
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
