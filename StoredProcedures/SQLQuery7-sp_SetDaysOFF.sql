--SQLQuery7-sp_SetDaysOFF.sql

USE P_421_Import
SET DATEFIRST 1;
GO
CREATE OR ALTER PROCEDURE sp_SetDaysOFF @year AS SMALLINT, @holiday_name AS NVARCHAR(150)
AS
BEGIN
	DECLARE @holiday AS TINYINT = (SELECT holiday_id FROM Holidays WHERE holiday_name LIKE @holiday_name);
	PRINT @holiday;
	DECLARE @date AS DATE = dbo.GetHolidaysStartDate(@year, @holiday_name);
	PRINT @date;
	DECLARE @duration AS TINYINT = (SELECT duration FROM Holidays WHERE holiday_name LIKE @holiday_name)
	PRINT @duration
	DECLARE @day AS TINYINT = 0;

	WHILE @day < @duration EXEC sp_InsertDayOFF @holiday, @date OUTPUT, @day OUTPUT
	--BEGIN
	--	INSERT DaysOFF([date], holidays)VALUE(@date, @holiday);
	--	SET @day+=1;
	--	SET @date = DATEADD(DAY,1,@date);
	--END


END