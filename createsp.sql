CREATE OR ALTER PROCEDURE usp_GetCustomerOrderCount
    @StartTime DATETIME,
    @EndTime   DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        COUNT(*) AS OrderCount
    FROM Customers c
    INNER JOIN Orders o      ON c.CustomerID = o.CustomerID
    INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
    INNER JOIN Products p    ON oi.ProductID = p.ProductID
    INNER JOIN AuditLogs al  ON o.OrderID = al.OrderID
    WHERE al.Create_Date >= @StartTime
      AND al.Create_Date <  @EndTime;
END
