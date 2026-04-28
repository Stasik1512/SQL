--SQLQuery7-GetHolidaysStartDate.sql

USE P_421_Import;
SET DATEFIRST 1;
GO
CREATE OR ALTER FUNCTION GetHolidaysStartDate(@year AS SMALLINT, @holiday AS NVARCHAR(150))RETURNS DATE
AS
BEGIN
	DECLARE @start_date AS DATE = 
	CASE 
		WHEN @holiday LIKE N'Нов%' THEN dbo.GetNextYearHolidaysStartDay(@year)
		WHEN @holiday LIKE N'Пасха' THEN dbo.GetEasterDate(@year)
		WHEN @holiday LIKE N'Летние%' THEN dbo.GetSummerHolidaysStartDate(@year)
		ELSE DATEFROMPARTS(@year,
		(SELECT [month] FROM Holidays WHERE holiday_name LIKE @holiday),
		(SELECT [day] FROM Holidays WHERE holiday_name LIKE @holiday)
		)
	END
	RETURN @start_date;
END