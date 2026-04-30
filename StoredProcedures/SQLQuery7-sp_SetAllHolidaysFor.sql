--SQLQuery7-sp_SetAllHolidaysFor.sql
USE P_421_Import;
SET DATEFIRST 1;
GO
CREATE OR ALTER PROCEDURE sp_SetAllHolidaysFor @year AS SMALLINT
AS
BEGIN
	EXEC sp_SetDaysOFF @year, N'Новый год';
	EXEC sp_SetDaysOFF @year, N'23%';
	EXEC sp_SetDaysOFF @year, N'8%';
	EXEC sp_SetDaysOFF @year, N'Пасха';
	EXEC sp_SetDaysOFF @year, N'Майские%';
	EXEC sp_SetDaysOFF @year, N'Летние%';
END