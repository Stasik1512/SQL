--SQLQuery2-GetNextLeaningDate.sql
USE P_421_Import;
SET DATEFIRST 1;
GO
CREATE OR ALTER FUNCTION GetNextLearningDate(@group_name AS NVARCHAR(10), @date AS DATE) RETURNS DATE
AS
BEGIN
	DECLARE @interval AS SMALLINT =	dbo.GetNextLearningDay(@group_name,@date) - DATEPART(WEEKDAY, @date);
	IF @interval < 0 SET @interval = 7 + @interval;
	DECLARE @next_date AS DATE = DATEADD(DAY, @interval, @date);
	IF EXISTS (SELECT holiday FROM DaysOFF WHERE [date] = @next_date)
		SET @next_date = dbo.GetNextLearningDate(@group_name, @next_date);
	RETURN @next_date;
END