--SQLQuery0-CHECK PROSEDURES

USE P_421_Import;
SET DATEFIRST 1;
SET LANGUAGE RUSSIAN;
--DELETE FROM Schedule;

EXECUTE sp_InsertSchedule N'P_421', N'%MS SQL Server',N'Юыху', N'2026-03-26',N'14:00'
EXECUTE sp_InsertSchedule N'P_421', N'%ADO.NET',N'Юыху', N'2026-03-26',N'14:00'

EXECUTE sp_SelectSchedule;

