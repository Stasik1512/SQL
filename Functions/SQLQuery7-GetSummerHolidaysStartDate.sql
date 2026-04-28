--SQLQuery7-GetSummerHolidaysStartDate.sql
 USE P_421_Import;
 SET DATEFIRST 1;
 GO
 CREATE OR ALTER FUNCTION GetSummerHolidaysStartDate(@year AS SMALLINT)RETURNS DATE
 AS
 BEGIN
	DECLARE @start_date DATE = DATEFROMPARTS(@year, 08, 01);
	DECLARE @weekday AS TINYINT = DATEPART(WEEKDAY, @start_date);
	RETURN DATEADD(DAY, 1 - @weekday, @start_date);
 END 