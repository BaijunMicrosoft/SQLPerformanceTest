EXEC sp_recompile 'dbo.usp_GetCustomerOrderCount';
EXEC usp_GetCustomerOrderCount 
     @StartTime = '2020-01-01 00:00:00', 
     @EndTime   = '2026-06-01 01:00:00';
WAITFOR DELAY '00:00:01';
EXEC usp_GetCustomerOrderCount 
     @StartTime = '2020-01-01 00:00:00', 
     @EndTime   = '2026-06-01 01:00:00';
WAITFOR DELAY '00:00:01';
EXEC usp_GetCustomerOrderCount 
     @StartTime = '2020-01-01 00:00:00', 
     @EndTime   = '2026-06-01 01:00:00';
