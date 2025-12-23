TRUNCATE TABLE AuditLogs_del;
SET IDENTITY_INSERT AuditLogs_del ON;
INSERT INTO AuditLogs_del (LogID, OrderID, ActionType, Create_Date)
SELECT LogID, OrderID, ActionType, Create_Date
FROM AuditLogs
WHERE Create_Date BETWEEN '2025-01-01' AND '2026-01-01';
SET IDENTITY_INSERT AuditLogs_del OFF;

delete from AuditLogs_del WHERE Create_Date BETWEEN '2025-01-01' AND '2025-06-01';
