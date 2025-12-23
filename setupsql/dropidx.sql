DROP INDEX IF EXISTS IX_AuditLogs_CreateDate_OrderID ON AuditLogs;
DROP INDEX IF EXISTS IX_Orders_CustomerID_OrderID ON Orders;
DROP INDEX IF EXISTS IX_OrderItems_OrderID_ProductID_Quantity ON OrderItems;
DROP INDEX IF EXISTS IX_Products_ProductID_ProductName ON Products;
DROP INDEX IF EXISTS IX_Customers_CustomerID_CustomerName ON Customers;
DROP INDEX IF EXISTS IX_OrderItems_OrderID_ProductID ON OrderItems;
DROP INDEX IF EXISTS IX_Products_ProductID ON Products;
DROP INDEX IF EXISTS IX_Customers_CustomerID ON Customers


select Count(*) from AuditLogs al  
where al.Create_Date >= '2025-06-05'
  AND al.Create_Date <  '2025-06-06';


select count(*) from OrderItems;


