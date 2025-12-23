drop table IF EXISTS AuditLogs_del;
select * into AuditLogs_del from AuditLogs where Create_Date between '2025-01-01' and '2025-06-01';
delete from AuditLogs_del;