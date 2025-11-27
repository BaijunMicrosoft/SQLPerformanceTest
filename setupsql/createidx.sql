-------------------------------------------------
-- 1. AuditLogs: Filter by Create_Date + join on OrderID
-------------------------------------------------
CREATE NONCLUSTERED INDEX IX_AuditLogs_CreateDate_OrderID
    ON AuditLogs (Create_Date);
GO

-------------------------------------------------
-- 2. Orders: join on CustomerID + OrderID
-------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Orders_CustomerID_OrderID
    ON Orders (OrderID);
GO

-------------------------------------------------
-- 3. OrderItems: join on OrderID + ProductID
-------------------------------------------------
CREATE NONCLUSTERED INDEX IX_OrderItems_OrderID_ProductID
    ON OrderItems (OrderID);
GO

-------------------------------------------------
-- 4. Products: join on ProductID
-------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Products_ProductID
    ON Products (ProductID);
GO

-------------------------------------------------
-- 5. Customers: join on CustomerID
-------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Customers_CustomerID
    ON Customers (CustomerID);
GO
