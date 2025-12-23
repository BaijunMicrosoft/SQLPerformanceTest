-- Drop tables if they exist
DROP TABLE IF EXISTS AuditLogs;
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- Customers table
CREATE TABLE Customers
(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NULL
);

-- Orders table
CREATE TABLE Orders
(
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    TotalAmount DECIMAL(18,2) NOT NULL
);

-- Products table
CREATE TABLE Products
(
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Price DECIMAL(18,2) NOT NULL
);

-- OrderItems table
CREATE TABLE OrderItems
(
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    LineTotal DECIMAL(18,2) NOT NULL
);

-- AuditLogs table
CREATE TABLE AuditLogs
(
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ActionType NVARCHAR(50) NOT NULL,
    Create_Date DATETIME NOT NULL
);

CREATE OR ALTER FUNCTION dbo.GetNumbers(@TopNum INT)
RETURNS TABLE
AS
RETURN
(
    WITH Numbers AS
    (
        SELECT 1 AS n
        UNION ALL
        SELECT n + 1
        FROM Numbers
        WHERE n + 1 <= @TopNum
    )
    SELECT n
    FROM Numbers
);