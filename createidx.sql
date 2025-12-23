DROP INDEX IF EXISTS IX_AuditLogs_CreateDate_OrderID ON AuditLogs;
DROP INDEX IF EXISTS IX_Orders_CustomerID_OrderID ON Orders;
DROP INDEX IF EXISTS IX_OrderItems_OrderID_ProductID_Quantity ON OrderItems;
DROP INDEX IF EXISTS IX_Products_ProductID_ProductName ON Products;
DROP INDEX IF EXISTS IX_Customers_CustomerID_CustomerName ON Customers;
DROP INDEX IF EXISTS IX_OrderItems_OrderID_ProductID ON OrderItems;
DROP INDEX IF EXISTS IX_Products_ProductID ON Products;
DROP INDEX IF EXISTS IX_Customers_CustomerID ON Customers;
DROP INDEX IF EXISTS IX_AuditLogsDEL_CreateDate ON AuditLogs_del;

-------------------------------------------------
-- 1. AuditLogs: Filter by Create_Date + join on OrderID
-------------------------------------------------
CREATE NONCLUSTERED INDEX IX_AuditLogs_CreateDate_OrderID
    ON AuditLogs (Create_Date);

CREATE NONCLUSTERED INDEX IX_AuditLogsDEL_CreateDate
    ON AuditLogs_del (Create_Date);

-------------------------------------------------
-- 2. Orders: join on CustomerID + OrderID
-------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Orders_CustomerID_OrderID
    ON Orders (OrderID);

-------------------------------------------------
-- 3. OrderItems: join on OrderID + ProductID
-------------------------------------------------
CREATE NONCLUSTERED INDEX IX_OrderItems_OrderID_ProductID
    ON OrderItems (OrderID);

-------------------------------------------------
-- 4. Products: join on ProductID
-------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Products_ProductID
    ON Products (ProductID);

-------------------------------------------------
-- 5. Customers: join on CustomerID
-------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Customers_CustomerID
    ON Customers (CustomerID);
