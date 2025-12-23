DBCC DROPCLEANBUFFERS; 
select o.*, al.ActionType,al.Create_Date from AuditLogs al --WITH (INDEX(IX_AuditLogs_CreateDate_OrderID), FORCESEEK)
join Orders o on al.OrderID = o.OrderID
where al.Create_Date >= '2025-06-04 22:00:00'
  AND al.Create_Date <  '2025-06-05 00:00:00' ;
