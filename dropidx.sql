DROP INDEX IF EXISTS IX_AuditLogs_CreateDate_OrderID ON AuditLogs;
DROP INDEX IF EXISTS IX_Orders_CustomerID_OrderID ON Orders;
DROP INDEX IF EXISTS IX_OrderItems_OrderID_ProductID_Quantity ON OrderItems;
DROP INDEX IF EXISTS IX_Products_ProductID_ProductName ON Products;
DROP INDEX IF EXISTS IX_Customers_CustomerID_CustomerName ON Customers;
DROP INDEX IF EXISTS IX_OrderItems_OrderID_ProductID ON OrderItems;
DROP INDEX IF EXISTS IX_Products_ProductID ON Products;
DROP INDEX IF EXISTS IX_Customers_CustomerID ON Customers;
DROP INDEX IF EXISTS IX_AuditLogsDEL_CreateDate ON AuditLogs_del;


